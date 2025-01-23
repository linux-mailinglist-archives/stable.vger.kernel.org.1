Return-Path: <stable+bounces-110272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CEDA1A459
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F4D3ABD12
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD54520FA91;
	Thu, 23 Jan 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HGSRykSr"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DC20F998;
	Thu, 23 Jan 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737635600; cv=none; b=Ez8h5os5VfHbi0nW/UXel3h/w1AAgC0jJ+oo8qaRL7SNpt2G4zmXFHG9jfin26RTYt8BcbSQVBe0sVBHYSh3WFyRnVsfxJDhlwlkzXLMoJuyo3PWAcNhiumOiH+hTXie7XI7/jQ5CkWIA/nanU2+qZ39X4xJQEUNL7TP0rs0mFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737635600; c=relaxed/simple;
	bh=C7yAxwNOJhR5ZUY/4+Hi83tor/0lXnWfYviV9iH2+HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bS2I3n0VtnzR0LEshR1cwcC8IGFT1R8n1F9ZgPfy134F04uj+1kU8q7hsmkdk3d/3PKi8Ra5xObtpv0gIgBbaBnCEr3SzWmvBhr396fMTzVaqWb/QWx8eQL2b3S3ABXv4IcBPfDu5muZbMYvAs6iYuaSnLzR7QkleFQ5sfP6Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HGSRykSr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dn0Qmm3YjXebpTIvQaz7gZeWlcXp/17xwRMzaRLNhIA=; b=HGSRykSr6WzpR23l1Nz7gw0K/P
	eFejM6yC9zAx1XXkPh28P1IjtIORnzIlXhZNvpv9hCN6BBzXjHWG8G0nAJDmQwPZwRNV2WKFhdF1Y
	cxKHp8zepSTXNzpWbiSE8a9yJejvjg3aN1KpKBEsmeLl8fZj4O4Qk2LJPCvXcjiEuaeIQXOVR7+HA
	YooE8wGdynbdvUjyhSwtDn17W8z846Pwb1TPzYBdiLp8NTOdDcL5mrU1FoYv10r1XQHs02GlUwyhb
	n4/4RdH6l58IQIzllezR/3KTHaoQycViAgc6Gb5qmqPrbgYfcb1z9T+tHts/JOhi+3hu39MnyhxYS
	0NPazpqw==;
Received: from [177.180.73.242] (helo=quatroqueijos..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tawOb-001CCB-0M; Thu, 23 Jan 2025 13:33:17 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] char: misc: deallocate static minor in error path
Date: Thu, 23 Jan 2025 09:32:49 -0300
Message-Id: <20250123123249.4081674-5-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123123249.4081674-1-cascardo@igalia.com>
References: <20250123123249.4081674-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating sysfs files fail, the allocated minor must be freed such that
it can be later reused. That is specially harmful for static minor numbers,
since those would always fail to register later on.

Fixes: 6d04d2b554b1 ("misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/char/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 7a768775e558..7843a1a34d64 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -266,8 +266,8 @@ int misc_register(struct miscdevice *misc)
 		device_create_with_groups(&misc_class, misc->parent, dev,
 					  misc, misc->groups, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
+		misc_minor_free(misc->minor);
 		if (is_dynamic) {
-			misc_minor_free(misc->minor);
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
-- 
2.34.1


