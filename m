Return-Path: <stable+bounces-248878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEFEJOlOB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:50:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42055405C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 296DE30608F0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C03F58FF;
	Fri, 15 May 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJZycQTE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCF3F58D7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863289; cv=none; b=n9Ko/00xv/nmUdT24jIPasX+Qs3yR/65s6XyiXmJfzyX9Mc/YjTiHEw9W/HTYh2Xfp2ZgvRzeB0k/VCRo5YXVUIO5AAxeMmrY+JmJUjbMcOoYvkXZkPHz2ypLLlCBV90zap2kACpD8Z3XZAdc9a7DMl/vZvY4/+5Mi329NMonUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863289; c=relaxed/simple;
	bh=VQrt6Kb8j8BwVo0kBZX98Mz7U5mvGhyJexU+/XCJAyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToSDqyHVlYNCw/J4EREJe3sla3vXcd8PCtYdOaxV6Gi78BGPMa7GsIS/4/scUA8P58Wr3DapPCaGHrh7lPlMICtyPHxe06OracsRxyOnOGe8FaCIh1uDZ1LhWBLoEvdKNzZupj2e/ct5ScKDA3fudS1iEGOUT5DXP2acTYUAApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJZycQTE; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbb4fdc04eso1293572a34.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863285; x=1779468085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUh3g6NF2/hDjdQJcgRgRluSwJT7rJP3ZfpYW2WdTWI=;
        b=HJZycQTEZKCwZPdT9amSYOIRjWf+pVC2bxgOk5u/xkOinCwjKURBXZaFYlhyyuub7H
         k9LhIAsyCQjXKzYrcesNAF72rOrlE46uGHmj/2E5Ax2IpkRwZGyc4zKNKE7VHlbUZjze
         Al5M8A+tYMgJ/bD7dzue/XZro4JWjhbD9/Nq5A+kl0QKS2P/2s8dbxnm5iSyMV2E9Nhv
         zMdUaxNUhGxEJSx7++ZsmlAxZBqcHGefBJ+7rRLD/pUIi+GJI0iXPvdzVuMx4RP9BP4j
         jONTvisBU9LXlvspi75dmlPdLQJSM0ocSERnxOzRtwa8OXt/Fn9WxgXxswRbO6Vkq9ud
         1kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863285; x=1779468085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUh3g6NF2/hDjdQJcgRgRluSwJT7rJP3ZfpYW2WdTWI=;
        b=ghOfIeEcd2TamizI/kdI+RA4xC5jCN1YLNsuSnNF+xvIaL0HTMmpMZn2/HPRzvQibx
         epUsY0TFf3iBaMb72IQunoO+WFXNsa+AJnkRWjXEXoSxq6p40BGG0GyR/pmtDraV3tqp
         hXhLo9tFPXUTm1Gx336JCG+veY3c79Opfa5qoWfRf/IYbbH31G88BiiTMB1cG3rnu0lV
         B5xPSLnTDNV/QR70OIpHQv3YgkAQOEIl083h0yyEz/Wr3iCEGdDDQeLTYQy6V2w9oLhW
         7v2M/ZmM8dYiczW91so9I6myrxtba4qnld6cB4vxAOD6iHXDR+9Iu9aDAzoOwNX83XH9
         f/vw==
X-Forwarded-Encrypted: i=1; AFNElJ9s9YDQAayWKVqXN69eE9S831H2i5tBKGUeORKcnJh7QzmiFdACDNW0Rs2wlOG3b3RxhNNUzXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbdhAK5Kgx79w75KjMVQHi8R+bFg4BwNSqgsnEydShs9OrYeS
	HvyDR9hHt31xhR52kFVMtKAdKz08M/wzzhGQ1cXm8ZTyUnUUjrWFsRzY
X-Gm-Gg: Acq92OEL3GcFy9HACN8W3pvkwSGcfwwROIPIQgQf/M3iG54klW45W22uo+C2DlcrTR1
	jcSbLnfFzh7ajwNZsj6lnqqD0zsIhg29VgBElHyvpMHGhPrYZV1DU9jsgX4IowJ2d22vx4D+Kag
	kiO8lwfsnqqbW3GWzt9drDAy11XOhldPbKQkX0Ylss2RbkSz4mENymB7PstSMnPNh46V4nwGjG/
	cdcWal8Gvuwg6nNUrUZqkvkczzv0N+SksqO69FaCm9IJjfuj+rMH9j/kUftlVsgnvL/HyP+Tr21
	vFCdEHZdeBGf+yQqiY0SA6UP0BjnyUl2U3Gt0ZjCxaBIRFXNEhPBK7CgO8HcOcBCR/6ARY06JSj
	rTT1JI8B91K/2WeVc9jwKNEnMePBxA0bddpOJs8Z5LLRpbmvnG3V/lI8XeqiyuFEEzj/HOaoRPB
	KdRjtDTEQ/cieTy2D+8re0jKIcsnmfsKfaaFP7JmkViuYwj1xruHAqdKrHud5VGwTTR/cNCsxMk
	pAj0GMmqT7XfNYsf3UpX+DX
X-Received: by 2002:a05:6830:4104:b0:7db:e661:bb52 with SMTP id 46e09a7af769-7e4f2b15f9cmr1890167a34.4.1778863285020;
        Fri, 15 May 2026 09:41:25 -0700 (PDT)
Received: from localhost ([136.49.184.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4983asm1608373a34.26.2026.05.15.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:41:24 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: imv4bel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sultan@kerneltoast.com,
	sd@queasysnail.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through frag-transfer helpers
Date: Fri, 15 May 2026 11:41:21 -0500
Message-ID: <20260515164121.2608076-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aga1VyHpHaUhnGZa@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC42055405C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,kerneltoast.com,queasysnail.net,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-248878-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

skb_segment() propagates SKBFL_SHARED_FRAG from head_skb only.  When
segments pull frags from frag_list members, the flag is never
propagated from those members into the segment skb.

There are two miss sites:

1. Line ~4986: a new nskb propagates only from head_skb, but frag_skb
   may already point to a list_skb carried over from the previous
   segment's iteration (i, nfrags, frag_skb persist across the outer
   do/while).

2. When the inner loop exhausts head_skb frags and switches to a
   list_skb (line ~4999-5002), frag_skb is updated but its
   SKBFL_SHARED_FRAG is not propagated into nskb.

Your v4 GRO fix means head_skb will normally carry the flag, so
skb_segment() picks it up indirectly.  But skb_segment() itself should
propagate from frag_list members directly --- otherwise any non-GRO
frag_list producer re-exposes the gap.

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4986,7 +4986,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
-		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
-					   SKBFL_SHARED_FRAG;
+		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
+					   SKBFL_SHARED_FRAG;
 
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -5000,6 +5001,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				frag = skb_shinfo(list_skb)->frags;
 				frag_skb = list_skb;
 
+				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {

Site 1 covers segments that start mid-list_skb (frag_skb carried from
the previous segment).  Site 2 covers segments that switch from
head_skb frags to list_skb frags mid-construction.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")

