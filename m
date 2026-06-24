Return-Path: <stable+bounces-268070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ahg5IxR3O2pcYQgAu9opvQ
	(envelope-from <stable+bounces-268070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:20:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D116D6BBB95
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:20:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=We4dDDJu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268070-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268070-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39EB301ECFA
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2DF38550E;
	Wed, 24 Jun 2026 06:19:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714A1C5F27;
	Wed, 24 Jun 2026 06:19:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281996; cv=none; b=Rgvecc94SAuL4Oz64nqphUzzzVTOqimRbDsx3w+p26HPGPBVAsDeyaKKs+ujfk0Haj0jqWJH21Mpl4ba677hQnuFzjm7dFaq/9ecr3I3tA9gcEXiDlXHdwtrpU7/I5HgostcvBYZ29McJEmEBZqA19o3AMNFZPrAO8yk3txYkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281996; c=relaxed/simple;
	bh=Cm8uxm8lEwj/kLkx5WD6HgrQFavrQweJc59P3wASls8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aeIGS0lsRgda5KOsVt0mlhlWvsvexsCybQitOVFTzq7uBGTPPf5JyNPZm6fUsGMBIDY0VHndrh2OfxH1SV6lQ1wRF0DAjBAXtWxVqgtPR72XT7I1lU/LMTLhFhKehNN6T5wnXpXinKWZf7/4zPckf/mRDUbHTIMhrfTQCtbuP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=We4dDDJu; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yl
	e0Kqd88zaVEflBPBDE3K9lYXnitx52ifkJn5SKETE=; b=We4dDDJueapUQ2UchF
	xCRY8IHkbysKOWewwKRaqDMudfZhxP+cZFzNoY5+qxU0m6OkCu6Hh/RCBQmi8/I1
	9HfxSNnhSLAj8HArHVezdIhNN1GQQ+GwWT4/USEacbKshDY22XPcnIkd9/QOxvVl
	lBDv3o6Xi5G3+VMIGwcze5XYY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn8xDfdjtq3ideEw--.60S2;
	Wed, 24 Jun 2026 14:19:15 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mjrosato@linux.ibm.com,
	alifm@linux.ibm.com,
	farman@linux.ibm.com,
	borntraeger@linux.ibm.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	david@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com,
	schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: s390: pci: Fix GISC refcount leak on AIF enable failure
Date: Wed, 24 Jun 2026 14:19:10 +0800
Message-Id: <20260624061910.2794734-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn8xDfdjtq3ideEw--.60S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWfZw1kAFyUWr17tw43Jrb_yoWDKFbEvw
	1Iy340q395ZrsrCryqkFs7ZF1Fka48WF4fAr10qrn8JF95ZrsrW3y8Zr43u3s7Wr4SyrWx
	X392ywn3Z34IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRu0PfDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxQM-rWo7duO5pwAA3O
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mjrosato@linux.ibm.com,m:alifm@linux.ibm.com,m:farman@linux.ibm.com,m:borntraeger@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:schnelle@linux.ibm.com,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268070-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D116D6BBB95

kvm_s390_gisc_register() registers the guest ISC before pinning
the guest interrupt forwarding pages and allocating the AISB bit.
If any of the later setup steps fails, the function unwinds the
pinned pages and other local state, but does not unregister the
GISC reference. Add the missing kvm_s390_gisc_unregister() to the
error unwind path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Move unregister call after "out" label. Thanks, Matt!
---
 arch/s390/kvm/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 5b075c38998e..686113be0530 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -328,6 +328,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 unpin1:
 	unpin_user_page(aibv_page);
 out:
+	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
 	return rc;
 }
 
-- 
2.25.1


