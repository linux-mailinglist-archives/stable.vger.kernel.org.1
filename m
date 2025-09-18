Return-Path: <stable+bounces-174347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6DFB36308
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FCB4676A2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6B340DAE;
	Tue, 26 Aug 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guUoI/QQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C15338F32;
	Tue, 26 Aug 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214150; cv=none; b=E3rf4zesjFoABHF+Q4q8nlNOH4SsS/AqAQYQg9oXV5TR10KcOZzihKksme1yJL5JCpeKRzflBq48CfriEZUeWIhfRC882ymtABh2I+9XPc97nX8g46TMKApEUcM5A5qRvmh8UaSIt10SjGq0C+dXcjrHjlPFwMEmtbUdBltKOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214150; c=relaxed/simple;
	bh=S/cqH8oPXa/2kYAXTpiP05rQ7Uhdwqmr9WE0okhNU2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf+/dN+3exIAp5VBOmo5hAFbUQNZnh1OW4Rmqn8JueE6/JutPiYoxGTPst5sHBobHZl6RcTLWtZdjN7t5wlphcr567af9ATklyAJIAxqn5toZncpAeO5ppWcnX0NdfVOVovPYBcGVXUpVzA4DXWbuyw0K4BS/JttBJJiQb+BBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guUoI/QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF967C4CEF1;
	Tue, 26 Aug 2025 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214150;
	bh=S/cqH8oPXa/2kYAXTpiP05rQ7Uhdwqmr9WE0okhNU2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=guUoI/QQEJxilKKH1iMO03D/y5JAEzKnDaKCWiFVwtgR8w/7mXOIXfCuUsl0q1oVY
	 N/AvYRtvDRPKCrVp6+Q5V/SQuI6Zs9Syu7Kbq/u1xL3epNEVoRbhRx7a8rMbfh8NDo
	 QeL0cP7rv0JPjt8Z4hDGyd++0QIRRrwTYBQu3m5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Johan Hovold <johan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 012/482] net: gianfar: fix device leak when querying time stamp info
Date: Tue, 26 Aug 2025 13:04:25 +0200
Message-ID: <20250826110931.086706203@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit da717540acd34e5056e3fa35791d50f6b3303f55 upstream.

Make sure to drop the reference to the ptp device taken by
of_find_device_by_node() when querying the time stamping capabilities.

Note that holding a reference to the ptp device does not prevent its
driver data from going away.

Fixes: 7349a74ea75c ("net: ethernet: gianfar_ethtool: get phc index through drvdata")
Cc: stable@vger.kernel.org	# 4.18
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250725171213.880-4-johan@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar_ethtool.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1466,8 +1466,10 @@ static int gfar_get_ts_info(struct net_d
 	if (ptp_node) {
 		ptp_dev = of_find_device_by_node(ptp_node);
 		of_node_put(ptp_node);
-		if (ptp_dev)
+		if (ptp_dev) {
 			ptp = platform_get_drvdata(ptp_dev);
+			put_device(&ptp_dev->dev);
+		}
 	}
 
 	if (ptp)



