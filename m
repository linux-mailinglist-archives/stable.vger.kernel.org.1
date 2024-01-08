Return-Path: <stable+bounces-10083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB07827256
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFC52810E4
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2294A99F;
	Mon,  8 Jan 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4UXPdP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6D4B5AB;
	Mon,  8 Jan 2024 15:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C68C433C7;
	Mon,  8 Jan 2024 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726706;
	bh=VvZd9BJB/Vw2JlUTAtiuOAbLKUXawawWXDiQGMFoEsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4UXPdP5bxC9Scx2oWhj3hEdNU59JF09pGrzRsdQR3bL3/jGh4NTvOD6WgwiSllbX
	 sAd1IrhkGgnDuCmlnfJjKawEBo2RYQzrFQEAn7fJm59mNQ1Vr+zUk1V5grapxI8EfN
	 T2VliqdKnN1i9wQfLLJC+U2U5iXhOYIIIEp/VhxU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suman Ghosh <sumang@marvell.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 023/124] octeontx2-af: Fix marking couple of structure as __packed
Date: Mon,  8 Jan 2024 16:07:29 +0100
Message-ID: <20240108150604.038146677@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 0ee2384a5a0f3b4eeac8d10bb01a0609d245a4d1 ]

Couple of structures was not marked as __packed. This patch
fixes the same and mark them as __packed.

Fixes: 42006910b5ea ("octeontx2-af: cleanup KPU config data")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/npc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index de9fbd98dfb76..c92c3f4631d54 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -520,7 +520,7 @@ struct npc_lt_def {
 	u8	ltype_mask;
 	u8	ltype_match;
 	u8	lid;
-};
+} __packed;
 
 struct npc_lt_def_ipsec {
 	u8	ltype_mask;
@@ -528,7 +528,7 @@ struct npc_lt_def_ipsec {
 	u8	lid;
 	u8	spi_offset;
 	u8	spi_nz;
-};
+} __packed;
 
 struct npc_lt_def_apad {
 	u8	ltype_mask;
-- 
2.43.0




