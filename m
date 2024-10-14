Return-Path: <stable+bounces-84502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D215699D080
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA89287094
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8719597F;
	Mon, 14 Oct 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F2O4xijk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299B3BBF2;
	Mon, 14 Oct 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918230; cv=none; b=EEv4EwYO/W3aOVYeVqz9ga/AJSfUVr/UzsloBfrdkqJH6xzRA3IEL2KcTdFbNu9zRw2dXMJZ5xaYyqmlZWnYvPzF3to823I+5HCckyxVRDPgx+zATuhJJcFsgTbijl/nbU0qotxQGHPIzbWDJTUK6GABcrx6cAncl598+v29P+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918230; c=relaxed/simple;
	bh=FHuhsALk4Yf24Q6S2E8iBNW2q9nIzDS9ZgjpI5eUeP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DchwyQKdpSnjCskFCvSFJVqDLpXDrFV6nW/lukXG6nLLlypqTDMHn8CcpH0nfkV3J0qVyu6EdjqUFjdG2SPO2aG5Um80mAmnpQvX+SsKCTru9FzEH0hMC/zhuG8oYYeyWXHgH3dapVC+s1omETVB1XL3fOK5kFF+95gqSBJN8mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F2O4xijk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786B4C4CEC3;
	Mon, 14 Oct 2024 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918229;
	bh=FHuhsALk4Yf24Q6S2E8iBNW2q9nIzDS9ZgjpI5eUeP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2O4xijkGQkZGH3Kno7oOAHrYvNr+Tsp16DN/PZG8rc1PE3zfyFwbS8xwNiiTMRz1
	 5xo/f5il8cVW4KTEKLc5x2YtyHWoP2cN7S/FwiHiMi7vg4YsPMyNrU0fwlSQpOhSo4
	 uKuL3AL0KnGoY5n8ZssQ+CUfcH7bj48g3ov+gVmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Hawking <maxahawking@sonnenkinder.org>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 230/798] ntb_perf: Fix printk format
Date: Mon, 14 Oct 2024 16:13:04 +0200
Message-ID: <20241014141226.958501697@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Hawking <maxahawking@sonnenkinder.org>

[ Upstream commit 1501ae7479c8d0f66efdbfdc9ae8d6136cefbd37 ]

The correct printk format is %pa or %pap, but not %pa[p].

Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
Signed-off-by: Max Hawking <maxahawking@sonnenkinder.org>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 65e1e5cf1b29a..5a7a02408166e 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
-			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
-- 
2.43.0




