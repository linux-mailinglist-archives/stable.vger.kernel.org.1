Return-Path: <stable+bounces-266673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mZRxHEJhMmoBzQUAu9opvQ
	(envelope-from <stable+bounces-266673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:56:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B647E697B3B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:56:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=iArlWrHW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266673-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266673-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=mailbox.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E27023065539
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2743905FD;
	Wed, 17 Jun 2026 08:54:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A3364EBF
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:54:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686496; cv=none; b=Fjqz+z37Rt8xn1GlSu6Ux/xxZa3ip+93y4r85XXX0OKGE3IiyIbPPIUQQoV15SzUgK1+V4rBPDaxWbr2Qcdekl7RzWiNRhH09LWZjW3NhRnIjYk/1EgkVNHKP2W5sW/mo7IgY9EDYmuGgRxudiwuziPxa8skoqP3tGpB1TFB8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686496; c=relaxed/simple;
	bh=ESMwUbBb58blTKfxbAvXVh7cgSzNJA2y4c5yV1z3x0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lk6yiC5CaJa2Q+BY1afVrw5qcPoNeLHRLsrJ//O4VWH0MUblJ7VR4JqxOs2Gl79VW3iw0EdikLU/jfi2PB8ZXBZ8Xs3VXokW9in7BkeqxELK3VZiSt+H1ZsNr3ra7WVy5gqL0pMpPeigyrfEh9KppIewc9o0SV1noQDNYQQFihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iArlWrHW; arc=none smtp.client-ip=80.241.56.152
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ggHjg4P44z9v8h;
	Wed, 17 Jun 2026 10:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781686487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RY/xsByTrOU91RetAIh8oOO6g3ivb2EbISGMITVzFDs=;
	b=iArlWrHWUoZ+jqjxV/71Fo8A+C1Tq7Gl8KPUlxNMvFTA0IGUiY9EfyCdEkynmqsUhf++0E
	ayq1H3oSQI/adPQ62D45Im9utO54Tq+nOqraJLaKMJCznisqREhfW0z7E3Aqjtn4w2j9ka
	CdAQDMxewFA5UWTO9cRyNuBFdBIOTZL3psSNrnvs1rXHM4OMROOIwO05jSwfhy+54Vg38p
	j5HgDIO9idMuJZmFhtfVFujpYkIVVyKeXBh4RCJ03qkSdwRVCWXalSbWPN4SOfx6oY3VjD
	8RPJVs5NKBx5oX98rpc7ypIz4P4qoJ6RVBLW2IT9wC20Mb1vEgtFtzjqPgQY+Q==
Message-ID: <4e3b5744-e797-4026-aae6-e2a4ec49d905@mailbox.org>
Date: Wed, 17 Jun 2026 10:54:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, stable@vger.kernel.org
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260616201828.389985-3-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eh9fs3zibkf6fj435aya7dt83zcug9o6
X-MBO-RS-ID: 3d650d757189b9313ca
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,outlook.com,m1k.cloud,gmail.com,kde.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-266673-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sunpeng.li@amd.com,m:amd-gfx@lists.freedesktop.org,m:Harry.Wentland@amd.com,m:mario.limonciello@amd.com,m:wiagn233@outlook.com,m:sysdadmin@m1k.cloud,m:timur.kristof@gmail.com,m:xaver.hugl@kde.org,m:mario.kleiner.de@gmail.com,m:stable@vger.kernel.org,m:timurkristof@gmail.com,m:mariokleinerde@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michel.daenzer@mailbox.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michel.daenzer@mailbox.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mailbox.org:dkim,mailbox.org:mid,mailbox.org:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B647E697B3B

On 6/16/26 22:18, sunpeng.li@amd.com wrote:
> 
> 2. There is a window during commit where a flip is armed (pflip_status =
>    SUBMITTED) but not yet programmed into HW. If the VUPDATE_NO_LOCK
>    fires in that window, it's handler would deliver a flip event to
>    userspace before HW has latched to it. If userspace then renders to
>    what it believes is now the back buffer (but HW is still latched to
>    it!), it will cause display corruption. (This issue seemed to have
>    existed ever since the introduction of pflip_status.

AFAICT this issue was introduced by 1159898a88db ("drm/amd/display: Handle commit plane with no FB.").

pflip_status was already there before DC, and AFAICT amdgpu_flip_work_func has always handled this correctly.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

