Return-Path: <stable+bounces-253591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FAABlwrD2roHQYAu9opvQ
	(envelope-from <stable+bounces-253591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:57:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDDE5A8C53
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B1A31B0B61
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4129ACDD;
	Thu, 21 May 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GB6r2D0u"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841823C50A
	for <stable@vger.kernel.org>; Thu, 21 May 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375279; cv=none; b=B2VaLGo9TcTyPh+ZO+Rc+BaIxAoh2OeUP88x89HT/zePJ6Ix4KfoOu3Y4gs/5nmCiycRq8UXkKBF9OuYGbazStkn5fXT+2Vkufkjf8KxyF90ePZqeHrqfdd3BS/CcMWmlDs2xhHv/0XWd04zwA5uuC2mURcHouph1Pv/oWMphK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375279; c=relaxed/simple;
	bh=tNf+jQSIhtyKdNZJ3FdnxttmKjIwnuF19Qpw5/Zlfno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbRa9qYFIweeFhXTkb2Ry/axmzXCAGL7/k2NIp0GNtNKQFI/1IRDfysIDrqyre5exIZmN7ZGEIO/nekfGobtQ4s45YEK2KarJuzZvKrnxidoBsIOxOteGfDoPKXnAXTWpLvqbvQ7UjOgTrVlyWFvNL+Ptu3GEcTGJBkY5qDmXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GB6r2D0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779375277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkpUKxYRq3JBmCsLVuUvlcRB20ZuCKg4fZnwr9v9arA=;
	b=GB6r2D0uDBOcDp+54uuIdkMjAwP9WAYQPgKWDMJJhiRDtu/CgkCXFluNabv3ugWGHgqj8X
	Yn7TlfiCgKlWVRj10DCKtZuUvC7nzO6Q3zNITGq383l8FMhAKHhPTZ1rTtKqrkTTyBhM9E
	lcWk52N99jBSUneibI5+EeAMwaP+bic=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-B5UuCS7_PzetmMcZEkJ2Dg-1; Thu,
 21 May 2026 10:54:08 -0400
X-MC-Unique: B5UuCS7_PzetmMcZEkJ2Dg-1
X-Mimecast-MFC-AGG-ID: B5UuCS7_PzetmMcZEkJ2Dg_1779375247
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 163DB195608C;
	Thu, 21 May 2026 14:54:06 +0000 (UTC)
Received: from ezulian-p1gen7.rmtde.csb (unknown [10.44.33.129])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB0971681;
	Thu, 21 May 2026 14:54:04 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: stable@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 6.18.y] iommu/amd: Remove latent out-of-bounds access in IOMMU debugfs
Date: Thu, 21 May 2026 16:54:01 +0200
Message-ID: <20260521145401.316511-1-ezulian@redhat.com>
In-Reply-To: <2026052055-satirical-mousy-05cf@gregkh>
References: <2026052055-satirical-mousy-05cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253591-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ezulian@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8DDDE5A8C53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In iommu_mmio_write() and iommu_capability_write(),
iommu->dbg_mmio_offset and iommu->dbg_cap_offset are int. However, they
are populated using kstrtou32_from_user(). If a user provides a
sufficiently large value, it can become a negative integer.

Prior to this patch, the AMD IOMMU debugfs implementation was already
protected by different mechanisms.

1. #define OFS_IN_SZ 8 ensures the user string <= 8 bytes, so
   e.g. 0xffffffff isn't a valid input.

  if (cnt > OFS_IN_SZ)
     return -EINVAL;

2. Implicit type promotion in iommu_mmio_write(), iommu->dbg_mmio_offset
   is int and iommu->mmio_phys_end is u64

  if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64))
      return -EINVAL;

3. The show handlers would currently catch the negative number and
   refuse to perform the read.

Replace kstrtou32_from_user() with kstrtos32_from_user() to parse the
input, and check for negative values to explicitly prevent out-of-bounds
memory accesses directly in iommu_mmio_write() and
iommu_capability_write().

Signed-off-by: Eder Zulian <ezulian@redhat.com>
Fixes: 7a4ee419e8c1 ("iommu/amd: Add debugfs support to dump IOMMU MMIO registers")
Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
(cherry picked from commit 8dfd3d8d74435344ee8dc9237596959c8b2a6cbe)
---
 drivers/iommu/amd/debugfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 20b04996441d..bb0c8552bc0f 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -33,11 +33,12 @@ static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->dbg_mmio_offset);
+	ret = kstrtos32_from_user(ubuf, cnt, 0, &iommu->dbg_mmio_offset);
 	if (ret)
 		return ret;
 
-	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {
+	if (iommu->dbg_mmio_offset < 0 || iommu->dbg_mmio_offset >
+			iommu->mmio_phys_end - sizeof(u64)) {
 		iommu->dbg_mmio_offset = -1;
 		return  -EINVAL;
 	}
@@ -74,12 +75,12 @@ static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->dbg_cap_offset);
+	ret = kstrtos32_from_user(ubuf, cnt, 0, &iommu->dbg_cap_offset);
 	if (ret)
 		return ret;
 
 	/* Capability register at offset 0x14 is the last IOMMU capability register. */
-	if (iommu->dbg_cap_offset > 0x14) {
+	if (iommu->dbg_cap_offset < 0 || iommu->dbg_cap_offset > 0x14) {
 		iommu->dbg_cap_offset = -1;
 		return -EINVAL;
 	}
-- 
2.54.0


