Return-Path: <stable+bounces-214832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICLoIK6ch2nUagQAu9opvQ
	(envelope-from <stable+bounces-214832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 21:12:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD310706A
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 21:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73AA5300460C
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2292FB99A;
	Sat,  7 Feb 2026 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdd+8RT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06391482E8
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770495142; cv=none; b=jXrcZ2c18QABj+gWje7B+QpgaUtxRrP8NHKTkA7HF7subIKc4mQINpyJrRg5dwWNPjERWZCSqlnQN/s9HUYfNThgUPCfm/PFmQhIY3roGJiWvOsJtDheMg8j3xPCkfeW7t3y32TacVR6Cyte0CZno3cHW5jnBZNyZ3CXnKXKxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770495142; c=relaxed/simple;
	bh=3++yUgoLQ+enGEQ2O3as4Sz+uZhNOqZ5ygR+1pI1Qpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/Bl4CZ173xBpPAIv4cyBfw9Ul2vDNhCT6w1m9JqSrZSEAriMSj+scOW1jrHDXgAZJNsYvRvO5hIGqRGt5eBjFEVttUVJuHHUnUhAQpnE2ya3HQ10sh4sABBDzrp4dtXhcIdoXFYpID/8yYFuYjHMj8TC0wE9qmkv2pMRMRNlQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdd+8RT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D60C16AAE;
	Sat,  7 Feb 2026 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770495142;
	bh=3++yUgoLQ+enGEQ2O3as4Sz+uZhNOqZ5ygR+1pI1Qpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rdd+8RT2G5zZce73uuEqUy29tLumXdEeE40Bv1ueZHa7iu0TS4edloIvMn9GeB64N
	 96MjNZU90aOoH4s53/Pcy5UA3TqHuAZ/cHtWlOT4vXNT/AuA2dNlCfpUbX1ojJcQvU
	 A9QFfqAbwiCEHB5ngcvz6k7nlflsYobh+rfcg3fm9xXVAQRO33osI1OGLesSQz1iqc
	 QmECusfAAJ7pyBcWsa/vAFe8ajU3HQx9G1HfFLP0C7nzlQlvN/8VZv5bycNpJm61e6
	 Gn+Rd/zgftwPy1KH5br43l+bFW0jFRssB1swOthyXWS2ni5ysUjH8VMxb6COSsxIgD
	 7MMJoL56jxLkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] nvmet-tcp: fix memory leak when performing a controller reset
Date: Sat,  7 Feb 2026 15:12:16 -0500
Message-ID: <20260207201219.540631-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260207201219.540631-1-sashal@kernel.org>
References: <2026020741-chitchat-symphonic-a96f@gregkh>
 <20260207201219.540631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214832-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93DD310706A
X-Rspamd-Action: no action

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit af21250bb503a02e705b461886321e394b300524 ]

If a reset controller is executed while the initiator
is performing some I/O the driver may leak the memory allocated
for the commands' iovec.

Make sure that nvmet_tcp_uninit_data_in_cmds() releases
all the memory.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 52a0a9854934 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3c0769d40edd3..bf34849c15a20 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1443,7 +1443,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_finish_cmd(cmd);
+			nvmet_req_uninit(&cmd->req);
+
+		nvmet_tcp_unmap_pdu_iovec(cmd);
+		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-- 
2.51.0


