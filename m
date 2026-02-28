Return-Path: <stable+bounces-220497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KpuOQJMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:11:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC01C7FF5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A8F830B7BE3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64733C8604;
	Sat, 28 Feb 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHrMx3+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1E3C85FC;
	Sat, 28 Feb 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300382; cv=none; b=p2+VNtfGkBvQz/UMdXrM80dz3xCFx2ORt3aBpJODafu+iAQVwI+3zJY+TdELZ262uD9gdTd1NstNHIOiOfsWBCXkgs34egeR4uspnbvp45s6R6OaDHHUDGtGjPA/GeTw5PuyBKNFEaOCTIUvVYLs0v1vxsnT1VAbVG5CqNgR94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300382; c=relaxed/simple;
	bh=l9iocyxtMSRJtf9FMoPMF9SpeSmJIAfbepK3rtVppNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dptaWZ1vhWhl1gNyEPEaj74e+L7nDshrIulQxZ82enbEbmeFRjpQSy6rty2PJ+DicrEThXIKYtcvJrS+ZRuLYAcqAn+Xg0hR9EWUmf7fM3Zfy20pHkVtV85mTc0BN92o0tE87ob5CsqB3Ro53CkX5WVc9K3LwNBu9a4BNGrqdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHrMx3+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9119BC19423;
	Sat, 28 Feb 2026 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300382;
	bh=l9iocyxtMSRJtf9FMoPMF9SpeSmJIAfbepK3rtVppNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHrMx3+mUzmaAy+T9fEvO4u6arHq2/4oV+DW7oO+kyLykRHQEIKxXRY3aC1Yczpx7
	 bHQs4Df5+6sVHA2YdNa0TVOo+nmvpjzavXVAEuaGNHVsf+21FPno8oQpEHANP4mAsh
	 /FZvR2lkazDN8geB1Mna2CVVngM1J3gGrPO/LWi3J29x1WqFIo9lyf1hWAJK+0kJdq
	 klnY8YCvAK7pT9nlSZF8D6KaPuak9ccKEBzzjGrQMkomv5k2NrnBoHKrH4r+Em0RDY
	 3DccAHcJhEI0U8IROEWgWomV8KMryv2iqLgrRajPznYEsLfLRfEftGoc10ir7V+/d8
	 PT7ScsEeF3kwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 418/844] mshv: Ignore second stats page map result failure
Date: Sat, 28 Feb 2026 12:25:31 -0500
Message-ID: <20260228173244.1509663-419-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.microsoft.com,outlook.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220497-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: D8EC01C7FF5
X-Rspamd-Action: no action

From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>

[ Upstream commit 7538b80e5a4b473b73428d13b3a47ceaad9a8a7c ]

Older versions of the hypervisor do not have a concept of separate SELF
and PARENT stats areas. In this case, mapping the HV_STATS_AREA_SELF page
is sufficient - it's the only page and it contains all available stats.

Mapping HV_STATS_AREA_PARENT returns HV_STATUS_INVALID_PARAMETER which
currently causes module init to fail on older hypevisor versions.

Detect this case and gracefully fall back to populating
stats_pages[HV_STATS_AREA_PARENT] with the already-mapped SELF page.

Add comments to clarify the behavior, including a clarification of why
this isn't needed for hv_call_map_stats_page2() which always supports
PARENT and SELF areas.

Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/mshv_root_hv_call.c | 52 +++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root_main.c    |  3 ++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index 598eaff4ff299..1f93b94d7580c 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -813,6 +813,13 @@ hv_call_notify_port_ring_empty(u32 sint_index)
 	return hv_result_to_errno(status);
 }
 
+/*
+ * Equivalent of hv_call_map_stats_page() for cases when the caller provides
+ * the map location.
+ *
+ * NOTE: This is a newer hypercall that always supports SELF and PARENT stats
+ * areas, unlike hv_call_map_stats_page().
+ */
 static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 				   const union hv_stats_object_identity *identity,
 				   u64 map_location)
@@ -855,6 +862,34 @@ static int hv_call_map_stats_page2(enum hv_stats_object_type type,
 	return ret;
 }
 
+static int
+hv_stats_get_area_type(enum hv_stats_object_type type,
+		       const union hv_stats_object_identity *identity)
+{
+	switch (type) {
+	case HV_STATS_OBJECT_HYPERVISOR:
+		return identity->hv.stats_area_type;
+	case HV_STATS_OBJECT_LOGICAL_PROCESSOR:
+		return identity->lp.stats_area_type;
+	case HV_STATS_OBJECT_PARTITION:
+		return identity->partition.stats_area_type;
+	case HV_STATS_OBJECT_VP:
+		return identity->vp.stats_area_type;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Map a stats page, where the page location is provided by the hypervisor.
+ *
+ * NOTE: The concept of separate SELF and PARENT stats areas does not exist on
+ * older hypervisor versions. All the available stats information can be found
+ * on the SELF page. When attempting to map the PARENT area on a hypervisor
+ * that doesn't support it, return "success" but with a NULL address. The
+ * caller should check for this case and instead fallback to the SELF area
+ * alone.
+ */
 static int hv_call_map_stats_page(enum hv_stats_object_type type,
 				  const union hv_stats_object_identity *identity,
 				  void **addr)
@@ -863,7 +898,7 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 	struct hv_input_map_stats_page *input;
 	struct hv_output_map_stats_page *output;
 	u64 status, pfn;
-	int ret = 0;
+	int hv_status, ret = 0;
 
 	do {
 		local_irq_save(flags);
@@ -878,11 +913,20 @@ static int hv_call_map_stats_page(enum hv_stats_object_type type,
 		pfn = output->map_location;
 
 		local_irq_restore(flags);
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
-			ret = hv_result_to_errno(status);
+
+		hv_status = hv_result(status);
+		if (hv_status != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (hv_result_success(status))
 				break;
-			return ret;
+
+			if (hv_stats_get_area_type(type, identity) == HV_STATS_AREA_PARENT &&
+			    hv_status == HV_STATUS_INVALID_PARAMETER) {
+				*addr = NULL;
+				return 0;
+			}
+
+			hv_status_debug(status, "\n");
+			return hv_result_to_errno(status);
 		}
 
 		ret = hv_call_deposit_pages(NUMA_NO_NODE,
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 681b58154d5ea..d3e8a66443ad6 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -993,6 +993,9 @@ static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
 	if (err)
 		goto unmap_self;
 
+	if (!stats_pages[HV_STATS_AREA_PARENT])
+		stats_pages[HV_STATS_AREA_PARENT] = stats_pages[HV_STATS_AREA_SELF];
+
 	return 0;
 
 unmap_self:
-- 
2.51.0


