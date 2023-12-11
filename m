Return-Path: <stable+bounces-6053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6F80D883
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44545B21605
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80A51C2B;
	Mon, 11 Dec 2023 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O0TfbbvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AABC8C8;
	Mon, 11 Dec 2023 18:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0469C433C7;
	Mon, 11 Dec 2023 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320384;
	bh=wi51PGAZAU0Tm78Pk5ubGhjH9iB3Ceu12rVkVhO4LZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0TfbbvBw3X375t5yBGhzK1rB9HvVyLq6Xr+ey6eeiiyIkrWtnIBo3nCSlymULFbL
	 EhUEZaujxRGxVWMPTHGG7iz4M/xUlsdDe5vPbEfvPyhvU1kPYkvgzy1ksOGZMYLXMK
	 5dWc3porxWJ4JBcYupMJQGjbCxZuzkHiBQmrX4P4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/194] ionic: fix snprintf format length warning
Date: Mon, 11 Dec 2023 19:20:31 +0100
Message-ID: <20231211182038.417639037@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 0ceb3860a67652f9d36dfdecfcd2cb3eb2f4537d ]

Our friendly kernel test robot has reminded us that with a new
check we have a warning about a potential string truncation.
In this case it really doesn't hurt anything, but it is worth
addressing especially since there really is no reason to reserve
so many bytes for our queue names.  It seems that cutting the
queue name buffer length in half stops the complaint.

Fixes: c06107cabea3 ("ionic: more ionic name tweaks")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311300201.lO8v7mKU-lkp@intel.com/
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20231204192234.21017-2-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 93a4258421667..13dfcf9f75dad 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -214,7 +214,7 @@ struct ionic_desc_info {
 	void *cb_arg;
 };
 
-#define IONIC_QUEUE_NAME_MAX_SZ		32
+#define IONIC_QUEUE_NAME_MAX_SZ		16
 
 struct ionic_queue {
 	struct device *dev;
-- 
2.42.0




