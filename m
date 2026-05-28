Return-Path: <stable+bounces-255047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBrWHjJhGGpEjggAu9opvQ
	(envelope-from <stable+bounces-255047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:37:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B15F4820
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE9363006470
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B126A08F;
	Thu, 28 May 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfuDqkcx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3492E7361
	for <stable@vger.kernel.org>; Thu, 28 May 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982092; cv=pass; b=STvHTSx7aqAGsosMwE9EiLbhF0GablZ6NRlncBI5XNwA0nhHvKYofoSU0Qg6wiuIbHbIb4Zs3f+cFMe1VkGdM3LJ7zwJbluUdKPOK1e1cqLguQ/A1L0nRTsHLylnY4uG5kga+pbkRye8q4cDsfERQqz1trdoQzkJQnScxB2UrJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982092; c=relaxed/simple;
	bh=QQZRMUyG4rdg9VbIhpDJ4B7GggxoScpV42/zNaHlETA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JmH+UyKhDdF/llYdNX50rAJhMhlCho59nVF1U0RcDLBQ7IwzONqQXdlzs4rVoGaUjUz2IVSqETmxTp6RnkdA3eBnzKKF9UQcJytoO9wkNZAYtz1JxkKhMXwhk7ykoHjmaKoKm8NQ9p8wnEr1/rH2/n6bb3XHZ1vqS8dQ2zc3WXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfuDqkcx; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d774f16ffso2607642eaf.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 08:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779982091; cv=none;
        d=google.com; s=arc-20240605;
        b=hT/Q20I4ofWJeUlKImfumzb0JBTMbRdxvA/gbaIbPVADgeQc2nQ/Xf/37B44sWVDjA
         xKynSS/jBswTJ/TAdYuWDYAWPnZ4kwwbvim0foRjfPUVvYFaQ7LPuM1W+hCpOEur8nzK
         t61ba0ElucoLoHiETuFrlnpQxXbnmu/1ZhBvdLrUV0bre4jqOeF5/9glmoCR4PajsSVV
         Abzv0SLq9mBMt05EZ63W0NlVMigodWRJAD+GxmZ6k5AlzrNTj2OVY9v4qYlunpG8UDtv
         6P6Q/WnKuupptGBFFCmGUoSIAZHVfLlxdNM6rhvuk8mgyHv3hME7O4EjgLw+k1Mgl2+W
         Ojug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        fh=6DVKTgGr6kARr2Mmf/XvkDvdlglgJ3vcfpn0ZZQ1IwU=;
        b=Gl/mFJo8sG0IE7/SGh2hB9no08z+dw4DvsteDQpDHJ7TpQ2/0r8/TtaP4eUBzDxrIt
         XbV7/DErdqeED9VmPf24KUNoYCRbcolwfoZVg+N+ZMSvS7cdRoiAqjz9t9IZGrjj7znr
         sse5GbhJpDJ1fs1YZsZQ+2vfu3HV899ryezzklEM3AbT0gpKu5wa/pK4pnjKvp+U2bns
         g1GR5na89W463m8bJjkQTX5lBFcHf2S3ml2uNiQqxmiZhIeGmBU6XM8T/MwMaJDaoIRZ
         6Tjwar1AFaJ2tBVASOeHg/BjQuKjZAePRZEwAEfb13JSNeLhDYBrA2FXuTQrxu8U99vV
         mx0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779982091; x=1780586891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=GfuDqkcxzhGtWCb6j9Jt2pXXoNhUxA+e5Bj90cyAGSaO5tTVYQCMR32CQMI2TAU4VQ
         0ktrTPAvf9T32ffX9N604td1xtaVktw1drvJ3ut2zvn8vNhRkUPYLpihkJfSQfD2jQdi
         kTvp6+5Y0LYdnAir/AvH5YZgWpzTCV8+FZT6IB8bgLbhBJS8X05RW/2hH25RLc6R9tSM
         BCA3S3XDnS5/TBZQVT5+P+6C8mzu7FAlbZtj/XRJ+oo+ciE1QxPHNf69/a12zlU4O5P4
         v4/1hJS/NVZBojFdQ2ysczS6WTCtIPC+XH2CzVazt5jn42iAxDqqNtDXdspsVwrje6Xa
         YrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779982091; x=1780586891;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0leLrUUC77byTFf4T2aIVlZtxOK+NbeHXiUHb/7zfE=;
        b=W7ZD7aKywUC9qKnvuSpn4Wq2hd3W0bKtQuFUnksAFRJGHkA7JDiMgYkOVErmUwIegR
         d8KvvoSfB8maCw/23iyZ5W2pcAuz/lq4KfX0t/r0sOMA9OsYVD2Vzt4b6No7jrmBp81+
         /30Um0cvt9CksR7gWir1IdG/JXDr61KaUIAUIMXXBpXIhWlW6U3suIvuGTaQULzuPjRw
         84PVUcfdlrDo16Iw6m2MbyjPRMEz69lUjuez5STkOVmIsVE4D6QlMdZtP3tNBMeqYAdu
         ThKhfEtLoBGCqjP1tVswS+edWkrKaReZoxpdLWscltMKMPT6pPzH9v/QaVRsL0hQp3i6
         Eu4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+JGn3B68E5v1jujhsLI06CrrFRHQDZHr1kEkohw/wU8xAdeUXMw27mBEC1lrlMjCEvO8wwlqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhM5/9Bv+Ld12H2+erirjrtIqx5DbgF+GViilIoJDHi96i8qs/
	NyNyzGVblVjDxbbUG7RKC9/HnsMSFK4fzOJesO5ZywY44lW2rukYsOfzpRrHErmxGzoBoyhqdsj
	ACZnewBQmVCRRvCoeCaHIfc9PC2O1D/8=
X-Gm-Gg: Acq92OGU20eAYtH3UaC1xHfYFn9ZxYROzxiJiiZ53fpHWTUYfBqBmAfZCDg7poPD20+
	+geIfr/V9coHCd9XTVtTbp6FQiasG0Fr2eKNptksMO6hsO877iqHdg8RdsMpSxLbsiiHHnfxZLc
	+SLXpe9vrGWBqIn48fqFWXrL1X+ZBchnCeoGEV8DFpwlKcgYC8fJKxdT3pHck00adIjDLNm8UPE
	osvR0eajltEyD2Rv/uQJYl6A38POYrxWHmUwRiukJrW3QDtnrMnmLfTW8GCKabdHNloSmm8ELmp
	r32wL3h4uavvZVYEWDX1gQzoWg==
X-Received: by 2002:a05:6820:1995:b0:67b:bd89:90ed with SMTP id
 006d021491bc7-69d7eca473fmr15377134eaf.41.1779982091287; Thu, 28 May 2026
 08:28:11 -0700 (PDT)
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:10 -0700
Received: from 469456477896 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 May 2026 08:28:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siho Lee <25esihoya@gmail.com>
Date: Thu, 28 May 2026 08:28:10 -0700
X-Gm-Features: AVHnY4IdqTJ7zDmth5WMGZnzwixk6rFBEMqwDoQ3EpXt7LiTgL1t7notH1b99jM
Message-ID: <CAOYEF6nkrD4o_Kw_gxbv7Vefxpp=E6N4X_s-3KEcS1f3Hb1uAg@mail.gmail.com>
Subject: [PATCH v2 net] netfilter: nft_payload: validate offset for all
 csum_type paths
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255047-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[25esihoya@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 254B15F4820
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

