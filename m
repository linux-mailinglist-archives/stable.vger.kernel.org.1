Return-Path: <stable+bounces-146427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D12AC4B10
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 11:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2B517CFD5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C924DD0B;
	Tue, 27 May 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mikaelkw.online header.i=@mikaelkw.online header.b="QipSeslw"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455724A055;
	Tue, 27 May 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336763; cv=none; b=tr0eC2bf2YneYo/sMStQU96XhBwN43IR+qJ7m9oRvfiJiPvWkM76TOPX+XHpZZ3VOilhndU1kn/NT2jTHqE3UlGLlyvLHJvraZDLbnW3A0z2Mxk728rDTSdN94W0r4+XeEaG0YTXyejy2XElHHU9pmijHfdd8ij4RcJOmOBQM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336763; c=relaxed/simple;
	bh=YuauqPOASLhHRtpX+GMSrLmgXOwq9QAmqyQcVsESSz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buDiFnIhK0opZR6G1B8Sx4exsRwIUcbr8n1804vOigBwn+UwG494ZBgG1Ha7j76YHY4wHAMaUxlapaiZAm6U8CRAfLtRexaxS9P/BKnBCh1CFZe7cAPwqMQyZZ222pkLg7+YtXqdsJT4/nZnIhPyrrPtZ2tAjc8cAH5R3bAjPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mikaelkw.online; spf=pass smtp.mailfrom=mikaelkw.online; dkim=pass (2048-bit key) header.d=mikaelkw.online header.i=@mikaelkw.online header.b=QipSeslw; arc=none smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mikaelkw.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikaelkw.online
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DDC803455F0;
	Tue, 27 May 2025 08:56:57 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.70.45.140])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 56B0D600B1;
	Tue, 27 May 2025 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikaelkw.online;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=pp-selector; bh=XVzcGbWpERYMml1uLAWk5RU7kc71sGLeR0bD1usT3/w=;
 b=QipSeslw/Ris0Qm4/HLYTGkoc/1pPRw5gLk8WoXClJZ8joMQFaeNuAzmdIuekbe0C5+sfZfb/s98b6n9TKvqq3jqp/NMMDkUts3mLOWFLoE3LVHfLv+GcHEUOgkz6OEge8ou1fGX2MLl/KzeHsItKD/cNHQh2j6P5sN+M4oNAdgIkiH0yubtGlige+ciKD7m8JePc7nN+5I/LOB5Dogd/MnwkwTNb2b2WKoG8R8Oor+tmBb5G8Q5wdRbQmXVBh6d8iI+Syo9az4KJsIJ8QX73ZqXBgR3eSdk6UHjTRYqcaq3Le0bwcvk5vOt9rQ8chzYThTZTJDZYe35NDkGdiBjeg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from test-ubuntu-rev3.. (78-26-16-15.network.trollfjord.no [78.26.16.15])
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A2542B00069;
	Tue, 27 May 2025 08:56:47 +0000 (UTC)
From: Mikael Wessel <post@mikaelkw.online>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	torvalds@linuxfoundation.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	security@kernel.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Mikael Wessel <post@mikaelkw.online>
Subject: [PATCH v2 net 0/1] e1000e: fix heap overflow in e1000_set_eeprom()
Date: Tue, 27 May 2025 10:56:11 +0200
Message-ID: <20250527085612.11354-1-post@mikaelkw.online>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1748336210-GI2fiDH3N2w8
X-PPE-STACK: {"stack":"eu1"}
X-MDID-O:
 eu1;fra;1748336210;GI2fiDH3N2w8;<post@mikaelkw.online>;7544ea0f74a3697a45f5192d6efff48c
X-PPE-TRUSTED: V=1;DIR=OUT;

v2: patch the correct write helper and add bounds-checking; v1
    mistakenly guarded e1000_get_eeprom() (read path).

---

Mikael Wessel (1):
  e1000e: fix heap overflow in e1000_set_eeprom()

 drivers/net/ethernet/intel/e1000e/ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.48.1

