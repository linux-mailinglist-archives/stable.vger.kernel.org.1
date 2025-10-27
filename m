Return-Path: <stable+bounces-190054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00157C0FA9F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2BF14EDF59
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59145316182;
	Mon, 27 Oct 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5sauO89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E562D4B4B
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586309; cv=none; b=u59SWsF/fHiYRpBITTjyQpBfqTDfl6sBSYQqU1ovOkID+e/XYeOIcyC812wENrcl6rrGZSLBoYEj3LlV+VvcJZHsb6r7EyQKxxkExrTUktmGgyaAyiO+MYuDV0VG+hGYBvtSijn2mziZGkpAUZFVUdJU/rn6VfJR0Pw7BzQrOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586309; c=relaxed/simple;
	bh=V0mYzgJ7yGRljKMAIZLCucOM55qx4iwM8oW1ieCk1ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaXXuVq4qkma7k1LPYoXZeaEMeeaVUmp1b1mxgDwNkyOl5ONKznfr7p2aveBeLDQoefNS0q/tSePZDUVjK/4aWACp74ujMugXZD6YGvhGuV7UhRvnxadwlyNGaH1gqwkJvdXWo5x1/EOlL+XDWgZYwbVmUIdRA6m/ouTbjoXWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5sauO89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F884C4CEFD;
	Mon, 27 Oct 2025 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761586308;
	bh=V0mYzgJ7yGRljKMAIZLCucOM55qx4iwM8oW1ieCk1ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5sauO89epNgAryJ9HS8Sg/jbqY5Sk9Z7FYqFgEvSpySv+vzXChoDceB2ThCdEQW0
	 dHUa1JQ3ndzki2xilmecZDUjR7ZfICQkvLAwXkcFGACr/H5WKad8zWQMkx9YHivNIX
	 Jo42zHZDZpJMFmSt20O0bd6f3CdgJdmSBroahVJKBOpq+KOMZP47HTMOiI6rnbg3Oz
	 5T70qfCa8Ws2J8hUAr0B0BA9BOkV/+e9uzaE9c3e08MSGyaCXIujQvH8kLGpUOsoTE
	 gpnysdkw4YR9vkNPs4dyD5CHb/pkHRjKj/V4Zug9cJ+RXrvXqS1W3o937qMwsqncCV
	 tnZYFvQ6LGEfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] serial: 8250_dw: handle reset control deassert error
Date: Mon, 27 Oct 2025 13:31:45 -0400
Message-ID: <20251027173145.608096-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027173145.608096-1-sashal@kernel.org>
References: <2025102700-impish-precook-5377@gregkh>
 <20251027173145.608096-1-sashal@kernel.org>
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


