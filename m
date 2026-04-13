Return-Path: <stable+bounces-235904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DlYDg903Gn1RAkAu9opvQ
	(envelope-from <stable+bounces-235904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:41:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140C3E7544
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E5773026753
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB0383C92;
	Mon, 13 Apr 2026 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SO588cYn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4E37E2E3
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055216; cv=none; b=asPqXyKRemzioRGuYmLVrlrV4TXiAbqtxJqAZq93vfiDD2+ukrjyTxHLb57YbL8rE7i0fFG5mPYsuZGzqb+vz6xIOG5U2ng99BaJPtwr/yoU/LFvHTtWmMCRWONOzw9Mw1AhtCxp2W+s3fpLrUkamCetz8vE8GtJZE+w47F/BeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055216; c=relaxed/simple;
	bh=32i2CGMRFLkk71ry4kqEvU3i5K2ngl/kHrRJQNNg15s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpPGXM9V2qr34FAvwFx0vI8gdZBr9ESiY0DL+iA32KRLgvi5zhIhX3rWMkLmPpcwlwQKa3pQPqheJZJalJlDWsM3zIvJ9F9duEa2SYlGDCycahkhT9gib1pcnVPyzbbqsL1zt/GuGdAh7+RyXHxMbsswUQRp6Uwi4XzbfQOeMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SO588cYn; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-9539b4df32fso70124241.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776055214; x=1776660014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEhC8dL15vha3u2nezC8YntUF4AHPl/GJlnlwSrjKaM=;
        b=UsVSLpRVPKTO54cXIn5SS9woeHswRI2dGptFa86on3xDdizr5sW/PpKP8cMutmsoFS
         EzD8n8MCJw0WmFfRCHE2GvNBTUXVUM8PmEbnyKmBviKH9TG9F/Kj6LJ7/hRciWfqE+yo
         aPi6350udsruHOS4uKV8EHUQpLV0yo6A1PUkgafrIlltRNDAfMqSf1GMdSTWpT7j+5Fu
         imjZtSlj1We/da7jnc/tV81FwX8td/cg8QVYfiqwS8AfUSKTp4TwU0cHzVsLqGvb7ANZ
         6f1fgM2qajYKyu1cVX7yZV45AE4EQpfvFzM1rF+WSuqJhl+mXyw0WtaG1f4loZ9GEMLr
         OLWA==
X-Gm-Message-State: AOJu0Ywmyhs5XJBS0QYMCumG4sDnZhA+xgfG9qx51yH9ig3fR06MZ9wd
	qi6atksxyQEegncjbj5A+8MUB6+PnYAvyCzJbtUxVKVdueTyq70I2bvvfIvKf0qn+NBEsoBqofD
	O+Cj0KR3gcb73xE7CNPAs6jB+s/Bg49BlHiR7Xnc6pBBajSo394wT2fdXqUwExdkSF0htUtdX+g
	TpAKhYhigyDXmCxvchq6D/bQHQvu+NvjjJ1Rle6K5doY8aq2t/xCr8QV6rNB6qD4ijNBXjb4QQT
	dta1tDNG/B09XURD7Cq0TypN3ulEoc=
X-Gm-Gg: AeBDiet17zzfuvZJZjdy/RZYNYFiAJiEGrxunzPxIw0IXPV84eSjJw+MnKE5vYi48dW
	IR7IoLq9VzXgpk20kEU20KK50hI8MPOl41qfD/ILBVQbeiOZIm+hGHBwzT1hmHHDDG+1edsuDwt
	gA5olDpUwttMtVfm+dr+D7i6l3/e1tCPLLh8dlweEzyoNCnPHHs1++K22rCjmTrG/pXcjId55sq
	HG+x3Nv0FW3hIYCAn2FckNFqXvTRKlMkUSe8Y0dBgKqEUOtVX3HxfSYMRLFBHO4p9haR1mAFkFo
	Du+SMmrGlrhunJQczSG3RYnsC/40qA1D9GlM3EDnvj/nWGXmD2vhBlikp42TMti3E/9WXUpQ9e1
	rrjeazeUM7SJBhzOIVSalx3/nDj83758eILDmn0cVl3GkkRheCkWx9jZrizSStolqk3+Q4yreUj
	PiDEbTmmYqKwiuM1mAvhww57BpbCBzgp+dxI4IgKkyel2e6UNzMXAVLw49YJC9ftOQuVIDt0cod
	A==
X-Received: by 2002:a05:6102:2413:b0:602:789e:9dee with SMTP id ada2fe7eead31-60b2e77243amr1147422137.0.1776055213568;
        Sun, 12 Apr 2026 21:40:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-609dba10814sm749787137.24.2026.04.12.21.40.13
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:40:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8a5bf7ee420so13279776d6.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776055212; x=1776660012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEhC8dL15vha3u2nezC8YntUF4AHPl/GJlnlwSrjKaM=;
        b=SO588cYnpMSCK8ejZkVQ8h2BFBcwM1VVp/9ajY/xxmPZ+Ir/4sPgpSVTN8K24cZSwf
         ZPcgEJZ8NBlyX2z9e6sYnGQ6Bu2poj9Pfuo6Rk4i2sdaDSXn+K/FK90LQq2bst/JlWR7
         sjFL0ZA9gV8Eb99crGO11wK0VmQVqPiuWlerQ=
X-Received: by 2002:a05:6214:2424:b0:89c:5159:ea52 with SMTP id 6a1803df08f44-8ac8627aaacmr140468986d6.7.1776055212475;
        Sun, 12 Apr 2026 21:40:12 -0700 (PDT)
X-Received: by 2002:a05:6214:2424:b0:89c:5159:ea52 with SMTP id 6a1803df08f44-8ac8627aaacmr140468666d6.7.1776055211924;
        Sun, 12 Apr 2026 21:40:11 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca5222c8esm38017646d6.28.2026.04.12.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:40:11 -0700 (PDT)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Stefano Brivio <sbrivio@redhat.com>,
	Mukul Sikka <mukul.sikka@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1] netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
