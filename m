Return-Path: <stable+bounces-128756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757CA7EB63
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8AD7A24E0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960D27C163;
	Mon,  7 Apr 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw8rsn6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0E25743A;
	Mon,  7 Apr 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049877; cv=none; b=UPyQFfj3Eobnjocu9YVBBpt+nI0eydnoz+GkygxGO6ih+QJ9iDgCstY9asnsbbmCUHxsb0kkuy0e7SC7r4uKZ/zpMd0KtrsUiLVIwpFpJ550xO1w76sSD6ucHQkm7+DX19pz540L8k8p5WSb8VbZbzsySyQVegmA/RGo+mtjq+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049877; c=relaxed/simple;
	bh=wsk/UR5Tcm+EPJNKKtRxbzJeGipu7B54s1YULyH0ZYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rf0zDAAGRVIAYWl9dquegpD+ohilQ9Vc//zUG1kqVZp0L+l0oa9oEshO8ngZOBEI0T0toDoKhMUgB6aal6iRSlBOYSISceuDDh0MX0yA7d9eiikJLID9lluQIVm3/3aMuMyt2ip7SVV45CWwlzBDxyB1bupUwPDvOgwdtYfF2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw8rsn6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7376FC4CEE9;
	Mon,  7 Apr 2025 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049876;
	bh=wsk/UR5Tcm+EPJNKKtRxbzJeGipu7B54s1YULyH0ZYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qw8rsn6Uz3chDBMaTG6hv/7QDcrzt8KLF511Og5TNIdixTe8+RzP90Xjoxob3OKeL
	 ehteOZZsSoppIC4nVYTkpJ2hYmzfY42Rodc+LVhTkxaDKe5HQoLD5mEda3LQmPSJTQ
	 egqHfsyHV4Bkrl5CNdELYrvi2DlVGlXaA0tg+/T5AflKu2p8zeO8XaMDubS0QqJzNW
	 vEujWJ9BTTaATMJFSFA0y2J11mAunanh9d823NQJ7YHp3RS73TLsiRBKqSQOpjm26S
	 LmHCteIUdFjDFAsAQtLVPUwl0tcZyknUXmY6YkTGzrt/dyrY3P0ibIIzaudzqR7qXP
	 zp37T1E3R9xzA==
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
	fancer.lancer@gmail.com,
	bhelgaas@google.com,
	zhangjiao2@cmss.chinamobile.com,
	pstanner@redhat.com,
	ntb@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 2/5] ntb: reduce stack usage in idt_scan_mws
Date: Mon,  7 Apr 2025 14:17:45 -0400
Message-Id: <20250407181749.3184538-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181749.3184538-1-sashal@kernel.org>
References: <20250407181749.3184538-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
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
index 51799fccf8404..6f7620b153032 100644
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


