Return-Path: <stable+bounces-59713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263F932B65
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BC61F20595
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F514136643;
	Tue, 16 Jul 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EEXWRrm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D144F9E8;
	Tue, 16 Jul 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144681; cv=none; b=ZwzXmAMMBRKlJmwx9yenb12ie7J5bUr+PiCwmdl70dygptrSj2lBy0BTCEGT3kzTPo5+00H27LymG6TMnqIlAvs+/n7Xl+X0WW/3Cz9XbBre1eG3RvYwmqSTE4x92u/o3H7EPU85CxEYM0JRZQ7qvrWLGsQmI1PFW438IVBXGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144681; c=relaxed/simple;
	bh=toIeQT6h9U/g3dxCpV0ZDPVjoOnRbxfjDXLu3GetbJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq5vKjxp7C30n+5AYuh2SZYn375TEg/4A/5oZETFrQnDD9o8evU9ck0jGDuhNbPMrYacjZPN0GUH6KByXnEg1+D0YN41k2HvMuIsBVA9/LXr/3yXRpy3FmLPdtsCbG+lq7Cl/a+y47S3B8W0vUhNgR0XJfqhWC28Q6dUoQsDdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EEXWRrm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF68C4AF0E;
	Tue, 16 Jul 2024 15:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144681;
	bh=toIeQT6h9U/g3dxCpV0ZDPVjoOnRbxfjDXLu3GetbJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEXWRrm0RaOWfAYIoi2RaQtsF8AhzKee+1GHe4TTndrz3xFIIUHwrrDROkrSlLUSq
	 vBcx4aQcRr2UdLxeqiEsG2SidZXl9T6wSbprV1IYq7MGSyVtJo7jPV9ViuhmE3S/Y2
	 28nPxRj4r/e8eIakYd2tY5uByTCNqEU8/t9Z2YIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 064/108] net: lantiq_etop: add blank line after declaration
Date: Tue, 16 Jul 2024 17:31:19 +0200
Message-ID: <20240716152748.439709014@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit 4c46625bb586a741b8d0e6bdbddbcb2549fa1d36 ]

This patch adds a missing line after the declaration and
fixes the checkpatch warning:

WARNING: Missing a blank line after declarations
+		int desc;
+		for (desc = 0; desc < LTQ_DESC_NUM; desc++)

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Link: https://lore.kernel.org/r/20211228220031.71576-1-olek2@wp.pl
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e1533b6319ab ("net: ethernet: lantiq_etop: fix double free in detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/lantiq_etop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 5ea626b1e5783..62300d46d9186 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -214,6 +214,7 @@ ltq_etop_free_channel(struct net_device *dev, struct ltq_etop_chan *ch)
 		free_irq(ch->dma.irq, priv);
 	if (IS_RX(ch->idx)) {
 		int desc;
+
 		for (desc = 0; desc < LTQ_DESC_NUM; desc++)
 			dev_kfree_skb_any(ch->skb[ch->dma.desc]);
 	}
-- 
2.43.0




