Return-Path: <stable+bounces-228293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJC9CPZRwWn+SAQAu9opvQ
	(envelope-from <stable+bounces-228293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:45:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDDF2F51C2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68460303457A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A93B3C18;
	Mon, 23 Mar 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Svgtx6pz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B943AD526;
	Mon, 23 Mar 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274715; cv=none; b=ANEWvq51FFR74csI1eHn7ds0fRGRkDZeoEFK7WdlQYJe8zIwhWNaxZa08DZoTeidQcwFZ0PuCuDZde11kzORSjtHxZKiYUq4kQ1r9hdoBjRTLJFcN8O7J3jK1WqEaWLDmz0dFzjder/tK//uqXAfcyiYBw29nOF2E3JFZJRtJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274715; c=relaxed/simple;
	bh=A4NXuhy8XEB7c/obJwVz+aF4xi4PFMGWqiqWz6Q53VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb0RhFMaBRZO04vQJ2BXp8cbHHGtmVeEGdsHGlICJffzG/UUCpJH5twX2UvIPBcUU4BKcyC/U6bZli+ZNmw9i8zp2mAy1bGCBImteGIDPWuOe8bucnPYF4lfbUtljUGBx2wgICK6R8gE6m6mX2qzHXrpa9L1Gmf0HpFy2/G5PDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Svgtx6pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB6C4CEF7;
	Mon, 23 Mar 2026 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274714;
	bh=A4NXuhy8XEB7c/obJwVz+aF4xi4PFMGWqiqWz6Q53VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Svgtx6pzhaYIkXk17mYpBqg9BfbpufdmQXLUzrvqIzP+ESRwjm2bC4DDUIoR3+iYJ
	 VyvOguTAUSOBUq7gMLLinR9QbpXG5qCyXx/FuJX689sfsO4Ci6g2zQ0tWZqkgmPBpk
	 /TKhJm+tt2R87dUsYjE0bOTXDUVB1BBpCBjBn5Jk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mehul Rao <mehulrao@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 032/212] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
Date: Mon, 23 Mar 2026 14:44:13 +0100
Message-ID: <20260323134504.781150411@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228293-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.dk,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8CDDF2F51C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mehul Rao <mehulrao@gmail.com>

[ Upstream commit 25966fc097691e5c925ad080f64a2f19c5fd940a ]

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
[ adapted `&header` to `header` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/ublk_drv.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3604,15 +3604,22 @@ static int ublk_ctrl_get_features(const
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
@@ -3902,8 +3909,7 @@ static int ublk_ctrl_uring_cmd(struct io
 		ret = ublk_ctrl_end_recovery(ub, header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, header);
-		ret = 0;
+		ret = ublk_ctrl_set_size(ub, header);
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
 		ret = ublk_ctrl_quiesce_dev(ub, header);



