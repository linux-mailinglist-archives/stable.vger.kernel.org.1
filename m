Return-Path: <stable+bounces-255745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JTNDm6kGGrClggAu9opvQ
	(envelope-from <stable+bounces-255745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B85D5F894F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAECC300CEB0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947732F39B4;
	Thu, 28 May 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yFjK407Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21922652D;
	Thu, 28 May 2026 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999765; cv=none; b=SFoFvkh5KnWSKJL/8ixq0gfvhT2v68cGJg+e6dcE8E2TF7t6HOFcfVzLC0byFbeYCw48+5OXccCwchSrNwfocJp981Z8gLEXn5f6BBLeo0ipJJ1KxLdBCsErG6lfOqZLcHitb1h9pxPeTEGHBVhDCLiRpINGpsuH5z1JNNq5JFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999765; c=relaxed/simple;
	bh=47N17AqHMIEbRsi8DDmcQiLpvtwqNSbL++gS3J+Yegw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KehRHpRuy9B+5lBwaB6apqkiAsUV793mg9MjsKJlXyPddXLIMAgHrGJCFKC/2dImHWbQVntTwO1YGDJOq5GCnDShFdwqN5fXfdV44RYLqEq6iDnT8wevVjXomfj+lyUjpgNyap+sn3q16q80nTwpgnRRXBAKk7j+eRCC72nRuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yFjK407Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA001F000E9;
	Thu, 28 May 2026 20:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999764;
	bh=2W48tyz12Iv91Fy3SnmrcaQ0JbgVfIncJ7YBuGGbbSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yFjK407QOC5Stu7WQqF9f5CV/wooWFLCKSM+9/cEWHlM0sgdT6n/KVUsBrG/nTytz
	 1U5D1bn17cTGgQvMec7HrtFSv5W7bDfdREuP6GpK0uYZLx4lgDlhb3EVCiYNnu2/nA
	 kezhKf4Dl8onDluJZPbGIAOqPtuDEc8oqzVnhebo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 182/377] firmware: arm_ffa: Unregister bus notifier on teardown for FF-A v1.0
Date: Thu, 28 May 2026 21:47:00 +0200
Message-ID: <20260528194643.692746429@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255745-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 0B85D5F894F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@kernel.org>

[ Upstream commit 6d3daa9b8d313f42d52e75590310f26a29b61b44 ]

For FF-A v1.0 the driver registers a bus notifier to backfill UUID
matching, but the notifier was never unregistered on cleanup paths.
Track the registration state and unregister it during teardown and early
partition-setup failure.

Fixes: 9dd15934f60d ("firmware: arm_ffa: Move the FF-A v1.0 NULL UUID workaround to bus notifier")
Link: https://patch.msgid.link/20260428-ffa_fixes-v2-5-8595ae450034@kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 30f8e0ff694fb..287db85286106 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -100,6 +100,7 @@ struct ffa_drv_info {
 	bool mem_ops_native;
 	bool msg_direct_req2_supp;
 	bool bitmap_created;
+	bool bus_notifier_registered;
 	bool notif_enabled;
 	unsigned int sched_recv_irq;
 	unsigned int notif_pend_irq;
@@ -1625,6 +1626,15 @@ static struct notifier_block ffa_bus_nb = {
 	.notifier_call = ffa_bus_notifier,
 };
 
+static void ffa_bus_notifier_unregister(void)
+{
+	if (!drv_info->bus_notifier_registered)
+		return;
+
+	bus_unregister_notifier(&ffa_bus_type, &ffa_bus_nb);
+	drv_info->bus_notifier_registered = false;
+}
+
 static int ffa_xa_add_partition_info(struct ffa_device *dev)
 {
 	struct ffa_dev_part_info *info;
@@ -1708,6 +1718,8 @@ static void ffa_partitions_cleanup(void)
 	struct list_head *phead;
 	unsigned long idx;
 
+	ffa_bus_notifier_unregister();
+
 	/* Clean up/free all registered devices */
 	ffa_devices_unregister();
 
@@ -1735,11 +1747,14 @@ static int ffa_setup_partitions(void)
 		ret = bus_register_notifier(&ffa_bus_type, &ffa_bus_nb);
 		if (ret)
 			pr_err("Failed to register FF-A bus notifiers\n");
+		else
+			drv_info->bus_notifier_registered = true;
 	}
 
 	count = ffa_partition_probe(&uuid_null, &pbuf);
 	if (count <= 0) {
 		pr_info("%s: No partitions found, error %d\n", __func__, count);
+		ffa_bus_notifier_unregister();
 		return -EINVAL;
 	}
 
-- 
2.53.0




