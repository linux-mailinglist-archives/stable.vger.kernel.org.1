Return-Path: <stable+bounces-33794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B78929C3
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 09:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2FEB217BC
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5CD1C0DE5;
	Sat, 30 Mar 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pujVzls7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E01364
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788417; cv=none; b=NtDnq/V5hjJxy7ulGi3ij3X0brIH1Jjhi3YHpv/qsMwErbv9H7eKDFx3QfjflOJb/oi/I/ucpkK/jxzsAI5rtjZ9wo0p7dQPMvTrXhRLX2Aneuy4ZBLQLsDReHxzJAFlI4aUGBeGSQkAN4iwlbxVK8zId/uRWNpdMrsjTeQN3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788417; c=relaxed/simple;
	bh=aK7yS8zHXqiQNZsVMXiBv/f7TRYN/9q1Gis/lRiYeHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4wQVNRk7WBUEE2+IZrxz8XzuzxIk0IeP7uWpGSSxQpm5UJ4ZeqUVH7SNBMplq8VOtWQMlDmWG538hwjY++oysE+G9zxicw0gYZuT5kmF2cUBK98iKEJsHs/DOnY19uVW85fx7d6FCM0Q1lyedG2flIaA4VwMkmxp6iXbWvbAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pujVzls7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52C6C433C7;
	Sat, 30 Mar 2024 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711788417;
	bh=aK7yS8zHXqiQNZsVMXiBv/f7TRYN/9q1Gis/lRiYeHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pujVzls7AmduvLwrvabRtnq7jtEp/nfoHgH3QG286coiYyCRRVcLsUGjwtINnuMty
	 rQ3urMNhIC9H3rdfhBkdqNi+n03t8D38u/ueA8Z6Rc5128qIbw7nWkLmVG+JFfeJCv
	 fVrxtsk2sNl7xMaugvx4Tfeb6mRuZxpZajPvSjO0=
Date: Sat, 30 Mar 2024 09:46:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH 6.1.y 2/7] Revert "vfio/pci: Prepare for dynamic
 interrupt context storage"
Message-ID: <2024033041-spotlight-tray-4bfa@gregkh>
References: <20240329213856.2550762-1-alex.williamson@redhat.com>
 <20240329213856.2550762-3-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329213856.2550762-3-alex.williamson@redhat.com>

On Fri, Mar 29, 2024 at 03:38:49PM -0600, Alex Williamson wrote:
> This reverts commit b8e81e269b3d97fe53cd9819aa4a29e1aaf26731.

Again, fake id, I've dropped the change from the queue, thanks.

greg k-h

