Return-Path: <stable+bounces-211630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LQfBXGAd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:55:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31D89CB6
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574E7301DBAA
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42DB318ED2;
	Mon, 26 Jan 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="latfrhts"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CD2F999F
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439267; cv=none; b=u/03FpwtGSPYBMQExAkWvbh5K1PX4tL8jRTSndBEtXdVOzAMPDY0fJZqzWQUb0LdlHtEQ4delURD2aGGwFxGPT18I/FIguXmK06JaW45tz+RFQgGohII2G6Y5RzXp4Atuf2u3amwZiIpi/xe+9WS17qdpsIOotFB1FPEZwB///U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439267; c=relaxed/simple;
	bh=Uxr1fUcxgHYez2kADgJu2kX9ia0MIDAG/hm5ySSvkVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=ugLc+WnFDnCRtmU9519gZHUSGRNg6gi9cWZxgCG3sHnLrelouuEiBESVmPNeAnWZuC8yoESFE2w9vl0j2IkS+l2DSriCy1K3bKxCx/KlV0PsfzFkjJ1Z+fQ3DI3e5wH+hDeQeUXNanOBPwIfw6DKKLXKv3SaW0ZHtxyE1UgdvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=latfrhts; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260126145423euoutp028f28d03affc7010095b7ded2e4f612e4~OT6Ksh56F2252522525euoutp02_
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:54:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260126145423euoutp028f28d03affc7010095b7ded2e4f612e4~OT6Ksh56F2252522525euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769439263;
	bh=FJ6dndNVnr43t5sh/dPsANRRiyWCeTFjxztR0Zx4Cp0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=latfrhtsmG8RtRz6JSigyMYSADZ/lFu31gIaRZXGoM25xpFM4HGx1IOuvYmKN1tVi
	 4sUcfPGg12Uh96uCRj+XIOl41w0DhSrap4g8zmAdpw5cd90hIFkCoUbnyZzvvTOpe9
	 xdDk4RRnYRMWithrPUfQAQa3VFcYmsfAwG6Bib6g=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260126145422eucas1p243889bf4ac456996ce7ed05111331d67~OT6KA7zOj1143511435eucas1p2B;
	Mon, 26 Jan 2026 14:54:22 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260126145422eusmtip2d1a656619f59b16d7baae0d47ee79283~OT6JQxXP51987919879eusmtip2T;
	Mon, 26 Jan 2026 14:54:22 +0000 (GMT)
Message-ID: <ac1832c1-e63b-45ba-9c57-83e56b34ed6d@samsung.com>
Date: Mon, 26 Jan 2026 15:54:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/3] drm/bridge: samsung-dsim: move bridge init sequence
 to atomic_enable
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Inki Dae
	<inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Andrzej
	Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
	Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Language: en-US
In-Reply-To: <1db5ffdf-924b-49cb-a057-802a1bfe6073@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260126145422eucas1p243889bf4ac456996ce7ed05111331d67
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260124172136eucas1p1e7a2da65c3fca268ea68f12506c6c19e
X-EPHeader: CA
X-CMS-RootMailID: 20260124172136eucas1p1e7a2da65c3fca268ea68f12506c6c19e
References: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
	<CGME20260124172136eucas1p1e7a2da65c3fca268ea68f12506c6c19e@eucas1p1.samsung.com>
	<20260124-exynos-dsim-fixes-v1-1-122d047a23d1@disroot.org>
	<1db5ffdf-924b-49cb-a057-802a1bfe6073@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-211630-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[disroot.org,samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: 6C31D89CB6
X-Rspamd-Action: no action

On 26.01.2026 09:57, Marek Szyprowski wrote:
> On 24.01.2026 18:20, Kaustabh Chakraborty wrote:
>> Since commit c9b1150a68d9 ("drm/atomic-helper: Re-order bridge chain
>> pre-enable and post-disable"), pre-enable sequence is called before the
>> CRTC is enabled.
>>
>> This causes unintended side-effects (abberation among potentially other
>> things) in the display when samsung_dsim_init() is called in the
>> pre-enable part of the sequence. Call it in samsung_dsim_atomic_enable()
>> instead.
>>
>> Cc: stable@vger.kernel.org # v6.17 and later
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>
> I'm not sure if this will be needed:
>
> https://lore.kernel.org/all/20251205-drm-seq-fix-v1-0-fda68fa1b3de@ideasonboard.com/ 
>

Even more, there is a pending similar patch:

https://lore.kernel.org/all/20250619-samsung-dsim-fix-v1-1-6b5de68fb115@ideasonboard.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


