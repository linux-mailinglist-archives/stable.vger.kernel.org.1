Return-Path: <stable+bounces-247835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA6zMLA8B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:33:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E105522E7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54258300C0C9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913C4B8DF8;
	Fri, 15 May 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYhVJkzK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6C4BC005
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859173; cv=none; b=rxz+AL1ej2/GwcOZy3OGpOF47I2tJHf7mvxCsmScrRNAuVHjPmoFclntIwhBa+ntnC1b/vMZCootmJV5QV0ZcjlfxcDb+gy63z03CbEvUo/FE1Kbun/wT4lJaQCZ4H4rirRgKLzyf+dOh5GKKtPg8bwRKkXz6glKRKp2QKcIA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859173; c=relaxed/simple;
	bh=bcD+jw99Iid5Mks6D8ebALNRP1lHWJBkvBIZAP4/pN4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XJVSlBRu2TN5YKAbHFssoKCnE7IXZyVEOpSaRwlq+h032loKnZtMskp+tsyyzUi70a6TBrbMw0yn/an4T8rv03ftgDy/Rib0Kr0Wzy0Bfo3c0cp32kxmBHcceE7AKxxLovpUIcoU/kgpKj1o9froE+PvDcj2gxPlQsg+EDFaQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYhVJkzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017ABC2BCB0;
	Fri, 15 May 2026 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778859172;
	bh=bcD+jw99Iid5Mks6D8ebALNRP1lHWJBkvBIZAP4/pN4=;
	h=Subject:To:Cc:From:Date:From;
	b=XYhVJkzKRUi8eoBDaUWJaE1XDI5w8XuDbaTuoKMDmyqUVJPelq0bE28DYa4lIKqxk
	 QIgLHhC6oyhMJQvbNz60jN2liR1e9bmheuIR0emMtZncq/rJ4uak9S67bCsajeZEB/
	 ST+x0LwL85AxCWhL9zVHBmN3/zQD0FFhAbAvS1Mc=
Subject: FAILED: patch "[PATCH] Bluetooth: MGMT: fix crash in set_mesh_sync and" failed to apply to 6.6-stable tree
To: pav@iki.fi,luiz.von.dentz@intel.com,pmenzel@molgen.mpg.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 17:32:56 +0200
Message-ID: <2026051556-unwarlike-energetic-5ff9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64E105522E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247835-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e8785404de06a69d89dcdd1e9a0b6ea42dc6d327
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051556-unwarlike-energetic-5ff9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e8785404de06a69d89dcdd1e9a0b6ea42dc6d327 Mon Sep 17 00:00:00 2001
From: Pauli Virtanen <pav@iki.fi>
Date: Fri, 3 Oct 2025 22:07:32 +0300
Subject: [PATCH] Bluetooth: MGMT: fix crash in set_mesh_sync and
 set_mesh_complete

There is a BUG: KASAN: stack-out-of-bounds in set_mesh_sync due to
memcpy from badly declared on-stack flexible array.

Another crash is in set_mesh_complete() due to double list_del via
mgmt_pending_valid + mgmt_pending_remove.

Use DEFINE_FLEX to declare the flexible array right, and don't memcpy
outside bounds.

As mgmt_pending_valid removes the cmd from list, use mgmt_pending_free,
and also report status on error.

Fixes: 302a1f674c00d ("Bluetooth: MGMT: Fix possible UAFs")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 74edea06985b..bca0333f1e99 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -853,7 +853,7 @@ struct mgmt_cp_set_mesh {
 	__le16 window;
 	__le16 period;
 	__u8   num_ad_types;
-	__u8   ad_types[];
+	__u8   ad_types[] __counted_by(num_ad_types);
 } __packed;
 #define MGMT_SET_MESH_RECEIVER_SIZE	6
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3d16eece0d2..24e335e3a727 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2175,19 +2175,24 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 	sk = cmd->sk;
 
 	if (status) {
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				status);
 		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
 				     cmd_status_rsp, &status);
-		return;
+		goto done;
 	}
 
-	mgmt_pending_remove(cmd);
 	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, NULL, 0);
+
+done:
+	mgmt_pending_free(cmd);
 }
 
 static int set_mesh_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_mesh cp;
+	DEFINE_FLEX(struct mgmt_cp_set_mesh, cp, ad_types, num_ad_types,
+		    sizeof(hdev->mesh_ad_types));
 	size_t len;
 
 	mutex_lock(&hdev->mgmt_pending_lock);
@@ -2197,27 +2202,26 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
 		return -ECANCELED;
 	}
 
-	memcpy(&cp, cmd->param, sizeof(cp));
+	len = cmd->param_len;
+	memcpy(cp, cmd->param, min(__struct_size(cp), len));
 
 	mutex_unlock(&hdev->mgmt_pending_lock);
 
-	len = cmd->param_len;
-
 	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
 
-	if (cp.enable)
+	if (cp->enable)
 		hci_dev_set_flag(hdev, HCI_MESH);
 	else
 		hci_dev_clear_flag(hdev, HCI_MESH);
 
-	hdev->le_scan_interval = __le16_to_cpu(cp.period);
-	hdev->le_scan_window = __le16_to_cpu(cp.window);
+	hdev->le_scan_interval = __le16_to_cpu(cp->period);
+	hdev->le_scan_window = __le16_to_cpu(cp->window);
 
-	len -= sizeof(cp);
+	len -= sizeof(struct mgmt_cp_set_mesh);
 
 	/* If filters don't fit, forward all adv pkts */
 	if (len <= sizeof(hdev->mesh_ad_types))
-		memcpy(hdev->mesh_ad_types, cp.ad_types, len);
+		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
 
 	hci_update_passive_scan_sync(hdev);
 	return 0;


