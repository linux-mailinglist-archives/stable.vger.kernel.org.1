Return-Path: <stable+bounces-225333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPpgFX0ytGn4igAAu9opvQ
	(envelope-from <stable+bounces-225333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:51:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F812865B6
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77E323034DFE
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52032C302;
	Fri, 13 Mar 2026 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="jGTeG0gc"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B535BDAD;
	Fri, 13 Mar 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416873; cv=none; b=Zt3W14QDtKq4hlEkgPqZTbkJ3/1COy5WJXo6Mr6PHSDzgWLHjlLvTOK1sIikXNj+egwR4PMl2EvwIdU2boA1m5Zzc9LmXUDBMTTzKtbQNsKF2wX7fcShVRxaUsbng0n9v+l6n/Ct6vcKz5e4DxdcTFs2jZCdm7Zn+Qs9fhkjM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416873; c=relaxed/simple;
	bh=jX2HYRFWRT/RczRM+euLNR8ZASJKKcLJ+bAoE5Jkk6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2Lgby9GFJ3jhSeQ8xmLTEOxScl38vLcrgf11+t1eSl2EG1L0ibnujJxPnlXchqEw2MBMT8zJ81Eh6vatPCftdvHo5SXqauYN2eUb6dC40oPN+M1oXNRtpO6Ygp4MqqsAGfx+L/qglvrnF31EgBN48+8s7mXDelu2qdiDhVAkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=jGTeG0gc; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B9B51077B0;
	Fri, 13 Mar 2026 16:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773416863;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pd3lTWjZ+5rSyJMewkwT1eT+19Jc15PppiNJcmSogXg=;
	b=jGTeG0gcswCkMeJGtupDnz72P0d6dI51r/nmE4P4w55YUQ16dGl8KS+2sOuA0lowqveU4M
	Yxds52mkPDbMqzq6DTB3WZDzuSG/0dWwHof2IxGvZHV4JJ/Xliug9O6+v8igmgm5MkD2Kp
	Gxz45U/QfjzeY+l2EZ36wqfTrYfQoqS1WqYSpucyRaVMpHbaiuAy74k0n3Q1a5q0m4NUkW
	Mn8K1c+2PUQtjc7U0AioKQ2h+d6DPvWhJI3AjHZcn2d//VoLPJ8pco12r66m4xa87lgCPC
	adhiF49yTUnlA5A5f9GpDXCFHP+FrhOoEUyg2mcROG1PIkDsbKFx5w/XfEnM/Q==
Message-ID: <3c6d81c6-500c-4ff6-b923-9f446678a6bc@nabladev.com>
Date: Fri, 13 Mar 2026 16:47:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imx: parallel-display: Prefer bus format set via
 legacy "interface-pix-fmt" DT property
To: Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260110171510.692666-1-marex@nabladev.com>
 <30511e1e0ffd6579091fc4ed1cad084fd81b9c96.camel@pengutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <30511e1e0ffd6579091fc4ed1cad084fd81b9c96.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225333-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,pengutronix.de,kernel.org,ffwll.ch,suse.de,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:email,nabladev.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5F812865B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 4:33 PM, Philipp Zabel wrote:
> On Sa, 2026-01-10 at 18:14 +0100, Marek Vasut wrote:
>> Prefer bus format set via legacy "interface-pix-fmt" DT property
>> over panel bus format. This is necessary to retain support for
>> DTs which configure the IPUv3 parallel output as 24bit DPI, but
>> connect 18bit DPI panels to it with hardware swizzling.
>>
>> This used to work up to Linux 6.12, but stopped working in 6.13,
>> reinstate the behavior to support old DTs.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 5f6e56d3319d ("drm/imx: parallel-display: switch to drm_panel_bridge")
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
> 
> Applied to drm-misc-next, thanks!
Thank you

