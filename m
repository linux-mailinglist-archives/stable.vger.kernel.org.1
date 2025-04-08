Return-Path: <stable+bounces-129718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0EA801C2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577CC16DBFA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC5269AE4;
	Tue,  8 Apr 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mF1JuC7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A87224F6;
	Tue,  8 Apr 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111794; cv=none; b=tE5yONx7jctPWq3ymOqmxLswymQN8JV9qoD6wlfNhdh60WUPHemgemQVjtg2keIiG7CwIwV0VBVd287saIYcJRVDSlz/Q8l/4sqPhm3BcWClJlWQMO1wgdYh0wYYknBl/IAYBT1q6WllRJG4KQ7jzMe3Ofe1Pkv/xNb+hrV+cSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111794; c=relaxed/simple;
	bh=DNPBfZb256eirFeuhmrc4sSUqD52UdZXxAy5z894foo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QV3e5LYG6YbsP68399i45t6+M/fYq4QQKsGB4xB6YkP+xzvfjD0Ip1uiGtbHesku+Fe64tdmAoDTPfVltfvbugfWwoxhHjSswkVqYT2eV9hgJZqult2Ns0gaugCDEDAYKvKqlAS+Sih/4HrV4JpXCmvKvnoqCKK5299EEFM/VoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mF1JuC7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08D2C4CEE7;
	Tue,  8 Apr 2025 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111794;
	bh=DNPBfZb256eirFeuhmrc4sSUqD52UdZXxAy5z894foo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mF1JuC7U/qGF/1pyWxeo7aCG0GFTkspoEoS0RMcNWZHQMtjb96RFfSIYf/g31o22e
	 VMa0p6+MAoc+fI42fIUdYw+nhNDMO3KOx9cx6LOOG7rICpkmGKEmni7m4zuDLAiOMf
	 S4lA3WxAx3NHn5O8S4daY3mQQI9Qe47Rl4i/M6V0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20 ?= <Yeking@Red54.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 563/731] LoongArch: Fix help text of CMDLINE_EXTEND in Kconfig
Date: Tue,  8 Apr 2025 12:47:40 +0200
Message-ID: <20250408104927.369492715@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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
index 2b8bd27a852fe..bdb989c49c094 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -382,8 +382,8 @@ config CMDLINE_BOOTLOADER
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




