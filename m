Return-Path: <stable+bounces-141605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FCCAAB4DD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667901C06B3E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242E2344FF6;
	Tue,  6 May 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU/rqBrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621628982A;
	Mon,  5 May 2025 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486857; cv=none; b=Hb6VfvGzrRNtxT1YuLaNfGh52VTPIAOyQifmMMp1JGg4CHqxeTFIIVxCRRWGZXjYSa3fjAKNMi4mxEAotJGNpsbjDnehtFL0X6+Stymp0kulmEnqNlTefMyJxZJKxvK8G4cYIakjMY/W+QAtmFrbdpIU4usscR9UYoO9jDCjxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486857; c=relaxed/simple;
	bh=0EWvK4TsmZ4hBZAMOT+xfxdc3HMMgFzeks/y6hvpEGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EheZwb3FsL13w0TdheB5s1AoK2JBAZeeE5sd9YB+9sMxBscgfRdAlIWLlmtUW7XpYFg9aNyGzo0EutPGXavEKaMX7DCwe9YJavigO67QR4qyNcYGwMpVvOihm1HSZzabdGUqWIClAiuQDHQmQS5roGqB5eLILmOsK99xYSSLImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU/rqBrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723C5C4CEED;
	Mon,  5 May 2025 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486857;
	bh=0EWvK4TsmZ4hBZAMOT+xfxdc3HMMgFzeks/y6hvpEGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QU/rqBrKUH6KumuPQzsv7iuz6wovWmMAiFAIrM9vfJO1CIXpjvpKGQen3S3pCLBOx
	 ahhooVH7vfei2Iy+Yh+SHBbLNZLgTU81f4uHZlDenC60L4QorwK1AJcZAslANCuyzG
	 PDAYHp7/1l0t96xzKGs2oZYxzDjfUAM2FUloThEmCI/t4ItzQ/HQiVE2E5nqV08z/3
	 5DqKBXBmmwAgqfNTsBtgyLXPzZh/SrKFlBXAE04Dh69qGPHQV9P7w91xEg5mwz4PZS
	 nCTbiyFfwSUqaHO2n6kllfkuJ/YF0i10LIrVF0sqtYJW88ftVuoodgEQu09KrvAkZ4
	 /JQwrl/8mFagg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stanley Chu <yschu@nuvoton.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 028/153] i3c: master: svc: Fix missing STOP for master request
Date: Mon,  5 May 2025 19:11:15 -0400
Message-Id: <20250505231320.2695319-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

[ Upstream commit 0430bf9bc1ac068c8b8c540eb93e5751872efc51 ]

The controller driver nacked the master request but didn't emit a
STOP to end the transaction. The driver shall refuse the unsupported
requests and return the controller state to IDLE by emitting a STOP.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250318053606.3087121-4-yschu@nuvoton.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 368429a34d600..92488ba5b5f2a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -437,6 +437,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
 	default:
 		break;
 	}
-- 
2.39.5


