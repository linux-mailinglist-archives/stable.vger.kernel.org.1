Return-Path: <stable+bounces-74353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E907972EE2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808EC1C23DE1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA118C021;
	Tue, 10 Sep 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dLPy8HGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C817BEAE;
	Tue, 10 Sep 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961559; cv=none; b=AZqr3T0mbQMQe+Nv7ynlCdimC6s9YVsZF3V+HZwgD98BmkxKFrq61kMfgKvoVM3+KfZDe7UFm2PNriaN8v5hIw6XOg/i6JHjDoAqk5UypRb0NirC/QdQ7zQUxa0VjKeP/8f/NM6BzKfSWSO3LWdL5Ks/ZtlvsaDv2OJ8ry/vdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961559; c=relaxed/simple;
	bh=0S76bNUtu/cwnZKcz84SW0nMCEeB1hjeN/vZL8Wuetw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5IV25VWpW9kujWsF9Y2TW5fL5/xG9kOCHMRvMu72lXB3spri8lAAM4MRtNL7bw0J7sjIvqHSG5Lw5Z26mXz+Kt1KkozWVbO5rNlBmHYBNnXF0ZBINlDspZFxZEkoJoIVVTSMFdeRsBRwMbln2ESi1uxjWofKBc6KOeVhUCiZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dLPy8HGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627BEC4CEC3;
	Tue, 10 Sep 2024 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961558;
	bh=0S76bNUtu/cwnZKcz84SW0nMCEeB1hjeN/vZL8Wuetw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLPy8HGD6nPWrh65JAnZBqdSbiV3aML08uOPODtN444oQd4gcFn+mLQuuN29LT+p8
	 e8Pn3QhP0LVaT/1r4cuS/dKhyBL5YOqDogiloYF1CUQTRPye4FnKfQ/c+5vbZrr3uX
	 0yH8Tx+79T3rgwvX+g9ca0zjufR+A8yasn7SY834=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rakesh Ughreja <rughreja@habana.ai>,
	Ofir Bitton <obitton@habana.ai>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 103/375] accel/habanalabs/gaudi2: unsecure edma max outstanding register
Date: Tue, 10 Sep 2024 11:28:20 +0200
Message-ID: <20240910092625.844649635@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rakesh Ughreja <rughreja@habana.ai>

[ Upstream commit 3309887c6ff8ca2ac05a74e1ee5d1c44829f63f2 ]

Netowrk EDMAs uses more outstanding transfers so this needs to be
programmed by EDMA firmware.

Signed-off-by: Rakesh Ughreja <rughreja@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2_security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
index 34bf80c5a44b..307ccb912ccd 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
@@ -479,6 +479,7 @@ static const u32 gaudi2_pb_dcr0_edma0_unsecured_regs[] = {
 	mmDCORE0_EDMA0_CORE_CTX_TE_NUMROWS,
 	mmDCORE0_EDMA0_CORE_CTX_IDX,
 	mmDCORE0_EDMA0_CORE_CTX_IDX_INC,
+	mmDCORE0_EDMA0_CORE_WR_COMP_MAX_OUTSTAND,
 	mmDCORE0_EDMA0_CORE_RD_LBW_RATE_LIM_CFG,
 	mmDCORE0_EDMA0_QM_CQ_CFG0_0,
 	mmDCORE0_EDMA0_QM_CQ_CFG0_1,
-- 
2.43.0




