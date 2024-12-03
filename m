Return-Path: <stable+bounces-97069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD2A9E22C8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11294167E29
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5B1F757E;
	Tue,  3 Dec 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PdFKL6HH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AF71F130F;
	Tue,  3 Dec 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239431; cv=none; b=kFc/qXjuQyEofUE8XM6UsodHZufm3MSsr4Ak2FQBWdjH0/c0caD5aQhg7Ix35uQlzCtlCdn0OEm2oDrWu/zP8QYFnSQ17N+yzRQDTVaH2ExAGhVIGE9J6NsdOuJZs6mYAU/pb1ldDlsZ2sA1i/pFwV0P+JNSqGL4pG3SeUTNHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239431; c=relaxed/simple;
	bh=vd7ImvmUC5rCTnMyNMIx+cXXTcQm+ktUDAXaRXbaiO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLD99GcpPxX/8yi4z/pLmbog32/TkoBrxPnE9f/TDWtkJ0Uv8zxV67he6szcJLz5C85hhhdkaT6sx/mA7WvXLkSipEWL/pBpVP7/MAXpJPFb2QNMoHykaod544JWNb4T/iuPmLgTCP3zobYYJi2nWSjxGXmZAjamUFSJEOVgVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PdFKL6HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD53CC4CED8;
	Tue,  3 Dec 2024 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239431;
	bh=vd7ImvmUC5rCTnMyNMIx+cXXTcQm+ktUDAXaRXbaiO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdFKL6HHWjgfAi5U1vUhLVHU3y41AHTXrywwgBE4uxqiLeeRbERLUnJ8K+Gl0NOp6
	 rVqtBegMfBqMj+Hx+LXQA6Triyvwo4dYRvjRoj1XjISdG2RpjBY1uqTft86HH2PsjN
	 ZgUS9YAQFtz13hdHTdoUn+BuD/W7KdbvzPzim7HQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hariprasad Kelam <hkelam@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 580/817] octeontx2-af: RPM: fix stale RSFEC counters
Date: Tue,  3 Dec 2024 15:42:32 +0100
Message-ID: <20241203144018.559640974@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 07cd1eb166a3fa7244afa74d48bd13c9df7c559d ]

The earlier patch sets the 'Stats control register' for RPM
receive/transmit statistics instead of RSFEC statistics,
causing the driver to return stale FEC counters.

Fixes: 84ad3642115d ("octeontx2-af: Add FEC stats for RPM/RPM_USX block")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 13 +++++++++----
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h |  4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 22dd50a3fcd3a..70629f94c27ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -699,6 +699,10 @@ int rpm_get_fec_stats(void *rpmd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 	if (rpm->lmac_idmap[lmac_id]->link_info.fec == OTX2_FEC_NONE)
 		return 0;
 
+	/* latched registers FCFECX_CW_HI/RSFEC_STAT_FAST_DATA_HI_CDC are common
+	 * for all counters. Acquire lock to ensure serialized reads
+	 */
+	mutex_lock(&rpm->lock);
 	if (rpm->lmac_idmap[lmac_id]->link_info.fec == OTX2_FEC_BASER) {
 		val_lo = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_VL0_CCW_LO);
 		val_hi = rpm_read(rpm, lmac_id, RPMX_MTI_FCFECX_CW_HI);
@@ -725,20 +729,21 @@ int rpm_get_fec_stats(void *rpmd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 		}
 	} else {
 		/* enable RS-FEC capture */
-		cfg = rpm_read(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL);
+		cfg = rpm_read(rpm, 0, RPMX_MTI_RSFEC_STAT_STATN_CONTROL);
 		cfg |= RPMX_RSFEC_RX_CAPTURE | BIT(lmac_id);
-		rpm_write(rpm, 0, RPMX_MTI_STAT_STATN_CONTROL, cfg);
+		rpm_write(rpm, 0, RPMX_MTI_RSFEC_STAT_STATN_CONTROL, cfg);
 
 		val_lo = rpm_read(rpm, 0,
 				  RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_2);
-		val_hi = rpm_read(rpm, 0, RPMX_MTI_STAT_DATA_HI_CDC);
+		val_hi = rpm_read(rpm, 0, RPMX_MTI_RSFEC_STAT_FAST_DATA_HI_CDC);
 		rsp->fec_corr_blks = (val_hi << 32 | val_lo);
 
 		val_lo = rpm_read(rpm, 0,
 				  RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_3);
-		val_hi = rpm_read(rpm, 0, RPMX_MTI_STAT_DATA_HI_CDC);
+		val_hi = rpm_read(rpm, 0, RPMX_MTI_RSFEC_STAT_FAST_DATA_HI_CDC);
 		rsp->fec_uncorr_blks = (val_hi << 32 | val_lo);
 	}
+	mutex_unlock(&rpm->lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
index 34b11deb0f3c1..a5773fbacaff8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.h
@@ -84,9 +84,11 @@
 /* FEC stats */
 #define RPMX_MTI_STAT_STATN_CONTROL			0x10018
 #define RPMX_MTI_STAT_DATA_HI_CDC			0x10038
-#define RPMX_RSFEC_RX_CAPTURE				BIT_ULL(27)
+#define RPMX_RSFEC_RX_CAPTURE				BIT_ULL(28)
 #define RPMX_CMD_CLEAR_RX				BIT_ULL(30)
 #define RPMX_CMD_CLEAR_TX				BIT_ULL(31)
+#define RPMX_MTI_RSFEC_STAT_STATN_CONTROL               0x40018
+#define RPMX_MTI_RSFEC_STAT_FAST_DATA_HI_CDC            0x40000
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_2		0x40050
 #define RPMX_MTI_RSFEC_STAT_COUNTER_CAPTURE_3		0x40058
 #define RPMX_MTI_FCFECX_VL0_CCW_LO			0x38618
-- 
2.43.0




