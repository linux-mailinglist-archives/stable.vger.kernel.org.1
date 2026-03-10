Return-Path: <stable+bounces-224408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PEODDIFsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:49:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0024B954
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 134AB3033E16
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43138B7A4;
	Tue, 10 Mar 2026 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IApt9yRp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED273C3BF4;
	Tue, 10 Mar 2026 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142142; cv=none; b=j0HMFSKnOHZjwEi1mhtTYgaDAwkaAPBcWiWzJ0Y54E8t83r6PUK9V68gLG6LvBTpLB5qFn1z/XQKmdCq2bsCmpaQvSgdOPcDs95l4a8KdBjJPVObENN0bgaME1Srs6cStY8+9YiwMJ6rPuXuY0rw4Tv/GZ2mD7LqYBzbDlfkFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142142; c=relaxed/simple;
	bh=xOzQ79KIStV3wTIjF7DaQjVGiM/WFAXn6+lfOREvynE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbaXjdQ8++QH+tXi/D89t4SJPz+aYJV+50GLBBPMKoWHkRf1HryrMaB9Xz6RbcxYdyPHBsBWUwRg2+dJMK7/lFIKZbzs8eOtjbU+EAkPRxSg5ngxH49wNzwP7s+L3bcaFj0dLkj02B1uOfU8xqb9JOcWZpdu0LU0lGhAlRCq+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IApt9yRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5965BC2BC9E;
	Tue, 10 Mar 2026 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142142;
	bh=xOzQ79KIStV3wTIjF7DaQjVGiM/WFAXn6+lfOREvynE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IApt9yRpx0eqPiIpYowAtR/h5dnwoJ+zvc+F+docA/UX2ENiILkJtn2lmnhEqwVlh
	 ysdIU6GWwoqV7D3sHs3xyXVrT3+Iv1I8TaDDbpgyG+mMRYQD6VrBBQW/hjjKFjSBAZ
	 3lrTkFGFtjNOn6mMfI16cnCagJ4XNxBq7NR0702gdBnmj+RK3+eNt8UsWqfxWJj19p
	 pusxiuN3gsxlzuR02Ob9lLetpu0+DAKl/AAO1d0CYhw0p3rSKoySSURXmqgzvrx7S5
	 tvMagW0q6DZT/z0UDUIW6pUPiDDKt3Q0snIyvyyqDGlKgjYsb0Bj2jpqfo4enc5lv8
	 IerS+4whE47pw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 229/314] nvme-multipath: fix leak on try_module_get failure
Date: Tue, 10 Mar 2026 07:18:08 -0400
Message-ID: <0c0f738512816aface34efded56ae8d87c5f7edb.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48C0024B954
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224408-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email,lst.de:email]
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
index e35eccacee8c8..81ccdd91f7790 100644
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


