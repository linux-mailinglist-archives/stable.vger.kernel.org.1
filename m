Return-Path: <stable+bounces-273653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GqIAKMnOVGpifAAAu9opvQ
	(envelope-from <stable+bounces-273653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:40:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 483AC74A73A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:40:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=VA8CuCvg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273653-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273653-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B81733030D66
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99A3EA976;
	Mon, 13 Jul 2026 11:39:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7743E5A2B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:39:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942751; cv=none; b=e2vYs8MEgaQGUJ+4mJv1e2B8/TDHP8DT4VgebrscqjkGBt/c8Lv1u2yLPFQBlFMhDCIPnJBLwb58h7lY1A/rK4wJL2fr81/0fBI8Tue2lCeh9FTzgZo2mEtdp7rXEJijYK2t9XvybWvdZP+qW/VAzrbrJBSLEsbhzKoPAmFQax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942751; c=relaxed/simple;
	bh=A4zo2+xQeX1vbXQna3iVpqkY6KIz76I1W77x/MUxy0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw73/CXyyhYCu72MGd9yLITi9gMPDNlrTQ774SxDCbAIdYygYua+tpn62J7EiQiEnH08SfrFIrDuHxBtqCaio5uhbSIuI/jLtWC02BPgm/8J53sc76ZbUuK10KFYW4MxznNy4THkTW6eSjaNA8wRRFj4YgtS3oi38XMDRiqSwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=VA8CuCvg; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b77b150aso25437275e9.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1783942747; x=1784547547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SyGrauJ6Z/D7QxLsQH4fnjbmvOpSdbv71QSALvp4E6s=;
        b=VA8CuCvgfGGkCyqKmHeOkFtpBz32Tl6QHxXPxixf9osP8opwAIWCbsAwwYyUxgIiad
         94hjON7VcI5h7qGfptpg+PsOVw1jSgDP1bsvQFGdho7u1E6mqFjVud2rSCN39mtGyFcr
         escfbKYAw5x+LNSXeZqEgzOAYNa7MIk5DED5rfAuHptJjeWGsrTgud1fo1CtNm+DBNHS
         fQSKKYbcA8zTBR/FPxNVAFzwjzdWmLOYP4uzmduu6MiwEhY3hAkyvM4ditxI8ZDtukML
         JLGTjmj7EQ2GVRPKux3PbRm2UK29kEOVVeWqtz33oV7tmYq7WmBrNQIQmbFIDr4eXmsV
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942747; x=1784547547;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyGrauJ6Z/D7QxLsQH4fnjbmvOpSdbv71QSALvp4E6s=;
        b=rC5W+GklKfuCSXuA5SY0eob5dynkJLJX6iewiWKaMnPq6/iGMRxPECmG1vxO2p1g4d
         v/0FaXYcWQ6OcZPANPAEgkzeDSRruF74fX3rKnPOiyx+/nItHQ16TjQ3flW+0kN5T84r
         SMHU3lTEbHo15rX358qL8T29beGe+ngKfQRvgvKCEn79/kp6d0LOQnJp94oi2h540LkG
         G7gi6huHv9zN5e8lLMs4jv5W+eJ59d1dbGViuP+WakZRQFdMq6JQz0+vTW5FM5qz022N
         IX4nrEKjHdHhcXOtA8EINGaPWFYxamXxy5Y5cpHuo7pTEqD04Pbgp/iEwblVLITXvrET
         Zo6A==
X-Forwarded-Encrypted: i=1; AHgh+RqB76o3oFBtxLRK60ZCqoHguTiSqNA428kwRAdK/eXDOkOJ835dto489KsBRYus4kPwKv8DxC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhH5JrqfYY6n+Cz4GeORzRJrZqxJW+qt0AfNapCMUdBgmJ3Wf
	d/wNRM61vEGKvqkDUryVdPUnSjimFf44TnPtVqbeFxBTDZtQrVJ5fnN+Fb+7GlOyNm4=
X-Gm-Gg: AfdE7cnKQQnSiLDPpz1l4YhK4AHONNGovKSTlJ/oHqgTa1QOQKIAk+27uy3bLVNMSAI
	aiS6BC5+r5807Bh0mifLn+YucNe5y9HkAcF7EhbMBKe8XKuCORCKdBFoejMMcTgXOi9Xp2oZmP4
	ruqtn+FANmCXrjV1FkAZVJSKmLvY8WjQfg19Srn0ZaRFiZTRlVa2fx92ErN3af1SecPtVQZH/6F
	lZEOSrM/tqjbicfaMaMfqaFc5BiIIMfo5pesDPnEQM3PwtKFCnb4cqN1Ox6SsdPBmSLEOff1vNU
	aipcVK/qXm7JiC5I1FjdOvA6hCZJMd6QTfvVUiusvL+FKjvborkOoW9vfsqOJdvEYbuRwiCgeXZ
	CDZ/TFSMq5Mswni0zjTGMgu9hjz0ohPOSncTRcaGGqpJY88AvbZXHp/zTX/VTVxMgb3//k/uQO7
	t0ecw3FJot9g==
X-Received: by 2002:a05:600c:3acf:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-493f884f5f2mr85117975e9.37.1783942746646;
        Mon, 13 Jul 2026 04:39:06 -0700 (PDT)
Received: from localhost ([2a02:8071:6401:180:d892:bf43:a0b4:83b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm372032495e9.3.2026.07.13.04.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:39:05 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:39:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcontrol: update state_local when flushing NMI
 stats
Message-ID: <20260713113901.GG276793@cmpxchg.org>
References: <20260713085053.2916813-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713085053.2916813-1-guopeng.zhang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273653-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:vbabka@kernel.org,m:alex@ghiti.fr,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email,cmpxchg.org:from_mime,cmpxchg.org:mid,cmpxchg.org:email,cmpxchg.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 483AC74A73A

On Mon, Jul 13, 2026 at 04:50:53PM +0800, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> flush_nmi_stats() updates state[] for kmem and slab counters but leaves
> the corresponding state_local[] counters unchanged. Local kmem and
> slab statistics therefore miss updates collected through the NMI-safe
> atomic path.
> 
> Update state_local[] together with state[].
> 
> Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

This issue affects memcg1 but also the workingset shrinker.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

And we should probably CC: stable # 6.15. Shakeel?

