Return-Path: <stable+bounces-237731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IQiO7bi3WnrkgkAu9opvQ
	(envelope-from <stable+bounces-237731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:46:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D393F634F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DCE4303FAA2
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15E370D63;
	Tue, 14 Apr 2026 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Eu6URQhC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D536E470
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776148744; cv=none; b=XXzyI24zUC2d56yGWzeF+adcVR2i31z8V3o4PziON34su/uqrNubspOayXQdUfC1Cq3o+PLvFVTfVvr3B+oW1LhZWQ6gRewzlWkOyBCCymicpSM+So4ZrKwwSONqs+/x9gXFLC9r3GxBCO+4Hhl7HsKc7zGXPbrKgR8Ps2C3Hf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776148744; c=relaxed/simple;
	bh=5ww9EE9Omd+lxTQKlJOWj/4hV3jbfueaHdGT5uwPtjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3ZiuUiLcifVL2p7e/iOUfWOhjpEJDnxXSFaelkkyG0u/gamWA1NGU0YbMMS+AUsCkeVjXDy54Doidz2cuZL8fSZp9X/Jms1ojO3o8t8Bn5+TMGuJ64jMchC7cTWMiLqzJR/bXys9snUuBNT2r3lTec6eGXngICimOsG6ukSKUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Eu6URQhC; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8a50968fd07so6485606d6.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148742; x=1776753542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYL2a3cReHZZ5YSJ0wmm3zCuDsPFAtU2gKvk7jCr2V0=;
        b=PEFNcC0RnOVxUsXmAieI3yPIRG+kUqXBL4NRo1f8HFdBds1uSjo1mAxJ1ZF7awXcv+
         FaCjWFFisxxcv/QBOOxpDgpZZadWvtxnki5wJ1VBlN+vUAYtYDUx3IBJKUVQUIqUaUGw
         LK4NRLHzSH1D82UqX58ijrDid0rQAltYQqXZ9ockVSyRUXgBNl+MaW06DbPXjCXbx+3n
         UDRs/ce57aHaKPPPg4YxwmfB1IpEpb0o7THTbkikdrXI1vRVs/bZ5zJ80hjAKG6KFppS
         Byjl3RdhdZPu2FpvC6odG+oOEOzae0ERVX3z2/qGkMaVKwpKyDf6JAIDOpepqYcTi3jj
         Pv8A==
X-Gm-Message-State: AOJu0YzTFtY7yHairExbgNlBqDJhaJvIRdIMv/0tyR3cCpas42u59+qt
	zWyXBOl1L2OZqQmX/7jLbXs6Ryb2fILhXpj8Y2I8lTvDyTV1Fm453YBbiZp0nWsnGWdzKgFG55p
	mxCddt8/6xDaWac9T+I013CpMuVhtOZwm/krF8LrsX/Ffw7D+vrbZ3G1odQ5w8E9LtdJXkAhQUg
	OgC6AUJhV+iq0nZZmOS9GotNtDoeHSzleKTp2GzxFzoAzVY3U1nQDxBdolyJDtbYphhqeDuIoV6
	6JxS1TxniavaQBz3oQfFVI6H7pPlA0=
X-Gm-Gg: AeBDieuqRY5OXYCHjRu+x24KLDdMQfc5yBezrJg4x7B3v4myxD5+RYPXupn7rR3onn4
	bCwhxzZkPDO90/54UzTEE0OIFEV64DhgtBWodVo17ZkMFIOe+8ADUjbCehDUT3dTsXvYzBkAQt+
	x8HlVQmLSv7Nx4xPok+Rcyl35CBMbdMxBehg+K0tVegBFWv72uKq/ttSeGDxake5ZT/SfMInZ1W
	HIPGskrNo12mCxV2Ol5bHtV6jWvonpOIud7rElB6JX/eAvqlCBtcHP9ZBqNZIJnrENrYsxHyoQR
	hNY4Zhjd1OvUteDrSDNfD8hiduVtHangAwnp9FPy6LB2kTbpvOqjOyHTnCSzREQSNwJTUDKEFul
	1QFX/X8DZaWNmvqRFcePzisrkPeVozp0e03/k34+lRg1v1qTi7KA4pye3dSmz/DuxCHKXxK3pY3
	QOyPlvBfW7aSUWzCpD6GLgucM1bFFyB2+LnbBH6+tWuJ9e14NXBDlzOMWFzXc9aULOjVyw1yVtz
	dYRd2CMPPG3
X-Received: by 2002:a05:622a:4c06:b0:50d:9138:3322 with SMTP id d75a77b69052e-50dd82ba5aemr170244971cf.7.1776148741700;
        Mon, 13 Apr 2026 23:39:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50e06df140esm1480221cf.2.2026.04.13.23.39.01
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 23:39:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12714223a5cso656506c88.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776148740; x=1776753540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYL2a3cReHZZ5YSJ0wmm3zCuDsPFAtU2gKvk7jCr2V0=;
        b=Eu6URQhC3iV+FnxPjArmO6tA160eauufzD4dJrNcAGsjIEKmhoPe+M155F533tudRM
         aBOuuIHfTDbnk8XaO/rMhC9jeTdykKu+Ucy+WjyTaeH0N2oaKJTwr+K3CmD26fAPv1cB
         AXqdps3MPyjfegbB4WX8ZDl9c+6tZqCxukoAA=
X-Received: by 2002:a05:693c:300d:b0:2bd:d8e6:90a0 with SMTP id 5a478bee46e88-2d5c39f6544mr3735056eec.3.1776148739985;
        Mon, 13 Apr 2026 23:38:59 -0700 (PDT)
X-Received: by 2002:a05:693c:300d:b0:2bd:d8e6:90a0 with SMTP id 5a478bee46e88-2d5c39f6544mr3735024eec.3.1776148739232;
        Mon, 13 Apr 2026 23:38:59 -0700 (PDT)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5630ac330sm19396261eec.29.2026.04.13.23.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:38:58 -0700 (PDT)
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
Subject: [PATCH v2 v5.15-v6.1] netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
Date: Tue, 14 Apr 2026 06:31:31 +0000
Message-ID: <20260414063131.4054234-1-keerthana.kalyanasundaram@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-237731-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email];
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
X-Rspamd-Queue-Id: 69D393F634F
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
Changes in v2:
- Fixed patch apply failure

v1: https://lore.kernel.org/all/20260413043247.3327855-1-keerthana.kalyanasundaram@broadcom.com/

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
 
-		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
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


