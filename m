Return-Path: <stable+bounces-256793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/GI8cJGmo70wgAu9opvQ
	(envelope-from <stable+bounces-256793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:48:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B46609045
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED2D3012270
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6237B41F;
	Fri, 29 May 2026 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYcU2T2M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56D3644C5
	for <stable@vger.kernel.org>; Fri, 29 May 2026 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091329; cv=none; b=ftsdxqsCOfz1D3Yad0EnXIlCqUlCUZoySLXEvgYAl/HEYY8y5Et25upO32Abc2Omsf1bTGepwiXoA1ugKv0HV2Z4FYZfUvpBdxFmwqjRMdIijmix7Fh/aYeyW5hH9h7shhWbkCfPQa1e5MEfGhh6b26KQ2JWQO1eBqgJNbPzWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091329; c=relaxed/simple;
	bh=3dHYA59Jx6ka2816XYC4D/s2gcX3ppCNTDr0R+bLnSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUnUKzutBtDQ7LN2j6J+tA4jsHx6C3auomlNYT6yoHhDbTsj6RlzT8u4A//c2ovoVnhRfv303UcrsnXEpaAC8dNOTCaHcyKpEDDEwlTzplbn62WLNoLHBzO24iqm/AE7P/eggpFCoi4fmqmeIQHwZmOrRghoVD3rlKPDgPbX3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYcU2T2M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86BE1F00898;
	Fri, 29 May 2026 21:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780091327;
	bh=WPQpCcsP+7miRc6MrJ/mdz/jZruQN2QF3V8kX5+bWUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EYcU2T2MZsNbMmCEXSyZPchBVWvMjcRFFp+ruIpTNDAJLucqgty8cc7adkNfm3IXQ
	 E+516L/6Yhsc3Xtk43686jBwBw8yZRvapIFAhcz7SP2cBQwPGJR9hkuO3DG9xhZG36
	 6HIa4DcFHQkM8CHGbN8PI5cLK+fwMYZPCCyrBZfDxM0BZXNHqJQl7+/emQtmFPyqeg
	 rj6GYJiRkZ5uPMVInuKTzcvMDJTKxbDsz9FrOE0B7yIGoZ5Ys0kPbUEclM2Qz0LkB3
	 t+Ek8qn3cPhGDCjr3wh1pVrpMM1MGWK4FUluJAER7WbpmlFdJMDwS6PhMzHoy1Mp9E
	 chxDXkI7PVfiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Bluetooth: hci_qca: Convert timeout from jiffies to ms
Date: Fri, 29 May 2026 17:48:45 -0400
Message-ID: <20260529214845.1804717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052801-scouting-tweet-fbed@gregkh>
References: <2026052801-scouting-tweet-fbed@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256793-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mpg.de:email,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00B46609045
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
[ adapted to `vmalloc`-based memdump path and older `qca_serdev_shutdown(struct device *dev)` signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c0de1b22e7539..d6bf5058a4309 100644
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
@@ -1058,7 +1057,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				    dump_size);
 			queue_delayed_work(qca->workqueue,
 					   &qca->ctrl_memdump_timeout,
-					   msecs_to_jiffies(MEMDUMP_TIMEOUT_MS)
+					   MEMDUMP_TIMEOUT
 					  );
 
 			skb_pull(skb, sizeof(dump_size));
@@ -1326,7 +1325,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	if (hu->serdev)
 		serdev_device_wait_until_sent(hu->serdev,
-		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+		      CMD_TRANS_TIMEOUT);
 
 	/* Give the controller time to process the request */
 	switch (qca_soc_type(hu)) {
@@ -1356,8 +1355,8 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 
 static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 {
+	int timeout = CMD_TRANS_TIMEOUT;
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
 	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
 
 	/* These power pulses are single byte command which are sent
@@ -1556,7 +1555,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT);
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
@@ -2345,7 +2344,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 static void qca_serdev_shutdown(struct device *dev)
 {
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
+	int timeout = CMD_TRANS_TIMEOUT;
 	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
@@ -2403,7 +2402,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	bool tx_pending = false;
 	int ret = 0;
 	u8 cmd;
-	u32 wait_timeout = 0;
+	unsigned long wait_timeout = 0;
 
 	set_bit(QCA_SUSPENDING, &qca->flags);
 
@@ -2424,15 +2423,15 @@ static int __maybe_unused qca_suspend(struct device *dev)
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
@@ -2484,7 +2483,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 	if (tx_pending) {
 		serdev_device_wait_until_sent(hu->serdev,
-					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+					      CMD_TRANS_TIMEOUT);
 		serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
 	}
 
@@ -2493,7 +2492,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
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


