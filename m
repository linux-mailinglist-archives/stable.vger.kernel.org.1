Return-Path: <stable+bounces-140620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9033AAAAE69
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9AC4A4F26
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CF28033F;
	Mon,  5 May 2025 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmvhBqS2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F22C1785;
	Mon,  5 May 2025 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485372; cv=none; b=R0Qd2Em+qvGnFgdQJ3X1A029NIqHULGGEGTLBOX7L0Y/Fz1a8e4T57j1FCbeU1qfKQNvMlpWPafmgxOXih40CFw1jfnHX72L61bykf8Jb0dGjN2t3RhbdVTx+eGU1BMsWM55c/TP8ZJDAmrYUlE0SvVe6VGCeIiRbuGDTTUlEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485372; c=relaxed/simple;
	bh=YVBEWd8fzTq67NZgBhRcJJ1n5ZNEhk8+BBu3Q9IDrXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psNSVhbsXzhfGP1ziDRFYZPWq6Tt3SluXVvxSldFbGMTTDuKwZUVjLUixMFDdrtxIhIXFKXIE+GE4KIv4CDlVg6CZLq6i7aetiMWqmMk0FWTRPaOdMSHFxfml1vHuFGtXZHYbmnvf4oeG48+B620KXBpmhIZDU46q5ki/9kyNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmvhBqS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DD3C4CEEF;
	Mon,  5 May 2025 22:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485371;
	bh=YVBEWd8fzTq67NZgBhRcJJ1n5ZNEhk8+BBu3Q9IDrXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmvhBqS2jPEH/9Ohwr9cbz+MQe9xVtExFodBDZ2p8Bc33w4PLzsKxQuf+TKatL9C+
	 gflKvI4U+2sZ+DNFtLeb1Ai5dSUPVkw2f0IxB7XUc0HqGi/ZGJPb0mfaKFPm+4O1lM
	 SVa6Hd0d1mYbAJVqsG4ECHBiuPzpbvtHysixi/37iCuHHI3o3lpXzqOnqHxNZIMsB+
	 DXbBb4CU2e8viVmzNLvGUpXeKe3G6ngF3TUnF8gUN57R5GWQCY5q59J5kIMpSXH/Pg
	 ObuMrTxEUyKRNFu/noZOHVbGpBXYrI3BNXB14BBb8LfmXkdf13LN1v2dYm9ogbhvIb
	 dGPy7um37aRyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 295/486] i3c: master: svc: Flush FIFO before sending Dynamic Address Assignment(DAA)
Date: Mon,  5 May 2025 18:36:11 -0400
Message-Id: <20250505223922.2682012-295-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 6ffe022dbb5b4..62913feae45dd 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -860,6 +860,8 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	u32 reg;
 	int ret, i;
 
+	svc_i3c_master_flush_fifo(master);
+
 	while (true) {
 		/* SVC_I3C_MCTRL_REQUEST_PROC_DAA have two mode, ENTER DAA or PROCESS DAA.
 		 *
-- 
2.39.5


