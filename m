Return-Path: <stable+bounces-180602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A83B88079
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 08:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920EC1C80E86
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 06:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA42C08BC;
	Fri, 19 Sep 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdWCIcTQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4B25A33A
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264467; cv=none; b=smv+c3RyF70F0sFr8yy2Vwrzb5sncjBbx0KruW1Ad/CE3ZoXvw2r/bl40BQhEARnb0x6KsjI5QvliEwSN6ELt9Z+RA3t/03fPuWPICJmnz3Z6Y13dDxIxQCs2GTyeVJyQGQUNHe5aDd7ITu/UK1ZpEDgi4rzMyO9kPS9g7fu4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264467; c=relaxed/simple;
	bh=8Yog+/Ps8miaSyy+L2Uqg/H6UWiu0bz43haxSkmUmKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iodGDD3byPgkyVNcYgBtsujfNEExEZ42A2ipBb8RWnOPAWXWzj8i02V4J4qFZgPTwej2KIPPseskpgVCwDmztMOs0SeRjY4M559zPdS/zrR8RvYAdaDJ1XDBwJmdSfHnMicTqwvnNSrmW4OH2tAfH6/3mdlI5SxYJGogXnIg2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdWCIcTQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so1259474a91.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758264465; x=1758869265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rk0FtUPyMZMHcSPcxo141iI4er0nDZ3cTT6KvZSd5I=;
        b=YdWCIcTQVZmTerH1zBztN8smpu7S2qfv0wXtfVeOIoh0fHw+H9EWqi3aScFKMJNc64
         dP8cwUIfAkeiT9/AoKgLyXwfHU6k1lnGESFGKhlmDAnbNsjTrTJwLc8QFLt/TcAiUSdS
         3U/75yXYQl3EvDSiJURYPNH747D68YOasEvDKdmeNFYR6NRNrgY4Ac0iTvAgCGq9JbZD
         fBnx48fKckeJezzW+8LLvCX4lQ+C8ysfuyWdwr1QmW+kOBFrD0kVfii4NKmeuOxBFcTh
         XXGGaQpu7TnOmVpBtc1avrO+t8vNFZksU0+/obn4aXxAYfjCbBoxx4YoOE0YSfZDAvSt
         1MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758264465; x=1758869265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Rk0FtUPyMZMHcSPcxo141iI4er0nDZ3cTT6KvZSd5I=;
        b=PflS8HJmLrk66tBFiXnrMxAM+PXK5lrw4SuCLy8QR7E/ba14WiRzcxefW6wk1zAuuZ
         B4Q3gwpPDDu1zqjDh73RiI3oU6o52wAxHRJ1czbbqjVmeTv8tigCD2wPxEMjaFkkXG9i
         LRnxKcRJgH0mpDEnUeI879QfO4uYHN9g+YRdUesSHNFn5fkqN7adk+IA79jeuRaT8GKB
         CkRN4WE1Y1qaQj2tRj2wHy3vRvAcNIdBMqRzuIt+WJvEv6xzjrHVvT31aVyH4zHmkzcL
         9Nj6D+/qAA/2GqK5K2VYyZe9qv24nmUTyRGUDliK+xDbX0uWaKj/i4ZyysXnPCPuTRqE
         pogA==
X-Forwarded-Encrypted: i=1; AJvYcCVEL0mWMAz2qwCB9kCH6aamlnt4mLhyKqFTCbcOkp5zxNXCk+oWuCECLXo9itQ0zKSH0V3c0+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzh18OPaEMkzffmEwEEaFDfvBNsDqUQVnNyg6nr6IcI/EPpJt
	P8ZpDMoxAQJBV9yKs1V4MT3aJIY2Rkky3iiR4UtzljhboImOOCLDMwS0
