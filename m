Return-Path: <stable+bounces-95752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023AA9DBC2E
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 19:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FED164307
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E9E1C0DFD;
	Thu, 28 Nov 2024 18:35:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2313BC35;
	Thu, 28 Nov 2024 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818929; cv=none; b=Y91VwbxLGXXkVvK10ZpdeOTMNDNKGEemOTBSqrA15LKXMAENuymjJ1DPLYMYoicc1APmPTFkc17ECCFnGMVLWZq+2MJxDzcIFfguqka9grwaK/+BkZ53SxJNwca75I511EXv6vjYhMTxdggd/bVAW5iuSUMu447Vv7f1Xjcrh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818929; c=relaxed/simple;
	bh=qp4ptKu4Z1R6OdIBX52vCTipE1Gk0eORG5tI1Ia/tNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKB/uetvLw57mgHeby+aQagDLHhOqUhZMQwkWo7mwFL0erkEWrWFT0+eZ/XlPBAJLN+UIVHKiGNoPt6wNQomgPg0oJRz76sYy5xKhb3Kwxmp/RTQ4PJGXSC+nSZzoroAocg7/pP+mJyMDEFxhdIsVcXsn+F2YGuxfbrGN11aDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Nov
 2024 21:35:22 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 28 Nov
 2024 21:35:22 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Boris Pismenny
	<borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.4/5.10/5.15 0/1] Backport fix for CVE-2023-1075
Date: Thu, 28 Nov 2024 10:35:08 -0800
Message-ID: <20241128183509.23236-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

This patch addresses an issue of type confusion in tls_is_tx_ready(),
as a check for NULL of list_first_entry() return value is wrong.
This issue has been given a CVE entry CVE-2023-1075 [1] and is still
present in several stable branches.

As the flawed function tls_is_tx_ready() is named is_tx_ready() and
is situated in another file (specifically, include/net/tls.h) in older
kernel versions, fix the error there instead. This adapted backport
can be cleanly applied to 5.4, 5.10 and 5.15 branches.

[PATCH 5.4/5.10/5.15 1/1] net/tls: tls_is_tx_ready() checked list_entry
Use list_first_entry_or_null() instead of list_entry() to properly
check for empty lists.
Fixes [1].

[1] https://nvd.nist.gov/vuln/detail/cve-2023-1075
[2] https://github.com/torvalds/linux/commit/ffe2a22562444720b05bdfeb999c03e810d84cbb

