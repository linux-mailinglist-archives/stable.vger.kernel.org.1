Return-Path: <stable+bounces-117421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18635A3B5BA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E687A3743
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584A1E32B3;
	Wed, 19 Feb 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hCOQE/UW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0C1E285A;
	Wed, 19 Feb 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955233; cv=none; b=pt9OpKvSoaq59cXhwDPVVAYIxoetETwvA4d3jtwEB15BDtS6ZfGqAX4D2DFjV9cm/ESHL8vyThYdqp4ruhCgKUHXjPt1xq5NL/ucn69NV8LlDGd64FdxZ0rcL6sUVPbdswPIM/ZLzLCKz+Lni8jfPSPn3RplITUVnkL1H7vCT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955233; c=relaxed/simple;
	bh=htiIlhbj0TWA63IhJjQnKpy6lL8vJV040l699orvEgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsA1mPKgrsXoWGibGeGS77iHSnH7JecmUUDayKfSKTIETlx8C9sGBVYyscx8+f/gwRcE+oUpI5cokBhAuwS5LgSxR6mzSAuEhDy+UA7rVrAw5+LdW+qqKbaREw9cDgYR0z6dfKP1vT9AJjTH6ZJMZlSDEUSUHumYNL1JefnmqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hCOQE/UW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F533C4CED1;
	Wed, 19 Feb 2025 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955232;
	bh=htiIlhbj0TWA63IhJjQnKpy6lL8vJV040l699orvEgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCOQE/UWoZ1ZJFdkVuZLA2ux2yfWHu1G5KeGDTpdx5bEKX6muTCIdZcBfqZA8rFRy
	 jfoX4twb9U7KNnN0kfYwkbKxh6zYV62VghwjvXOPjmYVdNmHEKjcW3tEoJcK9CZP++
	 /YrewZxT029FFMSfJMzIg1WbU5Kej2npaneUXKx4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 173/230] scsi: ufs: Fix toggling of clk_gating.state when clock gating is not allowed
Date: Wed, 19 Feb 2025 09:28:10 +0100
Message-ID: <20250219082608.472613977@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avri Altman <avri.altman@wdc.com>

[ Upstream commit 839a74b5649c9f41d939a05059b5ca6b17156d03 ]

This commit addresses an issue where clk_gating.state is being toggled in
ufshcd_setup_clocks() even if clock gating is not allowed.

The fix is to add a check for hba->clk_gating.is_initialized before toggling
clk_gating.state in ufshcd_setup_clocks().

Since clk_gating.lock is now initialized unconditionally, it can no longer
lead to the spinlock being used before it is properly initialized, but
instead it is mostly for documentation purposes.

Fixes: 1ab27c9cf8b6 ("ufs: Add support for clock gating")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20250128071207.75494-3-avri.altman@wdc.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5682fdcbf2da5..a73fffd6c3de4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9240,7 +9240,7 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
 			if (!IS_ERR_OR_NULL(clki->clk) && clki->enabled)
 				clk_disable_unprepare(clki->clk);
 		}
-	} else if (!ret && on) {
+	} else if (!ret && on && hba->clk_gating.is_initialized) {
 		scoped_guard(spinlock_irqsave, &hba->clk_gating.lock)
 			hba->clk_gating.state = CLKS_ON;
 		trace_ufshcd_clk_gating(dev_name(hba->dev),
-- 
2.39.5




