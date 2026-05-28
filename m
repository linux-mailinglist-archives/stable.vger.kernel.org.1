Return-Path: <stable+bounces-254990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHN9ENNGGGr2iQgAu9opvQ
	(envelope-from <stable+bounces-254990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:44:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D445F2EF2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC1C2300A119
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BE3F6C3E;
	Thu, 28 May 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH4d2LxL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624003F39D0
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975584; cv=pass; b=GgKnJGa7jdv3UhTqOhsuIKZZGU56CvXGV7ulhZbWZAynvArZ4ccBURHHHfRp3xnBdS+0mOKdrTzFZW3VhJcjQcY2mFx8d6nSZgwALOUVb437NeyGFVkGciHwNRZp7auRKGVfEJ/ZMXvDid7WB3ePwODYSYdVk/kNxApWa3/MwDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975584; c=relaxed/simple;
	bh=yw019RHIYxycqtwq64UtUDUJDQ24/M2csMV8DlAPgw0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=c5AgLEKSKPsRgHETVixP5Vw3ql+OKgmHdWRi14gcbavPgXWZ5yE4ttMMvEJOklCawXZjZMSHORzYrU5Kb6/wKeARM6D41KfjEhbn12q6m3HJpPJGC1lTy+9ixwyDmaxinGtHpwhbPYsLfAVfJ4emv9wK5i6phOLMVO0QIAWMTMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH4d2LxL; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69de16f5e80so955873eaf.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 06:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975582; cv=none;
        d=google.com; s=arc-20240605;
        b=lQRs1SQp8Qj5VAUab9KG8WMuAHUcZPSMFm7CC5RwthyWcIbBnQKLq3ZVVE7of9IZN7
         bm5+07AgK4rivh7cVIAxWi+X0/pjmswwpZ3rUkREowfK/32jIgAx1BygfjVvN1c3IiED
         Hp8FOZshUBAspxjECAvzjiEMCs36bd+lWaXSZi29PQ+dW300uPeggQL6HIDm1QX9/bha
         xZocF8b6EUtrkHhxvyc6FwGO5U3nD52SKg66WXiVPhIATkPYAbrxQMal0zCSQHFWXrcV
         +b1hC9TR4GH6jUaxkmRG2DSId/nHJ9DxhJL+vO8HsM/9DDpFxhPZ/9XKehnDDGGJfvF8
         lo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OV5MWD99v5jJibwQ0F1rYFH202co2ScZtiupmESToJY=;
        fh=KlEJwzazCwLDmXlKFY8gVBS5ibkJaIiaLPo4v2xORg8=;
        b=eQyz3Xw2Ls1aM6EyhM64iRPrRVCiCh9PcLEZICODApUI+iMfCR3fIzpXDYYeLQ3AEl
         tD+Qjou9EfUkcOCqeDOuDQGEsl4xv/bzlcpQ0X2tU9KvJwrtQHqTYAD9wH5kj0B8R134
         gjqmhjNPlLt0uRUsOJbiAh85fFNmWQpc3uC4TAEnnanad7Lkdk/qWJDC7eAkoEt5aF0o
         RkzTv3HGsg12jxy+LvVvRWAfiDmXCMkjhDjWlL8nkH0be8uAZ/21WPX5DsiPwNUX8u9t
         NbywK+kA/Yw93hDMn0KRP5p8fim+OR/qRMrYzfCgfPN8yngg9xzd5BSfsDyLtacMqSXM
         rr4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975582; x=1780580382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OV5MWD99v5jJibwQ0F1rYFH202co2ScZtiupmESToJY=;
        b=lH4d2LxLZepwO3Kezjd4XHcM5OYtiIVmZzGzAYcJLS/mEngBValeUxxK3RV0AHkjCL
         /K4I/+9N58xw966QiVMiztab/P6EdXYcdHlS7bgC9Q/XgPKEHbVzCCla6yPV0e6lr448
         820x3Ndwhotnz7ooe/YsjqVy++2Sq6RQ9zPIfW90OcFT9MNgG42XJ6TOfkz3MhZYzzO6
         H0dMV+wNrIiL4I2iLamLAJ7u46zWj/6BwqTyZUN8ZMayHEg0BBgXZIAGDVCoElj5A1EV
         ah5596D6oLY370pX364y2rLNqNtQ//OIJlRER1ot9l0Is+5RlJiupjpCr+rRLdEXc4Un
         cfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975582; x=1780580382;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OV5MWD99v5jJibwQ0F1rYFH202co2ScZtiupmESToJY=;
        b=Q3+G3MV1Zyh3oIUOKKx8tu63fS9T9816hQpn7/DR+cxwBB0ZvYFRqRdddW/kdUAbuH
         S3Dj9AAKdpQRjnOC7NMmPwvDJUDcQ9l7dOajXmRdv9oeTLdK/bnr7vUpX5KHKVfOdvJu
         zDZznH5SpyKcMbl8IoxPEaj5HvJW1X1LDRwKk/AggWE5mrJusN2NsJ75WE4xaa4SFeAF
         qCmS/Jh4nAq3IymKt6D1UfAcoDteqElwt287OkUclBYiStiGTe8t0jdYb/tQq7Q6sRXH
         EDoc8YHBTfjaOIVDbP/agE9ug+VMGYh+SzKGHuNSe/B2YRbnHibRjXiq3JwNY1DSq5uN
         irIw==
X-Forwarded-Encrypted: i=1; AFNElJ+NUudx2ZOoWFZITJL5Vqwc/5Nf/Fhe7sQg2EPUmlKMaWZ3NfMAT0PoaWNgE/ClM7dPrHqXDIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7z5AfasutpcJe8W02hkAiWsz4WlG4r42CxRnMWKlQ1KMdVKe
	L8mJFvfbztMW1EQl/enP+AmnPHei1geCPfa63oIw9nzKLJ4XAIljJYGG0hQHD5DClWmDYTB8tYC
	xUEIfFpLnLnnqZ7LSdSn/hpS/Xas7263E1twq
X-Gm-Gg: Acq92OH/cI6UfqnbGBrQObwaOysgRteylmOvZNpdCkst6CKr4/jcrcNGhWU+k+B7iHf
	sPBLH0WVtS2FCc2FfNJRPeEsdjdNxFfwyRnNHXECX5PonfCyA/kf90ddaEtTLaOJQ28LiXjlQFt
	+koQKBhB54T6xv/vYmMDM9o0hijLD3lUxHicqG2YHT9QSpe3keSCYYnxCGtkvuE1F+R/CcV2bQD
	Dgn+uGLAGc8lrElzY49kReA7/dEkKUzKcTRJ4H5yO2RMZHwiG69UZ/ryP5Zd07UfLPnPQ1OimDC
	fVTV0WFkdmUdrYGYqUkR7HjlTQ==
X-Received: by 2002:a05:6820:c203:b0:696:6585:a51 with SMTP id
 006d021491bc7-69d7eb66ac7mr12034312eaf.13.1779975582247; Thu, 28 May 2026
 06:39:42 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:39:41 -0500
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:39:41 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siho Lee <25esihoya@gmail.com>
Date: Thu, 28 May 2026 08:39:41 -0500
X-Gm-Features: AVHnY4IjQLe8D3fhmXisoI-4JSwxgrf6oHHC3rTfzHf8ykBiOBRC4gfpxJ5yCMs
Message-ID: <CAOYEF6nf5-B-P7DHf_cpLaqUSoZC2FJphBqE2s4zE8MygMCb_g@mail.gmail.com>
Subject: [PATCH net] netfilter: nft_payload: move offset bounds check outside
 csum condition
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254990-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25esihoya@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 02D445F2EF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 574604a1b4a98ee130d7f727ad3c8a7df3f3b6f1 Mon Sep 17 00:00:00 2001
From: Siho Lee <25esihoya@gmail.com>
Date: Thu, 28 May 2026 22:39:03 +0900
Subject: [PATCH v1] netfilter: nft_payload: move offset bounds check outside
 csum condition

The bounds check for offset + priv->len was placed inside the csum
condition block. When csum_type is NFT_PAYLOAD_CSUM_NONE and
csum_flags is 0, the entire block including the bounds check is
skipped.

For NFT_PAYLOAD_LL_HEADER, offset is computed as:
    offset = skb_mac_header(skb) - skb->data - vlan_hlen
which evaluates to -14 (or -18 with VLAN) after eth_type_trans()
pulls the Ethernet header.

Without the bounds check, a negative offset reaches:
    skb_ensure_writable(skb, max(offset + priv->len, 0))
    skb_store_bits(skb, offset, src, priv->len)

max(-14 + 4, 0) == 0 makes skb_ensure_writable a no-op, and
skb_store_bits(skb, -14, ...) writes to skb headroom (OOB write).

The signed-unsigned comparison in the bounds check correctly catches
negative offsets: (unsigned int)(-10) is a large positive value that
exceeds any valid skb->len.

Move the bounds check outside the csum condition so it applies
regardless of csum_type/csum_flags.

Fixes: d5953d680f7e ("netfilter: nft_payload: sanitize offset and
length before calling skb_checksum()")
Cc: stable@vger.kernel.org
Signed-off-by: Siho Lee <25esihoya@gmail.com>
---
 net/netfilter/nft_payload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 01e13e5255a9..62661e4eeb13 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -873,13 +873,13 @@ static void nft_payload_set_eval(const struct
nft_expr *expr,
 	csum_offset = offset + priv->csum_offset;
 	offset += priv->offset;

+	if (offset + priv->len > skb->len)
+		goto err;
+
 	if ((priv->csum_type == NFT_PAYLOAD_CSUM_INET || priv->csum_flags) &&
 	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
 	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
-		if (offset + priv->len > skb->len)
-			goto err;
-
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);

-- 
2.43.0

