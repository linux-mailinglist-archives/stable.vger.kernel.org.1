Return-Path: <stable+bounces-231183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMxeHbVpymnG8gUAu9opvQ
	(envelope-from <stable+bounces-231183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:16:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC7235AE6F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4687D306F0D1
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619221ADB7;
	Mon, 30 Mar 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5Jd5HnY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB53C0626
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872491; cv=none; b=WiYwACJQECfj8Nb071KYVP3awNNEL7KZKPT6IVcMDKffqv8xGrSIJhyQO9ZtDs2YQmZtkAVhsBz274DVIV1CD/WweJwAA+OS8A5ytNuRxGmN4r5HsudjIETkvuzaY3Yw9oS8zyPfHZLNgfzIk+NKXja3tzCsmKTOJzyXt4/ov1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872491; c=relaxed/simple;
	bh=kA3KUCMXL+4yl9X1Iw63ADWR+ZGb9Aou2Vcw9Ocw3P4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mSZlDc+o0AJdZ91MyHiWJh2cUiwwCgfO1LFdAzLPZVBswBC4pQub3hRIwFH/tR1HPH/TU3222e6xQJ1gKC8wBKQUGlxNsEyNgX6ZtwjIbecckdtwlRBk5BJXllGnrR+1afWouD9V2tj0XZuar7fM0PEDceX7rg7J868V5PB2bGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5Jd5HnY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8296d553142so1939062b3a.3
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774872489; x=1775477289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t47FTzjGejS6l0c/OZj369t+FiYeAAlmEsRfVM5hMso=;
        b=B5Jd5HnYXvxY1iZejHjQLquKuLYQjDEtXNaTbqBfHhjdToopFvkVo3p7UQMJkMUNYH
         k7TGaLTLvuEtZHFw8M033cfqHWsbNmrKiqNtgyfvg22VpCrhuOltNE2gHG7dHTEnFQUD
         BdaqcRbhjNxZRY0OZpust04UUgqTVVAIUSm6gzoGJlC1BlvnlRxCys3EOM9JvtuYB37+
         /SiGSZ7wTxxdv6cwuCNSBVIbaWrLIrtjWhDE6K0kMUhnTk1YZskeS/U98rwxmJWcQbnO
         SfPa/X6m0ahuegjFc8hDU7n1gNUx49i3br7YDCQeIrcZh/9M4R1NaK+2HqNwn9x2dml8
         Hw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872489; x=1775477289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t47FTzjGejS6l0c/OZj369t+FiYeAAlmEsRfVM5hMso=;
        b=Z2ma9H5C/UxxYRZJYDnhak6O31t25/CnydD0Bg1Nu7Tc78gNGTcuYvRt+8i/N8u0eG
         RdyKNtiUwsTSl8Dk4/xUVY3fcnP36eVr+dm8m2InB3DuPD+TCFV683UGo3/LrLW7NS2i
         StxTGpyqWQq9hXyE9T1HLbsGmt+n4e3Qn4TGGwqBQsBdvfx4IQLYYzUHd28k5LR4jxqG
         mmwY1DUefxBuhW6l7biTVctP09EnPqQZswAcSlDrMc5QP1rqh8UQfg1ElpBCVKSZzbwQ
         i/ECfTB+c81OGNyZnQisnOJs17HNM7KQqWMJ/Kib2v7N1CwiviyvASWKSf949I+CBP0p
         nF/w==
X-Forwarded-Encrypted: i=1; AJvYcCXwjUkwaw8IBx5zyh51/1mun97fIO/Oo2JlCzSB91KhQQRC13UbVrTPf0btdcwybpiVO4wMpmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCizAxkomzTMbOJUhS8HHmGBFzI2IsXd3ra1f39cU+CldGurff
	Ej3SsX9u8Y97J5ju6RY85uZMb42GmwO0Q94LSaqEcg+Y02SsLYjbvYTG
X-Gm-Gg: ATEYQzwdzw2Nyj5cKd35F9OpMV8BwyZPQQJJ2shPhYVFfrE11C+VMD2JO4yeV59TeTq
	oacg5WeSe74QQoLaUOd0387ni3pjYw4wbOEarQC8u3DoO4O3awhvlAuA1Y8KqKM5XBFqKfyeqDX
	ltghNS970TAYowhsgDity3dY/yKeiBxW+ClfmXM3M/BQsxMByBrdPVD2kmx1gebHSYn6Hv26YTJ
	ggTp38bMsnqHeF1Wq3K3Me5BALn4xBxithYZ6kTUvxXKc3EzB17nGbY42S9jeKAHGdZ8+G1FNff
	7dJ0SBO249FJtmsQRRRLw9K/m2V1iyM891U/w9oLdOMezZyz2AELXbRTCyq+o5jYFIbzD06yS7+
	Bm/Mc6q2RVI0nfwpAqmdgRyhloxhMzT9dtxmTMHuJjdC/Sf/WzcP3Yrih9/rc7p6d3QigRevSBN
	tFXKvhSHPWwIDgP9Hcd1MMJRhjrTcjtb1ewpO70ZmLM6J9PcDVcSJTJ3+Ka7nJj/J+XkR8RVqdW
	9GAevAMzK6fXeB/HDypO0VpAieCLJwqpVPZLNMNNohAPqsqbIqwcWhsxQZS
X-Received: by 2002:a05:6a00:1789:b0:82a:6de8:fa50 with SMTP id d2e1a72fcca58-82c95e45d30mr12770235b3a.18.1774872489085;
        Mon, 30 Mar 2026 05:08:09 -0700 (PDT)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-3-106-126-184.ap-southeast-2.compute.amazonaws.com. [3.106.126.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca860b125sm7137780b3a.50.2026.03.30.05.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:08:08 -0700 (PDT)
From: Weigang He <geoffreyhe2@gmail.com>
To: greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org,
	Ayush Singh <ayushdevel1325@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] greybus: gb-beagleplay: fix sleep in atomic context in hdlc_tx_frames()
Date: Mon, 30 Mar 2026 12:08:00 +0000
Message-Id: <20260330120801.981506-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-231183-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geoffreyhe2@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 1CC7235AE6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hdlc_append() calls usleep_range() to wait for circular buffer space,
but it is called with tx_producer_lock (a spinlock) held via
hdlc_tx_frames() -> hdlc_append_tx_frame()/hdlc_append_tx_u8()/etc.
Sleeping while holding a spinlock is illegal and can trigger
"BUG: scheduling while atomic".

Fix this by moving the buffer-space wait out of hdlc_append() and into
hdlc_tx_frames(), before the spinlock is acquired.  The new flow:

 1. Pre-calculate the worst-case encoded frame length.
 2. Wait (with sleep) outside the lock until enough space is available,
    kicking the TX consumer work to drain the buffer.
 3. Acquire the spinlock, re-verify space, and write the entire frame
    atomically.

This ensures that sleeping only happens without any lock held, and
that frames are either fully enqueued or not written at all.

This bug is found by CodeQL static analysis tool (interprocedural
sleep-in-atomic query) and my code review.

Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
Cc: stable@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/greybus/gb-beagleplay.c | 105 +++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 16 deletions(-)

diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 87186f891a6ac..da1b9039fd2f3 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -242,30 +242,26 @@ static void hdlc_write(struct gb_beagleplay *bg)
 }
 
 /**
- * hdlc_append() - Queue HDLC data for sending.
+ * hdlc_append() - Queue a single HDLC byte for sending.
  * @bg: beagleplay greybus driver
  * @value: hdlc byte to transmit
  *
- * Assumes that producer lock as been acquired.
+ * Caller must hold tx_producer_lock and must have ensured sufficient
+ * space in the circular buffer before calling (see hdlc_tx_frames()).
  */
 static void hdlc_append(struct gb_beagleplay *bg, u8 value)
 {
-	int tail, head = bg->tx_circ_buf.head;
+	int head = bg->tx_circ_buf.head;
+	int tail = READ_ONCE(bg->tx_circ_buf.tail);
 
-	while (true) {
-		tail = READ_ONCE(bg->tx_circ_buf.tail);
-
-		if (CIRC_SPACE(head, tail, TX_CIRC_BUF_SIZE) >= 1) {
-			bg->tx_circ_buf.buf[head] = value;
+	lockdep_assert_held(&bg->tx_producer_lock);
+	if (WARN_ON_ONCE(CIRC_SPACE(head, tail, TX_CIRC_BUF_SIZE) < 1))
+		return;
 
-			/* Finish producing HDLC byte */
-			smp_store_release(&bg->tx_circ_buf.head,
-					  (head + 1) & (TX_CIRC_BUF_SIZE - 1));
-			return;
-		}
-		dev_warn(&bg->sd->dev, "Tx circ buf full");
-		usleep_range(3000, 5000);
-	}
+	bg->tx_circ_buf.buf[head] = value;
+	/* Ensure buffer write is visible before advancing head. */
+	smp_store_release(&bg->tx_circ_buf.head,
+			  (head + 1) & (TX_CIRC_BUF_SIZE - 1));
 }
 
 static void hdlc_append_escaped(struct gb_beagleplay *bg, u8 value)
