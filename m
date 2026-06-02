Return-Path: <stable+bounces-259690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GEEMjI9HmpriAkAu9opvQ
	(envelope-from <stable+bounces-259690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 04:17:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF2627254
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 04:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63879307E00F
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111E634403A;
	Tue,  2 Jun 2026 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="W09QiX2N"
X-Original-To: stable@vger.kernel.org
Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B6F30E0F5
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366235; cv=none; b=f2kazood1ig30Wl7bt0hDKgoZ5O/hqoUJPOEa2L0QAWlT473Gxjbi9o3rFcslCRCv2OGiCZZJZzgqrzOtlKgGmpJpkIpkV7fRS5xhPqxNtJlFUv7X2H75yT7YKenWnsANVChFPcaUsncfhs17nsYfkdZ5irPIiCx0waB990NbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366235; c=relaxed/simple;
	bh=rQr4cgGt7UgoL3S4yiskjSogZfneK2pwoMz5gpD/drM=;
	h=To:From:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type; b=Hv86Tc7opsFMUAv2sB01VSiNhpnPoaJk/n6eeDCxXfEk2rM1MXEvR8dB+obc/ULwx5cku/S6v8UBdLEc+/RGnAX9mHcvexdhHCNJVzLpvUZuuC5EHQ7GHBJT1Y2/qLRgrS8YVxb58FxFfXZqaiHD7RNXNo3l1Nd060XyDQYc5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=W09QiX2N; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780366216; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Qvjk2VPn73XqElxLFraSfA68CbhnrneyArfCJ0SS8VY=;
 b=W09QiX2NeMg5YUbe/nWHx0OqquYhjtiWp8WolqV4xAMelIEBGf9Lk7qLQZXAlXmvrYcrIO
 4aQ3KF5U30LzaKw9OusnKv2TE0i+YASUFjL+wuJlVHshoAwIIdtYnvPZa1JDeCejtdzatv
 BkDmo5Kur/Q74kDc2/c4Lhmhl9hs2YEBbC6gMZqz2QTwZV2ux0VvJ4f6dbp/fyhST6bbsr
 HnbdjLPayyu/BDXxgC/Inp095xPpfXZfub89dS7Y+vKgL2v9sXLieaxHWymu+9NRd8u+gQ
 PQcvnUK+rtRPD6/U+8CpLXcLQFLYdw6THqJ9+tce5kOlXrclql1OSxxsXkqafw==
To: <srinivas.pandruvada@linux.intel.com>, <hansg@kernel.org>, 
	<ilpo.jarvinen@linux.intel.com>, <platform-driver-x86@vger.kernel.org>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.50.1
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Cc: <linux-kernel@vger.kernel.org>, <weiguixiong@bytedance.com>, 
	<stable@vger.kernel.org>
Subject: [PATCH] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue,  2 Jun 2026 10:07:52 +0800
X-Lms-Return-Path: <lba+26a1e3b86+0a70d5+vger.kernel.org+weiguixiong@bytedance.com>
Message-Id: <20260602020752.3126-1-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259690-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weiguixiong@bytedance.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:mid,bytedance.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35CF2627254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the last CPU of a legacy uncore die goes offline,
uncore_freq_remove_die_entry() clears control_cpu. During CPU hotplug
re-add, uncore_freq_add_entry() still populates sysfs attributes before
assigning the new control CPU. As a result, the current frequency read
returns -ENXIO and current_freq_khz is omitted from the recreated sysfs
group.

Assign control_cpu before the initial read paths and before
create_attr_group() so sysfs recreation uses the new online CPU. If
sysfs creation fails, restore control_cpu to -1 to keep the error path
state consistent.

Fixes: 4d73c6772ab7 ("platform/x86: intel-uncore-freq: Conditionally create attribute for read frequency")
Cc: stable@vger.kernel.org
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 .../x86/intel/uncore-frequency/uncore-frequency-common.c   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 7070c94324e0..f8137ee92e47 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -275,15 +275,20 @@ int uncore_freq_add_entry(struct uncore_data *data, int cpu)
 			  data->package_id, data->die_id);
 	}
 
+	/*
+	 * Set the control CPU before any read path so entry recreation after CPU
+	 * hotplug can populate read-only attributes from the new online CPU.
+	 */
+	data->control_cpu = cpu;
 	uncore_read(data, &data->initial_min_freq_khz, UNCORE_INDEX_MIN_FREQ);
 	uncore_read(data, &data->initial_max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
 	ret = create_attr_group(data, data->name);
 	if (ret) {
+		data->control_cpu = -1;
 		if (data->domain_id != UNCORE_DOMAIN_ID_INVALID)
 			ida_free(&intel_uncore_ida, data->instance_id);
 	} else {
-		data->control_cpu = cpu;
 		data->valid = true;
 	}
 
-- 
2.50.1 (Apple Git-155)

