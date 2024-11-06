Return-Path: <stable+bounces-91702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9881C9BF48F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D4DB2290F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540152071FD;
	Wed,  6 Nov 2024 17:48:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB52205137;
	Wed,  6 Nov 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915320; cv=none; b=JFrIcT9V/1UB+UexwYsZp3SC1BGWS9kiVnzf61RG/Txc9M5//yvCopye6ZP3iuAUeoQyMcQf1QJSqcLU4cbJ/6bl03X0iIMuu5L0QqfBUn/2zEBMF+23aHubXH+K+UgrOjvTskZuy9xNFcOQ5PBStsYVp6Qcrg7tVPuvNT5pX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915320; c=relaxed/simple;
	bh=WWfBHFK+jLZnFSbEFbWhnPgVSxpHMDxrTGKKTdHZ1gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C49/bqP0b34jlXHIbOkffJHGe1nE6T+HfgiPHCq9M6QuAvfS9+3Bghqf0ItK2zcViZHTiZORiQx5Zr0iFBGR0JsN1VaHHD7l5utYmrqewwslxNEAzC0CHFvOvIGjXxS08MF/lTEO15e3w0rNS+vVXpEU/dOZlxbd9ggbAwhwRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id C3C911F9E7;
	Wed,  6 Nov 2024 20:48:31 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 20:48:01 +0300 (MSK)
Received: from MBP-Anastasia.DL (unknown [10.198.46.47])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4XkCNK008Pz1h0Cv;
	Wed,  6 Nov 2024 20:48:00 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	lvc-project@linuxtesting.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Christopher Covington <cov@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1 0/1] arm64: esr: Define ESR_ELx_EC_* constants as UL
Date: Wed,  6 Nov 2024 20:47:55 +0300
Message-ID: <20241106174757.38951-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 188998 [Nov 06 2024]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2024/11/06 15:41:00 #26827080
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Incorrect casting is possible in 6.1 stable release using ESR_ELx_EC_*
constants.

The problem has been fixed by the following upstream patch that was adapted
to 6.1. The patch couldn't be applied clearly but the changes made are 
minor.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

