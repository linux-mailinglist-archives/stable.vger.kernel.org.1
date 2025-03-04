Return-Path: <stable+bounces-120230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870AEA4DBCF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 12:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C730A3AA253
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857171FF1BC;
	Tue,  4 Mar 2025 11:06:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [195.16.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2271F76CA;
	Tue,  4 Mar 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.16.41.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086393; cv=none; b=PHe7KT/iMWKF+qkUY7mKjcAiHthW6RU+Gj5sHhJR03sE9zrbbrHa0dln6McxcVkg6V4NSCclAjEeqeHa/WZzcuptSU+pnkmuh2kubG6dYFovDPpVnwJs872yIV6G+m5rZZAPDsMC+w6l7yWkQhb/EU/HUZPAuDA0Y9iN2SU0crI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086393; c=relaxed/simple;
	bh=/FJRmxqLEYsJeEWYr26Vk5w3ae6BxaP+IToKsjq0z9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7uuMxQbuxxxAVANq+EATXD10mdspTjAUyiXVLsSgRSEV9ccXlfAR57Eyx1oa15NaVsowrxXXccOiso8VA0nIWfPXpRu34Ot3BDn6e0SsT/joDBFdfx42mJndXe2k4jkjjBwaQL/p8DIiYCaERjIUzGaOJ07odcBMHMFtP+nRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=195.16.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id A26821F9EE;
	Tue,  4 Mar 2025 14:06:20 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 14:06:17 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.114])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z6XtH1zdrzkX0x;
	Tue,  4 Mar 2025 14:06:14 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 6.1 0/2] erofs: handle overlapped pclusters out of crafted images properly
Date: Tue,  4 Mar 2025 14:05:56 +0300
Message-Id: <20250304110558.8315-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;nvd.nist.gov:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191452 [Mar 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/03/04 09:41:00 #27591543
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/03/04 09:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted
images properly") fixes CVE-2024-47736 [1] but brings another problem [2].
So commit 1a2180f6859c ("erofs: fix PSI memstall accounting") should be
backported too.

The backport follows linux 6.6.y conflict resolution changes of
struct folio -> struct page from 1bf7e414cac3 ("erofs: handle overlapped
pclusters out of crafted images properly").

---
v2: Corrected patch comment about a minor fix. I mistakenly assessed
the significance of the changes relative to the backport from 6.6.y.

[1] https://nvd.nist.gov/vuln/detail/CVE-2024-47736
[2] https://lore.kernel.org/all/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com/

Gao Xiang (2):
  erofs: handle overlapped pclusters out of crafted images properly
  erofs: fix PSI memstall accounting

 fs/erofs/zdata.c | 66 +++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

-- 
2.39.5