X-Gm-Gg: ASbGncsCg/gmRqlK/BE3yvf/hBkCxfpTIHaavwyEiysfOFCwXz5AarE2S2CaNeoPg2w
	reenefSlSyydYYsCcubzmnAUXpLFU6JrbJA77u1PmxcC7vy6JGjuczmkWuxXrHLImqd5V3hpVq9
	NzrKGbSoBvLOLjFW9QfUyRqOd9zydWqeuGy7yF29A5FmZoakBhHgq4iuxHY7UOQ8CGylfmfguch
	9/OJ7ksQt1/nG/6JptboT4Hkp+Ej+uZd0y2fhaAiIM0S/tncC71fn5Ovo/rtZrzfy8MoJXkf/5x
	tJLNNSAlTyXdVHc25WgJHJbVm+d47US1eJlWjd4oacXzi1iE2Jhldc8yEgXqtk91jl72LQalmAS
	wiDJrysPueNM2RFJX+TjwhOBfbIfmD9zu8ID27hOIYA==
X-Google-Smtp-Source: AGHT+IEONXPXwTXLW4O6vfjecoXO93QrdqpGDn7u7EgAlcvrMMqPuD7PsnMYQ+XMLiCSv0GoFy74nQ==
X-Received: by 2002:a17:90b:1d49:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-330983886cdmr2544602a91.36.1758264464763;
        Thu, 18 Sep 2025 23:47:44 -0700 (PDT)
Received: from cortexauth ([2401:4900:4bb1:905c:8563:7696:c957:69ac])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551380444asm2182695a12.27.2025.09.18.23.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 23:47:44 -0700 (PDT)
From: Deepak Sharma <deepak.sharma.472935@gmail.com>
To: krzk@kernel.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Deepak Sharma <deepak.sharma.472935@gmail.com>,
	syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Subject: [PATCH net v3] net: nfc: nci: Add parameter validation for packet data
Date: Fri, 19 Sep 2025 12:15:44 +0530
Message-ID: <20250919064545.4252-1-deepak.sharma.472935@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an uninit-value bug at nci_init_req for commit
5aca7966d2a7 ("Merge tag 'perf-tools-fixes-for-v6.17-2025-09-16'..).

This bug arises due to very limited and poor input validation
that was done at nic_valid_size(). This validation only
validates the skb->len (directly reflects size provided at the
userspace interface) with the length provided in the buffer
itself (interpreted as NCI_HEADER). This leads to the processing
of memory content at the address assuming the correct layout
per what opcode requires there. This leads to the accesses to
buffer of `skb_buff->data` which is not assigned anything yet.

Following the same silent drop of packets of invalid sizes at
`nic_valid_size()`, add validation of the data in the respective
handlers and return error values in case of failure. Release
the skb if error values are returned from handlers in 
`nci_nft_packet` and effectively do a silent drop

Possible TODO: because we silently drop the packets, the
call to `nci_request` will be waiting for completion of request
and will face timeouts. These timeouts can get excessively logged
in the dmesg. A proper handling of them may require to export
`nci_request_cancel` (or propagate error handling from the
nft packets handlers).

Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation)
Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
---
v3:
 - Move the checks inside the packet data handlers
 - Improvements to the commit message

v2:
 - Fix the release of skb in case of the early return

v1:
 - Add checks in `nci_ntf_packet` on the skb->len and do early return
   on failure

 net/nfc/nci/ntf.c | 139 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 38 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index a818eff27e6b..c0edf8242e22 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -27,11 +27,16 @@
 
 /* Handle NCI Notification packets */
 
-static void nci_core_reset_ntf_packet(struct nci_dev *ndev,
-				      const struct sk_buff *skb)
+static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
+				     const struct sk_buff *skb)
 {
 	/* Handle NCI 2.x core reset notification */
-	const struct nci_core_reset_ntf *ntf = (void *)skb->data;
+	const struct nci_core_reset_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_core_reset_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_reset_ntf *)skb->data;
 
 	ndev->nci_ver = ntf->nci_ver;
 	pr_debug("nci_ver 0x%x, config_status 0x%x\n",
@@ -42,15 +47,22 @@ static void nci_core_reset_ntf_packet(struct nci_dev *ndev,
 		__le32_to_cpu(ntf->manufact_specific_info);
 
 	nci_req_complete(ndev, NCI_STATUS_OK);
+
+	return 0;
 }
 
-static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
-					     struct sk_buff *skb)
+static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
+					    struct sk_buff *skb)
 {
-	struct nci_core_conn_credit_ntf *ntf = (void *) skb->data;
+	struct nci_core_conn_credit_ntf *ntf;
 	struct nci_conn_info *conn_info;
 	int i;
 
+	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_conn_credit_ntf *)skb->data;
+
 	pr_debug("num_entries %d\n", ntf->num_entries);
 
 	if (ntf->num_entries > NCI_MAX_NUM_CONN)
