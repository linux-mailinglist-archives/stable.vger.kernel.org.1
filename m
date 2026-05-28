Return-Path: <stable+bounces-255048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKlXEzRgGGpajggAu9opvQ
	(envelope-from <stable+bounces-255048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:33:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8345F4760
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC271307F495
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466026E70E;
	Thu, 28 May 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzOoUkg1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E3176238
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982109; cv=pass; b=rs10fgrqvZ3X//LKakhw1zcBOJ2Akm/wMWRI/xtdrlUnWi2ixQimI/rUX3xaLxof2cfhUIohRmXgO9UpzaVmizJS6eeuUlxrAz96CLDFurmlMYA9cjjnc3Pn5PuPsgujbgZcER3iZG4A6IAUvTgjM3iBuuP1/qVq+igteI+L6sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982109; c=relaxed/simple;
	bh=QQZRMUyG4rdg9VbIhpDJ4B7GggxoScpV42/zNaHlETA=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6XBJys27QITSLYX2l9O78yagbFACr0FCYQQZRBD8JSUc0aOrlvgVmkeNYq2K8M3zPFiV+FoKoBdqPCRS6B2oWoLWx8IfRaQDhzHF+3DTaiNFcCG4+kBkMtBVZazNQlmGsT0GJz2wAv60p/dbicvw76HJJ9bo3emcx5r7aXq7vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzOoUkg1; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-439a7e828b1so10495221fac.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 08:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779982108; cv=none;
        d=google.com; s=arc-20240605;
        b=hiU1+nYHEnuwyrA10XS0W151iIqd/NgXkiVEan6y5E8Gy0BaCgWObKdQ9GG1hdORt4
         oKM3nVKimEkCFWuywjE+H17oybU2mjvqGWACJ63GiDT8ZjOpWz27DQjztBsPiQVoL09J
         JdQDw8VlTKvFKNnItrPC7bgyCNbOjhSAFuqjuOK6vzUkdRpsw4FAhSNxVzZDwymaaaim
         lqoexHqPvwcQuYkbL+lX2N4K0CeRH5z7O+ZcrcL40gNxFidnUp2q11DHSK9zUCyfkb9E
         ThKR+jvKpZb180lTH90Dz7WT2EytX6achnjd7FwSU/2q+dkZo0rVLo807BoEqQ+TbqBu
         qGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        fh=djTSjxKLH8AbU6yW6DjGvJ2oI2PSuTT9eWZ7aIT8cl8=;
        b=dZre1Qk8CJcr5lUD6FzN1WY7Ro+DE3cY94TCAsDqPToJqTZ+y8S1oZmp2NC28cwPyd
         9R+/orwV18Vw4lQIyWvgsRMlOgmSl5H67+2qVbMRNX3PFmceN05C8DJxKmcSTMYFHxtE
         3MxsPFSCndOUw1pXCNLrKnyb67qh3BsVagjmWeS0opigcS78o5HnVfgwLnj9jUQ6ADf4
         I/1njQJkJ6GBufEy9emztu1jElPyx3kTGyZp+FQ0b9WiubeLIysrszrErBFkw1nJz1m7
         xOxVl1OMl/xBeHtXKGVyoZsu7iFs9M3GtdHunSTbuDI1/BMfHzquihbgGKIIpe4b6j30
         6hCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779982108; x=1780586908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=VzOoUkg1ZnTWLmw5dWRm1Jk2re+9L1EkyBrTXhujJ8rLD6Hqdiljyplc0oD+BdEzkv
         bKutHvPStxai+OPb7JNj7p4HFxhOOeqRVJggLYpkyFfn/FryzsfSroleu9E0xl/DIEe7
         ZwyrNaGGgeJz0tIAyHY/srpCyV/EGPEiowWZbAfpBxr6Dxh3/p1i26c/GGFd2hpMBmR8
         CrHfki0XfzHqTWPT3z3Iz+Q6x2cEDwpLwrwgXhhTmXIW3JdUrH6XmsAL3Bjc3M+W2otr
         VYU0THM8UostJZvx0NlQHMh4kVBhiGjvyq1O3DGAq64peggqV9us/ZEq+IhwVsvGrRUl
         RYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982108; x=1780586908;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=IflP3FnjwVhx7u3h5XWP590RCze79CW9sjaIxlgQ3Sk7Frl5tthHaKhxvGIT8lZYh3
         GqksqYS6G8VZSteeFTa1QdG61jf6g97G8lkfIKEQrA0Ka7x3kAhh1MvqG+qZcElcUj2m
         4IYPCVZEm6bv30hUPbvxZj4yrFUpc1pEc2Q0mwHyHWJUsfN9pQgO8VSDphrSmhMUqie2
         QOKJqJGFGN89v2nenbxWxibskFsd1sBgzZLRJiAvp9gwekT9+a1qkPU8VhZzmWUjPLTm
         y7it1I3j0ZjwFc5v80GhL/TBwHS6u+0M4QAlPcqsDY0I5C36dZZjtOnO0xIDgXfswGlx
         djNA==
X-Forwarded-Encrypted: i=1; AFNElJ8IAapl7OyoVjh+EpOnLFyBWsuKMmKcZVA0nVI6W4ykQ7glT/toBWZzcrtVp/8F6vu+0S2LSRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2mgRMrF3aQIp2jAVaNFydb19mDImOQfLJ31UJvTTGJAIxZhSe
	4TCbfL/qDYPqvfkc/HzxJWiU6fvpuvYlH3oKW++3EDyHl/2sf4hkAGa0nQRx01e7V6wRItLpCWI
	NhFVJbrQk+P0pm5rE9gNv7kxqEViPvCU=
X-Gm-Gg: Acq92OFQYGj38KS2GwyGxGiqk6EHktZ7/OdiGhejGjSGke1uXeNgAOn5vkCEeVpSXvt
	nodyqlZHS3MHeGToHv+kSud5REzJtuW7FRd9/6qDwbe1XGh9plgiJLaLn2kCdh7pyZ/9cirxMJC
	VF0Ka7T6HkwjUlA1p8QVnR7bCkJcffpw/JKd/sS8zTsUVOVXKzhR1JDa6qZs2kVAYv4BwUJBlnM
	G6fTMPp0/3aiL7i3BcI871aCWRXnAXTQn4OYKJkQFIpEEC4rOZm5qpIL/6Ij9tO7tzu/q8XBxpy
	0bAN38Y7d04GzV+bL7Sy0NW7pw==
X-Received: by 2002:a05:6820:2188:b0:69b:85ba:bd4f with SMTP id
 006d021491bc7-69dfa8cc60bmr776345eaf.33.1779982108478; Thu, 28 May 2026
 08:28:28 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:27 -0700
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siho Lee <25esihoya@gmail.com>
In-Reply-To: <ahhNSscKHjx7bebv@strlen.de>
References: <CAOYEF6nf5-B-P7DHf_cpLaqUSoZC2FJphBqE2s4zE8MygMCb_g@mail.gmail.com>
 <ahhNSscKHjx7bebv@strlen.de>
Date: Thu, 28 May 2026 08:28:27 -0700
X-Gm-Features: AVHnY4L8t6Egmo5coWR6ByJIrK5IZmT-3tpDxVljiqUtl1hxBn6WdKFJ5bAIdmA
Message-ID: <CAOYEF6mb3K6=-+h-ayyVrSmXbxLVNXYgj23g4j4tJEaxvz5u8w@mail.gmail.com>
Subject: [PATCH v2 net] netfilter: nft_payload: validate offset for all
 csum_type paths
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255048-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25esihoya@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC8345F4760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From e11e35dfd10960ea8ca4258dfa6ed7aeb207179f Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Fri, 29 May 2026 00:23:35 +0900
Subject: [PATCH v2] netfilter: nft_payload: validate offset for all csum_type
 paths

When csum_type is NFT_PAYLOAD_CSUM_NONE and csum_flags is 0, the
bounds check inside the csum condition block is skipped entirely.

For NFT_PAYLOAD_LL_HEADER, offset is computed as:
    offset = skb_mac_header(skb) - skb->data - vlan_hlen
which evaluates to -14 (or -18 with VLAN) after eth_type_trans()
pulls the Ethernet header. This is a valid negative offset that
refers to the Ethernet header area (used by bridge/vlan rules).

However, without any bounds check in the csum=NONE path:
- skb_ensure_writable(skb, max(offset + priv->len, 0)):
  max() converts negative values to 0, making it a no-op.
- skb_store_bits(skb, offset, src, priv->len):
  A negative offset that exceeds skb headroom writes out of bounds.

Add proper validation after the csum condition block:
- Negative offsets: ensure they fall within skb_headroom(skb)
  (bridge/vlan rules legitimately access the Ethernet header)
- Positive offsets: ensure offset + len does not exceed skb->len

Also remove the max() wrapper from skb_ensure_writable() since
the new validation guarantees the offset is within range.

Fixes: d5953d680f7e ("netfilter: nft_payload: sanitize offset and
length before calling skb_checksum()")
Cc: stable@vger.kernel.org
Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 net/netfilter/nft_payload.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 01e13e5255a9..2c891c13bbf5 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -892,7 +892,17 @@ static void nft_payload_set_eval(const struct
nft_expr *expr,
 			goto err;
 	}

-	if (skb_ensure_writable(skb, max(offset + priv->len, 0)) ||
+	/* Negative offset (LL_HEADER with bridge/vlan) must be within headroom.
+	 * Positive offset must be within skb length.
+	 */
+	if (offset < 0) {
+		if (-offset > (int)skb_headroom(skb))
+			goto err;
+	} else if (offset + priv->len > skb->len) {
+		goto err;
+	}
+
+	if (skb_ensure_writable(skb, offset + priv->len) ||
 	    skb_store_bits(skb, offset, src, priv->len) < 0)
 		goto err;

-- 
2.43.0

