Return-Path: <stable+bounces-172533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8508B3263C
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2E2B03836
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562841C861A;
	Sat, 23 Aug 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX64GPWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159601E0E14
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755913522; cv=none; b=UV9mK3kNaZR4ebKFM1nqR6/nVMzuZhOBunr44gorFX7BTle1SIKo3aaEBRJeBRPkm8DXKOrA5s3rtxWAmv4o3/JfEeLCoqY38XntZpQgPC7Ex8aLLfXSMlpgoL2d1t/6CLAAL2pt3NKp2PjJsamWRR3X1Nr+yyvJZI/iSBaV+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755913522; c=relaxed/simple;
	bh=0zMu4nM/4VvX6uGoWUA7zEEDFO09Zbkb0qQ920m+wtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scJaVujVHUcsUFq+8CWnaAwUrB5t4IetPHN0eeWRVX+O/ftZBdTYoNX4yAfU77cR7nyaoxVldU1FHrPeY7+V2MSjAXR8PDRsNPVcv8msljA19HVS3qGkY9tY83nzMoVBpwkXJDRf8nSm5pVxK9cOQO48X11EpUauUdFMUpxukmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX64GPWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B5BC4CEED;
	Sat, 23 Aug 2025 01:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755913521;
	bh=0zMu4nM/4VvX6uGoWUA7zEEDFO09Zbkb0qQ920m+wtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CX64GPWBWTHAHgCEqJqUwXm5LIr/rV1AkxvxDBUhXo2xYRBytNdty1Be2Or9NLwV8
	 uqTcqW2THkHQXGb7TRaemilgmcRoqmWr5yCsQbmr84r4XFk3C+zDPvJ9+TB9iBAz+y
	 skyUqVRT/Xt6ZepjyGD57tzqZZ2nw0wcU8GFA1b+kzQrLzE+77iNItEVfdb0k9rlrT
	 h0j3i/u6ogcxZc1carRGwFzpzeoyxVf3WgYACYOpqeNK8KF3lfvcMnLHYn+1XIgtvx
	 Ij0lhZmquCTcOdRPs3jonHiaVGwnfWE/8ldqkAbEX0v1no8auNENjEBhLxgkUKpILB
	 /zzUXkQ55yk5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gui-Dong Han <hanguidong02@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] media: rainshadow-cec: fix TOCTOU race condition in rain_interrupt()
Date: Fri, 22 Aug 2025 21:45:18 -0400
Message-ID: <20250823014519.1670171-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082119-december-ranking-b3a3@gregkh>
References: <2025082119-december-ranking-b3a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 7af160aea26c7dc9e6734d19306128cce156ec40 ]

In the interrupt handler rain_interrupt(), the buffer full check on
rain->buf_len is performed before acquiring rain->buf_lock. This
creates a Time-of-Check to Time-of-Use (TOCTOU) race condition, as
rain->buf_len is concurrently accessed and modified in the work
handler rain_irq_work_handler() under the same lock.

Multiple interrupt invocations can race, with each reading buf_len
before it becomes full and then proceeding. This can lead to both
interrupts attempting to write to the buffer, incrementing buf_len
beyond its capacity (DATA_SIZE) and causing a buffer overflow.

Fix this bug by moving the spin_lock() to before the buffer full
check. This ensures that the check and the subsequent buffer modification
are performed atomically, preventing the race condition. An corresponding
spin_unlock() is added to the overflow path to correctly release the
lock.

This possible bug was found by an experimental static analysis tool
developed by our team.

Fixes: 0f314f6c2e77 ("[media] rainshadow-cec: new RainShadow Tech HDMI CEC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[ drivers/media/cec/usb/rainshadow/ => drivers/media/usb/rainshadow-cec/ ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/rainshadow-cec/rainshadow-cec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/rainshadow-cec/rainshadow-cec.c b/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
index ee870ea1a886..6f8d6797c614 100644
--- a/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
+++ b/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
@@ -171,11 +171,12 @@ static irqreturn_t rain_interrupt(struct serio *serio, unsigned char data,
 {
 	struct rain *rain = serio_get_drvdata(serio);
 
+	spin_lock(&rain->buf_lock);
 	if (rain->buf_len == DATA_SIZE) {
+		spin_unlock(&rain->buf_lock);
 		dev_warn_once(rain->dev, "buffer overflow\n");
 		return IRQ_HANDLED;
 	}
-	spin_lock(&rain->buf_lock);
 	rain->buf_len++;
 	rain->buf[rain->buf_wr_idx] = data;
 	rain->buf_wr_idx = (rain->buf_wr_idx + 1) & 0xff;
-- 
2.50.1


