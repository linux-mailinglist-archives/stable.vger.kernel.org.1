Return-Path: <stable+bounces-213767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLc9GUZkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:22:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D180E864C
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 203A330200B0
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1634218AE;
	Wed,  4 Feb 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDRKubcK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FC4218A8;
	Wed,  4 Feb 2026 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217438; cv=none; b=Yv8hacCg/CbPTrU+UVzTnmRpbpDUB3wOYxXS7IFC/pz+tBJEYJjKumm8HsK8bDtlKssheEV+HT0kTEjQxihd0aw0hbDntZPiYEVq0DKUmglqDiQ/lU5/uhMlqqOwoUo6figw2Mm4CH+n5SkUY/U2inKPlnbTJ+adKmIV1oPjXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217438; c=relaxed/simple;
	bh=7hIS0F4/quzd8CZEJ9my07kozPpNem2TioZwG6SXx+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPzJ3SFOsQH9nD3zyvRJMRONQ3ZrjUBfWUTA5AXYAdhTV3+VffLch3BOKJUrZTiEq8eCAiPttN8HFChidA+RW2vvuMbWJrb2K8JOuSNwI7LMxN3PG6A6ShRrhr/uILjX5B3WI6g+m4xGQQKFkuwU2xM1cbj+YLrGl7uEBON8m2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDRKubcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FB8C4CEF7;
	Wed,  4 Feb 2026 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217438;
	bh=7hIS0F4/quzd8CZEJ9my07kozPpNem2TioZwG6SXx+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDRKubcKGzj7GdHmUsdZLvizFldMrXvKHnV2q4DKU2hdlNiiy045jc0zMpfgKrQCq
	 ukxTMylc/UICwauaoldJriHcoU2dJXffkndC28iQGpGFvAl15/bP1u9EO7n6dPEVqf
	 fY437APeKhHt0t5tH/84sn1wVM3kXpRKSGYJODeo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 007/280] nvmet-tcp: remove boilerplate code
Date: Wed,  4 Feb 2026 15:36:21 +0100
Message-ID: <20260204143909.891584992@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213767-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,grimberg.me:email]
X-Rspamd-Queue-Id: 7D180E864C
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 75011bd0f9c55db523242f9f9a0b0b826165f14b ]

Simplify the nvmet_tcp_handle_h2c_data_pdu() function by removing
boilerplate code.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 32b63acd78f5 ("nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index eee052dbf80c1..8fc626ddc1275 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -930,8 +930,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		if (unlikely(data->ttag >= queue->nr_cmds)) {
 			pr_err("queue %d: received out of bound ttag %u, nr_cmds %u\n",
 				queue->idx, data->ttag, queue->nr_cmds);
-			nvmet_tcp_fatal_error(queue);
-			return -EPROTO;
+			goto err_proto;
 		}
 		cmd = &queue->cmds[data->ttag];
 	} else {
@@ -942,9 +941,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
 			data->ttag, le32_to_cpu(data->data_offset),
 			cmd->rbytes_done);
-		/* FIXME: use path and transport errors */
-		nvmet_tcp_fatal_error(queue);
-		return -EPROTO;
+		goto err_proto;
 	}
 
 	exp_data_len = le32_to_cpu(data->hdr.plen) -
@@ -957,9 +954,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		     cmd->pdu_len == 0 ||
 		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
-		/* FIXME: use proper transport errors */
-		nvmet_tcp_fatal_error(queue);
-		return -EPROTO;
+		goto err_proto;
 	}
 	cmd->pdu_recv = 0;
 	nvmet_tcp_build_pdu_iovec(cmd);
@@ -967,6 +962,11 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	queue->rcv_state = NVMET_TCP_RECV_DATA;
 
 	return 0;
+
+err_proto:
+	/* FIXME: use proper transport errors */
+	nvmet_tcp_fatal_error(queue);
+	return -EPROTO;
 }
 
 static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
-- 
2.51.0




