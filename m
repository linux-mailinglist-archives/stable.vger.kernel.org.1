Return-Path: <stable+bounces-256746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOIkMnHqGWqFzwgAu9opvQ
	(envelope-from <stable+bounces-256746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:35:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09165607EBB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5DD330221DA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C2370D62;
	Fri, 29 May 2026 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTylsACP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD03A8737
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083189; cv=none; b=Pc0sdlg6llIkwQb/zPxX/+wpT0KMW4hOQaTwlPh5s9p2bZ+Gwrnogupf4AAZ/h9nvwOle4zBV2nLrRZ53I91Sh60wk78DiglMz6+8nn5sWGGXmsj4hxlTqrNLwxK6WobrdPIkn0L28BWy7z/8AAl7FSTc8j/o3NFpHlqUWmk1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083189; c=relaxed/simple;
	bh=OWMyZbPYO6/RmP7MuFlo9zSTYENwke3aoWBhf1ZYXZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3xDOElT4ETdyb0C2hGaoCXmLP/GUr6qOvRM9aUsttyJyEFca1XvtlLwsGODPVMOWILqgc7XaOLZ3jH2E8+7X6x1Y9jIqL5rpJUTgom2diXvJ1NwmE/p1vhkRPY+itwxHintNBqCisst0/UCGxHz4uo8pEztwo3Vk9BJc2+03Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTylsACP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3351E1F00899;
	Fri, 29 May 2026 19:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780083187;
	bh=yeo1GtOlXgzHJPlKKIjpfzmSygtWbSPpXt/hDfOhMxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WTylsACPZADGZPH0iNsxdMoDt/Hzwin+F1tEA+8+eyGIPW9XkBndTBL1KhG3kQp3m
	 n04uDMvQoteg1TNBY2Q5YNwmsOuiRldOaNVlS65pYTxwxlUzl7SBLlDqcUVNL07kXc
	 r7G7pjG09A6eVvPR0Bu7qpZPtdRMXRAWtUIX64x8yTHDs1zuMAcZCoybOmtLQMeaiG
	 E0whDS/mhwypr52DEJDbN7f/PVMUyc9HiN5Wv89iukqQsUGeFnVKQvSVqIevt+rO4B
	 y/lI2gWA/5dLIs7WYbuAp8F22zHbe9gnIxdUV3lVqapwa2LLR2hrxg+n5I6sUt/RoN
	 lCFj6IDFlW4Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
Date: Fri, 29 May 2026 15:33:03 -0400
Message-ID: <20260529193303.1704693-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529193303.1704693-1-sashal@kernel.org>
References: <2026052800-unloving-guileless-afb9@gregkh>
 <20260529193303.1704693-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256746-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mpg.de:email,linaro.org:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 09165607EBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

[ Upstream commit 375ba7484132662a4a8c7547d088fb6275c00282 ]

Since the timer uses jiffies as its unit rather than ms, the timeout value
must be converted from ms to jiffies when configuring the timer. Otherwise,
the intended 8s timeout is incorrectly set to approximately 33s.

To improve readability, embed msecs_to_jiffies() directly in the macro
definitions and drop the _MS suffix from macros that now yield jiffies
values: MEMDUMP_TIMEOUT, FW_DOWNLOAD_TIMEOUT, IBS_DISABLE_SSR_TIMEOUT,
CMD_TRANS_TIMEOUT, and IBS_BTSOC_TX_IDLE_TIMEOUT.

IBS_WAKE_RETRANS_TIMEOUT_MS and IBS_HOST_TX_IDLE_TIMEOUT_MS are
intentionally left unchanged. Their values are stored in the struct fields
wake_retrans and tx_idle_delay, which hold ms values at runtime and can be
modified via debugfs. The msecs_to_jiffies() conversion happens at each
call site against the field value, so it cannot be embedded in the macro.

Wake timer depends on commit c347ca17d62a

Cc: stable@vger.kernel.org
Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 589069fd85de6..ac737ee143614 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -46,13 +46,12 @@
 #define HCI_MAX_IBS_SIZE	10
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
-#define IBS_BTSOC_TX_IDLE_TIMEOUT_MS	200
+#define IBS_BTSOC_TX_IDLE_TIMEOUT	msecs_to_jiffies(200)
 #define IBS_HOST_TX_IDLE_TIMEOUT_MS	2000
-#define CMD_TRANS_TIMEOUT_MS		100
-#define MEMDUMP_TIMEOUT_MS		8000
-#define IBS_DISABLE_SSR_TIMEOUT_MS \
-	(MEMDUMP_TIMEOUT_MS + FW_DOWNLOAD_TIMEOUT_MS)
-#define FW_DOWNLOAD_TIMEOUT_MS		3000
+#define CMD_TRANS_TIMEOUT		msecs_to_jiffies(100)
+#define MEMDUMP_TIMEOUT			msecs_to_jiffies(8000)
+#define FW_DOWNLOAD_TIMEOUT		msecs_to_jiffies(3000)
+#define IBS_DISABLE_SSR_TIMEOUT		(MEMDUMP_TIMEOUT + FW_DOWNLOAD_TIMEOUT)
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -1077,7 +1076,7 @@ static void qca_controller_memdump(struct work_struct *work)
 
 			queue_delayed_work(qca->workqueue,
 					   &qca->ctrl_memdump_timeout,
-					   msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
+					   MEMDUMP_TIMEOUT);
 			skb_pull(skb, sizeof(qca_memdump->ram_dump_size));
 			qca_memdump->current_seq_no = 0;
 			qca_memdump->received_dump = 0;
@@ -1349,7 +1348,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	if (hu->serdev)
 		serdev_device_wait_until_sent(hu->serdev,
-		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+		      CMD_TRANS_TIMEOUT);
 
 	/* Give the controller time to process the request */
 	switch (qca_soc_type(hu)) {
@@ -1380,8 +1379,8 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 
 static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 {
+	int timeout = CMD_TRANS_TIMEOUT;
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
 	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
 
 	/* These power pulses are single byte command which are sent
@@ -1583,7 +1582,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT);
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
@@ -2428,7 +2427,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 static void qca_serdev_shutdown(struct serdev_device *serdev)
 {
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
+	int timeout = CMD_TRANS_TIMEOUT;
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
@@ -2485,7 +2484,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	bool tx_pending = false;
 	int ret = 0;
 	u8 cmd;
-	u32 wait_timeout = 0;
+	unsigned long wait_timeout = 0;
 
 	set_bit(QCA_SUSPENDING, &qca->flags);
 
@@ -2506,15 +2505,15 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	if (test_bit(QCA_IBS_DISABLED, &qca->flags) ||
 	    test_bit(QCA_SSR_TRIGGERED, &qca->flags)) {
 		wait_timeout = test_bit(QCA_SSR_TRIGGERED, &qca->flags) ?
-					IBS_DISABLE_SSR_TIMEOUT_MS :
-					FW_DOWNLOAD_TIMEOUT_MS;
+					IBS_DISABLE_SSR_TIMEOUT :
+					FW_DOWNLOAD_TIMEOUT;
 
 		/* QCA_IBS_DISABLED flag is set to true, During FW download
 		 * and during memory dump collection. It is reset to false,
 		 * After FW download complete.
 		 */
 		wait_on_bit_timeout(&qca->flags, QCA_IBS_DISABLED,
-			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(wait_timeout));
+			    TASK_UNINTERRUPTIBLE, wait_timeout);
 
 		if (test_bit(QCA_IBS_DISABLED, &qca->flags)) {
 			bt_dev_err(hu->hdev, "SSR or FW download time out");
@@ -2566,7 +2565,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 	if (tx_pending) {
 		serdev_device_wait_until_sent(hu->serdev,
-					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+					      CMD_TRANS_TIMEOUT);
 		serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
 	}
 
@@ -2575,7 +2574,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	 */
 	ret = wait_event_interruptible_timeout(qca->suspend_wait_q,
 			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
-			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
+			IBS_BTSOC_TX_IDLE_TIMEOUT);
 	if (ret == 0) {
 		ret = -ETIMEDOUT;
 		goto error;
-- 
2.53.0


