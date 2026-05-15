Return-Path: <stable+bounces-247836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHDvKmNAB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:48:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD22552619
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DB4312668E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA31C3E00BB;
	Fri, 15 May 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rneVS5Ko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697194C040D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859214; cv=none; b=HoySZnOwGIAOmOoFzd0id91wC7nAAmMkXRYWbMktNpVwHrf/yzxYVzD0tsM41tEsvICUhAfySzLbew/8cY6HvBYfZCFSoocobgYhhRS6wVJrFm8+3Kw0mrkSFK18njKzOu0vKDB+vih2bdI8UGMf4ubU/3pp2vdjltp6DIuUbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859214; c=relaxed/simple;
	bh=FGhQDKbAz8CNMCk0kq9U4k7LhZL/pK94ULz572TNJRM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HuKpJtew0ULpk+s9yPmbsEZDNm+1SNWaf6pE0OELGHI4bOhsy+7wdHEVC+dOOA3wmxSSQzGwAjCis15jtyVIO/yQbyJHomdmISoSsRACYaxsQStDyb54jW2Hpe2VZpZNFmO/tKM4gPa1zOSyuu5DhVTwVVb/pPhnTDNW5OO6uCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rneVS5Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B634C4AF09;
	Fri, 15 May 2026 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778859213;
	bh=FGhQDKbAz8CNMCk0kq9U4k7LhZL/pK94ULz572TNJRM=;
	h=Subject:To:Cc:From:Date:From;
	b=rneVS5KoAXBorKJ7z3lYgKfCyWs/h9VMv8vOcxMfyt2IwoG9XmYNmFhHkQ3lKLVek
	 KvRCdmvkrkQDx+SM273q5Q2gb5q+4/v36nMxp8RSpRDgDA5zC/ot0kVO8ta94Qo/R8
	 Hhblf4Kfb8OW4ZddCsKlXd25cN94k8IrEpYP3R7I=
Subject: FAILED: patch "[PATCH] Bluetooth: MGMT: Fix list corruption and UAF in command" failed to apply to 6.6-stable tree
To: wangtao554@huawei.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 17:33:37 +0200
Message-ID: <2026051537-clique-ablaze-cd41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2FD22552619
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247836-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,huawei.com:email,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 17f89341cb4281d1da0e2fb0de5406ab7c4e25ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051537-clique-ablaze-cd41@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17f89341cb4281d1da0e2fb0de5406ab7c4e25ef Mon Sep 17 00:00:00 2001
From: Wang Tao <wangtao554@huawei.com>
Date: Fri, 27 Feb 2026 11:03:39 +0000
Subject: [PATCH] Bluetooth: MGMT: Fix list corruption and UAF in command
 complete handlers

Commit 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs") introduced
mgmt_pending_valid(), which not only validates the pending command but
also unlinks it from the pending list if it is valid. This change in
semantics requires updates to several completion handlers to avoid list
corruption and memory safety issues.

This patch addresses two left-over issues from the aforementioned rework:

1. In mgmt_add_adv_patterns_monitor_complete(), mgmt_pending_remove()
is replaced with mgmt_pending_free() in the success path. Since
mgmt_pending_valid() already unlinks the command at the beginning of
the function, calling mgmt_pending_remove() leads to a double list_del()
and subsequent list corruption/kernel panic.

2. In set_mesh_complete(), the use of mgmt_pending_foreach() in the error
path is removed. Since the current command is already unlinked by
mgmt_pending_valid(), this foreach loop would incorrectly target other
pending mesh commands, potentially freeing them while they are still being
processed concurrently (leading to UAFs). The redundant mgmt_cmd_status()
is also simplified to use cmd->opcode directly.

Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Signed-off-by: Wang Tao <wangtao554@huawei.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a7238fd3b03b..d52238ce6a9a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2195,10 +2195,7 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	sk = cmd->sk;
 
 	if (status) {
-		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
-				status);
-		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
-				     cmd_status_rsp, &status);
+		mgmt_cmd_status(cmd->sk, hdev->id, cmd->opcode, status);
 		goto done;
 	}
 
@@ -5377,7 +5374,7 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
 			  mgmt_status(status), &rp, sizeof(rp));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 	bt_dev_dbg(hdev, "add monitor %d complete, status %d",


