Return-Path: <stable+bounces-156376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD23AE4F4D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5491B609F4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E731F3FF8;
	Mon, 23 Jun 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyfnx8QX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA71DF98B;
	Mon, 23 Jun 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713263; cv=none; b=k1UfsEP3QICfHZwA5NsVdG+J2rQnOEvj12A1X6SXhcrUkRSQeDERd0Y/5pcHmFmo0KwQ+Zi1Pl0Jj0NmcuW9Zyy5kWx5nnGz0Eu7yiKgC2uHYCQRnL3vAnYXFfCDFy9TbeujaF9FBXfXDi+2Xx1wQ62MVjsZQfVCmeMQWZDCy2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713263; c=relaxed/simple;
	bh=MJdxnwMGK8ogpAdEcOB2kmzDBX5+cc4mC8gOieSdrH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoG7sZUYYyaLTjfmDnZVr8oS789jp+7mJWI83uCjYpzqFSNM2Mpvi/qzfSAQ2j7JWsIF8S7mWs98G3iZsfHH2gV20ymNl5NJhGKxlKysdGF7p4NzcQsw8OpQhBEdKI2CQoqylQHXtg5Hcrn+tI/lJuoOCOGg072w380Vmfd2xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyfnx8QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB6CC4CEEA;
	Mon, 23 Jun 2025 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713262;
	bh=MJdxnwMGK8ogpAdEcOB2kmzDBX5+cc4mC8gOieSdrH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wyfnx8QX741ZlGo4DdCmpQC/McWtiC7K9Lt9tuQntMtuRT/tDlbaWw7vDPWgfqnpx
	 odXsGjGs2yNXk/lhyWg3w/TgVnQFUAt5sTVqlKJsXSuaSAqBvyOSjrMxFSzJ34vlfB
	 +D1pN44pKUowJBz48YDIXGUCi3UFT9NhIAILttzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 5.4 177/222] i40e: fix MMIO write access to an invalid page in i40e_clear_hw
Date: Mon, 23 Jun 2025 15:08:32 +0200
Message-ID: <20250623130617.489203486@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyungwook Boo <bookyungwook@gmail.com>

[ Upstream commit 015bac5daca978448f2671478c553ce1f300c21e ]

When the device sends a specific input, an integer underflow can occur, leading
to MMIO write access to an invalid page.

Prevent the integer underflow by changing the type of related variables.

Signed-off-by: Kyungwook Boo <bookyungwook@gmail.com>
Link: https://lore.kernel.org/lkml/ffc91764-1142-4ba2-91b6-8c773f6f7095@gmail.com/T/
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index a3709c4fc65d0..e4aa2a2d50e5d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1322,10 +1322,11 @@ i40e_status i40e_pf_reset(struct i40e_hw *hw)
 void i40e_clear_hw(struct i40e_hw *hw)
 {
 	u32 num_queues, base_queue;
-	u32 num_pf_int;
-	u32 num_vf_int;
+	s32 num_pf_int;
+	s32 num_vf_int;
 	u32 num_vfs;
-	u32 i, j;
+	s32 i;
+	u32 j;
 	u32 val;
 	u32 eol = 0x7ff;
 
-- 
2.39.5