Date: Mon, 13 Apr 2026 04:32:47 +0000
Message-ID: <20260413043247.3327855-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	URIBL_MULTI_FAIL(0.00)[strlen.de:server fail,sea.lore.kernel.org:server fail,broadcom.com:server fail];
	TAGGED_FROM(0.00)[bounces-235904-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,strlen.de:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9140C3E7544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Florian Westphal <fw@strlen.de>

commit 07ace0bbe03b3d8e85869af1dec5e4087b1d57b8 upstream

pipapo relies on kmalloc(0) returning ZERO_SIZE_PTR (i.e., not NULL
but pointer is invalid).

Rework this to not call slab allocator when we'd request a 0-byte
allocation.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
[Keerthana: In older stable branches (v6.6 and earlier), the allocation logic in
pipapo_clone() still relies on `src->rules` rather than `src->rules_alloc`
(introduced in v6.9 via 9f439bd6ef4f). Consequently, the previously
backported INT_MAX clamping check uses `src->rules`. This patch correctly
moves that `src->rules > (INT_MAX / ...)` check inside the new
`if (src->rules > 0)` block]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/netfilter/nft_set_pipapo.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 863162c82330..2072c89a467d 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -525,6 +525,8 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	int i;
 
 	m = priv->clone;
+	if (m->bsize_max == 0)
+		return ret;
 
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
@@ -1365,14 +1367,20 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
-		if (src->rules > (INT_MAX / sizeof(*src->mt)))
-			goto out_mt;
+		if (src->rules > 0) {
+			if (src->rules > (INT_MAX / sizeof(*src->mt)))
+				goto out_mt;
+
+			dst->mt = kvmalloc_array(src->rules, sizeof(*src->mt),
+						 GFP_KERNEL);
+			if (!dst->mt)
+				goto out_mt;
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL_ACCOUNT);
-		if (!dst->mt)
-			goto out_mt;
+			memcpy(dst->mt, src->mt, src->rules * sizeof(*src->mt));
+		} else {
+			dst->mt = NULL;
+		}
 
-		memcpy(dst->mt, src->mt, src->rules * sizeof(*src->mt));
 		src++;
 		dst++;
 	}
-- 
2.43.7


