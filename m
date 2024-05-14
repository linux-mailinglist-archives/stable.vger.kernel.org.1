Return-Path: <stable+bounces-43851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB548C4FE7
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CDC1F21458
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6CE3D0D1;
	Tue, 14 May 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Bvuz1hg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B216200BF;
	Tue, 14 May 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682666; cv=none; b=fu1vGFrdBYKaWGp/GEwTEitRjvs2FVAJkexDl9jzFMDvi1LRpPNyc0SJIFacGiwAcmg8bf8jdd7W0pQb71vBKhgG9o9O+1pPoGnzDPMZqfEu3t19Q+CBRHV5IxGLEa/Z/ZzTB+TcrTbe+uzV8zY9ayRpt+KbLeKowz0otcwcBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682666; c=relaxed/simple;
	bh=0r16vcivetjBVnNTfuXtLwicfaZreaeNAnzNixTW7A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICqeXG3N38p7uRNxTFM3+w3EaR2b6u8ALb47dD9A2qBouMqqpqepIV8A5e/xw7u35KFMmpunYVC1p4RwvjOtJsbAYNaDCxWN2KFqw2SuIQdDv8Sc/vqtMZ7voNQPHSWqvVqTDkjbUwse8DdCff7LU3DTS+gXxsNXpvM846RcjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Bvuz1hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6F4C2BD10;
	Tue, 14 May 2024 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682666;
	bh=0r16vcivetjBVnNTfuXtLwicfaZreaeNAnzNixTW7A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1Bvuz1hg9/0NLpOc6KkktE+Le2Qpj/omh/M2Jn7GmPB4xw9DRuDsScIggjGVhCEGw
	 jBU7t4TaHGUpaAT4vBn6zlULZ/YIuHOk1Y3GMxmBm0qNGbhZzY59QlB5mDB19brsRL
	 o1jp13Mc/IoAAOa1ti2HHrZ8hw3Ag4qWf6qdVesg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 095/336] firmware: microchip: dont unconditionally print validation success
Date: Tue, 14 May 2024 12:14:59 +0200
Message-ID: <20240514101042.191989462@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit 6e3b7e862ea4e4ff1be1d153ae07dfe150ed8896 ]

If validation fails, both prints are made. Skip the success one in the
failure case.

Fixes: ec5b0f1193ad ("firmware: microchip: add PolarFire SoC Auto Update support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index fbeeaee4ac856..23134ffc4dfc6 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -206,10 +206,12 @@ static int mpfs_auto_update_verify_image(struct fw_upload *fw_uploader)
 	if (ret | response->resp_status) {
 		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
 		ret = ret ? ret : -EBADMSG;
+		goto free_message;
 	}
 
 	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
 
+free_message:
 	devm_kfree(priv->dev, message);
 free_response:
 	devm_kfree(priv->dev, response);
-- 
2.43.0




