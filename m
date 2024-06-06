Return-Path: <stable+bounces-48488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803328FE936
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14551C22DE5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E69B19925A;
	Thu,  6 Jun 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1KWXrhf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52819925E;
	Thu,  6 Jun 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682993; cv=none; b=tWXtb7SL/Ilb20A5bxMpY8muvOSkkNJBLR4ytlo/nxFkRH//AQzPuyqLhsalR51VHizUlcTX7eVoF7WZShT7xYif6PAMtce8LLLSIvDM4btmp7CLVwkx6UjckqavVGBV1L+tl2mxreAhydz+EEhxXtxNGOz4mxE3N5ROejmsWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682993; c=relaxed/simple;
	bh=r+VYGQ4ezkwMQf8xVtmbWBebhuf0OIfF2MU1SHsoWSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYQI4WTYx3JGWaVVpsHP+DSr2BMVWBaxDnRpYkjDfPUMRZjC0wfX9s8AoQSiRPsfKKMdSLB19nwdOsaWSDoB94H9pTdNeizHZVkdVOXej3KItOsphjpMExtPV/uxNiLGBptAVKvXI4ByoJ5cwAY9lplLJlrjLU2jXaOie+kXzeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1KWXrhf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC91C32786;
	Thu,  6 Jun 2024 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682993;
	bh=r+VYGQ4ezkwMQf8xVtmbWBebhuf0OIfF2MU1SHsoWSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1KWXrhf4TZQh+Nd4Zcixj5xeUu8bEY9Y5RYCp3Eu17CiHnZLuw074pYtBVfdUP4lY
	 SaStX9l/VQC4ERW/F9Ip5CQWM2ZzLCcZJqg8hx3wT3zpTdqbvuM9bZ1kuU43sk9ew4
	 WrGn2f0opnbevumIspSiyn/9alKhKgdeIA0/RblA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 136/374] s390/ipl: Fix incorrect initialization of len fields in nvme reipl block
Date: Thu,  6 Jun 2024 16:01:55 +0200
Message-ID: <20240606131656.461010146@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Egorenkov <egorenar@linux.ibm.com>

[ Upstream commit 9c922b73acaf39f867668d9cbe5dc69c23511f84 ]

Use correct symbolic constants IPL_BP_NVME_LEN and IPL_BP0_NVME_LEN
to initialize nvme reipl block when 'scp_data' sysfs attribute is
being updated. This bug had not been detected before because
the corresponding fcp and nvme symbolic constants are equal.

Fixes: 23a457b8d57d ("s390: nvme reipl")
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/ipl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 1486350a41775..aedd256156bd9 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -962,8 +962,8 @@ static ssize_t reipl_nvme_scpdata_write(struct file *filp, struct kobject *kobj,
 		scpdata_len += padding;
 	}
 
-	reipl_block_nvme->hdr.len = IPL_BP_FCP_LEN + scpdata_len;
-	reipl_block_nvme->nvme.len = IPL_BP0_FCP_LEN + scpdata_len;
+	reipl_block_nvme->hdr.len = IPL_BP_NVME_LEN + scpdata_len;
+	reipl_block_nvme->nvme.len = IPL_BP0_NVME_LEN + scpdata_len;
 	reipl_block_nvme->nvme.scp_data_len = scpdata_len;
 
 	return count;
-- 
2.43.0




