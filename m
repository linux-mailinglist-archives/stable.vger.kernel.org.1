Return-Path: <stable+bounces-132991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D5BA91971
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5BF7A7C37
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE2225A37;
	Thu, 17 Apr 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CuoGIFZB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EB13D89D
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885969; cv=none; b=X/qPVJBUi+QwsoOjn9UNHrZ2d640pbf9ug5Z9ZI2m6YAmNxyJ/DKP3SgaEGVnBjQZaYte8PjINYfU3InQMLuFho8Q3R8xyc6XCjoeDhoaYGdcNlPxYQn1ZhkYJBBbnu/w0bI3AgW3ki3e/MNQ2hpkT4iXOzsW9wE9SlJyaRLeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885969; c=relaxed/simple;
	bh=7BK1CpxI1HQsJLlniQv5J5EMGQTqtZZRJpy+WG/Onk8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CZcHKUMoKyE+8TKqp6ojFzo4ecRE66u6HdoSW/bQUqYasA5V6tTIkXUYZHoIiA5yHrQavVPM8byVc5VcF11WpynH+Fff5DAqKQwPNt3zS5gIYnekfkb8WcUyV/vgnK3rcGXFe5ZBGOols1cdUf89NGyqLnpI6HWrjnoEFZb11pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CuoGIFZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC36BC4CEE4;
	Thu, 17 Apr 2025 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744885969;
	bh=7BK1CpxI1HQsJLlniQv5J5EMGQTqtZZRJpy+WG/Onk8=;
	h=Subject:To:Cc:From:Date:From;
	b=CuoGIFZBi44wik1TrLbSxhtPFAJjhBO4mPfHM8Ozv8Q9/9FV/EaHiqxv68Upo7kr/
	 IpPTqStPakjl/NU+AJSVGD7hYYKd1zJ57BP0sZ2d7ExbJBaZM+6kt3h0PYWN9CTIvO
	 OcSQi6llTSYcBoCBcCTVijjGgfIGrMJ+nsnKpmug=
Subject: FAILED: patch "[PATCH] mtd: Add check for devm_kcalloc()" failed to apply to 5.10-stable tree
To: jiashengjiangcool@gmail.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:32:46 +0200
Message-ID: <2025041746-tummy-size-5785@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2aee30bb10d7bad0a60255059c9ce1b84cf0130e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041746-tummy-size-5785@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2aee30bb10d7bad0a60255059c9ce1b84cf0130e Mon Sep 17 00:00:00 2001
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Wed, 5 Feb 2025 02:31:41 +0000
Subject: [PATCH] mtd: Add check for devm_kcalloc()

Add a check for devm_kcalloc() to ensure successful allocation.

Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 2d004d41cf75..9cf3872e37ae 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -423,6 +423,9 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
+	if (!cxt->rmmap || !cxt->usedmap || !cxt->badmap)
+		return;
+
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
 	cxt->dev.zone.read = mtdpstore_read;


