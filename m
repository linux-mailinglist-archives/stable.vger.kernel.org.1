Return-Path: <stable+bounces-56619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BF4924540
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3325F1F22B00
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9B1BE24E;
	Tue,  2 Jul 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/yaxbSk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BB39847;
	Tue,  2 Jul 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940789; cv=none; b=oVRERMZZXC3xaynGemrtXV9iFVyJrg3Yqr2vqYT5MhQ5LV8n+oP8e1Ryyj1UWWsPFFLPWU9HctzWTjHV4eBthpza9v6/YssNGohiSiA7DtU6AdJDC2YCsXeSvBegLxBOgyqO7KmWbxVaBdzcakU6NK6FpLz8ITuPFNC1TEF8VaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940789; c=relaxed/simple;
	bh=WmlYWkJjDlgzDfkf/2NfeGkMBea0IDeA4aj1IRS24Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcSvS8kAe8wePcRyKQ7RPfMxGX7P0bM9c8TD1O0LNQZ1MIkHxtfGJYFTuV7HGargjU5LCiNrZ7Bl2ADO2ikXhmfvPwSeZWEbeLKR2jthD7XTK9+x2sw+RrWvyiOHxsXJj1Crvz1sb/sEPX3N0wAWUbT2x8962HNB9Cx5WbQ1Gaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/yaxbSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D225DC116B1;
	Tue,  2 Jul 2024 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940789;
	bh=WmlYWkJjDlgzDfkf/2NfeGkMBea0IDeA4aj1IRS24Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z/yaxbSkyzdoN25vxkzX5OBn1uLxNoTUUGBBYGBp2ga6B+//Isoz+f9JR3amu4nag
	 7y+nznr+XS4MGZJzQ7nQpciZw4eb/ytV4qZWpw7Ple/tOKGJ75n3uQ/lgn9Z/JRWG1
	 Xe5KV78Hyn1LQFl+Pe5qXP9sN83sgBB2sYXuHZjU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Keeping <jkeeping@inmusicbrands.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/163] Input: ili210x - fix ili251x_read_touch_data() return value
Date: Tue,  2 Jul 2024 19:02:00 +0200
Message-ID: <20240702170233.293255106@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

From: John Keeping <jkeeping@inmusicbrands.com>

[ Upstream commit 9f0fad0382124e7e23b3c730fa78818c22c89c0a ]

The caller of this function treats all non-zero values as an error, so
the return value of i2c_master_recv() cannot be returned directly.

This fixes touch reporting when there are more than 6 active touches.

Fixes: ef536abd3afd1 ("Input: ili210x - define and use chip operations structure")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Link: https://lore.kernel.org/r/20240523085624.2295988-1-jkeeping@inmusicbrands.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/ili210x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index ad6828e4f2e2d..ae7ba0c419f5a 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -261,8 +261,8 @@ static int ili251x_read_touch_data(struct i2c_client *client, u8 *data)
 	if (!error && data[0] == 2) {
 		error = i2c_master_recv(client, data + ILI251X_DATA_SIZE1,
 					ILI251X_DATA_SIZE2);
-		if (error >= 0 && error != ILI251X_DATA_SIZE2)
-			error = -EIO;
+		if (error >= 0)
+			error = error == ILI251X_DATA_SIZE2 ? 0 : -EIO;
 	}
 
 	return error;
-- 
2.43.0




