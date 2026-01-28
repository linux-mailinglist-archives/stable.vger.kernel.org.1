Return-Path: <stable+bounces-212306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N4INhI4eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:23:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A67A5892
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF24305C485
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B32F6183;
	Wed, 28 Jan 2026 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGSxPWqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4B2FB085;
	Wed, 28 Jan 2026 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615076; cv=none; b=NhPpFi+H0dpY+h6uD7AyHbJ4EMUHM3nxzod4WsshrJi9V5p2M8KHkBOZJLoKjOXl0NQVVJh0mPZFCE2KNY8R1ETdIHFx8lTRuo5qWNW5/pdrdwEtwwp3xNlF4ll01OjXrHSVd5OdQjjZGRr6Og2YTXi2nZqYf7cKb6Amkj9l1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615076; c=relaxed/simple;
	bh=4DUm8MeRh89//LB8dFD5tIgSgUdYClSTkdmNIzTTcUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOzwy74hxohxgFEpxhSRjTneHn8C9LMNl9qNKj/8rJ89DL93TvMFjruY0voBsk5m5t4u7qdNEaJ+cweorIQdvYbCzLmeOsfKvbVR8ZyaKUIoZmITd291AfgNNcUeY/W05q4EDs3n787gTYK75cTScQtceg0wyxRV0hY+q17SegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGSxPWqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8550AC4CEF1;
	Wed, 28 Jan 2026 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615076;
	bh=4DUm8MeRh89//LB8dFD5tIgSgUdYClSTkdmNIzTTcUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGSxPWqFweeGRoAYbQ+73bmPbscLc1tQ1/4A1p2QIjLkiUfnl4RymR/kcfaog3Yj2
	 u7iDJxUfMvuO8PwlsvqIysgOe8bEr3AZ+xM8Yq38FfX+9dqTTwJeLlOnuMOOVNebTY
	 2k3QWXDHEMx8iu/rDsVzQttlkZ5PE8SUnqk8tN0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brajesh Gupta <brajesh.gupta@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 071/169] drm/imagination: Wait for FW trace update command completion
Date: Wed, 28 Jan 2026 16:22:34 +0100
Message-ID: <20260128145336.562720393@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212306-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,imgtec.com:email]
X-Rspamd-Queue-Id: 33A67A5892
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brajesh Gupta <brajesh.gupta@imgtec.com>

[ Upstream commit 812062e74a3945b575dce89d330b67cb50054a77 ]

Possibility of no FW trace available after update in the fw_trace_mask due
to asynchronous mode of command consumption in the FW.

To ensure FW trace is available after update, wait for FW trace log update
command completion from the FW.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Link: https://patch.msgid.link/20260108040936.129769-1-brajesh.gupta@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 5dbb636d7d4ff..634c84bfc885a 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -141,6 +141,7 @@ update_logtype(struct pvr_device *pvr_dev, u32 group_mask)
 	struct rogue_fwif_kccb_cmd cmd;
 	int idx;
 	int err;
+	int slot;
 
 	if (group_mask)
 		fw_trace->tracebuf_ctrl->log_type = ROGUE_FWIF_LOG_TYPE_TRACE | group_mask;
@@ -158,8 +159,13 @@ update_logtype(struct pvr_device *pvr_dev, u32 group_mask)
 	cmd.cmd_type = ROGUE_FWIF_KCCB_CMD_LOGTYPE_UPDATE;
 	cmd.kccb_flags = 0;
 
-	err = pvr_kccb_send_cmd(pvr_dev, &cmd, NULL);
+	err = pvr_kccb_send_cmd(pvr_dev, &cmd, &slot);
+	if (err)
+		goto err_drm_dev_exit;
+
+	err = pvr_kccb_wait_for_completion(pvr_dev, slot, HZ, NULL);
 
+err_drm_dev_exit:
 	drm_dev_exit(idx);
 
 err_up_read:
-- 
2.51.0




