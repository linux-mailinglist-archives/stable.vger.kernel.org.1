Return-Path: <stable+bounces-140759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0297AAAF34
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E943A535A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF98A28A70B;
	Mon,  5 May 2025 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2suoZh/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915032DFA23;
	Mon,  5 May 2025 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486160; cv=none; b=IcMAIQLL0CTn8W6EhkWFfK0AT4LGnR9a3c/x3APG85zaorG2aJyrldEbRDFZAQts6qmIPvJ50S9mGLot//PSd722DaXQA59Ni8dD57O16Z0UpSQ5Jn1oHwB7Ce4FR9m24XSMerxGdhgpIPGUs5oQtfRIec2NgYruhU2qL38PzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486160; c=relaxed/simple;
	bh=D/r/hSjmZp9qNL7wF9FusFAnmVmbgEPC6MUHKcJAZTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJGvlCHbSHQhfpYhi/F+G2AlGXAB4eZOHLZepybB08/6jmEzjXRVwZ1RQU7e8Mw67ysulmRQnGPjPvJ+CYZ9KaKuIoDkJNIcR+ia0a9lf5b29JhV3+TmgULmw+gkxDIUV2HP7p32xQwCzEcinnIpvHntDtsdMn/92l9zVYO2fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2suoZh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4BCC4CEED;
	Mon,  5 May 2025 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486159;
	bh=D/r/hSjmZp9qNL7wF9FusFAnmVmbgEPC6MUHKcJAZTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2suoZh/TFeb3LowHuuA04Oq7Ctoyu/CCnuz9UYfo7V2QpXqoTOpdrdZxSMNXXrKg
	 EyBb+UIprjehiGJ+v4bLotCKAfzmPURJeLMrJN0wwnmAxm7QAmY94wTWmqj+f5PqJD
	 +I5Ve1o9WTbCDdRoHT3Ay2rN8j7OlBOB08uprgr1O1nKX4gjV66KB19Y6GmSSl0SwG
	 4coQiQIFtNiXEhqXIFpTaLxlrGQ7PhPg9mrqP+KqTpIOF54d4vFsWj+hbTC5d+bZ26
	 hRopoh1IbAQAKjqTSId02yH/AxMG/wDAA7oHoG2iVCTpHHYobgXpAG3CBnxzCj062o
	 pBIyreXGpKPhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 184/294] i3c: master: svc: Flush FIFO before sending Dynamic Address Assignment(DAA)
Date: Mon,  5 May 2025 18:54:44 -0400
Message-Id: <20250505225634.2688578-184-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit a892ee4cf22a50e1d6988d0464a9a421f3e5db2f ]

Ensure the FIFO is empty before issuing the DAA command to prevent
incorrect command data from being sent. Align with other data transfers,
such as svc_i3c_master_start_xfer_locked(), which flushes the FIFO before
sending a command.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20250129162250.3629189-1-Frank.Li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 3cef3794f10d3..3d1734849e0d9 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -841,6 +841,8 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	u32 reg;
 	int ret, i;
 
+	svc_i3c_master_flush_fifo(master);
+
 	while (true) {
 		/* Enter/proceed with DAA */
 		writel(SVC_I3C_MCTRL_REQUEST_PROC_DAA |
-- 
2.39.5


