Return-Path: <stable+bounces-91301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34669BED63
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695151F252A8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7231F9A96;
	Wed,  6 Nov 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBJdNOcH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8591F943B;
	Wed,  6 Nov 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898332; cv=none; b=kT1AW9SPCSjq7MlLn449xxOhrx/s8h8bf2j5EcHLwOH9O8zsNUhM9mdK338F9S5ZWktzNM+dYh2Epzze5TvpyBq8wldD2ErvJ4QwWnlTUntnrHG5Ev7GoI4TFAcLPixw2S5jNmEHX6oA1Rz7t/e+1HLEejofsFkN4bEA3WkP8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898332; c=relaxed/simple;
	bh=QCx79Hx/dv2vKrBd1Hr0m5Co7Y8Ggr3kI68B0bRqUug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjNNtt3oyAzp38KTBej5Vr+IwAqVasg32QbId4c3gQ6DQ8EpTNsVMC2GjPuV2kgXbhenMaDvkE5oqD8UuPnz+jjtAMYqhG8nAOMEXyPYre8RvQ0i+NLkwGUZRpKrRNAOHK8ER6ACeL/I/7lY59AIvJg2KVaQFmY+m9erixwyh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xBJdNOcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DD3C4CECD;
	Wed,  6 Nov 2024 13:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898331;
	bh=QCx79Hx/dv2vKrBd1Hr0m5Co7Y8Ggr3kI68B0bRqUug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xBJdNOcHrSj5NjyvrC1+754FisrKhErEyQOb1KWGUV5snK3IbaWCK4yvuLr72WndI
	 EY9FpLnNdF/7OXB0V75Ju+3s21TAk4Gq3QVCMZrylCwFLsCLd1AxPOceotALv16zGX
	 FSLv8u8xxWu1t/GEEFMpEib3CY3IS+1VBStEuUTw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 203/462] wifi: rtw88: select WANT_DEV_COREDUMP
Date: Wed,  6 Nov 2024 13:01:36 +0100
Message-ID: <20241106120336.530792582@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 7e989b0c1e33210c07340bf5228aa83ea52515b5 ]

We have invoked device coredump when fw crash.
Should select WANT_DEV_COREDUMP by ourselves.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240718070616.42217-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 33bd7ed797ff7..474e0c3f35558 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -12,6 +12,7 @@ if RTW88
 
 config RTW88_CORE
 	tristate
+	select WANT_DEV_COREDUMP
 
 config RTW88_PCI
 	tristate
-- 
2.43.0




