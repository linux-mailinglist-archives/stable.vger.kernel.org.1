Return-Path: <stable+bounces-5655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB680D5D4
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0292823B1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0CF5102F;
	Mon, 11 Dec 2023 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IBox37Jy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD515101A;
	Mon, 11 Dec 2023 18:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8813C433C8;
	Mon, 11 Dec 2023 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319310;
	bh=3i/7geo6Kl1aGIs7VVklqf41fFT4wUyjA6If0F3CoDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBox37Jya68ss+d4jFdoHHahXFkbJNL8kR7oHZ1J4u8z+QnGbdLrUAYeifNiQwjhL
	 6ROVCAa9SZ8f7FCouTM08v9kjHjGeKvqUb6ekpKdmqhpWC8k5FIEw95SVqiYc/P+0F
	 QlgZ1SnoKHiadsgpNKp/MIHzn6Qii51DjvS+AEy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geetha sowjanya <gakula@marvell.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 058/244] octeontx2-af: Fix mcs stats register address
Date: Mon, 11 Dec 2023 19:19:11 +0100
Message-ID: <20231211182048.400930312@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 3ba98a8c6f8ceb4e01a78f973d8d9017020bbd57 ]

This patch adds the miss mcs stats register
for mcs supported platforms.

Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mcs.c   |  4 +--
 .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index bd87507cf8eaa..c1775bd01c2b4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -117,7 +117,7 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
 	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYTAGGEDCTLX(id);
 	stats->pkt_tagged_ctl_cnt = mcs_reg_read(mcs, reg);
 
-	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(id);
+	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
 	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
 
 	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
@@ -215,7 +215,7 @@ void mcs_get_sc_stats(struct mcs *mcs, struct mcs_sc_stats *stats,
 		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCNOTVALIDX(id);
 		stats->pkt_notvalid_cnt = mcs_reg_read(mcs, reg);
 
-		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(id);
+		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(id);
 		stats->pkt_unchecked_cnt = mcs_reg_read(mcs, reg);
 
 		if (mcs->hw->mcs_blks > 1) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
index f3ab01fc363c8..f4c6de89002c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
@@ -810,14 +810,37 @@
 		offset = 0x9d8ull;			\
 	offset; })
 
+#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(a) ({	\
+	u64 offset;					\
+							\
+	offset = 0xee80ull;				\
+	if (mcs->hw->mcs_blks > 1)			\
+		offset = 0xe818ull;			\
+	offset += (a) * 0x8ull;				\
+	offset; })
+
+#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a) ({	\
+	u64 offset;					\
+							\
+	offset = 0xa680ull;				\
+	if (mcs->hw->mcs_blks > 1)			\
+		offset = 0xd018ull;			\
+	offset += (a) * 0x8ull;				\
+	offset; })
+
+#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a)	({	\
+	u64 offset;						\
+								\
+	offset = 0xf680ull;					\
+	if (mcs->hw->mcs_blks > 1)				\
+		offset = 0xe018ull;				\
+	offset += (a) * 0x8ull;					\
+	offset; })
+
 #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCDECRYPTEDX(a)	(0xe680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCVALIDATEX(a)	(0xde80ull + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(a)	(0xa680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(a)	(0xd218 + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a)	(0xd018ull + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(a)	(0xee80ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a)		(0xb680ull + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a) (0xf680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSAINVALIDX(a)	(0x12680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTUSINGSAERRORX(a) (0x15680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTVALIDX(a)	(0x13680ull + (a) * 0x8ull)
-- 
2.42.0




