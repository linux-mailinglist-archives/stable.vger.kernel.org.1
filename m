Return-Path: <stable+bounces-194034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D8C4AD78
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEBBE4FC015
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9252DC35A;
	Tue, 11 Nov 2025 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnaQxzqr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38015189B84;
	Tue, 11 Nov 2025 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824649; cv=none; b=jSbzgjBJxgq/xbUWQdOnyw1f/79fhWa4txRip2uGSeOkuf/IDWdUKhKB7vRScRIjL8M5xBn9TDPGUoirUmofNptIlYQ4t/ugAGMl0QISzKzyPGuTLjmZpO6FHWCz/qrYWFD2rVMcmKOm3WrI47mVn4f2pRie8Rk48wNlu8MXTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824649; c=relaxed/simple;
	bh=oVdHYDGfhZfButhH0Z6a/0MtVXZgHWrb7BmurdeL6VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIntFwTvRn/BoXjb3DuKXUhJnlPb4rZTVywOxEPpXkpYq4atOsCEEkqudlWucIJrH5hOTtpr4aCv8jQvnGaWxPH1u+aoKmEKZyml0Q+Qh36QsQ22KUdAfvuYPj5U/vbfr/Qachu6ZhYoKcN1PcFLFFjET1IgAl905xUwDMdo7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnaQxzqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA66C19421;
	Tue, 11 Nov 2025 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824647;
	bh=oVdHYDGfhZfButhH0Z6a/0MtVXZgHWrb7BmurdeL6VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnaQxzqrPFXnlnwP83YwSuOU88IJcsEV13Oh9sCUHQCoqSnsBDiEBRJRKdSU8b1Uv
	 8V0m0dE3DKxCLJun7dfpHYMgI9zNJabO2Ex/jxRSgykixeQDNrAVe8/aQntYFCAc6S
	 9A0jdLUCzB8/JbeLv/KXjgnzE4iRnyxRuu1BQ/sg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Keeping <jkeeping@inmusicbrands.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 543/849] ALSA: serial-generic: remove shared static buffer
Date: Tue, 11 Nov 2025 09:41:53 +0900
Message-ID: <20251111004549.538852134@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <jkeeping@inmusicbrands.com>

[ Upstream commit 84973249011fda3ff292f83439a062fec81ef982 ]

If multiple instances of this driver are instantiated and try to send
concurrently then the single static buffer snd_serial_generic_tx_work()
will cause corruption in the data output.

Move the buffer into the per-instance driver data to avoid this.

Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/serial-generic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/serial-generic.c b/sound/drivers/serial-generic.c
index 21ae053c05767..766206c6ca75a 100644
--- a/sound/drivers/serial-generic.c
+++ b/sound/drivers/serial-generic.c
@@ -37,6 +37,8 @@ MODULE_LICENSE("GPL");
 #define SERIAL_TX_STATE_ACTIVE	1
 #define SERIAL_TX_STATE_WAKEUP	2
 
+#define INTERNAL_BUF_SIZE 256
+
 struct snd_serial_generic {
 	struct serdev_device *serdev;
 
@@ -51,6 +53,7 @@ struct snd_serial_generic {
 	struct work_struct tx_work;
 	unsigned long tx_state;
 
+	char tx_buf[INTERNAL_BUF_SIZE];
 };
 
 static void snd_serial_generic_tx_wakeup(struct snd_serial_generic *drvdata)
@@ -61,11 +64,8 @@ static void snd_serial_generic_tx_wakeup(struct snd_serial_generic *drvdata)
 	schedule_work(&drvdata->tx_work);
 }
 
-#define INTERNAL_BUF_SIZE 256
-
 static void snd_serial_generic_tx_work(struct work_struct *work)
 {
-	static char buf[INTERNAL_BUF_SIZE];
 	int num_bytes;
 	struct snd_serial_generic *drvdata = container_of(work, struct snd_serial_generic,
 						   tx_work);
@@ -78,8 +78,10 @@ static void snd_serial_generic_tx_work(struct work_struct *work)
 		if (!test_bit(SERIAL_MODE_OUTPUT_OPEN, &drvdata->filemode))
 			break;
 
-		num_bytes = snd_rawmidi_transmit_peek(substream, buf, INTERNAL_BUF_SIZE);
-		num_bytes = serdev_device_write_buf(drvdata->serdev, buf, num_bytes);
+		num_bytes = snd_rawmidi_transmit_peek(substream, drvdata->tx_buf,
+						      INTERNAL_BUF_SIZE);
+		num_bytes = serdev_device_write_buf(drvdata->serdev, drvdata->tx_buf,
+						    num_bytes);
 
 		if (!num_bytes)
 			break;
-- 
2.51.0




