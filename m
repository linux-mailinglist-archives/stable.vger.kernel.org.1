Return-Path: <stable+bounces-70160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9D95EFE2
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE083B20986
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D81547FF;
	Mon, 26 Aug 2024 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjDd1i0C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A41547C0
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672233; cv=none; b=BzaUULY2C2e4cBTLD8od1twH/ZAmjMkYYTI8ZK/pgoQVry9j8klUNonfPip9Iyj7TBsbVjFYPNryxxsEDjGddMtL7e9j34A4psInj596ekh/jbsya8EpGdjD2NEVRsOHSqimUEsDTa+4PVCq+A52H3WSf4Ou78POdoYPeH9K2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672233; c=relaxed/simple;
	bh=1EVzP7skt42zU/E6jGsytLQdvf+AHQSQT3X9FFCEyRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEW7Y56boUR6TXi8ZIncTtuZmWfcZghXKCTgSTCff2IJ0JPSw2kQkeZW0m5shC9oIZoCQG74NUkKPQunQUUg51O/0IMcLTBPJCeqmDEOLZPe+/AVLu4rOO7zbwKAT+je5uSmmDLVjTvDNCR2DlvpU9KhIhd/TLAHiSm5vvd9gig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjDd1i0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32ECC4AF1A;
	Mon, 26 Aug 2024 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724672233;
	bh=1EVzP7skt42zU/E6jGsytLQdvf+AHQSQT3X9FFCEyRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjDd1i0CdUU8AJ7ZwJP1GAYF35B1vBvRDSQfWojJqZ1nRWMA2nGxYG1Sj/LlsDpKU
	 zVRlvAHMY/eqO6rfeZj8O2zNaAtehW2VFzqLstQI2A15B0dThrIqrj6KcZNCJbkGcL
	 m42Xj2ml8qlkQ4GVHwSxtpGfQg5/9F5Vnc6JwfCA=
Date: Mon, 26 Aug 2024 13:37:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Glaser <tg@debian.org>
Cc: stable@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>,
	YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
Subject: Re: [proposal] binfmt_misc: pass binfmt_misc flags to the interpreter
Message-ID: <2024082626-shaded-trout-6d80@gregkh>
References: <Pine.BSM.4.64L.2408260104111.16173@herc.mirbsd.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.BSM.4.64L.2408260104111.16173@herc.mirbsd.org>

On Mon, Aug 26, 2024 at 01:10:07AM +0000, Thorsten Glaser wrote:
> commit 2347961b11d4079deace3c81dceed460c08a8fc1
> 
> I would like to propose this commit from 5.12 for stable,
> or rather, ask whether it’s a candidate and leave the exact
> picking/backporting to the experts (if it has other commits
> as prerequisites and/or later fixups).
> 
> This is because qemu-user needs it, and it arrived just too
> late for the current Debian LTS kernel (5.10), and qemu-user
> in Debian until yesterday had a workaround, but now doesn’t
> because it’s in the stable kernel (6.1), so qemu-user-static
> cannot be just used as-is on Debian LTS any more.

As this is a debian feature being backported, why not just add it to the
debian 5.10 kernel?

But, as it is a bugfix, I'll go queue it up now, thanks.

greg k-h

