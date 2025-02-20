Return-Path: <stable+bounces-118443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3CA3DC0D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF017A04C
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A11F63F0;
	Thu, 20 Feb 2025 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="Avk9qhtF"
X-Original-To: stable@vger.kernel.org
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7C1A8F94
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060218; cv=none; b=pPDV8raruAUe43bB4slld1KfI16QTCgh25ahSkDkvnTvfZNa+VdUEVoXwHNtU/SpcrObfYnYXYxf/zIT2PEGjcOtUSy1Alydun18YkltOP+KG+5hUGXp6N7CNtbsqcoeHxCbDZBDvWve1PfDfRyt0wlzkCYr+tN0RspzKwPrlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060218; c=relaxed/simple;
	bh=OK+wKiv3INSS/jdgScf/SWMYt248TaSo+TrFVE0Hcqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLmHMsFS+1453B39MTlw3dGrl2ErnfcdsUn16bLHxy88SxZ7qL9XzF5c7PDU2pwoU0jNoMqo+3laSVL647OufqgBoG26hfRo+x/7h5lPh4vTYJm3ItjXMqkma5r6gD5YUyZ1XAcmEGUBN1/l0F9VVgU7bT3MHD3Dp326Byn4qok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=Avk9qhtF; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id B3F3E2003CA;
	Thu, 20 Feb 2025 15:03:29 +0100 (CET)
Authentication-Results: smtp2-g21.free.fr;
	dkim=pass (1024-bit key; unprotected) header.d=morinfr.org header.i=@morinfr.org header.a=rsa-sha256 header.s=20170427 header.b=Avk9qhtF;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=64ZWZPJsI9mYJ1iSeQ4Skp2JdkisJ9To91cgUm3QKnU=; b=Avk9qhtFC0zxvGrYnWVEfsMXYB
	5xAZIpb8/y93k3hXNkHpESFGfP+iSUS0fz2CW53LEIDdiPlkUohUiAdJbfm0wEnBq9s4hqatqzM3a
	bzjeVYkWknEj2a9pvXDy/Oh1dAVfrBhl1TICa96akp7TSCI9YdmZaHjhTaZY+hVuixdA=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1tl79F-000WSk-0G;
	Thu, 20 Feb 2025 15:03:29 +0100
Date: Thu, 20 Feb 2025 15:03:29 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>, gregkh@linuxfoundation.org,
	stable@vger.kernel.org, bristot@kernel.org, lgoncalv@redhat.com
Subject: Re: 6.6.78: timerlat_{hist,top} fail to build
Message-ID: <Z7c2Mc0DYKQ-L9Yg@bender.morinfr.org>
References: <Z7XtY3GRlRcKCAzs@bender.morinfr.org>
 <CAP4=nvQ2cZhJbuvCryW7aTm4FcLSGLyDnhZX1wHNLxo1b3q2Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvQ2cZhJbuvCryW7aTm4FcLSGLyDnhZX1wHNLxo1b3q2Lg@mail.gmail.com>

On 19 Feb 16:03, Tomas Glozar wrote:
>
> Hello,
> 
> st 19. 2. 2025 v 15:48 odesílatel Guillaume Morin
> <guillaume@morinfr.org> napsal:
> >
> > Hello,
> >
> > The following patches prevent Linux 6.6.78+ rtla to build:
> >
> > - "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads" (stable
> > commit 41955b6c268154f81e34f9b61cf8156eec0730c0)
> > - "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads" (stable
> > commit 83b74901bdc9b58739193b8ee6989254391b6ba7)
> >
> > Both were added to Linux 6.6.78 based on the Fixes tag in the upstream
> > commits.
> >
> > These patches prevent 6.6.78 rta to build with a similar error (missing
> > kernel_workload in the params struct)
> > src/timerlat_top.c:687:52: error: ‘struct timerlat_top_params’ has no member named ‘kernel_workload’
> >
> 
> I did not realize that, sorry!
> 
> > These patches appear to depend on "rtla/timerlat: Make user-space
> > threads the default" commit fb9e90a67ee9a42779a8ea296a4cf7734258b27d
> > which is not present in 6.6.
> >
> > I am not sure if it's better to revert them or pick up
> > fb9e90a67ee9a42779a8ea296a4cf7734258b27d in 6.6. Tomas, what do you
> > think?
> >
> 
> We don't want to pick up fb9e90a67ee9a42779a8ea296a4cf7734258b27d
> (rtla/timerlat: Make user-space threads the default) to stable, since
> it changes the default behavior as well as output of rtla.
> 
> The patches can be fixed by by substituting params->kernel_workload
> for !params->user_hist (!params->user_top) for the version of the
> files that is present in 6.6-stable (6.1-stable is not affected, since
> it doesn't have user workload mode at all).
> 
> I'm not sure what the correct procedure would be. One way I can think
> of is reverting the patch as broken, and me sending an alternate
> version of the patch for 6.6-stable containing the change above. That
> would be the cleanest way in my opinion (as compared to sending the
> fixup directly).

Either way would work for me. Not sure what Greg prefers however

-- 
Guillaume Morin <guillaume@morinfr.org>

