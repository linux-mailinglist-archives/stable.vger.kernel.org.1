Return-Path: <stable+bounces-140479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147CAAA961
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA079A2F11
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC693579E3;
	Mon,  5 May 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci1MNdUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A6357D6C;
	Mon,  5 May 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484938; cv=none; b=ppF/9yv91bjpoVfELtLmTX3DlsKOEg/qzl5a/c4e7QewWjyy6HOgynRaxMuU186WvUxOWFb771GKxIsXNvRgTF8okW+vccIuwihS85bt3vn7yfmWBIcJImioz5a+1Hq3XLYvtTlNA/iYbRpu9rRjsrqfEC2lhQkDSExfbAtqkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484938; c=relaxed/simple;
	bh=6eFnS680vN2hlxIE2CQ2X6sg5pSvlbguIhhlCewL73M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hT5ffk/9rz5ednr28kL/2/Ufrfy/rc2xvbje2WxAnrsywmIOQxxZkmYTPpZ8RHcLivf3bYaZdd5IaWi6+ymXna2Xs0iSbGKC4tyg4QUNNo4C0jzzm3i+m48CUjnAQjFguDgYSNkhRqXO0MYPLw+mScPlFe4CwtSzxe5vEbOXKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci1MNdUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB4AC4CEE4;
	Mon,  5 May 2025 22:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484938;
	bh=6eFnS680vN2hlxIE2CQ2X6sg5pSvlbguIhhlCewL73M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ci1MNdUYyG4SJ4tx1WRa925jISAPdLyS3NhAeMuuBS4m8fmbSjJ2BXge+AIlNDHJn
	 QB+J2HGx4LXaNqGzfcXa3nKGq+qUA7R65r0L3TdJ2U3dvAtbNnfzxozu4Lptjnt3ay
	 q5wA0GZcH+1Ow6X2aOz/2prXXlb1PXCI4+mHZTzsHmifBO3H+6nyNwkr5sbxk1IC45
	 8sci5uw7tGOU3my2uqT799UP0E/m9hFjPGbxXizOgYOJEmTQ/S8mVmQFgiqV43aFIE
	 Xufqo5zxmf/CnrKMNfsOvUfuSex1kzWiLCT/ZdFFCwF6/og6cJOPZLaE8S+SLBWzCN
	 oz9qWdg9RplpA==
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
Subject: [PATCH AUTOSEL 6.12 085/486] i3c: master: svc: Fix missing STOP for master request
Date: Mon,  5 May 2025 18:32:41 -0400
Message-Id: <20250505223922.2682012-85-sashal@kernel.org>
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
index 7911814ad82ac..6ffe022dbb5b4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -511,6 +511,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
 	default:
 		break;
 	}
-- 
2.39.5


