Return-Path: <stable+bounces-220753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDdvIsdVo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:53:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEEA1C897A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E428336271A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E084046F1;
	Sat, 28 Feb 2026 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU9UWtKq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B14046EB;
	Sat, 28 Feb 2026 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300634; cv=none; b=FtFQUYD/w1TOegzKB3itgca3u76vdfGrFULE+N1sIUHqlLS+pbCVnIO/wezGW4LCozQDkrewyH5PDd9P0nKwoI8K8T+dsQuQV41SFWNLIr0p7e2nJ6jwFwdSMgFNE/e0QeoZlu1I7NU8psKRfqB9RxH2goxlAuylcUNvpKBIJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300634; c=relaxed/simple;
	bh=xrUDajPkY4vdJvRuRoyNz2rXbWijUgSR+43IvsPfa40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mI7AEsjYUqzRHykVwJ1IzPU93Nnd1hNXQTjU1r8GLDUkfcy8k2JTiwbzaWCqCJR6tmQOjZZr5L76m60sRrWFJwAIdJgEkmYyQSM8bRoRCURURo/ZqdgX/MigW57gVxjum5nU1yynidfHkq7IikSkU1twwCSnAttyMYQKwFVNhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU9UWtKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAA9C116D0;
	Sat, 28 Feb 2026 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300633;
	bh=xrUDajPkY4vdJvRuRoyNz2rXbWijUgSR+43IvsPfa40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iU9UWtKqaUY+sX3h+pigWQKMbPhpPqy3YL+MTs7Yl/cTN1cD23ibf7rOzTIkmU/P3
	 wRKvVJJLX50ULNcIAI/CYgaxsSG5yz6Z3AixqtDtoEXnnvwmkagdkP9pgknCkkuVGH
	 XC/hjg6NqcSillulYgVpCWJRWjmiT9hkrx7nCl4mhwPgpDapUt1v/XBTULzM7hKUew
	 3djFcfsVhEL4VSW2xtLdNgP9J8HJ10WN4s6bk4NCtTF74m17O4Eq3o4pbgWcGbi8Z5
	 zeJEuoZ7Hse7RN2557j+bKUOxa6FWzzwcGXqvWeFFOugzsVNEzXYW3G71WODb89h25
	 uYMxJQaZqfqNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 674/844] iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
Date: Sat, 28 Feb 2026 12:29:47 -0500
Message-ID: <20260228173244.1509663-675-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220753-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 8CEEA1C897A
X-Rspamd-Action: no action

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 2781f2a930abb5d27f80b8afbabfa19684833b65 ]

C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
different than the normal S1-bypass and S1DSS-bypass modes. As a result,
fields like MEV and EATS in S2's used list marked the word1 as a critical
word that requested a STE.V=0. This breaks a hitless update.

However, both MEV and EATS aren't critical in terms of STE update. One
controls the merge of the events and the other controls the ATS that is
managed by the driver at the same time via pci_enable_ats().

Add an arm_smmu_get_ste_update_safe() to allow STE update algorithm to
relax those fields, avoiding the STE update breakages.

After this change, entry_set has no caller checking its return value, so
change it to void.

Note that this change is required by both MEV and EATS fields, which were
introduced in different kernel versions. So add get_update_safe() first.
MEV and EATS will be added to arm_smmu_get_ste_update_safe() separately.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 31 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 28 ++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +++
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index d2671bfd37981..b254a94b2003d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -38,13 +38,16 @@ enum arm_smmu_test_master_feat {
 static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 						const __le64 *used_bits,
 						const __le64 *target,
+						const __le64 *safe,
 						unsigned int length)
 {
 	bool differs = false;
 	unsigned int i;
 
 	for (i = 0; i < length; i++) {
-		if ((entry[i] & used_bits[i]) != target[i])
+		__le64 used = used_bits[i] & ~safe[i];
+
+		if ((entry[i] & used) != (target[i] & used))
 			differs = true;
 	}
 	return differs;
@@ -56,12 +59,24 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 	struct arm_smmu_test_writer *test_writer =
 		container_of(writer, struct arm_smmu_test_writer, writer);
 	__le64 *entry_used_bits;
+	__le64 *safe_target;
+	__le64 *safe_init;
 
 	entry_used_bits = kunit_kzalloc(
 		test_writer->test, sizeof(*entry_used_bits) * NUM_ENTRY_QWORDS,
 		GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
 
+	safe_target = kunit_kzalloc(test_writer->test,
+				    sizeof(*safe_target) * NUM_ENTRY_QWORDS,
+				    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, safe_target);
+
+	safe_init = kunit_kzalloc(test_writer->test,
+				  sizeof(*safe_init) * NUM_ENTRY_QWORDS,
+				  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, safe_init);
+
 	pr_debug("STE value is now set to: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
 			     test_writer->entry,
@@ -79,14 +94,23 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 		 * configuration.
 		 */
 		writer->ops->get_used(test_writer->entry, entry_used_bits);
+		if (writer->ops->get_update_safe)
+			writer->ops->get_update_safe(test_writer->entry,
+						     test_writer->init_entry,
+						     safe_init);
+		if (writer->ops->get_update_safe)
+			writer->ops->get_update_safe(test_writer->entry,
+						     test_writer->target_entry,
+						     safe_target);
 		KUNIT_EXPECT_FALSE(
 			test_writer->test,
 			arm_smmu_entry_differs_in_used_bits(
 				test_writer->entry, entry_used_bits,
-				test_writer->init_entry, NUM_ENTRY_QWORDS) &&
+				test_writer->init_entry, safe_init,
+				NUM_ENTRY_QWORDS) &&
 				arm_smmu_entry_differs_in_used_bits(
 					test_writer->entry, entry_used_bits,
-					test_writer->target_entry,
+					test_writer->target_entry, safe_target,
 					NUM_ENTRY_QWORDS));
 	}
 }
