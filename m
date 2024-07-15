Return-Path: <stable+bounces-59271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C5930D6B
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 07:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40412B20ACF
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 05:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36811836D1;
	Mon, 15 Jul 2024 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kVQJ+aVX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667EB219E0;
	Mon, 15 Jul 2024 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020356; cv=none; b=VROgJmcSaiuOW5oLgH01EscPSZYVeHWHJtUT4GNM3Hmh9RDgS6gej9bbnSbKCb9Vi20V0ebFoaeEKjn3Z617xnAVx8k8HIpMJsw/MCOzmB79FYMlaG0C+5N1KO+ZQFe4eGnWG3WyAoVnbDaxUvEPzM9XyfegZTj4Y6y84QI5sdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020356; c=relaxed/simple;
	bh=LJHclODpyrboPhQhaBBGs+WVF5tYU2NDz6MkUk+jTjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVPT7j/iMT+FLAJlC4mIjN/tX3ydLff/EVA5hsrJhqr9ggxO2lRxI4v42gBxE5OpJ0xa/bWvQbdBGla75vFPsDiiCK8TqXUTMoJ+ref7wv55pHRaTE2pK8LVqoB8yI3Cb7WgJi3oMFLdF9mp7Z2WhxIYCZKQnA8yxeut0QveZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kVQJ+aVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C50C4AF0B;
	Mon, 15 Jul 2024 05:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721020355;
	bh=LJHclODpyrboPhQhaBBGs+WVF5tYU2NDz6MkUk+jTjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVQJ+aVX56E5jhlNT9GTOCl5hqMJqfnZXM5yvy+JTWfoKkWx2LA3UoXJkaEPRKYIq
	 h2B01zTXs/KSAM/4Tqpd/7cX2FdeEN6aYk8BfBMhAfCYBOd0rd/ZmAJt4bSpKmh1bp
	 wxZ/3gF1TaP25zaU/FXMztRSV7sWI7dYX6VgHKrA=
Date: Mon, 15 Jul 2024 07:12:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
	mpe@ellerman.id.au, manoj@linux.vnet.ibm.com, imunsie@au1.ibm.com,
	clombard@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
Message-ID: <2024071500-certainly-kick-11c8@gregkh>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715025442.3229209-1-make24@iscas.ac.cn>

On Mon, Jul 15, 2024 at 10:54:42AM +0800, Ma Ke wrote:
> In read_handle(), of_get_address() may return NULL if getting address and
> size of the node failed. When of_read_number() uses prop to handle
> conversions between different byte orders, it could lead to a null pointer
> dereference. Add NULL check to fix potential issue.
> 
> Found by static analysis.

You need to describe the tool that found this.  And how did you test
that your fix is correct?

thanks,

greg k-h

