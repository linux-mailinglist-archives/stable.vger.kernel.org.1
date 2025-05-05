Return-Path: <stable+bounces-141391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F8BAAB6E2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31A03A7C4F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA920F08E;
	Tue,  6 May 2025 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFxB9xIU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BE381EA4;
	Mon,  5 May 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486025; cv=none; b=EIcj20Qp3k0bUSk/shCxWllGzJiEAp88t55AC8euYCZ3UcChf8CLSf8V0Wcqwyxjc6K/nEM0Xhx2iukhWBp1nqDxvPdHLUlfMcfr7D4n2oju4h0zj5nAFXc1SYig91Tm3OUdbJgLhPDy6ZQtxo0fA/tIWI3Gracs/f+ZTJ25Glw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486025; c=relaxed/simple;
	bh=FDTKH3+ShSHhRFPMJ8xezgRuCyIXgMvtIvlGpDq1aQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1G0dHiwvLBRaaWUD/6tA69xq62hQiwRPKVWux9mGGC0LFDAw3ilWow2gby/B1/TXxesqhyR56kxK8tTvjE6/VKca1rLp2xNZffLcOzEmwQsxXjq6QDR4oObp4r6zOKFoVyVfxQxAB/mhkLx8/l3i1h+cvDYzrTjlnGEASHNQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFxB9xIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD69C4CEF1;
	Mon,  5 May 2025 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486023;
	bh=FDTKH3+ShSHhRFPMJ8xezgRuCyIXgMvtIvlGpDq1aQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFxB9xIUkXL0i8p24ks2FQaeBo2q7RtG8W3oCQfVE/6MvH3eM08SNeI5W6q6/LZHZ
	 FO91ePcYqFgrXvfomYz5pP1/DEkCH+zFXCACPgV34kGj70BAxXx/ib4+TMvtVVc/HF
	 LSJAMAMzWouqM6/0UHYKjKmvD1JgQcpjJvxArvOz8j8e0ZU36sbPVh+8nBOTBjHN7W
	 wIRLurzXUypqor5WZWRmssjpcrIBG2W+/4R7F0DFN81jC/e34Dwaws0cfyub/TyyHq
	 dRZ2X/bvC/GuAkFJEnyYmdoG2ztWhD6ckvMbcR63czzLFcVwSPYTN0EUwjcMDa0U5P
	 rlhzOeMiuVeoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 116/294] net: phylink: use pl->link_interface in phylink_expects_phy()
Date: Mon,  5 May 2025 18:53:36 -0400
Message-Id: <20250505225634.2688578-116-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Choong Yong Liang <yong.liang.choong@linux.intel.com>

[ Upstream commit b63263555eaafbf9ab1a82f2020bbee872d83759 ]

The phylink_expects_phy() function allows MAC drivers to check if they are
expecting a PHY to attach. The checking condition in phylink_expects_phy()
aims to achieve the same result as the checking condition in
phylink_attach_phy().

However, the checking condition in phylink_expects_phy() uses
pl->link_config.interface, while phylink_attach_phy() uses
pl->link_interface.

Initially, both pl->link_interface and pl->link_config.interface are set
to SGMII, and pl->cfg_link_an_mode is set to MLO_AN_INBAND.

When the interface switches from SGMII to 2500BASE-X,
pl->link_config.interface is updated by phylink_major_config().
At this point, pl->cfg_link_an_mode remains MLO_AN_INBAND, and
pl->link_config.interface is set to 2500BASE-X.
Subsequently, when the STMMAC interface is taken down
administratively and brought back up, it is blocked by
phylink_expects_phy().

Since phylink_expects_phy() and phylink_attach_phy() aim to achieve the
same result, phylink_expects_phy() should check pl->link_interface,
which never changes, instead of pl->link_config.interface, which is
updated by phylink_major_config().

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Link: https://patch.msgid.link/20250227121522.1802832-2-yong.liang.choong@linux.intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b5f012619e42d..800e8b9eb4532 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1718,7 +1718,7 @@ bool phylink_expects_phy(struct phylink *pl)
 {
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
 	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_config.interface)))
+	     phy_interface_mode_is_8023z(pl->link_interface)))
 		return false;
 	return true;
 }
-- 
2.39.5


