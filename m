Return-Path: <stable+bounces-3322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C367FF50D
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B411C20F21
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978654F9B;
	Thu, 30 Nov 2023 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N4sLKJ6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A11954F90;
	Thu, 30 Nov 2023 16:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7831FC433C7;
	Thu, 30 Nov 2023 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361536;
	bh=2YtktEvZdv2duc8AkNwlRV3THDhm6iLg720iTL2gD6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4sLKJ6HfT8V4XdyJ9RHZkNWaUVsDtn16MGmJy5rKN1fOCDq8evG0ecybRYYYhrPk
	 FcHvEnkM0cT2iI8zfSfbneTooDVb9APfAUzCnyczmWdmZ4yIzabtMV7De5oWGM18HP
	 URM11Tn1EouPmqjd0MROs1RWOOQwHvCUTNLzwAh4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gil Fine <gil.fine@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.6 062/112] thunderbolt: Set lane bonding bit only for downstream port
Date: Thu, 30 Nov 2023 16:21:49 +0000
Message-ID: <20231130162142.293313207@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

From: Gil Fine <gil.fine@linux.intel.com>

commit 24d85bb3be373b5831699bddf698b392bd2b904d upstream.

Fix the lane bonding procedure to follow the steps described in USB4
Connection Manager guide. Hence, set the lane bonding bit only for
downstream port. This is needed for certain ASMedia device, otherwise
lane bonding fails and the device disconnects.

Cc: stable@vger.kernel.org
Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/switch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1082,7 +1082,7 @@ int tb_port_lane_bonding_enable(struct t
 	 * Only set bonding if the link was not already bonded. This
 	 * avoids the lane adapter to re-enter bonding state.
 	 */
-	if (width == TB_LINK_WIDTH_SINGLE) {
+	if (width == TB_LINK_WIDTH_SINGLE && !tb_is_upstream_port(port)) {
 		ret = tb_port_set_lane_bonding(port, true);
 		if (ret)
 			goto err_lane1;