@@ -106,6 +130,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 static const struct arm_smmu_entry_writer_ops test_ste_ops = {
 	.sync = arm_smmu_test_writer_record_syncs,
 	.get_used = arm_smmu_get_ste_used,
+	.get_update_safe = arm_smmu_get_ste_update_safe,
 };
 
 static const struct arm_smmu_entry_writer_ops test_cd_ops = {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7a6aea3b61c11..56420104e154e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1093,6 +1093,13 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
 
+VISIBLE_IF_KUNIT
+void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
+				  __le64 *safe_bits)
+{
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
+
 /*
  * Figure out if we can do a hitless update of entry to become target. Returns a
  * bit mask where 1 indicates that qword needs to be set disruptively.
@@ -1105,13 +1112,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 {
 	__le64 target_used[NUM_ENTRY_QWORDS] = {};
 	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
+	__le64 safe[NUM_ENTRY_QWORDS] = {};
 	u8 used_qword_diff = 0;
 	unsigned int i;
 
 	writer->ops->get_used(entry, cur_used);
 	writer->ops->get_used(target, target_used);
+	if (writer->ops->get_update_safe)
+		writer->ops->get_update_safe(entry, target, safe);
 
 	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
+		/*
+		 * Safe is only used for bits that are used by both entries,
+		 * otherwise it is sequenced according to the unused entry.
+		 */
+		safe[i] &= target_used[i] & cur_used[i];
+
 		/*
 		 * Check that masks are up to date, the make functions are not
 		 * allowed to set a bit to 1 if the used function doesn't say it
@@ -1120,6 +1136,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 		WARN_ON_ONCE(target[i] & ~target_used[i]);
 
 		/* Bits can change because they are not currently being used */
+		cur_used[i] &= ~safe[i];
 		unused_update[i] = (entry[i] & cur_used[i]) |
 				   (target[i] & ~cur_used[i]);
 		/*
@@ -1132,7 +1149,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 	return used_qword_diff;
 }
 
-static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
+static void entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
 		      const __le64 *target, unsigned int start,
 		      unsigned int len)
 {
@@ -1148,7 +1165,6 @@ static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
 
 	if (changed)
 		writer->ops->sync(writer);
-	return changed;
 }
 
 /*
@@ -1218,12 +1234,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
 		entry_set(writer, entry, target, 0, 1);
 	} else {
 		/*
-		 * No inuse bit changed. Sanity check that all unused bits are 0
-		 * in the entry. The target was already sanity checked by
-		 * compute_qword_diff().
+		 * No inuse bit changed, though safe bits may have changed.
 		 */
-		WARN_ON_ONCE(
-			entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS));
+		entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_write_entry);
@@ -1554,6 +1567,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
 	.sync = arm_smmu_ste_writer_sync_entry,
 	.get_used = arm_smmu_get_ste_used,
+	.get_update_safe = arm_smmu_get_ste_update_safe,
 };
 
 static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc38402..287e223c054d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -900,6 +900,8 @@ struct arm_smmu_entry_writer {
 
 struct arm_smmu_entry_writer_ops {
 	void (*get_used)(const __le64 *entry, __le64 *used);
+	void (*get_update_safe)(const __le64 *cur, const __le64 *target,
+				__le64 *safe_bits);
 	void (*sync)(struct arm_smmu_entry_writer *writer);
 };
 
@@ -911,6 +913,8 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 #if IS_ENABLED(CONFIG_KUNIT)
 void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
+void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
+				  __le64 *safe_bits);
 void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
 			  const __le64 *target);
 void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
-- 
2.51.0


