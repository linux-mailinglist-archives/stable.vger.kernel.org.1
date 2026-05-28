Return-Path: <stable+bounces-255516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFEyJ16jGGrJlggAu9opvQ
	(envelope-from <stable+bounces-255516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:19:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF905F8640
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30B96318C146
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DA409E16;
	Thu, 28 May 2026 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BWvxR7Sk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEB40961F;
	Thu, 28 May 2026 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999131; cv=none; b=kNvDZe7jy4QCMVo01IMoT2+i9A00ZtoKZYqNoW9h3ZqHDAKtl5YsM7gkE/kgHcSutBThYDzFASRnmDLe71dFgAPtdZVtr/eb00eeHhiaJ/Hgya4oKj+mmzE0fbKuMYPo0hbOV+87iS4ly5WstY4o6qpXhb6X4NEDinwXyH8E360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999131; c=relaxed/simple;
	bh=HlpMoWyeI2+PLAN/kkbi4b15vpacLYiFCZGO9zM9sqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3of/A0Dt+RCMdY8f0wWkhUBFN4mvVi3s8DsJZH3ofEnQbOvgIpWmHKgFANwx/pB1sc0Eq0GS5ZhdARFNgGeD3JaPT1NFSNIZ5ismvW0UE3M7a7Svl4IxxTc2llrTSwiVf6Nw/64rkHiaAx/4ygb/d/lfDLn4tnqJ8wgiavUZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BWvxR7Sk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618F21F00A3A;
	Thu, 28 May 2026 20:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999129;
	bh=rHiImgAvu7gS01eilDBgajrr8rERsPAdetH8MP8sRLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BWvxR7SkdMrCZs/v+cjf5/CgJolBDmF7/VJagp4y2pGRp6ouYwOJbT1nCacZ4TTXc
	 TEAwuGVaLOCn0vLDVHjFref+ru5ql4SDcqiFcX3D2EDE+i7sUiU269FwNpJFGLDicQ
	 Hh11cAlpoouWH5NqMq4yg76YuMllc6ML7damfeZk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 419/461] Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
Date: Thu, 28 May 2026 21:49:08 +0200
Message-ID: <20260528194659.628237028@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255516-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 3CF905F8640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 23d528d817a485fe9800a66c9411bd9e3d8a6f63 ]

This fixes not setting the bit for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
when extended features bit is set otherwise the controller may not
generate HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE causing
hci_le_read_all_remote_features_sync to timeout waiting for it.

Also remove dead code.

Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Feature Set")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 919ec275dd237..426f465be3553 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4438,6 +4438,9 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
 	}
 
+	if (ll_ext_feature_capable(hdev))
+		events[5] |= BIT(2);
+
 	if (le_cs_capable(hdev)) {
 		/* Channel Sounding events */
 		events[5] |= 0x08;	/* LE CS Read Remote Supported Cap Complete event */
@@ -7413,9 +7416,6 @@ static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
 					sizeof(cp), &cp,
 					HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE,
 					HCI_CMD_TIMEOUT, NULL);
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_READ_ALL_REMOTE_FEATURES,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
 static int hci_le_read_remote_features_sync(struct hci_dev *hdev, void *data)
-- 
2.53.0




