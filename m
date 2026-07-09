Return-Path: <stable+bounces-272783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tD85O18CT2rcYwIAu9opvQ
	(envelope-from <stable+bounces-272783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 04:07:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540D72BDAE
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 04:07:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ma4wp730;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272783-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272783-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E1430297B7
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 02:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9131E822;
	Thu,  9 Jul 2026 02:07:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4630F7FF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 02:07:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562841; cv=none; b=kDggt85lKCUwhhjJ2KOaCkbToFqILCUrOa0woa7vglIBzTkTYSlceEGVq0fqJbRe9W43WcH/JSORAUlaCKacX6+FBNiatnzhBrzEDy7OnfaGViVUhpj+dqC5j4mYG0GNFjP56A1tYx93WfvhbbfmDU+hNmd9x74qpDDANtmu9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562841; c=relaxed/simple;
	bh=PoPEUr6KS0Je/aVdiGP+sFxqtUXWh++lbWgpLTbivR8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XD3JvOlbLzPayRTAsTclziYyF4eVB7W79GQOeUrsuomXSEW9tRTrFo5r+KJyFRF/K2AIRWu7iMLJ/okNiGqMcW+1gA8U5sxQkiYixBUv6Rp6LGd72rYQ9vhYhUq9TAEoL3lTXvQXK5cV32GfsxS4g0KgegNLKYArQAM7LocAdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma4wp730; arc=none smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80cbb0688c8so21107497b3.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783562839; x=1784167639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DiPeyVYQaEiVqx7WKQEaIVABISxwCwD67P0r37Z1zdw=;
        b=Ma4wp730Sv4nNZnOHmCCC5/vyV55tWljs0zgQoSeoykBlsnAflLTdnjsTTDuGU2Wnf
         CQs0kQSNDkM042f9UhB3aPhz+i9u6QV5+Zxfm4hWJAfwhNpr2wjbWo2C/jlW9OeQ+VBx
         7pzOfEYDvgpN3PJ3vPPK6j2yXNx8JiD1io3b18sTdsoAr0w0IJegiKmPXdNSOOyfnw95
         Ck+wyXHkH8jP7lP9CaDWkwH7xU6T0Ss6CmlHXzDKvgYtyLs0imYvY/BKEsHdzQgsDXT4
         O8GnH1tn/cnijR8c9ypE/5pHaq6badb5OxaW5oR8dZsaQECB3zGSjJ+n/F5cI9FVunJe
         osmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783562839; x=1784167639;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiPeyVYQaEiVqx7WKQEaIVABISxwCwD67P0r37Z1zdw=;
        b=phJCcd8Y44DnK3BzQoYFVp9aTIgcJOQtYx93v78E0bC6iTkAsNkaxd6Ctx58eIkeo6
         XFqQ4bjHVbeQdEPg9zg07gvhTE58YkAlmyRGvulUrZY6yzUxWa/iFPSPg1teUk45F2fy
         nI9plLfkHycCGTFVMdudqFWgvvqYuTfa6dvUGFCtU455W5Lau3pBLpeZuFCkPe+0ttEa
         S86M+/9JVJu/AHEMEe1KVigNXka3rYxQEQcmYWnQhsf7hnS2jpXlHadQ3PhzKGfwXODL
         v2//lC3ndhDqGgY+nrq8hi9769M6kXoTmOSKhJVjx4/KiDpTuXzjgN55d99onM1U1H+N
         oREQ==
X-Gm-Message-State: AOJu0Yx1eRhZmErGRiwJ3uo+Ryl/JkeK7Vt3fag6bN4r/JP5zB+JAjMF
	47CsCk8tfoxhwDoyJRLmFBSuiElnNkJbJxvf7N0KakRNVZneVIrRUDUv
X-Gm-Gg: AfdE7clW3MLRp+aDvW5vVFj1pwXwwwFhM9ipJ8ikqTYFU/f3HVW73URjm2ui8akxNP4
	zLSO8dNC8nGnjW336jSTKNTYIs1JxEVqDNYakbarNjHXoLmjyuOj26bKJNHoIoV8ADRompb5Uia
	UX+YIqh7fQGPyxWDGEoFuFTbMTD/jiAbZSGoTyq1ONVDoHF2fd1pWC4+abwRGr7uEZtk8rUDpLe
	LB0GgffuucKZvvqOtHb7Oz7u8GlPXYsyPEMqCaczwQZLjM74jNeqs3BwKYgA+guIhmUt7R/MIVo
	hOsQyOyQFRG/st6H6SB7YF26AmPvJlY2lsejYttlP1SMyGU+Cg7Af1aAAbMGIOSBZLSJ+kMQFbT
	2Xj8VKN/WFyCW8vBlNig3x2EQdJ97VHR5wvkanbUAJ1tgBeuqDDO9D1GDYMaslWHpmHwR4UDOLO
	sAYoeSsiQRB6xiBVt1VHSIrvtbBWjwhSkqiRMobng4ZBkKikyCwZSUA+/2K295PWDU0Q==
X-Received: by 2002:a05:690c:4b90:b0:814:608a:acb4 with SMTP id 00721157ae682-81dbeb5f73emr38829227b3.27.1783562838726;
        Wed, 08 Jul 2026 19:07:18 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be904a4sm6869687b3.7.2026.07.08.19.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:07:18 -0700 (PDT)
Date: Wed, 08 Jul 2026 22:07:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, 
 steffen.klassert@secunet.com, 
 lena.wang@mediatek.com, 
 shiming.cheng@mediatek.com
Message-ID: <willemdebruijn.kernel.2801a1401793d@gmail.com>
In-Reply-To: <20260709014704.3625-1-shiming.cheng@mediatek.com>
References: <20260709014704.3625-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v7] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272783-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[mediatek.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,isovalent.com,queasysnail.net,nbd.name,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS(0.00)[m:shiming.cheng@mediatek.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:willemb@google.com,m:daniel.zahka@gmail.com,m:alice@isovalent.com,m:sd@queasysnail.net,m:eilaimemedsnaimel@gmail.com,m:imv4bel@gmail.com,m:nbd@nbd.name,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:steffen.klassert@secunet.com,m:lena.wang@mediatek.com,m:matthiasbgg@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6540D72BDAE

Reminder to mark patches [PATCH net v7]

(or PATCH net-next when targeting that tree)

Shiming Cheng wrote:
> Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
> packet.") added a flush check to skb_gro_receive(), but
> skb_gro_receive_list() lacks the same validation.
> 
> As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
> re-aggregated.
> 
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list
> 
> Root cause in skb_segment():
>   The check at line ~4891:
>     if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>         (skb_headlen(list_skb) == len || sg)) {
> 
>   When frag_list is corrupted by double aggregation, when list_skb is
>   a NULL pointer from skb->next, skb_headlen(list_skb) dereference
>   NULL/corrupted pointers occurs.
> 
> Call Trace:
>  skb_headlen(NULL skb)
>  skb_segment
>  tcp_gso_segment
>  tcp4_gso_segment
>  inet_gso_segment
>  skb_mac_gso_segment
>  __skb_gso_segment
>  skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  qdisc_restart
>  __qdisc_run
>  qdisc_run
>  net_tx_action
> 
> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

