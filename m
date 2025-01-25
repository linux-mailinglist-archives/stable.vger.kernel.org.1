Return-Path: <stable+bounces-110429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C767A1BFDB
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 01:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD5D1602F4
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA43A4C85;
	Sat, 25 Jan 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j8U6aoZy"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAD8836
	for <stable@vger.kernel.org>; Sat, 25 Jan 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765171; cv=none; b=VPYlONMjLgyu3IfAwz3wbd96g20Rlh9XktmxPwCj/UzZELT1R3FNRHqnkS7SpaXbv52tPJq4/2LZWHlJNpWIa0hPoKA4Ldb9hdkGBvHPaXNbWSlAHvKnP42SEWmgr7nyyC14uANmpzp4HBS7V3dWT2OeYozFDvnyzFQFAZTgfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765171; c=relaxed/simple;
	bh=L5pE0V9HMjQOcTf/wifmJwT+PQNThjQv4744OQeWmtc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jfGOHNzh9dgZsrAp4jCP+ev7U+Dd2jJPdVcR/TVqilZyX/PIgYtCLeO9r+/P0IqhhinkwZ1bglqWwY2visEuFESj34VTISQDWdHSnc4GckK8RxKuF0fPVgi3eAdzF13idJ/YuOwixnHbL3tRozcgyoQCyFFpRH+Dt3GLCPqj0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=j8U6aoZy; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737765170; x=1769301170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HwKCi6XYmt6c849V1nKlNByFFn1gcaNhte179xkAmIQ=;
  b=j8U6aoZysx68+kYnrTVcspiruuApzusRYqfbWkV6Q6mnPo06CWpDf776
   w50bS1GQqcHlhvrpg3KAm3O03S0ZBDtKIzPGJmbV1c3EoHZdw7mppnfOr
   zqM5QJxBM3tsitgyupvZDu+Sq7tuhrQFEYIlnJzRjcu2uIhYedcIXL0f5
   c=;
X-IronPort-AV: E=Sophos;i="6.13,232,1732579200"; 
   d="scan'208";a="466704008"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 00:32:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:15456]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.215:2525] with esmtp (Farcaster)
 id afa82763-5b26-4625-90ba-ddb2b126c9e0; Sat, 25 Jan 2025 00:32:48 +0000 (UTC)
X-Farcaster-Flow-ID: afa82763-5b26-4625-90ba-ddb2b126c9e0
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 00:32:48 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 00:32:47 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>
Subject: [PATCH 5.4 0/2] CVE-2024-49884
Date: Sat, 25 Jan 2025 00:31:33 +0000
Message-ID: <20250125003135.11978-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

Backport CVE-2024-49884 fixes to stable 5.4.

Baokun Li (1):
  ext4: fix slab-use-after-free in ext4_split_extent_at()

Theodore Ts'o (1):
  ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path

 fs/ext4/ext4.h    |  1 +
 fs/ext4/extents.c | 64 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 11 deletions(-)

-- 
2.40.1


