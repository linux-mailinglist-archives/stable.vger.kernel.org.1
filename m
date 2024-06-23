Return-Path: <stable+bounces-54905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B82913B06
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C061C20C17
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C961849E4;
	Sun, 23 Jun 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0epEJFA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A91849CB;
	Sun, 23 Jun 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150266; cv=none; b=BZBeVt7obkmGDZ4Kd+xXdbssRZrqiwgEn+KdOI71kwGmYJ0XReW/iqNJTsJm1hFxVMukUDKHA6W2NZFk/TYiHslbFbh0tFuzF4+Lj5FC+1+JK7wF2FZpvOQPuOLL8kKIV7rFSvtNYV4gvM764Iygdjg6SfdgH+CYgnTuzmVPfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150266; c=relaxed/simple;
	bh=fhKGUJQllVcPbn3/3BUDDYeanVxvFBtXK0o0H+N7akA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJ8GZ48WBalyihl3zlVwLa+AtIm9/+rWJ1sb6jHzu1L6bQSloLBS8p32mAzl2L+3m1/X2g2xVSs4XJQeY5hp69nIkzmYlKU8bhrTvX2En1n9Wrr9hfnYgbHzNid9/XKhmDvwjom1f0Tl/uaHgvBCVgFBE7TBmVN9rFT8b5gxHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0epEJFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6584CC2BD10;
	Sun, 23 Jun 2024 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150266;
	bh=fhKGUJQllVcPbn3/3BUDDYeanVxvFBtXK0o0H+N7akA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0epEJFAT1QVwqFGEpQfhU5esJnnZtC84Y/+WrULaCSZ1+yR52D2109RviBYAg1Ue
	 OIVmZ7qwXfFlgDQjYWPUAEpm8rQS9PH0H5/6uMFzYXqLyVWAqkRH5xwitSWbs7dJ6R
	 9h3qEY/v3x22VevcNN0ESWolnONKBqzgx4XjNNmTv1jinmJ+3Bp5At13cEM0yY1I3B
	 830HbouojoFHmyiLqJNB4mPCuRfAlZOtQLIVCCbJfqvKD+laq5DRp1jrHTLx/uXSU6
	 q2ePPOk3mI6IDZep3VQG4ZoOJmQP/TmJk2IU9FtTW+jfhbzSZPnE0mGW7a6+XFGoA0
	 9coEhKIVodZ8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	sudipm.mukherjee@gmail.com
Subject: [PATCH AUTOSEL 6.9 12/21] parport: amiga: Mark driver struct with __refdata to prevent section mismatch
Date: Sun, 23 Jun 2024 09:43:45 -0400
Message-ID: <20240623134405.809025-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 73fedc31fed38cb6039fd8a7efea1774143b68b0 ]

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent the following section mismatch warning

	WARNING: modpost: drivers/parport/parport_amiga: section mismatch in reference: amiga_parallel_driver+0x8 (section: .data) -> amiga_parallel_remove (section: .exit.text)

that triggers on an allmodconfig W=1 build.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20240513075206.2337310-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/parport/parport_amiga.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index e6dc857aac3fe..e06c7b2aac5c4 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -229,7 +229,13 @@ static void __exit amiga_parallel_remove(struct platform_device *pdev)
 	parport_put_port(port);
 }
 
-static struct platform_driver amiga_parallel_driver = {
+/*
+ * amiga_parallel_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver amiga_parallel_driver __refdata = {
 	.remove_new = __exit_p(amiga_parallel_remove),
 	.driver   = {
 		.name	= "amiga-parallel",
-- 
2.43.0