@@ -313,13 +309,90 @@ static void hdlc_transmit(struct work_struct *work)
 	spin_unlock_bh(&bg->tx_consumer_lock);
 }
 
+/**
+ * hdlc_encoded_length() - Calculate worst-case encoded length of an HDLC frame.
+ * @payloads: array of payload buffers
+ * @count: number of payloads
+ *
+ * Returns the maximum number of bytes needed in the circular buffer.
+ */
+static size_t hdlc_encoded_length(const struct hdlc_payload payloads[],
+				  size_t count)
+{
+	size_t i, payload_len = 0;
+
+	for (i = 0; i < count; i++)
+		payload_len += payloads[i].len;
+
+	/*
+	 * Worst case: every data byte needs escaping (doubles in size).
+	 * data bytes = address(1) + control(1) + payload + crc(2)
+	 * framing    = opening flag(1) + closing flag(1)
+	 */
+	return 2 + (1 + 1 + payload_len + 2) * 2;
+}
+
+#define HDLC_TX_BUF_WAIT_RETRIES	500
+#define HDLC_TX_BUF_WAIT_US_MIN	3000
+#define HDLC_TX_BUF_WAIT_US_MAX	5000
+
+/**
+ * hdlc_tx_frames() - Encode and queue an HDLC frame for transmission.
+ * @bg: beagleplay greybus driver
+ * @address: HDLC address field
+ * @control: HDLC control field
+ * @payloads: array of payload buffers
+ * @count: number of payloads
+ *
+ * Sleeps outside the spinlock until enough circular-buffer space is
+ * available, then verifies space under the lock and writes the entire
+ * frame atomically.  Either a complete frame is enqueued or nothing is
+ * written, avoiding both sleeping in atomic context and partial frames.
+ */
 static void hdlc_tx_frames(struct gb_beagleplay *bg, u8 address, u8 control,
 			   const struct hdlc_payload payloads[], size_t count)
 {
+	size_t needed = hdlc_encoded_length(payloads, count);
+	int retries = HDLC_TX_BUF_WAIT_RETRIES;
 	size_t i;
+	int head, tail;
+
+	/* Wait outside the lock for sufficient buffer space. */
+	while (retries--) {
+		/* Pairs with smp_store_release() in hdlc_append(). */
+		head = smp_load_acquire(&bg->tx_circ_buf.head);
+		tail = READ_ONCE(bg->tx_circ_buf.tail);
+
+		if (CIRC_SPACE(head, tail, TX_CIRC_BUF_SIZE) >= needed)
+			break;
+
+		/* Kick the consumer and sleep — no lock held. */
+		schedule_work(&bg->tx_work);
+		usleep_range(HDLC_TX_BUF_WAIT_US_MIN, HDLC_TX_BUF_WAIT_US_MAX);
+	}
+
+	if (retries < 0) {
+		dev_warn_ratelimited(&bg->sd->dev,
+				     "Tx circ buf full, dropping frame\n");
+		return;
+	}
 
 	spin_lock(&bg->tx_producer_lock);
 
+	/*
+	 * Re-check under the lock.  Should not fail since
+	 * tx_producer_lock serialises all producers and the
+	 * consumer only frees space, but guard against it.
+	 */
+	head = bg->tx_circ_buf.head;
+	tail = READ_ONCE(bg->tx_circ_buf.tail);
+	if (unlikely(CIRC_SPACE(head, tail, TX_CIRC_BUF_SIZE) < needed)) {
+		spin_unlock(&bg->tx_producer_lock);
+		dev_warn_ratelimited(&bg->sd->dev,
+				     "Tx circ buf space lost, dropping frame\n");
+		return;
+	}
+
 	hdlc_append_tx_frame(bg);
 	hdlc_append_tx_u8(bg, address);
 	hdlc_append_tx_u8(bg, control);
-- 
2.34.1


