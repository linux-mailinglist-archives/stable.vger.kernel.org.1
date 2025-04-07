Return-Path: <stable+bounces-128761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8A3A7EB6B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275097A2DFE
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939CE27CB03;
	Mon,  7 Apr 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOnOtFsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69D27CB25;
	Mon,  7 Apr 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049890; cv=none; b=BtTbaMea5+F4tc050TKGT4AZzo3MHl1/5tEsBv332M37yZNRIAMnHAm2P2oq5fA8wFfdGkTiyityexIHhLQArjHyo+TQVcXmj6+nOm6WOQNIzYP2oVlMzNy/qiVoNtyNxH7DjCKLq0oF20rv8+37Pokk8Pr8Wet2EHNEsKygLxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049890; c=relaxed/simple;
	bh=yn4rIepodu57VeEGKcyTBHzdR+ShZUPTHrw2zmhNZuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkH6xoM1j7xm1CalA+c4xBia6XKmZJ8WtknIcf2WAwizDy2aE4A1qgvo2lR8oIcW2AoALxzHJxz6LV0ATbJ79F7y4lYIAcRJo7Phu9LUwHnFsO0nTWKRPSpbUo2MV55UnbWyYpg3fD9i7nXYp+x3JABpL1f0DlxwHuyMDlD8bwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOnOtFsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE91BC4CEE7;
	Mon,  7 Apr 2025 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049890;
	bh=yn4rIepodu57VeEGKcyTBHzdR+ShZUPTHrw2zmhNZuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOnOtFsuHt/WLUp0ATQfmouxpDU07i2TOiF60u52ndeyt7FOk6tE1zxQUmtmqh/fJ
	 ylCK2eHQ1+1Fvnl2aCbp2+xYYvOdRoyxbnw3mSjGmzdJOK9i7BwxnnLSPhWFCgHdM/
	 +BRy+AWo9npvU9yTv2yvrptM462FDUMIvloReksSVDTqxPfFTMkQ3SjKB3XFUOQvLH
	 I2KS3UcvFHh0izVRWZ2nksDKlPkYtUVRGsPBYB2tBM9HrWFpdLKs5JL9dnS2Aa+19u
	 6l2a2O8jhdeBCGgaA2mmuZ9www8fcOg3hrSfmy/8JXjPkdY/caG2CE0OLydXLBBEux
	 M0FwIotBJSJ9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>,
	allenbh@gmail.com,
	bhelgaas@google.com,
	fancer.lancer@gmail.com,
	zhangjiao2@cmss.chinamobile.com,
	pstanner@redhat.com,
	ntb@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/2] ntb: reduce stack usage in idt_scan_mws
Date: Mon,  7 Apr 2025 14:18:01 -0400
Message-Id: <20250407181802.3184614-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181802.3184614-1-sashal@kernel.org>
References: <20250407181802.3184614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit aff12700b8dd7422bfe2277696e192af4df9de8f ]

idt_scan_mws() puts a large fixed-size array on the stack and copies
it into a smaller dynamically allocated array at the end. On 32-bit
targets, the fixed size can easily exceed the warning limit for
possible stack overflow:

drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in 'idt_scan_mws' [-Werror,-Wframe-larger-than]

Change it to instead just always use dynamic allocation for the
array from the start. It's too big for the stack, but not actually
all that much for a permanent allocation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202205111109.PiKTruEj-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 72060acb9cafc..366e19dbae316 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1041,7 +1041,7 @@ static inline char *idt_get_mw_name(enum idt_mw_type mw_type)
 static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 				       unsigned char *mw_cnt)
 {
-	struct idt_mw_cfg mws[IDT_MAX_NR_MWS], *ret_mws;
+	struct idt_mw_cfg *mws;
 	const struct idt_ntb_bar *bars;
 	enum idt_mw_type mw_type;
 	unsigned char widx, bidx, en_cnt;
@@ -1049,6 +1049,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	int aprt_size;
 	u32 data;
 
+	mws = devm_kcalloc(&ndev->ntb.pdev->dev, IDT_MAX_NR_MWS,
+			   sizeof(*mws), GFP_KERNEL);
+	if (!mws)
+		return ERR_PTR(-ENOMEM);
+
 	/* Retrieve the array of the BARs registers */
 	bars = portdata_tbl[port].bars;
 
@@ -1103,16 +1108,7 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 		}
 	}
 
-	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
-			       GFP_KERNEL);
-	if (!ret_mws)
-		return ERR_PTR(-ENOMEM);
-
-	/* Copy the info of detected memory windows */
-	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
-
-	return ret_mws;
+	return mws;
 }
 
 /*
-- 
2.39.5


