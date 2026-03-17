Return-Path: <stable+bounces-226460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEryBvGJuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:05:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D02AEEC1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CF35309FEF0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02B83F7873;
	Tue, 17 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0lMtK0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3E346797;
	Tue, 17 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766810; cv=none; b=D9rqA9giV/XqoLkrHH09WN8h9npubtR0TLqknGmCjbndMWKBYXhGh3lD0a/41sR3i7ss4NWa+Qp0s7mG8m0Agya+HlBeNAecU8Q+4fRRZyv7c96Tf6jVkkp9plMPPFC0o4PPv4+b5xRDvieTKEoU6bEpbH1QwuL/qTyHzWs4U88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766810; c=relaxed/simple;
	bh=t0iqsZRHz/04VDuPtEkM2aKOZnJQaDuF8gHb7XbF41M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuvKHJilhg9KmHH2qg08tpsdnDeBlYy8b61bAthKws65WbUoE/1RGRtcnhCzdxFxAF2OIAVgDUdIXwLalSFMlPPaneSO2ByZUBjoEJzwAym5a9bTGYRdICt6XPvHvVG9lOFrFNKb74hVHyNFYCiLJZumnewy4QcWyzYIYGm6w8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0lMtK0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD61C19424;
	Tue, 17 Mar 2026 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766810;
	bh=t0iqsZRHz/04VDuPtEkM2aKOZnJQaDuF8gHb7XbF41M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0lMtK0gd+UdFXlMtw7KSXbCzlutAsTfqxjpLAFmSaNsLVPnX0Mpmi1PZPhaFa9EB
	 vH1/XMaEcMEkl2H5RvVoq7G3InLw33GsjhIvTuK584HHnZwmz7SYjMuSiw+pJ8i5Pq
	 /jqsZcMAJvYbxTKcfB6LIA55QpMLMPJxMkNcRqUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mehul Rao <mehulrao@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.19 326/378] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
Date: Tue, 17 Mar 2026 17:34:43 +0100
Message-ID: <20260317163018.983282084@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226460-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,kernel.dk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D22D02AEEC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mehul Rao <mehulrao@gmail.com>

commit 25966fc097691e5c925ad080f64a2f19c5fd940a upstream.

ublk_ctrl_set_size() unconditionally dereferences ub->ub_disk via
set_capacity_and_notify() without checking if it is NULL.

ub->ub_disk is NULL before UBLK_CMD_START_DEV completes (it is only
assigned in ublk_ctrl_start_dev()) and after UBLK_CMD_STOP_DEV runs
(ublk_detach_disk() sets it to NULL). Since the UBLK_CMD_UPDATE_SIZE
handler performs no state validation, a user can trigger a NULL pointer
dereference by sending UPDATE_SIZE to a device that has been added but
not yet started, or one that has been stopped.

Fix this by checking ub->ub_disk under ub->mutex before dereferencing
it, and returning -ENODEV if the disk is not available.

Fixes: 98b995660bff ("ublk: Add UBLK_U_CMD_UPDATE_SIZE")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/ublk_drv.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3534,15 +3534,22 @@ static int ublk_ctrl_get_features(const
 	return 0;
 }
 
-static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
 {
 	struct ublk_param_basic *p = &ub->params.basic;
 	u64 new_size = header->data[0];
+	int ret = 0;
 
 	mutex_lock(&ub->mutex);
+	if (!ub->ub_disk) {
+		ret = -ENODEV;
+		goto out;
+	}
 	p->dev_sectors = new_size;
 	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+out:
 	mutex_unlock(&ub->mutex);
+	return ret;
 }
 
 struct count_busy {
@@ -3853,8 +3860,7 @@ static int ublk_ctrl_uring_cmd(struct io
 		ret = ublk_ctrl_end_recovery(ub, &header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, &header);
-		ret = 0;
+		ret = ublk_ctrl_set_size(ub, &header);
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
 		ret = ublk_ctrl_quiesce_dev(ub, &header);



