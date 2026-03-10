Return-Path: <stable+bounces-224070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCgoCr3/r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 938CB24AAB7
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4EAC3207128
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E35F36EA89;
	Tue, 10 Mar 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyAL+C+0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFE387362;
	Tue, 10 Mar 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141205; cv=none; b=f7m1BQtv70dvbUd+6zjdeCAXEW1JJ21H9q8xMRzWXufwmkiE9nUH16GRE2bH9uN7bLpRVvRnyxQ3GZbpqIgNp867gbYEqZrgNU7Cb6v3hLgqEhtM4Fn6S/qSQYRHuc6puKdE6NP7Fk0JBRBrYWPlppPNSxB9btPtE10c54Wio6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141205; c=relaxed/simple;
	bh=t5CvwlLpAZwmrgnCnWCqVSVeP0EcyKN5jfGGURH/g4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HowB71kysuZj0BLbtAchT48bHdDo1wV1mWakJL0qrbX3pokNE+EixRvTIfBveLW65wKCJU+mHPxiqLIfHUI4zuRNFYepsP9+rUlpWbAdmxdCTiwm6ITN5bvPnkFDAIqcDH3HXUIhQVxpFQoLK5SKrvVqFI36Qts4wYER6goDmfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyAL+C+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446C0C2BC9E;
	Tue, 10 Mar 2026 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141205;
	bh=t5CvwlLpAZwmrgnCnWCqVSVeP0EcyKN5jfGGURH/g4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyAL+C+0XeUbq00Euq9uBWvGAcxtXrSxZx6i337G+4lN74dPf973CWSxPDzC/m4Dg
	 ch7gAWP7KCUTg1EgOklngDV3xmzuFOH4/zD1mD+hntTn92H5yvyzDBEM+9+Qbv6ixF
	 /T5u231+v1dvKjIl4fhL5Bkh5o6QuwmBpg9iEwW/hJfutki+mJFJ93HWbDD2ZhXwEL
	 Xq4VkFrCBxixjWs3nKrQcBQoRnez/cw3DyCHvCFZukcMZvG7H99OwrQVgO0WMeY4bB
	 POSpajERC7ORMC3h765H2VfUBshwDL0m1C5yU5CTKFYEH1LmEU+L5iao978RNd2odh
	 2T02M1MZqUIdQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 205/311] nvme-multipath: fix leak on try_module_get failure
Date: Tue, 10 Mar 2026 07:04:12 -0400
Message-ID: <6c2cb6fb2a344b0639c2cdc778e52d5ce092264b.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 938CB24AAB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 0f5197ea9a73a4c406c75e6d8af3a13f7f96ae89 ]

We need to fall back to the synchronous removal if we can't get a
reference on the module needed for the deferred removal.

Fixes: 62188639ec16 ("nvme-multipath: introduce delayed removal of the multipath head node")
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 174027d1cc198..5e41fbaf5f46a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1310,13 +1310,11 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	if (!list_empty(&head->list))
 		goto out;
 
-	if (head->delayed_removal_secs) {
-		/*
-		 * Ensure that no one could remove this module while the head
-		 * remove work is pending.
-		 */
-		if (!try_module_get(THIS_MODULE))
-			goto out;
+	/*
+	 * Ensure that no one could remove this module while the head
+	 * remove work is pending.
+	 */
+	if (head->delayed_removal_secs && try_module_get(THIS_MODULE)) {
 		mod_delayed_work(nvme_wq, &head->remove_work,
 				head->delayed_removal_secs * HZ);
 	} else {
-- 
2.51.0


