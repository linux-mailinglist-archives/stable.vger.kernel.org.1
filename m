Return-Path: <stable+bounces-15334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F2838579
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFFCB2DDD8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91D7691D;
	Tue, 23 Jan 2024 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qGVkXVDS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF676908;
	Tue, 23 Jan 2024 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975499; cv=none; b=lpWN/KLo4lWjEJBSu6VvAMmyEQ3+zCaDKmuszZjQ0SEvU2cMZbPYz5Fqdh0zuB3z7d6B0lr7MrHyEvzG7/I2CAiNBAjfjYjfcQ9DVwO9Y9n4TvsM1ZLVBhecAyRSACkfM8a+3WtICUZepMjkf9XyuuNUJXrSqduCjpUGXVPwRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975499; c=relaxed/simple;
	bh=7J3a++afUoSmGB4FvUEe9kzAP3DO8b+cdLwbrY96GOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM74yS+Grv4jaK+sGj9tLWPfz952VdBr2/MQxkLXVPSUQbeqxg8RU82ceHEWvqaDkLGa5ChznYszQdkYSLTXq3WrJWYPRV9kDVdSLgzMdxTh8/sgwtAKnpVbVnqAE/5CbW3grqv+vdxcYh0d+eFoAgzoZFeqUk3EZ6Pz9bvyH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qGVkXVDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46096C433F1;
	Tue, 23 Jan 2024 02:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975499;
	bh=7J3a++afUoSmGB4FvUEe9kzAP3DO8b+cdLwbrY96GOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGVkXVDSvr2zm0Q+Bwh0cZd626mb4wD4AIDt1Lq3hkFQzOiy8qBxbZ+en00Nq31s3
	 zFh0n38sHFtHrqTNg5V/p1R8mkZfbJxzcidLyymUCpDCg8NrCEpfAHjWWZdaJWzIk7
	 OIwFsSSW8sKwIXIkzScQ58ZIwMmZMGNPCvTM3EKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frederik Haxel <haxel@fzi.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 453/583] riscv: Fixed wrong register in XIP_FIXUP_FLASH_OFFSET macro
Date: Mon, 22 Jan 2024 15:58:24 -0800
Message-ID: <20240122235825.836824726@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Frederik Haxel <haxel@fzi.de>

[ Upstream commit 5daa3726410288075ba73c336bb2e80d6b06aa4d ]

During the refactoring, a bug was introduced in the rarly used
XIP_FIXUP_FLASH_OFFSET macro.

Fixes: bee7fbc38579 ("RISC-V CPU Idle Support")
Fixes: e7681beba992 ("RISC-V: Split out the XIP fixups into their own file")

Signed-off-by: Frederik Haxel <haxel@fzi.de>
Link: https://lore.kernel.org/r/20231212130116.848530-3-haxel@fzi.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/xip_fixup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
index d4ffc3c37649..b65bf6306f69 100644
--- a/arch/riscv/include/asm/xip_fixup.h
+++ b/arch/riscv/include/asm/xip_fixup.h
@@ -13,7 +13,7 @@
         add \reg, \reg, t0
 .endm
 .macro XIP_FIXUP_FLASH_OFFSET reg
-	la t1, __data_loc
+	la t0, __data_loc
 	REG_L t1, _xip_phys_offset
 	sub \reg, \reg, t1
 	add \reg, \reg, t0
-- 
2.43.0




