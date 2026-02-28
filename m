Return-Path: <stable+bounces-220395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JPoMk41o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF961C5FD9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD7FF30764A5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51D3AB430;
	Sat, 28 Feb 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqu2AXX2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424753AB423;
	Sat, 28 Feb 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300288; cv=none; b=en9vsjQ7b9koMPXVkSzdrSqRZFi2rF5VhuwGsNPTM5yFq4k1FLftL6BRSNlKU4Tv9DSRCYz56hAHzhOhBk2McFQhjf9ZSnJ9yL83RdEEyb6IijQIWNvlJuvIALV9FuXW8IbvuxpUMUIlHs8Ot61xG1g3F1zqFpM78dAaVlOGHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300288; c=relaxed/simple;
	bh=5JgT2L3Zry9ZaKOHywsRUBM87mU0XvTZ6LuSRBXw7Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZojLLZn1Ls1CB7/QeYotiu+RWqTb8JSJYhkYhvKmM1RJGVtU5ylkhPnuoidRhRj68NnwJJ886cbY6eNk+1nPmJAqo7nnmBAIElknvkO0McygGfAnvwrMIF1NR8hXCS5VnPa0WQ+aF+JCJ2XpHzBVkJ75m49pzBXsfiOjm7QwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqu2AXX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343B1C19424;
	Sat, 28 Feb 2026 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300287;
	bh=5JgT2L3Zry9ZaKOHywsRUBM87mU0XvTZ6LuSRBXw7Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqu2AXX2z1/9vgGerB7yc+mWCvxVae20TEpzy26NiR1XLcZguGbxiVkRanZCU8tVA
	 0GJA4uwu4BwfnzjeYwvQrmwd2tEjWE8JUjwrakCJvAwFHZ6aJKxgxSWpJ8v6TGkLkF
	 OGGAgJCZRNrCvSj4gdAWoxUfJZdEh4K+JEMI8wGEEiqGvbnfXWXUPB6Y0eOh1IOsR/
	 UC3mne5VyY08BpcIuCgCo6F3Asse2twNplmZwjG7AfTF5rg5QbpN1wEplIUXBNNRTL
	 TXXhqxl0t1cUCNrDQc9Oh9No4cYFr3Ve6Vi/wZAnKB52QJy4dCBuqLvUmIDDrW5HmD
	 sdTcVVrIHi3+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 316/844] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
Date: Sat, 28 Feb 2026 12:23:49 -0500
Message-ID: <20260228173244.1509663-317-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220395-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6EF961C5FD9
X-Rspamd-Action: no action

From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

[ Upstream commit fce1a9244a0f85683be8530e623bc729f24c5067 ]

On QCS9075 and QCA8275 platforms, the BT_EN pin is always pulled up by hw
and cannot be controlled by the host. As a result, in case of a firmware
crash, the host cannot trigger a cold reset. Instead, the BT controller
performs a warm restart on its own, without reloading the firmware.

This leads to the controller remaining in IBS_WAKE state, while the host
expects it to be in sleep mode. The mismatch causes HCI reset commands
to time out. Additionally, the driver does not clear internal flags
QCA_SSR_TRIGGERED and QCA_IBS_DISABLED, which blocks the reset sequence.
If the SSR duration exceeds 2 seconds, the host may enter TX sleep mode
due to tx_idle_timeout, further preventing recovery. Also, memcoredump_flag
is not cleared, so only the first SSR generates a coredump.

Tell the driver that the BT controller has undergone a proper restart sequence:

- Clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED flags after SSR.
- Add a 50ms delay to allow the controller to complete its warm reset.
- Reset tx_idle_timer to prevent the host from entering TX sleep mode.
- Clear memcoredump_flag to allow multiple coredump captures.

Apply these steps only when HCI_QUIRK_NON_PERSISTENT_SETUP is not set,
which indicates that BT_EN is defined in DTS and cannot be toggled.

Refer to the comment in include/net/bluetooth/hci.h for details on
HCI_QUIRK_NON_PERSISTENT_SETUP.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 888176b0faa90..a3c217571c3c4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1653,6 +1653,39 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 		skb_queue_purge(&qca->rx_memdump_q);
 	}
 
+	/*
+	 * If the BT chip's bt_en pin is connected to a 3.3V power supply via
+	 * hardware and always stays high, driver cannot control the bt_en pin.
+	 * As a result, during SSR (SubSystem Restart), QCA_SSR_TRIGGERED and
+	 * QCA_IBS_DISABLED flags cannot be cleared, which leads to a reset
+	 * command timeout.
+	 * Add an msleep delay to ensure controller completes the SSR process.
+	 *
+	 * Host will not download the firmware after SSR, controller to remain
+	 * in the IBS_WAKE state, and the host needs to synchronize with it
+	 *
+	 * Since the bluetooth chip has been reset, clear the memdump state.
+	 */
+	if (!hci_test_quirk(hu->hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
+		/*
+		 * When the SSR (SubSystem Restart) duration exceeds 2 seconds,
+		 * it triggers host tx_idle_delay, which sets host TX state
+		 * to sleep. Reset tx_idle_timer after SSR to prevent
+		 * host enter TX IBS_Sleep mode.
+		 */
+		mod_timer(&qca->tx_idle_timer, jiffies +
+				  msecs_to_jiffies(qca->tx_idle_delay));
+
+		/* Controller reset completion time is 50ms */
+		msleep(50);
+
+		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
+		clear_bit(QCA_IBS_DISABLED, &qca->flags);
+
+		qca->tx_ibs_state = HCI_IBS_TX_AWAKE;
+		qca->memdump_state = QCA_MEMDUMP_IDLE;
+	}
+
 	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
 }
 
-- 
2.51.0


