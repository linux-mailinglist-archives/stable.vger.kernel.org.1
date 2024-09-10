Return-Path: <stable+bounces-74448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AAA972F59
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E721C24113
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041EE18C344;
	Tue, 10 Sep 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRovMVNk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3B13AD09;
	Tue, 10 Sep 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961834; cv=none; b=RtKWx7O2uvLIIlf1v97K3AIhPx8l8oPn4zIovR2Guikn4SIWnfo1rMG1rihNB50bc1RUitf9T4F5T8/zyr0vzGAPZA0b5f8774chPJ7lXJsaJ3tlTQ8x/1H/Zu+rOr7MNvKQiuca3tF8Z4skkau+Fx6WZCzU65mtg0LTv+sjK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961834; c=relaxed/simple;
	bh=AwhZ8/pKCAKxpYxxMTQV2fJmuSm/yZj6pYU58zEhKDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSH3VCJCd16sfIK7kAvSZoypy2ypVYGA926xd8Za2JFAkjblf0b/9fzg5H287DmHH95qbcbQSe6oWlBFBY/K0MKhLLcdVdJpFBbovReO+tP92mXlCQMwbt4GrLrAylDaUbQEWQiSn5XDKku9632b6ZWnXX9r3G+kIAKZUemsVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRovMVNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35919C4CEC3;
	Tue, 10 Sep 2024 09:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961834;
	bh=AwhZ8/pKCAKxpYxxMTQV2fJmuSm/yZj6pYU58zEhKDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRovMVNkxyoj+v1cTtd35c9hOkex+QKf3II0kPCM47UWUxBWpT6GQ35iCwE4pSAms
	 NWY1pL1EocM7CFaX5KaY6Mr+hATJw0iXXUG+td7/soOQzzR6NvTdgAQKpX/h+waP09
	 ClmSA00DLIg2V2jKJ74C92hMvn5/IO6EF7DJMDRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 205/375] iommu/vt-d: Handle volatile descriptor status read
Date: Tue, 10 Sep 2024 11:30:02 +0200
Message-ID: <20240910092629.392788318@linuxfoundation.org>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

[ Upstream commit b5e86a95541cea737394a1da967df4cd4d8f7182 ]

Queued invalidation wait descriptor status is volatile in that IOMMU
hardware writes the data upon completion.

Use READ_ONCE() to prevent compiler optimizations which ensures memory
reads every time. As a side effect, READ_ONCE() also enforces strict
types and may add an extra instruction. But it should not have negative
performance impact since we use cpu_relax anyway and the extra time(by
adding an instruction) may allow IOMMU HW request cacheline ownership
easier.

e.g. gcc 12.3
BEFORE:
	81 38 ad de 00 00       cmpl   $0x2,(%rax)

AFTER (with READ_ONCE())
    772f:       8b 00                   mov    (%rax),%eax
    7731:       3d ad de 00 00          cmp    $0x2,%eax
                                        //status data is 32 bit

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20240607173817.3914600-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20240702130839.108139-2-baolu.lu@linux.intel.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 304e84949ca7..1c8d3141cb55 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1446,7 +1446,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	 */
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
-	while (qi->desc_status[wait_index] != QI_DONE) {
+	while (READ_ONCE(qi->desc_status[wait_index]) != QI_DONE) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
-- 
2.43.0




