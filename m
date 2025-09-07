Return-Path: <stable+bounces-178523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C74B47F03
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD86C16D726
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3111FECCD;
	Sun,  7 Sep 2025 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lajTqRNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0515C158;
	Sun,  7 Sep 2025 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277108; cv=none; b=I2+XWJh/WpnGKxNVDrSiJ4xGK1PbMP+eEMVuSNZiT7iJBs7YkA6uS/dHn5uCZrFehJcHKRlXpDTNo6vagF4ewrOlrHCoUpIUSQlMyDCh7Fy/gBffYgQthZ2zDGI6KFbiiIYbeToguaezNK50CX3Kmmt6CgwnB3W3TClEPtrKxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277108; c=relaxed/simple;
	bh=tpoKvTbAoDdtv20uQGGhIbbb57bAUaQUKQ/jNxtAQNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK41TEK+wEw6apYX28tjtCz9nvAucDxY9cFHNr0p5f9kCkqyVR5FdIE3Nac416+ykRQJv/AvsrPvBaSthTo666DcwDegVLM5ic039iV30pmcJT9y8lB3iuv+A+oMovfjUlid1hlxR/grog1kaVxaQT9gfRHitDasVTWfyhdy2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lajTqRNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAD3C4CEF0;
	Sun,  7 Sep 2025 20:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277108;
	bh=tpoKvTbAoDdtv20uQGGhIbbb57bAUaQUKQ/jNxtAQNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lajTqRNyqJOrysVZkQhBLYlRL1aSoFqwGSDpa/3gU9StvkLJWF4lOtXTeVKz4BZxx
	 /ni6EJs4yIPS7XtOCcsiPuRJEzsxz1YnoFsXVuoeRNYKd9S6BVy5CSyQ8xd5p1lnRD
	 ooSy1VULpCHoOAvLhS/tVzDTVlegQga7zsxWvgLM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rosen Penev <rosenp@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 081/175] net: thunder_bgx: decrement cleanup index before use
Date: Sun,  7 Sep 2025 21:57:56 +0200
Message-ID: <20250907195616.751581361@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
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

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 9e3d71a92e561ccc77025689dab25d201fee7a3e ]

All paths in probe that call goto defer do so before assigning phydev
and thus it makes sense to cleanup the prior index. It also fixes a bug
where index 0 does not get cleaned up.

Fixes: b7d3e3d3d21a ("net: thunderx: Don't leak phy device references on -EPROBE_DEFER condition.")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250901213314.48599-1-rosenp@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 5afc0735b5827..a360d3dffccd4 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1519,11 +1519,11 @@ static int bgx_init_of_phy(struct bgx *bgx)
 	 * for phy devices we may have already found.
 	 */
 	while (lmac) {
+		lmac--;
 		if (bgx->lmac[lmac].phydev) {
 			put_device(&bgx->lmac[lmac].phydev->mdio.dev);
 			bgx->lmac[lmac].phydev = NULL;
 		}
-		lmac--;
 	}
 	of_node_put(node);
 	return -EPROBE_DEFER;
-- 
2.50.1




