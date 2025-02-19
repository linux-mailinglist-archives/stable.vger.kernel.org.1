Return-Path: <stable+bounces-117413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07BA3B678
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AB417D61A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54E1E1C09;
	Wed, 19 Feb 2025 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h4t/8Det"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4B1E105E;
	Wed, 19 Feb 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955207; cv=none; b=lTjoweFgEMc5uDy0ZbtOVp/mCzbzuc5IQOMnFxfI5E9Nt/wg8mnMh57KFkpT5uQcrmRzp3WvbDDruP7FiEIdkNTMDqG/K1SxJ0hhkC6s01/eClWQY4VJioveVuu24uld3Ib0ZIEh792/XnWNYjYeaBzXh6muyNrnZDawSnsHqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955207; c=relaxed/simple;
	bh=ZYQNTgrCugyum/ljBKqjEkX6HLqIuQFImpwmas1r8Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDxtXzIEZPxvYDzH6yhpG0Bs7/WdSySHC9AncjXkIduBYRMR1VzalAmiIMSJbN+RlfYtGW7aTnUeyoHdKrs1x6AwHHxZ5GfJPLXwJO/8/Dtf72SHPNbpI2HDqhf/ZsJmAOqVWNfvIyl8k2mJ5/ygZCbkgF4UB3Jee7YW/M3U9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h4t/8Det; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D5C4CED1;
	Wed, 19 Feb 2025 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955206;
	bh=ZYQNTgrCugyum/ljBKqjEkX6HLqIuQFImpwmas1r8Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4t/8Detil4RYrJuucCbygOj002ndtbPAgqM9itGIhqASku5gnUQPh886iox1wQEd
	 nnr1stkFZyrdqvRT/NM5lNwWMidQ0gvGjKh+HINKeczXi21I3QuNvC2Eh02++VdprE
	 0l/xTfNQR0PeUXwJemPJGKo0nSPQh2oMgOY3EtCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin van der Gracht <robin@protonic.nl>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 132/230] can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated
Date: Wed, 19 Feb 2025 09:27:29 +0100
Message-ID: <20250219082606.849428618@linuxfoundation.org>
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

From: Robin van der Gracht <robin@protonic.nl>

commit f7f0adfe64de08803990dc4cbecd2849c04e314a upstream.

Fix NULL pointer check in rkcanfd_handle_rx_fifo_overflow_int() to
bail out if skb cannot be allocated.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
Link: https://patch.msgid.link/20250208-fix-rockchip-canfd-v1-1-ec533c8a9895@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index df18c85fc078..d9a937ba126c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -622,7 +622,7 @@ rkcanfd_handle_rx_fifo_overflow_int(struct rkcanfd_priv *priv)
 	netdev_dbg(priv->ndev, "RX-FIFO overflow\n");
 
 	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
-	if (skb)
+	if (!skb)
 		return 0;
 
 	rkcanfd_get_berr_counter_corrected(priv, &bec);
-- 
2.48.1




