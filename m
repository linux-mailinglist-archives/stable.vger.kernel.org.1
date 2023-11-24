Return-Path: <stable+bounces-2034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857567F827C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2811CB24529
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F52E64F;
	Fri, 24 Nov 2023 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DgF0XwPM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A233076;
	Fri, 24 Nov 2023 19:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F85EC433C7;
	Fri, 24 Nov 2023 19:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852884;
	bh=nzW13D0l7kQzgm05nvf3dwAvT3Oo2t50nI0TS1qgzvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgF0XwPM3ELMfr5SL495zeZDIK67IOIUemqlA6SLgxAPESsZ6KkNEGIlUSIVSwAQN
	 mAmY91+BIV6Yx2AZ4rcsuoKfx8au9JrZqA6VlEA80ohOElWaFMkFpKf0V2pIsZbK8Q
	 sQ8MAPsRm/zNMuaTOiov01bQrS230rMBWc/Gwp4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johnathan Mantey <johnathanx.mantey@intel.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 161/193] Revert ncsi: Propagate carrier gain/loss events to the NCSI controller
Date: Fri, 24 Nov 2023 17:54:48 +0000
Message-ID: <20231124171953.635018181@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

From: Johnathan Mantey <johnathanx.mantey@intel.com>

commit 9e2e7efbbbff69d8340abb56d375dd79d1f5770f upstream.

This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.

The cited commit introduced unwanted behavior.

The intent for the commit was to be able to detect carrier loss/gain
for just the NIC connected to the BMC. The unwanted effect is a
carrier loss for auxiliary paths also causes the BMC to lose
carrier. The BMC never regains carrier despite the secondary NIC
regaining a link.

This change, when merged, needs to be backported to stable kernels.
5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable

Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events to the NCSI controller")
CC: stable@vger.kernel.org
Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ncsi/ncsi-aen.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,11 +89,6 @@ static int ncsi_aen_handler_lsc(struct n
 	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (had_link)
-		netif_carrier_off(ndp->ndev.dev);
-	else
-		netif_carrier_on(ndp->ndev.dev);
-
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;



