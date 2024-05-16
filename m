Return-Path: <stable+bounces-45273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C416F8C75A3
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 14:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012F01C2283F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C6145B1E;
	Thu, 16 May 2024 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="biPzZaMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B3145B04;
	Thu, 16 May 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861229; cv=none; b=TLo9i90j0NZQI4f46ntzXTK3cjlu9fRocKXfr5CHSWzEP1XNeNR112As/t2mzqoEPcZZJJ5XtxVxPDCmSkgb6AmE8w3mQGBjKoJU/Kftom7eDKA+Gd5NFZRGrYwAt3DWAmvjGjdTxc2ksuOq2ByfDfoMvVitBwdiDztClR8s+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861229; c=relaxed/simple;
	bh=F/NDg+q4448IaAly3cLE6vkaENzwXj1yZC3S3ugEWtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLwq7z8Vi5Wi3pNbSpR0KFfQxjThfugNVTjcg8gcybk4LMGSHPy5Hj1/a5Ia7NlHS1RrYYo9QRoV/do+G1CVI1mgQs00CqmLDoace9Th1jEQdZQLPF3a9GTXkKXNgwj30iHImSNKd1NLgdIGUT+WqHg12P6JCn28qxSIF6WtmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=biPzZaMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107C8C2BD11;
	Thu, 16 May 2024 12:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715861228;
	bh=F/NDg+q4448IaAly3cLE6vkaENzwXj1yZC3S3ugEWtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biPzZaMwND7ElKFy54bvu5DoeNlSablGCvN90XtEml6nZDBtCtGzjlxWZmGlbvn2J
	 9E4AemO3akVwWbFkbChte0THUxwvjwgIEuZX72WXmpjhO1566TLIrIPQ7hgIM5d2TJ
	 rZAyvKU9IpGDTD5dLUsKIpeNTzPjjq9IVCg+74WE=
Date: Thu, 16 May 2024 14:07:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Sergeev <alexander.sergeev@onmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Rtnetlink GETADDR request for 1 specific interface only (by ID)
Message-ID: <2024051645-onyx-subtext-2448@gregkh>
References: <ac768f81f5218be629864b850bb7b959-1715851155@onmail.com>
 <2024051638-chase-viral-0653@gregkh>
 <2c63357c6f3220819739d293c9a25f1f-1715860234@onmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c63357c6f3220819739d293c9a25f1f-1715860234@onmail.com>

On Thu, May 16, 2024 at 04:50:34AM -0700, Alexander Sergeev wrote:
> Good afternoon!
> 
> Thank you for your advice! Unfortunately, I couldn't find any way or
> form for reporting issues in netlink, so I decided to use a bug
> reporting guide for kernel in general. Could you please let me know
> where could I forward this information? How could I contact netlink
> development team?

The NETWORKING section of the MAINTAINERS file lists:
	netdev@vger.kernel.org
as the proper place to go.

greg k-h

