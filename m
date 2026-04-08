Return-Path: <stable+bounces-234368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K3ADBKg1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:36:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F66D3C10A2
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A352E302A506
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449E3A16A0;
	Wed,  8 Apr 2026 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vLrT/9Ox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA2B67E;
	Wed,  8 Apr 2026 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672677; cv=none; b=Cst5fO7bAAK4KxVNG7l6vg2lY2VKMA4R8K42huzeOr/MmEZzZEPlvIbOFIArpRXfWqBCi+mJ3OTRjoQf8qxRKpC4S0Aez04Jb0Ufvtd6Z0eg8VIvk63aW5UzXre5N6d7zbNkyxp3WMy7vMK985PvJ6JC3lwJ+NLZDw0LgI30lCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672677; c=relaxed/simple;
	bh=SAHwC2PLISUlR5e/IT1PTMqHA6T+eRcLBr+UJL4LCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlblv5edl/sQAs7t96ufG0a1pVJcEKRCVAkbT2x9oB6K5/70VGr+KW2Gdw5Vu+yALYxC8w//iWrkPgfn/IEauLJlQgxtc2j3N8XSWsl38OMay+AkN3iFu/4eDWh2XpLbBsayM93piMi7DQOgAQjsahzl/W4cQIbSE8zRFx3M4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vLrT/9Ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D504C19421;
	Wed,  8 Apr 2026 18:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672677;
	bh=SAHwC2PLISUlR5e/IT1PTMqHA6T+eRcLBr+UJL4LCi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLrT/9OxjmkVvWw020L9VhFFHmhxJxxL6203D6fa14RltPuIBGPoJ0mAP9iVZV/tC
	 XTY7YD2D6yCsheKGO4Gl7cuOsMSRNJ7810u+OY/cSLKdgnKoEfJ7GQdLyuaIinnpNX
	 ZiAIrai7uojzPu5ay5xRgnQzumF3LfgzVcdov0z4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 066/160] accel/qaic: Handle DBC deactivation if the owner went away
Date: Wed,  8 Apr 2026 20:02:33 +0200
Message-ID: <20260408175915.669011184@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234368-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email,amd.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F66D3C10A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

[ Upstream commit 2feec5ae5df785658924ab6bd91280dc3926507c ]

When a DBC is released, the device sends a QAIC_TRANS_DEACTIVATE_FROM_DEV
transaction to the host over the QAIC_CONTROL MHI channel. QAIC handles
this by calling decode_deactivate() to release the resources allocated for
that DBC. Since that handling is done in the qaic_manage_ioctl() context,
if the user goes away before receiving and handling the deactivation, the
host will be out-of-sync with the DBCs available for use, and the DBC
resources will not be freed unless the device is removed. If another user
loads and requests to activate a network, then the device assigns the same
DBC to that network, QAIC will "indefinitely" wait for dbc->in_use = false,
leading the user process to hang.

As a solution to this, handle QAIC_TRANS_DEACTIVATE_FROM_DEV transactions
that are received after the user has gone away.

Fixes: 129776ac2e38 ("accel/qaic: Add control path")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Signed-off-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Link: https://patch.msgid.link/20260205123415.3870898-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/qaic/qaic_control.c | 47 +++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index 08b78f5678532..de8b17e2b29e1 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -910,7 +910,7 @@ static int decode_deactivate(struct qaic_device *qdev, void *trans, u32 *msg_len
 		 */
 		return -ENODEV;
 
-	if (status) {
+	if (usr && status) {
 		/*
 		 * Releasing resources failed on the device side, which puts
 		 * us in a bind since they may still be in use, so enable the
@@ -1104,6 +1104,9 @@ static void *msg_xfer(struct qaic_device *qdev, struct wrapper_list *wrappers, u
 	mutex_lock(&qdev->cntl_mutex);
 	if (!list_empty(&elem.list))
 		list_del(&elem.list);
+	/* resp_worker() processed the response but the wait was interrupted */
+	else if (ret == -ERESTARTSYS)
+		ret = 0;
 	if (!ret && !elem.buf)
 		ret = -ETIMEDOUT;
 	else if (ret > 0 && !elem.buf)
@@ -1414,9 +1417,49 @@ static void resp_worker(struct work_struct *work)
 	}
 	mutex_unlock(&qdev->cntl_mutex);
 
-	if (!found)
+	if (!found) {
+		/*
+		 * The user might have gone away at this point without waiting
+		 * for QAIC_TRANS_DEACTIVATE_FROM_DEV transaction coming from
+		 * the device. If this is not handled correctly, the host will
+		 * not know that the DBC[n] has been freed on the device.
+		 * Due to this failure in synchronization between the device and
+		 * the host, if another user requests to activate a network, and
+		 * the device assigns DBC[n] again, save_dbc_buf() will hang,
+		 * waiting for dbc[n]->in_use to be set to false, which will not
+		 * happen unless the qaic_dev_reset_clean_local_state() gets
+		 * called by resetting the device (or re-inserting the module).
+		 *
+		 * As a solution, we look for QAIC_TRANS_DEACTIVATE_FROM_DEV
+		 * transactions in the message before disposing of it, then
+		 * handle releasing the DBC resources.
+		 *
+		 * Since the user has gone away, if the device could not
+		 * deactivate the network (status != 0), there is no way to
+		 * enable and reassign the DBC to the user. We can put trust in
+		 * the device that it will release all the active DBCs in
+		 * response to the QAIC_TRANS_TERMINATE_TO_DEV transaction,
+		 * otherwise, the user can issue an soc_reset to the device.
+		 */
+		u32 msg_count = le32_to_cpu(msg->hdr.count);
+		u32 msg_len = le32_to_cpu(msg->hdr.len);
+		u32 len = 0;
+		int j;
+
+		for (j = 0; j < msg_count && len < msg_len; ++j) {
+			struct wire_trans_hdr *trans_hdr;
+
+			trans_hdr = (struct wire_trans_hdr *)(msg->data + len);
+			if (le32_to_cpu(trans_hdr->type) == QAIC_TRANS_DEACTIVATE_FROM_DEV) {
+				if (decode_deactivate(qdev, trans_hdr, &len, NULL))
+					len += le32_to_cpu(trans_hdr->len);
+			} else {
+				len += le32_to_cpu(trans_hdr->len);
+			}
+		}
 		/* request must have timed out, drop packet */
 		kfree(msg);
+	}
 
 	kfree(resp);
 }
-- 
2.53.0




