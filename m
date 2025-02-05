Return-Path: <stable+bounces-113191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89959A29065
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2091B162D0B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2530B7DA6A;
	Wed,  5 Feb 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="osL9P6yF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C10151988;
	Wed,  5 Feb 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766129; cv=none; b=uOY8DPKGcDZNKhp8CJ68YUje1AhysTQxE/Gcq5/ir9j5a1EOnzHB+jAjMIhx32w+LxT7ZKZxrSu6ge2O4jKPBmeI0TdR1G3YPMjW1RxIogE55iimmmpU24dIwaM5/5lTNDE1eAVpoMqc4czQger8IBniuv4oqtpV3n6q7EkVsq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766129; c=relaxed/simple;
	bh=ep0An/c+E9V/tJt+mG7FrrTer5bu3vJ5Qo28ucqgcxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hl+dJkRCy7t8XVIH7pgNYDzkdsAav24vbWgjvwzNQpl0hNat7h2QfHWvK5CsFZSYFx3FkCFhxN8uj7nnenk3mHTZJzNRd7yXCZ5QIQaFsH33FuVB9njdc5hweZjztjw4Iifn0wrxMjTkoccsV51hnwQGWL8+hd4t1PPMPBTLUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=osL9P6yF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4410DC4CED1;
	Wed,  5 Feb 2025 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766129;
	bh=ep0An/c+E9V/tJt+mG7FrrTer5bu3vJ5Qo28ucqgcxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osL9P6yFr3YIyhTWWZvHH2XIZ+S9QyxkiIas/yAlX0kmTrAmU+XGbB5fj1eQYYOne
	 A32ImDUbnOvDI8b5OxQ/zuX0GQMgNFTVlI9tiartjKU+Nosyjvp42XHztPrdtH06aO
	 7Lk5F6Eo9MB9sjibz1Vx66uSJZqn7LNKPBRGA+/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	David Thompson <davthompson@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 245/623] platform/mellanox: mlxbf-pmc: incorrect type in assignment
Date: Wed,  5 Feb 2025 14:39:47 +0100
Message-ID: <20250205134505.599561703@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit b5dbb8e23cb334460acdb37910ce3784926e1cf1 ]

Fix sparse warnings:
expected 'void __iomem *addr', but got 'void *addr'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411121935.cgFcEMO4-lkp@intel.com/
Fixes: 423c3361855c ("platform/mellanox: mlxbf-pmc: Add support for BlueField-3")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/fece26ad40620b1e0beb733b9bba3de3ce325761.1732088929.git.xiaopei01@kylinos.cn
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 9d18dfca6a673..9ff7b487dc489 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1168,7 +1168,7 @@ static int mlxbf_pmc_program_l3_counter(unsigned int blk_num, u32 cnt_num, u32 e
 /* Method to handle crspace counter programming */
 static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num, u32 evt)
 {
-	void *addr;
+	void __iomem *addr;
 	u32 word;
 	int ret;
 
@@ -1192,7 +1192,7 @@ static int mlxbf_pmc_program_crspace_counter(unsigned int blk_num, u32 cnt_num,
 /* Method to clear crspace counter value */
 static int mlxbf_pmc_clear_crspace_counter(unsigned int blk_num, u32 cnt_num)
 {
-	void *addr;
+	void __iomem *addr;
 
 	addr = pmc->block[blk_num].mmio_base +
 		MLXBF_PMC_CRSPACE_PERFMON_VAL0(pmc->block[blk_num].counters) +
@@ -1405,7 +1405,7 @@ static int mlxbf_pmc_read_l3_event(unsigned int blk_num, u32 cnt_num, u64 *resul
 static int mlxbf_pmc_read_crspace_event(unsigned int blk_num, u32 cnt_num, u64 *result)
 {
 	u32 word, evt;
-	void *addr;
+	void __iomem *addr;
 	int ret;
 
 	addr = pmc->block[blk_num].mmio_base +
-- 
2.39.5




