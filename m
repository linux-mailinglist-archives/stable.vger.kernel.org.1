Return-Path: <stable+bounces-190156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B600BC100FE
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184AE1A201B3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF2321445;
	Mon, 27 Oct 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYUyvvMF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A43203A9
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590572; cv=none; b=dPPrKPkhblLTIsqoa5kX2AcMRRzPlmpRIpTQWDd5t+YPsNLP2R27ZSitzM/mjvdKY5nmymRNA718t7vpDRqxkeOf3cV55ILSabPoMNZ1HQdQQA9tNJ2JSQ187OsnWz9y5nS0fWb+j3AGdHv00oX8i2RXbWO62ils3ryloH8/G8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590572; c=relaxed/simple;
	bh=V0mYzgJ7yGRljKMAIZLCucOM55qx4iwM8oW1ieCk1ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvNamBfXiAqvuIjw67Yd/a7+qLckzdE9a3WV7rSOItkstBZNn8l20MvdKevrxh+OaGtYp8N8vM7EQfYmHyAATxqpQ6caooaO/tQXzOgMSSPleddBKjPJf2Ae1DuHXIbI5awRqYR+C14Rv0Z/FclQJb0fP9WbC0lxC/iWMKKk5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYUyvvMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC894C116D0;
	Mon, 27 Oct 2025 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590572;
	bh=V0mYzgJ7yGRljKMAIZLCucOM55qx4iwM8oW1ieCk1ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYUyvvMFJ3IIEsers4JgxajlUXiWWuLZfW9HwF/WI/i8gCiNQvIWpbnm9QrQ0gMmZ
	 F99Zytq2aArck0PurgQng2OzLsKdvzVYWga/RBdCNCwxaC1FmCtzOVBVjCa20cJGso
	 nE3yVIgNFVumTi/LJT7Bct4i4o7ZuiAv5xPLpkMDUw02LjjfFEarBg+jhnZqYmuoY5
	 pD04Bf0eo4dwnbRm10MQZqwDy9YvKB3OqOUV08fY2thJuKOBHQBbrrh+Rq3kaB7EAE
	 xOz4VKgYmee59/z4ce7Kr9WmNPgkUpw89XZKo8DWo7JuoNOeT58xvpLV8xDHBB03xV
	 SIpkadkcj1J5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] serial: 8250_dw: handle reset control deassert error
Date: Mon, 27 Oct 2025 14:42:49 -0400
Message-ID: <20251027184249.638796-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027184249.638796-1-sashal@kernel.org>
References: <2025102700-sleep-robotics-c9e3@gregkh>
 <20251027184249.638796-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Shimko <a.shimko.dev@gmail.com>

[ Upstream commit daeb4037adf7d3349b4a1fb792f4bc9824686a4b ]

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
Cc: stable <stable@kernel.org>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
Link: https://patch.msgid.link/20251019095131.252848-1-a.shimko.dev@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 6abdebb63ecbe..bcf770f344dac 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -580,7 +580,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.51.0


