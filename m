Return-Path: <stable+bounces-140833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A8AAABF3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883A53B2B56
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E7399EC8;
	Mon,  5 May 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlcW+Bl/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3A2EC88F;
	Mon,  5 May 2025 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486463; cv=none; b=gMbQqHA1V2uPAcTd2CYyZPMESIR8WpQN2VxsHNBOU5Px7TULd3NUXwfNrFzTyODk+OqEaOk06j3ngHfQbSNykSgnviATeu0w4K5nWekxkjxJ+69DfKPUWywToTT0H4sp26HF1dewpIAmihptk+0VResqStypkUtEHKf9kq19uRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486463; c=relaxed/simple;
	bh=jXEQ6PPjiMzyXTjS7YV05hzr62o6h6uD16Pq6S6UpHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rolBaSCsP9iF+U0fcPZQaAwcxk6SK/+4KaAq5SwbR+DdurfuhgLA4QfYkJYCzPIY2vtGtcS0vDdnCd6wjHir/yjdnItUP3O+jBCLUh8OsASksy5AKxu2gTjYSCU3s/fMcIogiICi5aQa93cAbD1YDyGssk2suoXInwbEcjvhbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlcW+Bl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D973FC4CEEF;
	Mon,  5 May 2025 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486461;
	bh=jXEQ6PPjiMzyXTjS7YV05hzr62o6h6uD16Pq6S6UpHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlcW+Bl/AXSX6jjIl9lwtu0qzcMCYMHXS+515TS1weEoo2RMb0Vf+tJDJpbzUANoC
	 /o5mwAqhaINbrvKVfEzTqFylZW1N+f1HjrrBIfjE2BE1MZFlSfHog5nIVmMiycCtQc
	 c+6yTW4NjHwwGV8aZuDQwRtJkVBfpGZbz0I37B/TRMf+YEHMl9Hrsh5ua/dXAHF4uS
	 pFsq85ViKVF/wLzf511za8ieb9oKD8l1z0s3kUijmXaWpiUMNdQVcONr3ySgmvoACm
	 vHGqWuKCx23VvFrki2gmH7n4gMO+abHjD3vjWU2nrsw0NXCKKXu5GbppRmP67gzj/x
	 FPFUfgNeTkWCA==
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
Subject: [PATCH AUTOSEL 6.1 042/212] i3c: master: svc: Fix missing STOP for master request
Date: Mon,  5 May 2025 19:03:34 -0400
Message-Id: <20250505230624.2692522-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 38095649ed276..cf0550c6e95f0 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -495,6 +495,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
 	default:
 		break;
 	}
-- 
2.39.5


