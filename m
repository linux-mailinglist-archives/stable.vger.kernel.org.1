Return-Path: <stable+bounces-135970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB6A99125
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088A1175CE1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF029A3EE;
	Wed, 23 Apr 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xpsbz+WN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E347298CD0;
	Wed, 23 Apr 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421318; cv=none; b=K9T+XO2RPO49RNskGqOKZofbb/tCMijBVADnyaPs1WAUyFFms+a52kiExW/ZBJwSDwRBAnzjergdCGXIXRTRnJHAev8KCMJlTmNcbVpYfaPms/UN5r6JwjRyaQSiTYGndWArVLvW6yWKrbUmJw52VKW4tV87qI3kn2iVvutjoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421318; c=relaxed/simple;
	bh=hVyBtNdNPLYTURZiP2rj04PeKJpQ07rvOJzquQ5ASKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAvOjKwR5eqtAadXNK9ztDncklVTa7ElsJ2o6slNDuA+bu03vI4uSB2or1QTMba5jLtiTvZ+aW1BzxkCt1PRJZAaWvEgvM+0RcXJBCgbflfKG/NcHWJtk7B2QfvL+B/LyZIarVOkKpl0bSmL+G/s7QyXwn7fd45y8fE0O4+kCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xpsbz+WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEBEC4CEEC;
	Wed, 23 Apr 2025 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421317;
	bh=hVyBtNdNPLYTURZiP2rj04PeKJpQ07rvOJzquQ5ASKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xpsbz+WNttcFbfA9no3d12diIT69aDJNDJW6oKuFlv5Gaulf7C39Bo5FMmNbCKF8P
	 xx60FhS/GeFyubF0pP/AZltu8gxRUN1Re5LLkrf8KHEGgCO9FHRcumK/R+nt+j4o+C
	 rotI/opsLmZ1Y+7a5XTZ7ww8gXa4JpC7PrvMjcyY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 126/291] mtd: rawnand: Add status chack in r852_ready()
Date: Wed, 23 Apr 2025 16:41:55 +0200
Message-ID: <20250423142629.549472031@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit b79fe1829975556854665258cf4d2476784a89db upstream.

In r852_ready(), the dev get from r852_get_dev() need to be checked.
An unstable device should not be ready. A proper implementation can
be found in r852_read_byte(). Add a status check and return 0 when it is
unstable.

Fixes: 50a487e7719c ("mtd: rawnand: Pass a nand_chip object to chip->dev_ready()")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/r852.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -387,6 +387,9 @@ static int r852_wait(struct nand_chip *c
 static int r852_ready(struct nand_chip *chip)
 {
 	struct r852_device *dev = r852_get_dev(nand_to_mtd(chip));
+	if (dev->card_unstable)
+		return 0;
+
 	return !(r852_read_reg(dev, R852_CARD_STA) & R852_CARD_STA_BUSY);
 }
 



