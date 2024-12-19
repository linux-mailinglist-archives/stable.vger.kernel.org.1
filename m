Return-Path: <stable+bounces-105375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C949D9F880B
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 23:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1587A3B20
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E484C1C5F2F;
	Thu, 19 Dec 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="kzMK3Uct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040119FA92;
	Thu, 19 Dec 2024 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648436; cv=none; b=uxI2EbynIhzfqEcnYGcTRk2tH05mOwfU3aFk0httFdyn8sXX2tx+YwTSXqnARBJiFE1Uj4gFWvE1rxxNO9FlD4TsXmItso0XH/yuuU6u4f2cWuNL1kWxbaVD04xB3JwUVjJhXFn85eApO60z5A1hKPR0Wo8qVx3dob5zRVQTek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648436; c=relaxed/simple;
	bh=twcOgW39ORCy6kaIQzutC0BWyK65sKKIGGvefmUpGtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kT1gzE5sSCHGKO6ptLq3+gXJzIJ1P74vT4gI2J67yFwJ6nXpkzUU5hsAM4OSxb9qYJ/iJUg2XneiYuxuhS4/BLQ5ehLNCjXycQBD9EcN47f9cAM2hFvgdk2WaIdo7O8aWReAIeHvGWnQKQMLmOni8Ckf6DXNX9zGCFgsNdXvZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=kzMK3Uct; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734648433; x=1766184433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=twcOgW39ORCy6kaIQzutC0BWyK65sKKIGGvefmUpGtk=;
  b=kzMK3UctwkSgCGg7HUCWvz18CFniBFStTOdA2Q+kZeImPBAN5jCvobUY
   t0oakoc037aje9ZgV0umGWHltz43hPX3V8sOxTIEeQt47oDlHI+NlhTuF
   BCZdLVDHnVWGNDMHtxtloTnC1OjwXHibX3DFSXLZfP4cVC6zBXuQzfZdc
   4=;
X-CSE-ConnectionGUID: MVYnHboYSxmeIGDqDZlqVA==
X-CSE-MsgGUID: 3M+NuwlYT6WjxfuyxFg5LA==
X-IronPort-AV: E=Sophos;i="6.12,248,1728943200"; 
   d="scan'208";a="28263085"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 19 Dec 2024 23:47:10 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 407792397;
	Thu, 19 Dec 2024 23:47:10 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-kernel@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Anthony PERARD <anthony.perard@vates.tech>,
	Michal Orzel <michal.orzel@amd.com>,
	Julien Grall <julien@xen.org>,
	=?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 0/1] lib: Remove dead code
Date: Thu, 19 Dec 2024 23:45:00 +0100
Message-ID: <20241219224645.749233-1-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219092615.644642-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241219092615.644642-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch removes a dead code in lib/inflate.c; it follows from a discussion
in Xen.

The dead code is tracked by Coverity-ID 1055253 in Xen, was triggered by a file
taken unmodified from Linux.

Thank you,

Link: https://lore.kernel.org/all/7587b503-b2ca-4476-8dc9-e9683d4ca5f0@suse.com/
--
v2:
* Cc stable

Ariel Otilibili (1):
  lib: Remove dead code

 lib/inflate.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.47.1