@@ -68,7 +80,7 @@ static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 		conn_info = nci_get_conn_info_by_conn_id(ndev,
 							 ntf->conn_entries[i].conn_id);
 		if (!conn_info)
-			return;
+			return 0;
 
 		atomic_add(ntf->conn_entries[i].credits,
 			   &conn_info->credits_cnt);
@@ -77,12 +89,19 @@ static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 	/* trigger the next tx */
 	if (!skb_queue_empty(&ndev->tx_q))
 		queue_work(ndev->tx_wq, &ndev->tx_work);
+
+	return 0;
 }
 
-static void nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
-					      const struct sk_buff *skb)
+static int nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
+					     const struct sk_buff *skb)
 {
-	__u8 status = skb->data[0];
+	__u8 status;
+
+	if (skb->len < 1)
+		return -EINVAL;
+
+	status = skb->data[0];
 
 	pr_debug("status 0x%x\n", status);
 
@@ -91,12 +110,19 @@ static void nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
 		   (the state remains the same) */
 		nci_req_complete(ndev, status);
 	}
+
+	return 0;
 }
 
-static void nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
-						struct sk_buff *skb)
+static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
+					       struct sk_buff *skb)
 {
-	struct nci_core_intf_error_ntf *ntf = (void *) skb->data;
+	struct nci_core_intf_error_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_core_intf_error_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_intf_error_ntf *)skb->data;
 
 	ntf->conn_id = nci_conn_id(&ntf->conn_id);
 
@@ -105,6 +131,8 @@ static void nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
 	/* complete the data exchange transaction, if exists */
 	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
 		nci_data_exchange_complete(ndev, NULL, ntf->conn_id, -EIO);
+
+	return 0;
 }
 
 static const __u8 *
@@ -329,13 +357,18 @@ void nci_clear_target_list(struct nci_dev *ndev)
 	ndev->n_targets = 0;
 }
 
-static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
-				       const struct sk_buff *skb)
+static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
+				      const struct sk_buff *skb)
 {
 	struct nci_rf_discover_ntf ntf;
-	const __u8 *data = skb->data;
+	const __u8 *data;
 	bool add_target = true;
 
+	if (skb->len < sizeof(struct nci_rf_discover_ntf))
+		return -EINVAL;
+
+	data = skb->data;
+
 	ntf.rf_discovery_id = *data++;
 	ntf.rf_protocol = *data++;
 	ntf.rf_tech_and_mode = *data++;
@@ -390,6 +423,8 @@ static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 		nfc_targets_found(ndev->nfc_dev, ndev->targets,
 				  ndev->n_targets);
 	}
