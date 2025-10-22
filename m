Return-Path: <stable+bounces-188935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DCBFAF97
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D686E19C3399
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997EE3054D7;
	Wed, 22 Oct 2025 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1gQ/zcbs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1292F99B8;
	Wed, 22 Oct 2025 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122928; cv=none; b=Qsk0PJSTKK+r8RbJu5Td36bybOQ0ja5CrkC8qOEPIGz6vQna61Qnk/mO4BuOILRdwjWOYeGdstRkFJnR63/STa21TW0aS41hUtWatOXzobJCOeI4KbZiV33JKSH8D8kqQZpubb9EAkGVBvIfP+H/qJd8roW2RnfVvabHn/4jK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122928; c=relaxed/simple;
	bh=Uc/QVU2M7Q75wiFeDLGW5PtLoxS3htEIR1Lh3uZxtqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5wbD2QZMx5THKi5N5ItU4M+VEzuq/oOy8jUbvpEaRZLyCUrur11Umd14q+fMtow8jMSSO8WdvQmtKSx9aDni/R8uWoz99dHCSvY+XdA4dfGqt2jJHpXNV5ew0B336RF+dOulIvLcfa7XryFb+96iQ2xi9bpfpf/AyY/c64v6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1gQ/zcbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89693C4CEE7;
	Wed, 22 Oct 2025 08:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761122926;
	bh=Uc/QVU2M7Q75wiFeDLGW5PtLoxS3htEIR1Lh3uZxtqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1gQ/zcbs3755oybpEUPpHEApIn0Ca9Uku8Wyk7JJtQ2mt5v56kb2vMCfhWEzq9VWC
	 XQ++2JAlxCBNuUJoZzKjSRtJiEIvWZ7oWukwzXjaE511MY8ObkBYSAUnL6lwxKOj3f
	 hIox+6fGVIndAdbgRiqvJ9eoKOZY0rJO+/yWa9wY=
Date: Wed, 22 Oct 2025 10:48:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: eajames@linux.ibm.com, ninad@linux.ibm.com, joel@jms.id.au,
	jk@ozlabs.org, linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] Once cdev_device_add() failed, we should use
 put_device() to decrement reference count for cleanup. Or it could cause
 memory leak. Although operations in err_free_ida are similar to the
 operations in callback function fsi_slave_release(), put_device() is a
 correct handling operation as comments require when cdev_device_add() fails.
Message-ID: <2025102231-sturdily-zoom-ada1@gregkh>
References: <20251022083452.37409-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022083452.37409-1-make24@iscas.ac.cn>

On Wed, Oct 22, 2025 at 04:34:52PM +0800, Ma Ke wrote:
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.

Your subject line looks a bit messed up :(


