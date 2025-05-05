Return-Path: <stable+bounces-141358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFF0AAB2D4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D411C01F5C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CCB43F3B9;
	Tue,  6 May 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXkmY7az"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7B3703A4;
	Mon,  5 May 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485894; cv=none; b=WR32ufEA42vhEPOwIJJTQocmBn1ETMK+JAPJmYuFUNyDcQL8Sg0KrjEXvLKkXD6OKjTtEyqdJrFL2q8CYwRWwWtviDx8Im/JqLoTtIlofbtw60wDyls30VXjVYfrmZkJMm8v8S/SlHSsZckRQez9bPsKtRk5yTHe9PIz/0KbhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485894; c=relaxed/simple;
	bh=LVkJi8mchCIWcADcYyvzANclyip1P0il3Yw/lKBvEI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUB3ow8WDnlbTx1uSo8gxqbHrOASGUMEYsxl7jdLN7Gg0tPFxMN548euHJvpzFlL4+Aato+Dc+/3xjkwZGpS2maBypmOvJ9YkKxboNINrwr+assZQ8V63D1anAWfnJ6M9ruQ6gnzAtJr6ehQA7+FujH7lY50AGvMSRG8KGRp//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXkmY7az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC0C4CEEF;
	Mon,  5 May 2025 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485894;
	bh=LVkJi8mchCIWcADcYyvzANclyip1P0il3Yw/lKBvEI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXkmY7az9lnR6fPwK9u0nyCTXfY59o2XGVwUWqz5LsjE9ues34hfQ/Bq89TayZWNd
	 ZyKirQ3ICvdNGG1wktI+hjVkeemUVlW3gC3BmRiwx8J7MfMVQZYxjo6tw1K3Vjjm/Q
	 YYHkcmtT+3RyJehSovC8dkUvX3HDzu6nCXdejYkFGwTme7AGCyuWc4OiOrioX4H4W5
	 PhFm5HtjvvjpSGCO368avmqs4pM/1rWxpsxbRBBwoNoT0eif5f9mTFJ7ABnLQcdkMd
	 a6tM3ArNoR09au+S+EVYwkQdCEglt9tfTj/rpBmWQqLMeYxuTeNm7c7pzOFbDvyU1n
	 GRtAlLJzupqcQ==
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
Subject: [PATCH AUTOSEL 6.6 052/294] i3c: master: svc: Fix missing STOP for master request
Date: Mon,  5 May 2025 18:52:32 -0400
Message-Id: <20250505225634.2688578-52-sashal@kernel.org>
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
index fa1f12a89158c..3cef3794f10d3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -503,6 +503,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
 	default:
 		break;
 	}
-- 
2.39.5


