Return-Path: <stable+bounces-182637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630FFBADB6A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF721944AA9
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793D2F39C0;
	Tue, 30 Sep 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H++LD+w6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B801EB5E3;
	Tue, 30 Sep 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245596; cv=none; b=WwaFX1nRvP7Xn93xg6yoBzkmQ+RItzRR7cZrGKMP2Uc9AmWnX0zR9/x1peSa8My+sudxw33pWanqnVMdFRIHDPwqfbTFAX2hyMRHFdC/O7lp69GO8cXzemQRC6/UrMsB5NzDjw6xagzNsaYRCJ2PD7EYwWhhV7zESQZOhv6t3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245596; c=relaxed/simple;
	bh=I0SxwHE8oG8uVx93qQ6NkU9uhNmTTfuFrkmI7lyOQQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiY+CffUjoSN3pgfCHK2EVL6+2d8OUbxqv5b6OjGawd755E4v5/5OFmzGJRa3vUFB2I+e1688UDyc8VaVrSWpG5pmtIDyQzpB7KbQvCU6D9ebY6Zw4+PpvO/BMdMyUTBoZzIi7GCivKF83fBU9vgwiis/31e/ZpsiSW6/6vCjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H++LD+w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C984CC4CEF0;
	Tue, 30 Sep 2025 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245596;
	bh=I0SxwHE8oG8uVx93qQ6NkU9uhNmTTfuFrkmI7lyOQQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H++LD+w6Sel3OfmKCd7VV7Nlz//3CF50PDZxMGmaJbD+QCCuK1jEDIOyo9IAmGM2O
	 3jCeLp7esjzutZnUnkjhc87/8R0cIBHqbW+uzpvv9TSG0AHDkj8jPBpgiC6Vpn9HbF
	 Ro9OF63JG/Y5SxtFjX5FMGRsdh+fkOh8h/UJmDpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Malat <oss@malat.biz>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 34/73] ethernet: rvu-af: Remove slash from the driver name
Date: Tue, 30 Sep 2025 16:47:38 +0200
Message-ID: <20250930143822.006679645@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
References: <20250930143820.537407601@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Petr Malat <oss@malat.biz>

[ Upstream commit b65678cacc030efd53c38c089fb9b741a2ee34c8 ]

Having a slash in the driver name leads to EIO being returned while
reading /sys/module/rvu_af/drivers content.

Remove DRV_STRING as it's not used anywhere.

Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
Signed-off-by: Petr Malat <oss@malat.biz>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250918152106.1798299-1-oss@malat.biz
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 254cad45a555f..2fe633be06bf9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -21,8 +21,7 @@
 #include "rvu.h"
 #include "lmac_common.h"
 
-#define DRV_NAME	"Marvell-CGX/RPM"
-#define DRV_STRING      "Marvell CGX/RPM Driver"
+#define DRV_NAME	"Marvell-CGX-RPM"
 
 static LIST_HEAD(cgx_list);
 
-- 
2.51.0




