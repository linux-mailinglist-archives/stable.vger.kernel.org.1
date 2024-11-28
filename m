Return-Path: <stable+bounces-95730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E59DBA8D
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 16:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9CF281EA2
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73851BC9EB;
	Thu, 28 Nov 2024 15:33:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA571B85E1;
	Thu, 28 Nov 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808028; cv=none; b=BfjV8p0OK9jZngHuTo1XIn3kWFkdtdOYSNUknRyqEfQBoswoiBmS8PdSSUa5mux+sc2sqCOwsDpg2PtOS30lSbAsPw/DdJFVnJZCaGh1GUeOCsSoFfuN48/gpOcr6bnFydPDudKGhlSgjloF3AjN2ohs71NVkbuF8uX/MWC+OJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808028; c=relaxed/simple;
	bh=/U7kaNA2fDhFwYK5OOrGrST3PZ1U9/vnIicHP4Fvnco=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rck0e+oIvPb6DF3QxOHcf+51nIpldXxQzhA9lIMG0c7HL4zABEp2cJsuhqHiVZlYY85N5eWeYq0peMoZWj82uFVDPzGzJHdKNnee2U6/puJX03rrqkCRuVxjz9kYqsIEeb/7NYVQF4oU5NnpF6j6i65Iq3o3ouTUZgh1X0Gt0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Nov
 2024 18:33:41 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 28 Nov
 2024 18:33:41 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <stable@vger.kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Harald Freudenberger
	<freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Holger
 Dengler" <dengler@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.1 0/3] Backport fixes for CVE-2024-42155, CVE-2024-42156 and CVE-2024-42158
Date: Thu, 28 Nov 2024 07:33:34 -0800
Message-ID: <20241128153337.19666-1-n.zhandarovich@fintech.ru>
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

This series addresses several s390 driver vulnerabilities related to
improper handling of sensitive keys-related material and its lack
of proper disposal in stable kernel branches. These issues have been
announced as CVE-2024-42155 [1], CVE-2024-42156 [2] and
CVE-2024-42158 [4] and fixed in upstream. Another problem named as
CVE-2024-42157 [3] has already been successfully backported.

All patches have been cherry-picked and are ready to be cleanly
applied to 6.1 stable branch. Same series adapted for 6.6 version
will follow separately. Backports for 5.10/5.15 have already been
sent, see [5].

[PATCH 6.1 1/3] s390/pkey: Use kfree_sensitive() to fix Coccinelle warnings
Use kfree_sensitive() instead of kfree() and memzero_explicit().
Fixes CVE-2024-42158.

[PATCH 6.1 2/3] s390/pkey: Wipe copies of clear-key structures on failure
Properly wipe sensitive key material from stack for IOCTLs that
deal with clear-key conversion.
Fixes CVE-2024-42156.

[PATCH 6.1 3/3] s390/pkey: Wipe copies of protected- and secure-keys
Properly wipe key copies from stack for affected IOCTLs.
Fixes CVE-2024-42155.

[1] https://nvd.nist.gov/vuln/detail/CVE-2024-42155
[2] https://nvd.nist.gov/vuln/detail/CVE-2024-42156
[3] https://nvd.nist.gov/vuln/detail/CVE-2024-42157
[4] https://nvd.nist.gov/vuln/detail/CVE-2024-42158
[5] https://lore.kernel.org/all/20241128142245.18136-1-n.zhandarovich@fintech.ru/


