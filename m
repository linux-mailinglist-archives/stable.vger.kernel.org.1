Return-Path: <stable+bounces-247261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGyOGBALBmqfeQIAu9opvQ
	(envelope-from <stable+bounces-247261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:49:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A852B54583E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78C0D3010176
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419E7393DDC;
	Thu, 14 May 2026 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqXStCPZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019023939B5;
	Thu, 14 May 2026 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780921; cv=none; b=N2kUIOhCmmK9ef5mlXLcl/wkUTDwnkF4zaZSO6KH9n3Ug6pb4venJ+VW/dSu/nrkM58GdoE4Uz4BA8e48Z149LyHJ8lBj79pz3EtLFqsj9DiIDfrpeP9HHcxMsKmOyaCvPI7Sb9IytPK9PN72i1FAtHqZmCDZl1gAg359OAP9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780921; c=relaxed/simple;
	bh=SpC0Q2FuxRUJkqZhyltOgdHrXLX0XT2Kl77zMRud2Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mze41lZnxHXzHoKjf8INGprDf9i8l4WmEdqXRc9EKFNMeGmBAf73MMr9Mm/Yhmlu7hfpoka1zHbCT1wlQDgJOy9vWhlVOqCsPQ6WiNBlYaMnh16EqWzNDLOjyGKr98wxy6CwofE2FVAiyXkfaTl3HJkc0DzdPQwR+Xa8pdr5QjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqXStCPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BAECC2BCB3;
	Thu, 14 May 2026 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778780920;
	bh=SpC0Q2FuxRUJkqZhyltOgdHrXLX0XT2Kl77zMRud2Rg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cqXStCPZefM/4HVlY65OqWQEFYCtuY5dih7LDuVI6CVgR7b7glkM7rD7SpeGtT2WZ
	 +81T+kUJLGoWRSEENd7NJW7hS8zZUgxSqCxqrTm5Zi8qqi/B7zrTp0+kO+Z/x2NXAf
	 AJWjPOrs7KnxKV6xEvJWrnUaTvLJO4f3RYcU6bwaYoRQ83ngAktiGDj3x8Jhb+v2DP
	 ee53vKgTKR2Coz//T78didhhs/zzxJy5XB2vppXZZcJHdetoq0JWmYnNHl965Wro1i
	 G1Azyg7RHvfBR111A4cHwxoyXm6X443kchfC3SJCJCr+te4aM1mVYLca8BjR9cuR85
	 o8tV94wVv5pgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67082CD37AC;
	Thu, 14 May 2026 17:48:40 +0000 (UTC)
From: Shivam Kalra via B4 Relay <devnull+shivamkalra98.zohomail.in@kernel.org>
Date: Thu, 14 May 2026 23:18:13 +0530
Subject: [PATCH] Bluetooth: btmtk: Fix FUNC_CTRL parsing for devices with
 zero-length payloads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in>
X-B4-Tracking: v=1; b=H4sIANwKBmoC/yXMQQqDMBCF4avIrB3QwSrpVYoLx050RE1JohTEu
 zfW5cfj/QcE8SoBntkBXnYN6taEMs+gH7t1ENR3MlBBdfEoK+R5k+jciFa/uMTGEKEhZhZriQx
 Den68pPVffbW3w8aT9PFKwXn+AIppPYt3AAAA
X-Change-ID: 20260514-bluetooh-fix-mt7922-92bbbeff229b
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Tristan Madani <tristan@talencesecurity.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, Shivam Kalra <shivamkalra98@zohomail.in>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778780918; l=3281;
 i=shivamkalra98@zohomail.in; s=20260402; h=from:subject:message-id;
 bh=bcjmkVn6V3NtLKEjGgmZqORTUn19c/SPpadc1fesit4=;
 b=/01nuKC6TNTxIJytg/c6BI11qqo/OIDmX6XK3217Rpx6jibl/qWUCcWwasbS3GKv892fZ2oGI
 SPlPJOfwOb7Bb7mBGJhTkzaJRnWAUswPzEcElVilQ2/qgwkjMgJeW7S
X-Developer-Key: i=shivamkalra98@zohomail.in; a=ed25519;
 pk=U8kQSxcte8P8iZ6zB7phIj+Yl+i/5ntifBGuclgypx8=
X-Endpoint-Received: by B4 Relay for shivamkalra98@zohomail.in/20260402
 with auth_id=716
X-Original-From: Shivam Kalra <shivamkalra98@zohomail.in>
Reply-To: shivamkalra98@zohomail.in
X-Rspamd-Queue-Id: A852B54583E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247261-lists,stable=lfdr.de,shivamkalra98.zohomail.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,collabora.com,talencesecurity.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[shivamkalra98@zohomail.in];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zohomail.in:email,zohomail.in:mid,zohomail.in:replyto]
X-Rspamd-Action: no action

From: Shivam Kalra <shivamkalra98@zohomail.in>

Commit 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length
before struct access") added strict SKB length checks to prevent OOB
memory reads when parsing WMT events.

However, when enabling the protocol (flag = 0), the MT7922 returns a WMT
event with a zero-length payload (skb->len == 7), omitting the 2-byte
status field entirely.

The strict sizeof() check unconditionally enforced the presence of the
status field for all BTMTK_WMT_FUNC_CTRL events. This caused the driver
to reject these payload-less responses with -EINVAL, failing Bluetooth
initialization ("Failed to send wmt func ctrl (-22)").

Fix this by making skb_pull_data() conditional: if the status payload is
present, parse it as before; if omitted, default to BTMTK_WMT_ON_UNDONE.
This restores the pre-regression initialization behavior while
maintaining the memory safety bounds of the previous patch.

Fixes: 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221511
Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
---
Tested on a laptop with a single MediaTek MT7922 (USB ID 0489:e0e0)
Bluetooth controller. Before this patch, Bluetooth initialization failed
with "Failed to send wmt func ctrl (-22)" on every boot. After applying
this patch, initialization succeeds reliably.

This regression is also reported by other users on the kernel bug
tracker [1].

Note: btmtksdio.c and btmtkuart.c have similar FUNC_CTRL parsing code
but were not modified by the original commit 634a4408c061, so they are
not affected by this regression and do not require changes.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=221511
---
 drivers/bluetooth/btmtk.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index f70c1b0f8990..026e5a76b086 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -717,19 +717,19 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
-		if (!skb_pull_data(data->evt_skb,
-				   sizeof(wmt_evt_funcc->status))) {
-			err = -EINVAL;
-			goto err_free_skb;
-		}
-
-		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
-		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
-			status = BTMTK_WMT_ON_DONE;
-		else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
-			status = BTMTK_WMT_ON_PROGRESS;
-		else
+		if (skb_pull_data(data->evt_skb,
+				  sizeof(wmt_evt_funcc->status))) {
+			wmt_evt_funcc =
+				(struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+			if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
+				status = BTMTK_WMT_ON_DONE;
+			else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
+				status = BTMTK_WMT_ON_PROGRESS;
+			else
+				status = BTMTK_WMT_ON_UNDONE;
+		} else {
 			status = BTMTK_WMT_ON_UNDONE;
+		}
 		break;
 	case BTMTK_WMT_PATCH_DWNLD:
 		if (wmt_evt->whdr.flag == 2)

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260514-bluetooh-fix-mt7922-92bbbeff229b

Best regards,
--  
Shivam Kalra <shivamkalra98@zohomail.in>



