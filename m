Return-Path: <stable+bounces-119975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D3A4A0F9
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 18:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C5188AB0B
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B091BD9F2;
	Fri, 28 Feb 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="JOFj3dN6"
X-Original-To: stable@vger.kernel.org
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA411BC065
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.128.248.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765290; cv=none; b=P8m4vCvH5GkzkA16fBH2lvJ/DMS5BVPSTdX/oUt4frm0JqzMED+BrU5LSNvZ2uMaA1Rm7mWmpx5PjzC8nXd1AKWvuKGwVBhPnxbkdFxPH4bObnufbTgloTGiPMTLiwa0l7TtAvVCbud+p9pZ7jgLaHMAF/Xmh5xrMyhV1xyS724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765290; c=relaxed/simple;
	bh=eSFMXJ12iDjaESGF05cso0GvQ7vh1Kq24g7n5bFXzZQ=;
	h=From:To:Cc:Subject:Date:MIME-Version:Message-ID:In-Reply-To:
	 References:Content-Type; b=UYwSRzCdBemiOeCN5Nq70rBuJnxSk35uP37teoFYyw8YLDQZUmM9+KFR3xGSXuViJmDRwsx4mQvS3Us9G9iK5C1bIQuO+TJRdTENinkpX+6mQ97qCxRhZItOcgOtR7tVHmoq1i3dfbbNJTpap/Zc9VL3zu8zPhd0/ygXm+6InDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz; spf=pass smtp.mailfrom=cesnet.cz; dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b=JOFj3dN6; arc=none smtp.client-ip=78.128.248.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cesnet.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
	s=office2-2020; t=1740765284;
	bh=FWXg0yJCwr0VZRTKexGu60ylw2sTqEfmHf1yraVIpVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JOFj3dN6ZrvkjOGyBcDd5gLkhzzNvr3J6T/zItj31xs1HWqUSB76z1fDUeH95Mkut
	 WiVcYgt1GaFz/fTezob4YvqM3iqzEImUZLLGFOKAZBhL/DkixyVFXl80vzRXPR5oZs
	 f7NME3ZBrILX87JJKGRl/knvYxKzWnMSyhq6lLwwnJHFsvB2614Pp43NuoSLNWjmyW
	 1ercelpT0oyYZsqzo37b4NwkIT1DStnsbQopGkGCOJhtdDsTNZICxaYljfIw1TIsVf
	 NZh8Po008u9NJ1y8hWIVK8nWB98xfsX2fW6Vi4IpwG5gt7qKjRf8+kQr2e+7rdTv6n
	 bXSgOH9nfjzgw==
Received: from localhost (unknown [IPv6:2a07:b241:1002:700:921c:ed49:e10b:7c56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by office2.cesnet.cz (Postfix) with ESMTPSA id 6661F118007F;
	Fri, 28 Feb 2025 18:54:43 +0100 (CET)
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: Tomas Glozar <tglozar@redhat.com>
Cc: <stable@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guillaume Morin <guillaume@morinfr.org>,
 Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH 6.6 0/4] rtla/timerlat: Fix "Set =?iso-8859-1?Q?OSNOISE=5FWORKLOAD_for_kernel_threads"?=
Date: Fri, 28 Feb 2025 18:54:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5add3e65-9fd1-4a84-8f7a-40b80ff42ae3@cesnet.cz>
In-Reply-To: <20250228135708.604410-1-tglozar@redhat.com>
References: <20250228135708.604410-1-tglozar@redhat.com>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.15; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On p=C3=A1tek 28. =C3=BAnora 2025 14:57:04 CET, Tomas Glozar wrote:
> Two rtla commits that fix a bug in setting OSNOISE_WORKLOAD (see
> the patches for details) were improperly backported to 6.6-stable,
> referencing non-existent field params->kernel_workload.
>
> Revert the broken backports and backport this properly, using
> !params->user_hist and !params->user_top instead of the non-existent
> params->user_workload.
>
> The patchset was tested to build and fix the bug.
>
> Tomas Glozar (4):
>   Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
>   Revert "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads"
>   rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
>   rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
>
>  tools/tracing/rtla/src/timerlat_hist.c | 2 +-
>  tools/tracing/rtla/src/timerlat_top.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>

Thanks for a quick fix, it now builds again and the tool appears to work.

Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

With kind regards,
Jan

