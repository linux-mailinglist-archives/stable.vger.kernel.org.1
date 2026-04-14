Return-Path: <stable+bounces-237732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM8RJADj3WnrkgkAu9opvQ
	(envelope-from <stable+bounces-237732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:47:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A123F63A5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39A4A3068D7F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6DB36EAB9;
	Tue, 14 Apr 2026 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ti2EBGoj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF736E465
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148818; cv=none; b=lXucwwshqtInimhCrNXXTd2OzNNTdukpWdHgtqbVS/d7fHHO9fmJ4o2yPd6LLeJ+skRBwXU4GXVoddN5Bx2ymoQUX4NTIMdjiDxBLaClHvnsft+sZUkW6uYQVKzT9U05AzcvfqoDMcQW0qjorUrI+WyIyMFluAZs9U8vFczxFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148818; c=relaxed/simple;
	bh=eUByrnPJ2nona1QXhiPKoFAJ4ou5D+Pn4Dg2jpFDt6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGfsius9L8SsrGUFTNdXtPablRKT2AM2C50zhN2ksykitEjyeHd7Bltm1qFk5rPLe+D4xlqQNPC1CIoawkCqWMrUyuXG2Me24Pk4Xjw9wMranaP53vB4+NNQcPmkMNLhLSzVRZ0637OUOGfPe7pC9oHD3XDsP89BBfAsOIgGaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ti2EBGoj; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35daa02ea08so571168a91.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148816; x=1776753616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=Ve7wC5YN79d1xL9ve1EZVv0HH/hQqKqdQg4o//8aqflHsQO6rETxl6bYBvJcfQ0cxo
         5nfKImiohp8gaNfzeAYxqEaznnPYhF6vwRUKLdXZ+/II2Jgqt25GC8wr/PjoaS2YSLNZ
         9lDsviLuJrAGWltaRqHWyb5IuSNxJxC65S9+nHRwsby/Xq3+19uMhKm+qWJI1zxE6oF2
         kbwVMJDlUMxv7K2sBIFUexA7NP5O4Y+lEUiyN5XXpRTBUVOhG9q8tfTfYEXbEuZ+4g7f
         WwSK56ShUhEMdckn3KJNaFCAi+a5nFKRyIDDCgNj8F2aK6MEM9Ezo8XRSaJrw5AQd7o+
         dVjw==
X-Gm-Message-State: AOJu0YwmF1WLL+E4rQoMo1gILJ5WtLBjq54voMFQmYISxNHmPIgyB31d
	7d7JmS0qZS5p9HKriKq7lA6GV4Su+Uvz/vUpJgptxzhgwWg1a0zP1kPFgJf3aNjyXKB3wngcJf9
	OsiURu0cquBhF0Cz1dHjOst5DHPLrbWLMlTs5WLrifxz4Rct8YBx/S+bcKeXtCjDEBU9k4mQXER
	NbbAsUu2q7MqkoGQ8tWznT1NEr0Ovel2HvXwhRftDXQunfl6+a9IkI72cIoNmHyp8zjcrOWOLTg
	Fr+XLuRqTU75eo7LutSYNnheI3GWks=
X-Gm-Gg: AeBDieuiPmxnBqvJh3Qg3x0E1xc4XodEfUIk50r/Vr2eLb5IxjAFHpx1nC/Ohgu0dSK
	y9qxdX3NflWM8VdN5ktdYRkloJUdxpq+3aYISHtldEp00F427wQR5Gh0fPxVu++kZTqm0tnXrma
	sKPG0sbCshRadSrLRkw9rQZ8ErDXBqXvimUL8+x6pkatQiU/lDfaoVuAovdBXWj4YVWiIcsphBN
	ZvSBVuzBbAnohUfUlA0J8E5BCUqvOvj5+LjvT/1Sydutbm5KVTOrpqDCsocAXBq2TKxYJQl2Xmg
	Xnv/OnGdY9sfh7rGTBcqIr2UlV0Hk8kz1jkloawC7lXER6KpeNq2oj4GCGszZi4WTBrrH6S/ekT
	Bca2VJ9cwd3HdiaSsgIJJQfN+PZgf0PnDKhfNvSKe4lBIrZuivnGhHRoR/pyU8Pew0gd/9hlkQB
	fY7kHa48wUnCS8CSqDrSjcVEORWEH8Ge90Fc/v09XwwSZcYCj5GhYujVsQ8EPNZpBG0xZ/LRGHr
	5VR9XtIw6am
X-Received: by 2002:a05:6a00:3002:b0:81f:453d:1ab9 with SMTP id d2e1a72fcca58-82f0ed10d84mr9661228b3a.3.1776148816438;
        Mon, 13 Apr 2026 23:40:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82f0c2ff0fasm937941b3a.2.2026.04.13.23.40.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 23:40:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d45ebdbc9fso104170085a.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776148814; x=1776753614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=Ti2EBGojhCEoCjHxHmHkv1o2ejoAfa6151Jh1Nh6c07CljOglc3Gg6ilw9iYl3JpGB
         MyCp2ORQ054YiPpwIYlIglO58Sqv24PC0plyxkj0v9j+V8Xu5h4yyx0afm3nrrgikHhv
         YJOtXhgylpAmOE1lrjxoGAuNW8CdR6HZ2Z9N4=
X-Received: by 2002:a05:620a:44d1:b0:8cf:c757:f1e8 with SMTP id af79cd13be357-8ddec1f0d27mr1636848285a.7.1776148814461;
        Mon, 13 Apr 2026 23:40:14 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:8cf:c757:f1e8 with SMTP id af79cd13be357-8ddec1f0d27mr1636845685a.7.1776148813891;
        Mon, 13 Apr 2026 23:40:13 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aca5222c8esm71566416d6.28.2026.04.13.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:40:13 -0700 (PDT)
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
Subject: [PATCH v5.10] netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
Date: Tue, 14 Apr 2026 06:32:43 +0000
Message-ID: <20260414063243.4062926-1-keerthana.kalyanasundaram@broadcom.com>
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
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237732-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_NEQ_ENVFROM(0.00)[keerthana.kalyanasundaram@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 25A123F63A5
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
 net/netfilter/nft_set_pipapo.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index a4fdd1587bb3..83606dfde033 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -524,6 +524,9 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	struct nft_pipapo_field *f;
 	int i;
 
+	if (m->bsize_max == 0)
+		return ret;
+
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
@@ -1363,14 +1366,20 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
-		if (src->rules > (INT_MAX / sizeof(*src->mt)))
-			goto out_mt;
+		if (src->rules > 0) {
+			if (src->rules > (INT_MAX / sizeof(*src->mt)))
+				goto out_mt;
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
-		if (!dst->mt)
-			goto out_mt;
+			dst->mt = kvmalloc_array(src->rules, sizeof(*src->mt),
+						 GFP_KERNEL);
+			if (!dst->mt)
+				goto out_mt;
+
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


