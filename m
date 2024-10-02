Return-Path: <stable+bounces-80321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC798DCE5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34021C202F7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBB1D0F49;
	Wed,  2 Oct 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ytieu8K9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69B1D0956;
	Wed,  2 Oct 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880032; cv=none; b=PGLjbQbnQb8JQESghU8vC4iMSUqINaU5rLLgeafeRiPRcLrbpfkV+HL0PwjmfQ0py/vzpqXF1fWy7IM9OU6r8hsiqzyCrJNXtsNrEmyXs74q1cKnHqROsM2A3iDGZWVUwNl4AfZuksxSigUJ3GIdBK1uwnVVUI56saKoeT5trq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880032; c=relaxed/simple;
	bh=kObb8Op1rHKCvLQIQzTVWa5rszgqC5kGFeqbLUTIPoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2n8CWPEYizeidHp/JOssOiA1SjsbDDdGI8rJH6zEQZ20/UPwYulCR4pi5Ck7wYmm1Y/sFP1Ggk/cP0hAFpIyS8LBEP585FOWk3zXA2MowBO5BNSzBDfG/yBJS1kp8s48yv3vDRid6bu8bszYPIrLxVM3iY4IgnFSTh+9e9VVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ytieu8K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11798C4CEC2;
	Wed,  2 Oct 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880032;
	bh=kObb8Op1rHKCvLQIQzTVWa5rszgqC5kGFeqbLUTIPoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ytieu8K9OOJ5xmBx9e64x5HEytK5RGbGKSKYLpagLI/jZ6nuAjA4/ER2SNoVnZoPk
	 nhEbkfpsgV0GuVwMbObthdCU0HuYcEXPgqyfaSJ2NgXvU2a7XrD1F9WoYhiaIn5+2T
	 D0SIJ3WuIGZIKUzW970Ek/Wu/w0drle/rqLbXySU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 320/538] RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS
Date: Wed,  2 Oct 2024 14:59:19 +0200
Message-ID: <20241002125805.060338208@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit ce196f6297c7f3ab7780795e40efd6c521f60c8b ]

The 1bit-ECC recovery address read from HW only contain bits 64:12, so
it should be fixed left-shifted 12 bits when used.

Currently, the driver will shift the address left by PAGE_SHIFT when
used, which is wrong in non-4K OS.

Fixes: 2de949abd6a5 ("RDMA/hns: Recover 1bit-ECC error of RAM on chip")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20240906093444.3571619-8-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2cdd002b71228..d226081e1cc03 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6157,7 +6157,7 @@ static u64 fmea_get_ram_res_addr(u32 res_type, __le64 *data)
 	    res_type == ECC_RESOURCE_SCCC)
 		return le64_to_cpu(*data);
 
-	return le64_to_cpu(*data) << PAGE_SHIFT;
+	return le64_to_cpu(*data) << HNS_HW_PAGE_SHIFT;
 }
 
 static int fmea_recover_others(struct hns_roce_dev *hr_dev, u32 res_type,
-- 
2.43.0




