Return-Path: <stable+bounces-225164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHhKAoQhs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:26:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CEA2790FB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE42303817F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8C535A3BA;
	Thu, 12 Mar 2026 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGzaXl8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C426F288;
	Thu, 12 Mar 2026 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347199; cv=none; b=L+iiOrJ8Zq6WyhQWRBFcQxZd/uXl7iUNVOrJf/3TxMKKak9qyy6IcSMtKcTmEO9OIlKrb3HiJiv9wjkjKaCZt3Zobx6DVV400NKsw70Gcax7FBZGpIplPOsN7Pf25+jDDUrwRaFznd/U/TbtpkBn4GjLgzRBuao8sLkjNiOWkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347199; c=relaxed/simple;
	bh=hlJXDlWpV3jIAm0bNG1mGKatsASOI0+6dTnIF/t6oDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kxwdk52h1flbOIOaXY/2PQt0+WOTx8w/udk0JiYo8ogChyI8n7UTuru3mpBWqh1NYt+ZogSDcUkfI7FEG6lHCbyfYb4bB8N58MQDPAPZs135ox9WINvqwjtDsHxBZa2zr8cd0gKoPv5jLbNyUaPUPzfzDm2gVPqz0VAxMI53o2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGzaXl8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E4AC4CEF7;
	Thu, 12 Mar 2026 20:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347198;
	bh=hlJXDlWpV3jIAm0bNG1mGKatsASOI0+6dTnIF/t6oDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGzaXl8p19L8TggmB5aiAUVGruQ6WfA/Fb4dZcfzZxbcf2W/lM8uufkJGbAFS2lv1
	 wO/cDQ3CZdhJ6mz1Vhvn92pM5ZkLjuJpYs60oz+eE/kkosZfJR6WGnQJOc39b0G3pq
	 E9HgIecWJiy/MRSYemPPfGsQ+/eJBLuVt15nfNwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 223/265] nvme: reject invalid pr_read_keys() num_keys values
Date: Thu, 12 Mar 2026 21:10:10 +0100
Message-ID: <20260312201026.380261497@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225164-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,oracle.com:email]
X-Rspamd-Queue-Id: 56CEA2790FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Hajnoczi <stefanha@redhat.com>

[ Upstream commit 38ec8469f39e0e96e7dd9b76f05e0f8eb78be681 ]

The pr_read_keys() interface has a u32 num_keys parameter. The NVMe
Reservation Report command has a u32 maximum length. Reject num_keys
values that are too large to fit.

This will become important when pr_read_keys() is exposed to untrusted
userspace via an <linux/pr.h> ioctl.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c3320153769f ("nvme: fix memory allocation in nvme_pr_read_keys()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 80dd09aa01a3b..d330916a3199d 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -200,7 +200,8 @@ static int nvme_pr_resv_report(struct block_device *bdev, void *data,
 static int nvme_pr_read_keys(struct block_device *bdev,
 		struct pr_keys *keys_info)
 {
-	u32 rse_len, num_keys = keys_info->num_keys;
+	size_t rse_len;
+	u32 num_keys = keys_info->num_keys;
 	struct nvme_reservation_status_ext *rse;
 	int ret, i;
 	bool eds;
@@ -210,6 +211,9 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	 * enough to get enough keys to fill the return keys buffer.
 	 */
 	rse_len = struct_size(rse, regctl_eds, num_keys);
+	if (rse_len > U32_MAX)
+		return -EINVAL;
+
 	rse = kzalloc(rse_len, GFP_KERNEL);
 	if (!rse)
 		return -ENOMEM;
-- 
2.51.0




