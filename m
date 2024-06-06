Return-Path: <stable+bounces-49137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141288FEC04
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB1B22EAA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53986198838;
	Thu,  6 Jun 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PPCSH1Hz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ADC19AA75;
	Thu,  6 Jun 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683320; cv=none; b=E1UYORNZhIG9+33bVo6mZuAIDuwhv+RjAb4GZpcSc8gsoB1Mcyu0HUQ/zMVmp7VSBaNzEy2eKStIfAhzfHGrMuE1RnKeE+r6PjaUjszjLwXzD93nuT9m4sneJP0utKUb4H5cHgbqf+6SwgHQg55K+SCQ4uN+Ahlp8p1Q9N0XsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683320; c=relaxed/simple;
	bh=EgkFqVWjJ6Rsqx1b06yO4RFrHNQ3FNr5BTlbn0m8BFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0dEvXeUU5Fty0+AkZmqIMaUinSbzSI9Pjy+Nkzlw1V0jXy39e3v2l8Y2QAhOz1J4XX5t2adDJzeenA+wmlf9kpixEQa8MEYSe9FqkVEXLHRumOydCU2PgJb9sJBDiwlCgi6jTLuHc1jKdTwcI/OlMFpcwsRzdHybXqYvAKqGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PPCSH1Hz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E514DC32781;
	Thu,  6 Jun 2024 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683320;
	bh=EgkFqVWjJ6Rsqx1b06yO4RFrHNQ3FNr5BTlbn0m8BFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPCSH1HzvSbYntIr32iTWIe2Ij2pyki5rpIrISJnLl3cRH0z3WFf2bOO0Dm0Ns5aN
	 J2XG8b8/fCnaFsd8GAMFplh4KywWlSfoT5e99dbCtYcrPdMmk6pwapR6oTKnBgAst6
	 dt7dgn2r198vWxTskA6wpiCLD3danzJxL75BZj50=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 199/473] mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()
Date: Thu,  6 Jun 2024 16:02:08 +0200
Message-ID: <20240606131706.525615657@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

From: Aapo Vienamo <aapo.vienamo@linux.intel.com>

[ Upstream commit d44f0bbbd8d182debcce88bda55b05269f3d33d6 ]

Jump to the error reporting code in mtd_otp_nvmem_add() if the
mtd_otp_size() call fails. Without this fix, the error is not logged.

Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240313173425.1325790-2-aapo.vienamo@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdcore.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 24518e5e1b5e4..ad527bdbd4632 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -942,8 +942,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 	if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
 		size = mtd_otp_size(mtd, true);
-		if (size < 0)
-			return size;
+		if (size < 0) {
+			err = size;
+			goto err;
+		}
 
 		if (size > 0) {
 			nvmem = mtd_otp_nvmem_register(mtd, "user-otp", size,
-- 
2.43.0




