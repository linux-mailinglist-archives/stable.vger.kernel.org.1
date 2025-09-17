Return-Path: <stable+bounces-180223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC78BB7EF38
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66798188F14E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA331A7EA;
	Wed, 17 Sep 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PBOK/u5T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C018308F18;
	Wed, 17 Sep 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113773; cv=none; b=QygEpKjdw2mYlLhTemxKNjuAX/g2lxw/GDpgKdVTZuaV6bdQNjmZM7p/o40YmMoGVJCTmjaiPKJLJZ0hnOp/9N4Rfydod/Xh9h+L3am0LfJJiVRiX2/jhJs+23xNx6XJroJeHXsB6lq01/WR2wohRTKg5lChJd9mjBEnhvenozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113773; c=relaxed/simple;
	bh=dMNf3DSngKwTJV9SbBWRb2nUGKz10wYf+Vb2u/zSMRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+YNCaiQ5BjxCDpAcUZMVrDy8PbXG3Udd2VHtXO0sAPoxPbyI5xR66RIKWiK0fSGcSPEVdNevJnbf2pEmMTwo/UhlVoL44+rYil45/VFr4z3xaNQdq5uPLDnOVdDWpEvNJ2bQmF2s3TkYOALGI1gk2zfLo+VKr2MvkxeYvF9W1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PBOK/u5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F474C4CEF0;
	Wed, 17 Sep 2025 12:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113773;
	bh=dMNf3DSngKwTJV9SbBWRb2nUGKz10wYf+Vb2u/zSMRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBOK/u5T8iCM16fl2VkSqHf0N6EvTBoKxENgsKbKM1EP2oUvjTFPBfKWmAmYt/4fE
	 EMzyZ0p8vo542bObr4fEpq3EXFGZLOztzgjNX3T6dMfhHjP9e9nVXdVvgwFWW8biAv
	 ynWfOLWgXYr8sifksHDPkwgNivDq7YTebO5f8eEE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 047/101] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Wed, 17 Sep 2025 14:34:30 +0200
Message-ID: <20250917123337.980656645@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
References: <20250917123336.863698492@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Dahl <ada@thorsis.com>

[ Upstream commit 1c60e027ffdebd36f4da766d9c9abbd1ea4dd8f9 ]

Looks like a copy'n'paste mistake introduced when initially adding the
dynamic timings feature with commit f9ce2eddf176 ("mtd: nand: atmel: Add
->setup_data_interface() hooks").  The context around this and
especially the code itself suggests 'read' is meant instead of write.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240226122537.75097-1-ada@thorsis.com
Stable-dep-of: fd779eac2d65 ("mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1378,7 +1378,7 @@ static int atmel_smc_nand_prepare_smccon
 		return ret;
 
 	/*
-	 * The write cycle timing is directly matching tWC, but is also
+	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *



