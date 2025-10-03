Return-Path: <stable+bounces-183334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F847BB8271
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 22:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6943B3E80
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999562571BC;
	Fri,  3 Oct 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2IDlRFM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59946253951
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524942; cv=none; b=kw4gvoOF/QQRyU7ise8tjykxn19WJa5EeRSm5miR6HwuyWoxU5rl1K7iZyLyUVGwRF4ntjtKx3I2naH06PR9Vars5XgVggT0I3wLceOnexnxrk5bm1AsjUscjdqa2OxA+57H5cHtCFRTsjlTL2yFaE9FXIXcufF30pnUURHkYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524942; c=relaxed/simple;
	bh=8g7mxgsUuK3O9nYg4JNAs8DAxG0RlGceDmCtgxcrFNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEi+J5KbZsPQzVrHGKg9khsuKKGWRNrfJPdlvOOpUmfDZKWSYHO4OwP0REXn3s/jIhamVGCf7CSm4O8Xjr11VV3VDv5/prP8L9pbgubRfTeK7v8bm++f89VK6Sh2RWl9WB75ppVrGSgUZ9aKTTXOwqQprruG6eNw5uH49W1shvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2IDlRFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691B6C4CEFB;
	Fri,  3 Oct 2025 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524942;
	bh=8g7mxgsUuK3O9nYg4JNAs8DAxG0RlGceDmCtgxcrFNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2IDlRFMkqAkRSCRkRI6KGq/1byBV15Rs96wbat44hjnXXBQR3qjeUYtRTYdIXVYN
	 LdwH4y/NGEFJZ4ZP4GnFTeHe5eaMkU/EF7jwr0d5D54PF4Wi3LljF739SKLydBSv1e
	 NqhUP8wYweK1BfYYgXYSsztijd2Iy3Np3ClOVzKdgBooGCfd8iUlEDsfyuYskQ2Eyh
	 JJ9GOeRx8iEUgqcZwGt8r6MTJcoiU2LOv3rB9f5P/5saSd+WnWCypLEREiCchJm2kQ
	 qbS7WSrZz15AdxgRP3xYdlkxPnoBcivW2m60lFc23cks1gzHr9hztrNrzM26GS2ccN
	 ufBD21ZkgQsjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 3/4] media: imon: grab lock earlier in imon_ir_change_protocol()
Date: Fri,  3 Oct 2025 16:55:36 -0400
Message-ID: <20251003205537.3386848-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003205537.3386848-1-sashal@kernel.org>
References: <2025100320-pout-unwired-1096@gregkh>
 <20251003205537.3386848-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 7019553ab850ce1d3f0e512e16d14ab153f91c04 ]

Move mutex_trylock() in imon_ir_change_protocol() to the beginning,
for memcpy() which modifies ictx->usb_tx_buf should be protected by
ictx->lock.

Also, verify at the beginning of send_packet() that ictx->lock is held
in case send_packet() is by error called from imon_ir_change_protocol()
when mutex_trylock() failed due to concurrent requests.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: fa0f61cc1d82 ("media: rc: fix races with imon_disconnect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/imon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index b1a759e174841..02949597aaa64 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
 	int retval = 0;
 	struct usb_ctrlrequest *control_req = NULL;
 
+	lockdep_assert_held(&ictx->lock);
+
 	/* Check if we need to use control or interrupt urb */
 	if (!ictx->tx_control) {
 		pipe = usb_sndintpipe(ictx->usbdev_intf0,
@@ -1126,7 +1128,7 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 	int retval;
 	struct imon_context *ictx = rc->priv;
 	struct device *dev = ictx->dev;
-	bool unlock = false;
+	const bool unlock = mutex_trylock(&ictx->lock);
 	unsigned char ir_proto_packet[] = {
 		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x86 };
 
@@ -1153,8 +1155,6 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 
 	memcpy(ictx->usb_tx_buf, &ir_proto_packet, sizeof(ir_proto_packet));
 
-	unlock = mutex_trylock(&ictx->lock);
-
 	retval = send_packet(ictx);
 	if (retval)
 		goto out;
-- 
2.51.0


