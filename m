Return-Path: <stable+bounces-130706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C6A805F7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553061B8317C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1456926B966;
	Tue,  8 Apr 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x07GI2nh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524F26B960;
	Tue,  8 Apr 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114431; cv=none; b=phM4mkkgBAn0AZ8KVCxninASIYW47NC8DTJq3UEGt84/gITeowxUkJXmzDICb859AHehJ4T3t6WtDjWIR+EtU7JFhsHn6OXqeYSIsXIEWlfRjQIJXoKB2flFyot11qCFE/xSb+yqj+8EPz0mK7kW5eot9eIE2wOdq4PrP3rM1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114431; c=relaxed/simple;
	bh=26xILjm4xFd4S5m7hXcKDjauaF6AO5izTeS8XJ16728=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0bCVMUtqSjMPlrsq/l6rU/rSqsDoASf6cyw8qeDLXF3CVvkwt3iDOgP/2UlR3b/uAg0e7zxPDIKbaHGk3DjOKUbdoKoO723aMVNHQkz1wx1jqgXpgdhgvtd5WXiRpMRIQ1+DagCY4n7Qv0hm+VgKo065QcAupKmJHuW/Nhcx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x07GI2nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFC9C4CEE5;
	Tue,  8 Apr 2025 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114431;
	bh=26xILjm4xFd4S5m7hXcKDjauaF6AO5izTeS8XJ16728=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x07GI2nhTZNrwxh5vBbkY4oHrokHVbI6OdCrYtS3f4QnmqiXoOJSJEQFzgRocUv1o
	 dcXQmhg7oQJza/pGz3Kbnv7Pwv51T6YEtUUeZ5eRxQGv0vskdaoKx03ynXfAEjBrSy
	 D1no/gYTybocDRXcGsE5ow925pVA9dmujghvDGZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason-JH Lin <jason-jh.lin@mediatek.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 104/499] drm/mediatek: Fix config_updating flag never false when no mbox channel
Date: Tue,  8 Apr 2025 12:45:16 +0200
Message-ID: <20250408104853.804724937@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason-JH Lin <jason-jh.lin@mediatek.com>

[ Upstream commit 4ba973c8bad04d59fd4efa62512f4d9cee131714 ]

When CONFIG_MTK_CMDQ is enabled, if the display is controlled by the CPU
while other hardware is controlled by the GCE, the display will encounter
a mbox request channel failure.
However, it will still enter the CONFIG_MTK_CMDQ statement, causing the
config_updating flag to never be set to false. As a result, no page flip
event is sent back to user space, and the screen does not update.

Fixes: da03801ad08f ("drm/mediatek: Move mtk_crtc_finish_page_flip() to ddp_cmdq_cb()")
Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250224051301.3538484-1-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 5674f5707cca8..8f6fba4217ece 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -620,13 +620,16 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 
 		mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_handle);
 		mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
+		goto update_config_out;
 	}
-#else
+#endif
 	spin_lock_irqsave(&mtk_crtc->config_lock, flags);
 	mtk_crtc->config_updating = false;
 	spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
-#endif
 
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+update_config_out:
+#endif
 	mutex_unlock(&mtk_crtc->hw_lock);
 }
 
-- 
2.39.5




