Return-Path: <stable+bounces-235905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBW7IlR03Gn1RAkAu9opvQ
	(envelope-from <stable+bounces-235905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9DA3E7569
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87512303205D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72684383C8E;
	Mon, 13 Apr 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bsl+aEeG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96F37C911
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055233; cv=none; b=focpw7Enpe7B9LRFurVJ5XBrLBL+yxd82+caKvWUT3kIqXtlKNcZo6rCiN8oImjCgoZiT54WfMvtCbhHVMBrCF+c9I9DLdWOUx6MUDlVIkgzKoojJRHmYltlLAgQ9aUxzbk4CDNJrP4feKDYPR6+IpSYFzIBBkm6ELnFF0/qeY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055233; c=relaxed/simple;
	bh=eUByrnPJ2nona1QXhiPKoFAJ4ou5D+Pn4Dg2jpFDt6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEle8RnXFyZvBgo/m8O+nHADK4mDJJ7TOauB4N7KkETiHgZGUbvPLvvLdaSTYghpKbSwVF7BmIA6P1GxG+K24q+B699ZHajGyExUA8bPL4obQ1FQjUs/hgxa+alPLIViD4NcahAe7u1XaofsKIW/VDqtOmvrkLjdW5eCBshybXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bsl+aEeG; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso595769a91.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776055231; x=1776660031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=OSEZJyo+53worQaYOBxRU7xRbuefNHS/rydOYAVMpAr7zpGziqEYoG4n6EdUMtlZKn
         3Mcwww2UgwphBTLxTZEnf3S7iJXOmMOCG+EpTqOLz33I0FcxKKpA16ilHIM4pkVwQ6g+
         1OIqZFOaswFo/9Lvd9VZJWZpCC2BGp+ojn+/V+5q8gm1/+bGSy4eLT1CXfEln6hcMfGw
         xTbrtHrb23rCsfGfxKU53QIYQifkqnQTLV1UQ6FCs51/IGX6ZWf4RnEZHZgYyYAOwJWQ
         xwcdIVQcSpJHQiD9f8YN+s/kzsCA2XKf1Qj+fYt2NDLGNBYXdvz/zjQmGyPt05aJB/jv
         D8pA==
X-Gm-Message-State: AOJu0Yx3S7jI4Oxn6HiXVFkbryGf7XQAdn6mGx3ukhUiwZchsIU/sj4i
	RtdbT+DkzZ5l6uIUG6HEkV9XTP3xrqpVH7z7MDSmrcacZdXu52VWRVrDKfiMKB2DPKrVX2ulZ1b
	U42GeE/dme7N1WoP/Rh7fuKM0UoVI+5EvZePilQ+Lx2GANpLY9w5Qrm7g/AG+PdRjaLmU9gzPVT
	NNnmncdqPM1fw83HVy6Ei4iRZ09XxxebEzezDEqnWf6TXP9DGhnc3Upc8vGzOIfZseh+VAY54iC
	ayxz2s8Mw3m9fiL3bXE5D+gOUD9sFY=
X-Gm-Gg: AeBDievQyfg62ks7ZpO6pe9m2SVAcSHwfaTbfVVbZgEjaP+GjcuVLd5xV3+ZOyBvRv8
	qFiDOkdcQ3bRotEfKI55BihCvjLDS1mEl7aS37kuO+HO2lKsI78GzRg7y8Lc+5/dRmou9S7GpTg
	d38QHDkiL/1NKtA81yyOr0LaZgtfE+fv3xwyeZsqLZW9wHhGFDqz/FhixMXCI9SzoMPE+AKKJDS
	n3d/t0zj+fmuJmH69P2lYFj0BB0Ic4EtSB0ASl3pQXMWz/U0982sIp0XG8qcKTRfdMd+qhobYYV
	iq/mW6/FAzOpP6+hrImggfxEPPJJd0PugqY1zJRHG5E8kzTGP7a8xbwe+UANMLhIheoQ+N+rvgF
	3BwEcyDWJ9oq1/9nvGe9VaWVMnkdLO3Mk4ENOSVPh4yhJIJvN98rHcDXXt8S9qPISlOvVt3zRI/
	DBog1qh6Pas4BwqiVHa3jW8Lyc+Kw43lbnDhQFxmMPAMd24G6bQOoraRArJQaERysbDzQDwc27a
	g==
X-Received: by 2002:a17:90b:3c0f:b0:35d:a87b:ef68 with SMTP id 98e67ed59e1d1-35e441c455fmr6997058a91.1.1776055231433;
        Sun, 12 Apr 2026 21:40:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35fbac670b3sm108151a91.8.2026.04.12.21.40.30
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:40:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d4ea15b4c3so28668eec.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776055229; x=1776660029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2l7i8vnpUJQTdJaWwY66SR5P0SKGOILNorZy9BBZKRQ=;
        b=Bsl+aEeG4YLqFSpfbtV7Jd9pMFk2JSju6AQGoN4NqSduQqZnCgkIF8Ld5R94KaR51M
         sZC4bVByMRuFyGBgGuFzVzda/YmbojVV8OZcHIi1Rt4g0GOAK5gxZsC4S8UrTTrtYUOW
         nA/q1LToHVseQb6q9tXlIO6+Si3rQ2LsU54pA=
X-Received: by 2002:a05:7301:1e84:b0:2cb:de38:c76f with SMTP id 5a478bee46e88-2d5c3f14ed2mr2494774eec.6.1776055229018;
        Sun, 12 Apr 2026 21:40:29 -0700 (PDT)
X-Received: by 2002:a05:7301:1e84:b0:2cb:de38:c76f with SMTP id 5a478bee46e88-2d5c3f14ed2mr2494757eec.6.1776055228195;
        Sun, 12 Apr 2026 21:40:28 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db64c4sm14677061eec.27.2026.04.12.21.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:40:27 -0700 (PDT)
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
Date: Mon, 13 Apr 2026 04:33:04 +0000
Message-ID: <20260413043304.3327873-1-keerthana.kalyanasundaram@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235905-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A9DA3E7569
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