+
+	return 0;
 }
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
@@ -501,7 +536,7 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
 		ndev->remote_gb_len = min_t(__u8,
-			(ntf->activation_params.poll_nfc_dep.atr_res_len
+					    (ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
 			NFC_ATR_RES_GB_MAXSIZE);
 		memcpy(ndev->remote_gb,
@@ -513,7 +548,7 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 		ndev->remote_gb_len = min_t(__u8,
-			(ntf->activation_params.listen_nfc_dep.atr_req_len
+					    (ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
 			NFC_ATR_REQ_GB_MAXSIZE);
 		memcpy(ndev->remote_gb,
@@ -553,14 +588,19 @@ static int nci_store_ats_nfc_iso_dep(struct nci_dev *ndev,
 	return NCI_STATUS_OK;
 }
 
-static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
-					     const struct sk_buff *skb)
+static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
+					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
 	struct nci_rf_intf_activated_ntf ntf;
-	const __u8 *data = skb->data;
+	const __u8 *data;
 	int err = NCI_STATUS_OK;
 
+	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+		return -EINVAL;
+
+	data = skb->data;
+
 	ntf.rf_discovery_id = *data++;
 	ntf.rf_interface = *data++;
 	ntf.rf_protocol = *data++;
@@ -667,7 +707,7 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 	if (err == NCI_STATUS_OK) {
 		conn_info = ndev->rf_conn_info;
 		if (!conn_info)
-			return;
+			return 0;
 
 		conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
 		conn_info->initial_num_credits = ntf.initial_num_credits;
@@ -721,19 +761,26 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 				pr_err("error when signaling tm activation\n");
 		}
 	}
+
+	return 0;
 }
 
-static void nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
-					 const struct sk_buff *skb)
+static int nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
+					const struct sk_buff *skb)
 {
 	const struct nci_conn_info *conn_info;
-	const struct nci_rf_deactivate_ntf *ntf = (void *)skb->data;
+	const struct nci_rf_deactivate_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_rf_deactivate_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_rf_deactivate_ntf *)skb->data;
 
 	pr_debug("entry, type 0x%x, reason 0x%x\n", ntf->type, ntf->reason);
 
 	conn_info = ndev->rf_conn_info;
 	if (!conn_info)
-		return;
+		return 0;
 
 	/* drop tx data queue */
 	skb_queue_purge(&ndev->tx_q);
@@ -765,14 +812,20 @@ static void nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
 	}
 
 	nci_req_complete(ndev, NCI_STATUS_OK);
+
+	return 0;
 }
 
-static void nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
-					  const struct sk_buff *skb)
+static int nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
+					 const struct sk_buff *skb)
 {
 	u8 status = NCI_STATUS_OK;
-	const struct nci_nfcee_discover_ntf *nfcee_ntf =
-				(struct nci_nfcee_discover_ntf *)skb->data;
+	const struct nci_nfcee_discover_ntf *nfcee_ntf;
+
+	if (skb->len < sizeof(struct nci_nfcee_discover_ntf))
+		return -EINVAL;
+
+	nfcee_ntf = (struct nci_nfcee_discover_ntf *)skb->data;
 
 	/* NFCForum NCI 9.2.1 HCI Network Specific Handling
 	 * If the NFCC supports the HCI Network, it SHALL return one,
@@ -783,6 +836,8 @@ static void nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
 	ndev->cur_params.id = nfcee_ntf->nfcee_id;
 
 	nci_req_complete(ndev, status);
+
+	return 0;
 }
 
 void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
@@ -809,35 +864,43 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 
 	switch (ntf_opcode) {
 	case NCI_OP_CORE_RESET_NTF:
-		nci_core_reset_ntf_packet(ndev, skb);
+		if (nci_core_reset_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_CONN_CREDITS_NTF:
-		nci_core_conn_credits_ntf_packet(ndev, skb);
+		if (nci_core_conn_credits_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_GENERIC_ERROR_NTF:
-		nci_core_generic_error_ntf_packet(ndev, skb);
+		if (nci_core_generic_error_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_INTF_ERROR_NTF:
-		nci_core_conn_intf_error_ntf_packet(ndev, skb);
+		if (nci_core_conn_intf_error_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_DISCOVER_NTF:
-		nci_rf_discover_ntf_packet(ndev, skb);
+		if (nci_rf_discover_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_INTF_ACTIVATED_NTF:
-		nci_rf_intf_activated_ntf_packet(ndev, skb);
+		if (nci_rf_intf_activated_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_DEACTIVATE_NTF:
-		nci_rf_deactivate_ntf_packet(ndev, skb);
+		if (nci_rf_deactivate_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_NFCEE_DISCOVER_NTF:
-		nci_nfcee_discover_ntf_packet(ndev, skb);
+		if (nci_nfcee_discover_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_NFCEE_ACTION_NTF:
-- 
2.51.0


