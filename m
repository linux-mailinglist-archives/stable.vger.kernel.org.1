Return-Path: <stable+bounces-104200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00E9F2041
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C31A166DBD
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787B195B18;
	Sat, 14 Dec 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AIJmeqD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32980C02
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734199608; cv=none; b=poZK56fmw+WTgtCqCMphAWTn72sS39tY3tbtuVlr4Byv4yv765kUcaue+e4TJl3bxk0r1OElO5QAkEDKeF1pcE7LacGj/xJCMrZ9SfUc7+bFzQSMoHsAXgHzlTN2nWC+DV4o37NHYBZUhnE1IG0t6ZUL4At6b5qMtsPOFjdsG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734199608; c=relaxed/simple;
	bh=7ShFlV/aEY0xFV8Df0SgwnbY++2hK8qtC/OABaYp+6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmgJy8GJczZZvNVAE0gKxq0/yKiFwI0uVNvcXNKJdpbB45t8WY8Ma7QUBma+jnShaTvx7Uyrf4ZYcrqih9qocYuq4146sd/kwNjJn31CUgIc0vAy/6rIcto4hQwL+E+Hf8oOG5gAjw4Kgq5OwqBT/33GSNgWpUnb6nVk4MWN7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AIJmeqD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B71C4CED1;
	Sat, 14 Dec 2024 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734199607;
	bh=7ShFlV/aEY0xFV8Df0SgwnbY++2hK8qtC/OABaYp+6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIJmeqD7fvWD3OVV0Worqua9y8uM5V/7ml0h4lVK2i4emQ83/F4tMN/xmhvEJmlRz
	 qakpqmR/gYsxdBsoNuyE0lTZSjNCRQUG8Yusb5OkQYgQmDNqEb/nd91gKX0mqV6tzq
	 xhT0OjkOtXR5pTjSs2HqWYQM2SyyBRlwuSuTdgF8=
Date: Sat, 14 Dec 2024 19:06:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15.y, 5.10.y] exfat: fix potential deadlock on
 __exfat_get_dentry_set
Message-ID: <2024121419-cupcake-fantasy-92dd@gregkh>
References: <20241214091651-0af6196918c18d20@stable.kernel.org>
 <CE0C9579-A635-4702-B8B3-896E3F035044@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CE0C9579-A635-4702-B8B3-896E3F035044@oracle.com>

On Sat, Dec 14, 2024 at 05:57:01PM +0000, Sherry Yang wrote:
> Hi, 
> 
> > On Dec 14, 2024, at 6:26 AM, Sasha Levin <sashal@kernel.org> wrote:
> > 
> > [ Sasha's backport helper bot ]
> > 
> > Hi,
> > 
> > The upstream commit SHA1 provided is correct: 89fc548767a2155231128cb98726d6d2ea1256c9
> > 
> > WARNING: Author mismatch between patch and upstream commit:
> > Backport author: Sherry Yang <sherry.yang@oracle.com>
> > Commit author: Sungjong Seo <sj1557.seo@samsung.com>
> > 
> > 
> > Status in newer kernel trees:
> > 6.12.y | Present (exact SHA1)
> > 6.6.y | Present (different SHA1: a7ac198f8dba)
> > 6.1.y | Not found
> > 5.15.y | Not found
> 
> I didn’t backport the commit to linux-stable-6.1.y, because 6.1.y didn’t backport the culprit commit 
> a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_set_cache”), so not influenced.
> 
> However, both linux-stable-5.15.y and linux-stable-5.10.y actually backported the culprit commit. So I’m trying to fix it on 5.15.y and 5.10.y.
> 
> Let me know if you have more questions about it.

That's confusing, why doesn't 6.1.y have that commit?  Shouldn't we also
add it there along with this one?

thanks,

greg k-h

