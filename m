Return-Path: <stable+bounces-105376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB59F880F
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 23:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954D6188C152
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 22:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570ED1DC9BE;
	Thu, 19 Dec 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="P12w3cQT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E51C9DF0;
	Thu, 19 Dec 2024 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648440; cv=none; b=V/vt/2egi+PI/uwB67h2iQpH5zWVsiqsfbS+1MaTBwVXkdiY/KkSvxRUdrMGYc4vKVVSmozLLDE8FhlH+HwW4VxNafH4JwQbmRlOfr010HEy71m/RtDSGTTC2lMJ/kFTn7NOiTCAHFanFbJBCnO1m7RQVFS+TQrkmzW5yXYWmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648440; c=relaxed/simple;
	bh=V8sVQh2GzpjQPMrZ4BpJcSrIaxPFuHtvHMLSHRGfOx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrapsR0g5VNDQRlQpGr3GJYo5BwhwxXiqKfrtHiDIMRF/iyQjgs+xDNrI41oXQtie49WJpfZDxacNsjF+pCFIVJ/oTUF+Fg6LC/GCNehugm4Vi00qdlbnQeGeQgqf0VFkzHw4lct5N96wmlazWwvSDnxHgFhYn52XPsPRf72yRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=P12w3cQT; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734648437; x=1766184437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V8sVQh2GzpjQPMrZ4BpJcSrIaxPFuHtvHMLSHRGfOx4=;
  b=P12w3cQTl3aFoT/+LtyrpaIE1Z+y5FGjP8NvXAuBpSLVHq/AIUjuZWXi
   BDAzgAZtQc3unuX1ozlrKUEVKWaUuC4mocJpY7lsGszB+x422FXq38nNE
   rROF2mPsxsSkht+yPlBSGWyruMBgldi7LWIkr7LWmuo9KIIARv7xGSz1l
   E=;
X-CSE-ConnectionGUID: tVhKrNPLRYGLnSmy3ws9Xw==
X-CSE-MsgGUID: oAtabZZKTP+dUb54DWNQuA==
X-IronPort-AV: E=Sophos;i="6.12,248,1728943200"; 
   d="scan'208";a="28263088"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 19 Dec 2024 23:47:15 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id C93A12398;
	Thu, 19 Dec 2024 23:47:14 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-kernel@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Jan Beulich <jbeulich@suse.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Anthony PERARD <anthony.perard@vates.tech>,
	Michal Orzel <michal.orzel@amd.com>,
	Julien Grall <julien@xen.org>,
	=?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 1/1] lib: Remove dead code
Date: Thu, 19 Dec 2024 23:45:01 +0100
Message-ID: <20241219224645.749233-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219224645.749233-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241219092615.644642-1-ariel.otilibili-anieli@eurecom.fr>
 <20241219224645.749233-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow up from a discussion in Xen:

The if-statement tests `res` is non-zero; meaning the case zero is never reached.

Link: https://lore.kernel.org/all/7587b503-b2ca-4476-8dc9-e9683d4ca5f0@suse.com/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
--
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Anthony PERARD <anthony.perard@vates.tech>
Cc: Michal Orzel <michal.orzel@amd.com>
Cc: Julien Grall <julien@xen.org>
Cc: =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 lib/inflate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/inflate.c b/lib/inflate.c
index fbaf03c1748d..eab886baa1b4 100644
--- a/lib/inflate.c
+++ b/lib/inflate.c
@@ -1257,8 +1257,6 @@ static int INIT gunzip(void)
     /* Decompress */
     if ((res = inflate())) {
 	    switch (res) {
-	    case 0:
-		    break;
 	    case 1:
 		    error("invalid compressed format (err=1)");
 		    break;
-- 
2.47.1


