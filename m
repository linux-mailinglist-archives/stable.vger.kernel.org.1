Return-Path: <stable+bounces-131264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AEDA808E9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9AD1B63E2F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B8226E143;
	Tue,  8 Apr 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceEYFHQi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F526B2C7;
	Tue,  8 Apr 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115928; cv=none; b=bf/Km8H4wR1jy4IVdCmKQUmmNuPY5Xdl84QUYpEk0DCRkv4khMeqF/R0QjGDJ4NGVdJArHdZ/cfjhyQmqTZzGgfHBfuWcRs3183QRLfdGZ16aSdyXIh7GIgCg0ARkPp8GUozOmByVbFf6qkIr50XJjpjlAmlqcYDC1CiTMvMlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115928; c=relaxed/simple;
	bh=NJeMUQzMqx62RGRtz2xbxvXr9yr6cGMUfg7QZEqKI+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtP/Jcgw1tK4QUQf0uerA5fuMK995og5IWm/LJa4vzy1DKGRD2/e614H3yHnZ6AVaLFWo7cVrSloFdED2GMdO7NBK1ldngVtBSKSAR75DemSI7DeLp6JPftxqE0QtqYXv3w3KuIPpipGlnwme2oTVIntAWtEE3rDFZ/5CiMByHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceEYFHQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFBFC4CEEA;
	Tue,  8 Apr 2025 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115927;
	bh=NJeMUQzMqx62RGRtz2xbxvXr9yr6cGMUfg7QZEqKI+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceEYFHQiC9VjZVVnhS3BRhW7JwOznRTyvhTIYAoSs2ddi8QhziZTrjle6rqQwDBTs
	 qff1se5ZSg149xrBMbbQS3F79aP2pSY8fpymrSy2yBWIhpDqqdGuSKbYa5IFKQkHs2
	 skG91T1rACUDphfQxNVIdQHwXl/TJMGZ6w/AUJtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20 ?= <Yeking@Red54.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/204] LoongArch: Fix help text of CMDLINE_EXTEND in Kconfig
Date: Tue,  8 Apr 2025 12:50:49 +0200
Message-ID: <20250408104823.805410058@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

[ Upstream commit be216cbc1ddf99a51915414ce147311c0dfd50a2 ]

It is the built-in command line appended to the bootloader command line,
not the bootloader command line appended to the built-in command line.

Fixes: fa96b57c1490 ("LoongArch: Add build infrastructure")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f4ba3638b76a8..0166d357069d9 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -310,8 +310,8 @@ config CMDLINE_BOOTLOADER
 config CMDLINE_EXTEND
 	bool "Use built-in to extend bootloader kernel arguments"
 	help
-	  The command-line arguments provided during boot will be
-	  appended to the built-in command line. This is useful in
+	  The built-in command line will be appended to the command-
+	  line arguments provided during boot. This is useful in
 	  cases where the provided arguments are insufficient and
 	  you don't want to or cannot modify them.
 
-- 
2.39.5




