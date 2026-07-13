Return-Path: <stable+bounces-273587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1/7JLBGTVGrQngMAu9opvQ
	(envelope-from <stable+bounces-273587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 09:26:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E37481F5
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 09:26:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273587-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273587-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B6813012748
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 07:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC4381B1D;
	Mon, 13 Jul 2026 07:22:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3337BE71
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:22:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927337; cv=none; b=Mxim87faFi3YO0jU3OdIMFWqgVFfbu5WT8Y1bb1p8TJ03OSD0EK1quoO+tqbJk9YOG39oEnFHaEfygo9re2niCsnCXFg1EWrDHMpdfjl7JjzMsJsCyEPalM6G4emP2ggVV5E3vSgwikbfltnBqPGA8/V26CjCLeWGRDWH21uho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927337; c=relaxed/simple;
	bh=prDBsEDkefgLC10ZgD/cNKCQ1km1ZVKL+7eLXBoG9jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J216x8NroaPyKI3vf9brKBc72k2SbpUe2G9Fo76ELNYyKv2n2gi9x3I6MQSaDLmP+VY/ViiBA7+19sAP95iU4S3i+v0IEyPtomP9vOBk5MUg2fv5WyB0d8rwhk+NGbOYXGab1LgAPLs/uzBiENjDpluQWUidcqIw+bXE3vBlE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf62388d17so1026528e0c.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 00:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927334; x=1784532134;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k9efCbe+5Y6ahQNJH2dxKPZ1FaQevv/SuYysWDsVR8s=;
        b=oecLF32iHTu6VTHWkIcfyBYaMRdJAi/aWPI61mxr/q0Gw5TeZDR0QmU5WBRp+a9Qi6
         fhTsBDMUL9fqBLbfFJHIKzf+wLloGj4oqy0+sYS1thX47wZTCk/Vi2jiwmsbvKz3xARE
         UsaGe78mZF6fyWgSN5U05jpK63mhFP0FTjb590+OPti4Wbtpk9CrG9pVROBYxEC+Hayw
         NrRncRvGQ5RAwRFOi4KibYxFaMzp3ttED4YcIzPYbiR9U0mbPSDzpyi4R+B4KofGdGn4
         4sXby57yQtLwdKU3DuddziiNgffQbYwUqXOC1E37Jp4vE1dOPcpDNczDWFcM0B7opynM
         aRuQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLwLDKlnNU+pRK90THK/Jxg87yleyBE6NALEtTtJsRf9MYplrs6aPR/mF720k1BsHxQ1629Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFD8xZeuSpoETPMkzXJJMgMrVsa/Fesh949a2fNsF0BGDDQmKK
	q3WicYokJ48UQ9HXGBIacyD9Zy7lmHJusEhNAbtH3Cu69hFyquZ05c2dRpcvicad
X-Gm-Gg: AfdE7ckb/PjQBoEBqQp3nCmL7OMVrMFgps7GVlYMXhZErFQP8WXMBHIOTa8MxUc1ZhZ
	DN0BLi4dqO6O/zjXny/kvMN9BWJ53poVgmFx/PVTO29q0zwSElYfoXs8kFuce2yZTEMmq9Wu9Aa
	lA2BEcBZsA9GZTTMKjNktaIH0f7c4XfPpuCtd79bKv6w/fFwurkGJQilWzYxIeXZVaKhdhBC8Dh
	W8yx8PLsfbhtaz/0uxAvSuoT+iUzonbyxLlc6CShKepKeAozuQTzmdGm7qQNl0NPgt2YGWDrMkm
	xirFL7Ojk/+nuzMojsmmdHYqlVDvJU8qbZNjlh5FgwWJIhOe6PIVPoXm3DrWzT62ibHixQBdDzm
	J3TIKCstSyWmDgmAMCeRccCGsKOYLFo4wKd1vIPI7/1SydUa7+X4u2QukNxQqMI0z4JyNqhbIJ/
	onxMeoXJ14+xiF2mh8psu5hU3WCl7XJFbybYK78fCw/dJRGMrFfw==
X-Received: by 2002:a05:6102:2913:b0:631:af51:7d8e with SMTP id ada2fe7eead31-74533d605e1mr4248472137.17.1783927334115;
        Mon, 13 Jul 2026 00:22:14 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed5d4d40esm6880956241.9.2026.07.13.00.22.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 00:22:11 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so683689241.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 00:22:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoezkAP40Kepr9+UW5IsEalXKa7BlK6jNtxtRtTlfuzZyA/DLBfPS9suoU6HSO4rFw13ZCyOv8=@vger.kernel.org
X-Received: by 2002:a05:6102:26d4:b0:737:783d:1900 with SMTP id
 ada2fe7eead31-74533bddb5fmr4721253137.9.1783927329441; Mon, 13 Jul 2026
 00:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
In-Reply-To: <20260711130931.740719-3-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2026 09:21:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUK9a+1EwCGFw7dS8tvU=N438Bd2Z=EY0xuaQYPDy2hug@mail.gmail.com>
X-Gm-Features: AUfX_mx-KZ6ym34u_XnSAl1rHvfZCpzLD6QFC2QtuW07Z8oE-TV1vNB_HazP5kM
Message-ID: <CAMuHMdUK9a+1EwCGFw7dS8tvU=N438Bd2Z=EY0xuaQYPDy2hug@mail.gmail.com>
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, 
	MOKUNO Masakazu <mokuno@sm.sony.co.jp>, stable@vger.kernel.org, 
	Geoff Levand <geoffrey.levand@am.sony.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273587-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:geoff@infradead.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:paulus@ozlabs.org,m:mokuno@sm.sony.co.jp,m:stable@vger.kernel.org,m:geoffrey.levand@am.sony.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[infradead.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,ozlabs.org,sm.sony.co.jp,vger.kernel.org,am.sony.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-m68k.org:from_mime,linux-m68k.org:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A90E37481F5

On Sat, 11 Jul 2026 at 15:10, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> decrements iopage but keeps using the failed mapping's offset. As a
> result, it repeatedly tries to invalidate the failed IOPTE slot and
> leaves the already installed IOPTEs valid.
>
> Recompute offset and invalidate the installed IOPTEs instead.
>
> Fixes: 6bb5cf102541 ("[POWERPC] PS3: System-bus rework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

