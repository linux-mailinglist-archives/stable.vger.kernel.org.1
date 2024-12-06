Return-Path: <stable+bounces-98977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22549E6B5F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A647A1884B48
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD211EE016;
	Fri,  6 Dec 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KfUacZMu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602481DC182
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479943; cv=none; b=cdYw5sXUrpBjcGsRo1jmxVD6LGmItsnZ+POk84Ckg1cbvFALz/vOuZabgocpJ0QUlkpIENqaPClq6ZJB/tjmakDEDyEB9HIpLjyrcnZFHBazoGCJ+vMWHL8sGzxOEPTDO9jIszLfb8OVzf2/Eer3p9doL8NBbPVV15XTg9Qsc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479943; c=relaxed/simple;
	bh=/iwzGEEd0wQQYWN4Kao+piQJiilb+W3r5zGrmTfsa7Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dhq6t+SCPPWFAJpdzqTPKjBaUX28pfZQ8Hp43mqHkq4PVmMvd/u6zxBLZFm/18ts9AuxE3Fguh9QOHp4cvU98+wI/CyBVxySzrrlGJePm4Tp+7A0LVeNRkMlsZJv+3p4YnyAaK4a+008xfZYYbD+8tIY7WVpdT5Y6I7thGXf24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KfUacZMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AB2C4CED1;
	Fri,  6 Dec 2024 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479943;
	bh=/iwzGEEd0wQQYWN4Kao+piQJiilb+W3r5zGrmTfsa7Y=;
	h=Subject:To:Cc:From:Date:From;
	b=KfUacZMud2znfwhqJ5zxxa6YB2YQJ9AnlVN8sWzO90T823OjouFgSZ3Q4RI9RH+mX
	 aRtytnZOHFdjn2J6z1Q9IF2su/jMhoh47crrNarner+yeZLribht1UMeT7ZtmtKrvv
	 pzVnD0kLC+e8DTNDv23HzyiadQOT0BPeDRTa+rNo=
Subject: FAILED: patch "[PATCH] mmc: core: Use GFP_NOIO in ACMD22" failed to apply to 6.12-stable tree
To: avri.altman@wdc.com,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:12:20 +0100
Message-ID: <2024120619-protozoan-concept-0f8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 869d37475788b0044bec1a33335e24abaf5e8884
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120619-protozoan-concept-0f8d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 869d37475788b0044bec1a33335e24abaf5e8884 Mon Sep 17 00:00:00 2001
From: Avri Altman <avri.altman@wdc.com>
Date: Mon, 21 Oct 2024 18:32:27 +0300
Subject: [PATCH] mmc: core: Use GFP_NOIO in ACMD22

While reviewing the SDUC series, Adrian made a comment concerning the
memory allocation code in mmc_sd_num_wr_blocks() - see [1].
Prevent memory allocations from triggering I/O operations while ACMD22
is in progress.

[1] https://lore.kernel.org/linux-mmc/3016fd71-885b-4ef9-97ed-46b4b0cb0e35@intel.com/

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 051913dada04 ("mmc_block: do not DMA to stack")
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Cc: stable@vger.kernel.org
Message-ID: <20241021153227.493970-1-avri.altman@wdc.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 04f3165cf9ae..a813fd7f39cc 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	u32 result;
 	__be32 *blocks;
 	u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
+	unsigned int noio_flag;
+
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
 	struct mmc_data data = {};
@@ -1018,7 +1020,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
+	noio_flag = memalloc_noio_save();
 	blocks = kmalloc(resp_sz, GFP_KERNEL);
+	memalloc_noio_restore(noio_flag);
 	if (!blocks)
 		return -ENOMEM;
 


