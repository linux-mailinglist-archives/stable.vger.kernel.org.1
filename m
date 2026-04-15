Return-Path: <stable+bounces-238146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGWSLa+u32lCXwAAu9opvQ
	(envelope-from <stable+bounces-238146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:28:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B50405ED3
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C5543004D37
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A423DCD88;
	Wed, 15 Apr 2026 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkjwaP4q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C233DA7C7
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266922; cv=none; b=ia89imPu0xS2CQF/cIbl2KztptoUWRrviMTOIKuZIW1QDsUDriuJUbT0L5FL84g7qzmybR5sgaE6znnkGdaADjPlGjMgHoud1opBQyJ1e6KkNDstO83dPEUMWc/Oh+40i8q5O5/SgAYVImYKtZRHkrKx/JjHNjJoZGsqyFloukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266922; c=relaxed/simple;
	bh=oJIKfpkjLTRuSN0Na5MbEEyvI1htq76RZymUd605YJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bC+oA+j4LKrPFQftHxFqv22mfhPjrcd+mGWqPcziveOWXV/t6XAOpCv0X0QJ4srJNdJSYJu5kwUqplEvZGRp4J6Ceyp3Q58Sw6qbTwnGOssg82pwtm7TZliQRibO7dEpv/TumDv1dMUdj8Mbc0pamC3I4TgzhGyxeV3j/CxW2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkjwaP4q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab077e3f32so32960665ad.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266921; x=1776871721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpi8dSRmXDyoL9oy3Sy4RDdQKtqc7S8AukkEChjSFcU=;
        b=IkjwaP4qxK1AOR4Wcskl1buhA2/hEBFNUZAgFgz0iacco2DZHQvEH1mCuYmY6hFy5Y
         CVixGBXglLe8VZdQZOq6stuLwCN7Ir+328Pku9uTwk1zTtorTFYBBpYUucCzmXCJP7AX
         RFMTPS52JwygLXGTiNuEoDm3z41mt8hkkXTNULbCVsmWyfiU+26DMvAutXO/TklTozwq
         wF1eqQA+HfvaTuP5zPNFfBcD6x+saP6y5n6MSFVo0XfI/k/Sl83ymJmX9riHLnGlPYlv
         vviTd+T/BEaMnQhrkyc2HFv9QYPGVVWOikFXPY4BzHKgYMQHyZJU7HOEYnEJ+Dnux8bH
         StkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266921; x=1776871721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpi8dSRmXDyoL9oy3Sy4RDdQKtqc7S8AukkEChjSFcU=;
        b=gMOspZKaoIONKNEJ0zjSjUsw2CUSd+Wg7ei2wCg0Y2nzu+GG0TZnklPF5MLht4bqNF
         R3S7CysPKtKPWyTW7k31MOTi7kpEtV58UsMagc2IHotzF/lbcbO1rFSHIJiPSX+zrh0e
         D44ZRsu6vMVXgGO9g8Ga7RiRufZiDRSViTs3tP/8ouK8N6efsrMMjDAkh7PY7A+NxDhZ
         AqVCxhEzKC2eWX7FCRz2XFeW3V3amVbsJJ8aFfksNvsP7OyyD1YMJr1WtVmEdhSd6Zpr
         hXAd6+6zjUUe0YUmcBK6de86oCbNq3Tv6SNQu04gCyTMKJITltRkSBTSljhI1KxT2dC/
         06Jg==
X-Forwarded-Encrypted: i=1; AFNElJ8psqNvihcF8mw9uzQqZoJG4bz27yr2qCW36uqn7XJFuBFKs+vSQwZ3m7BcELkQrQX9Z3199FM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqvj4nL/YUOy/650YR6l9fOsXjUQ7jX8sYNayRXwGvSJs9y3Xc
	skp3scjOoPzr6uzbwRtMOXL3W0EFaZe9A5+8/kbSIdRmimHUlCn+fDxS
X-Gm-Gg: AeBDiev+1a476cDITA2+yvUvtcX7cYxLUCwLdHm1FcRulS2eXyn63/Kwvgum0p9uV3w
	/OpAL3lnR4g91+ybhGESGKTiAuDnZmF6cpM/7giWUfjTXnuTB8PQccOMdN9HAsZGzXHO8GyLgYm
	qfrgWZj4hymumwc4jzGHYZ75dFlMJw9RuvknYuvpUlXeagC4pAiQ4PWyPjStQrBkI08ZJQzG5yX
	WZvLPs07DgrzAsNkIkLnvTEd2zkCkTSgXFSsbEM96w4Nlx3XugrEwh+OVrpS6mR58XRKOWO4HVh
	1CZI+hBtG+YcFYbwiRms/fB5VwqmhvEqHj82pyltax48crDFmcDFk9cOFPKQUzDOs4mm5OUQHiu
	Oa7O5rU/tsWu+R2phe+LM67nkmyoKQbD0IsGeNreKPvjMbawER3TRNkAKRQOWnziIssF72wTyKe
	/XgYvLKtE36agTC4RPdjuKwtiBQ/gduIbyVnzbK47Dnw==
X-Received: by 2002:a17:903:3848:b0:2b4:678c:5f1f with SMTP id d9443c01a7336-2b4678c60a9mr90028585ad.0.1776266920513;
        Wed, 15 Apr 2026 08:28:40 -0700 (PDT)
Received: from lgs.. ([2409:893d:1179:9a96:408e:b322:d944:7204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47810ae96sm34661885ad.21.2026.04.15.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:28:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: vidtv: fix reference leak on failed device registration
Date: Wed, 15 Apr 2026 23:28:26 +0800
Message-ID: <20260415152826.3406217-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238146-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58B50405ED3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in vidtv_bridge_init(), the
embedded struct device in vidtv_bridge_dev has already been initialized
by device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  vidtv_bridge_init()
    -> platform_device_register(&vidtv_bridge_dev)
       -> device_initialize(&vidtv_bridge_dev.dev)
       -> setup_pdev_dma_masks(&vidtv_bridge_dev)
       -> platform_device_add(&vidtv_bridge_dev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: f90cf6079bf67 ("media: vidtv: add a bridge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/test-drivers/vidtv/vidtv_bridge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index b6203e10e37a..0b551981a5b2 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -592,8 +592,10 @@ static int __init vidtv_bridge_init(void)
 	int ret;
 
 	ret = platform_device_register(&vidtv_bridge_dev);
-	if (ret)
+	if (ret) {
+		platform_device_put(&vidtv_bridge_dev);
 		return ret;
+	}
 
 	ret = platform_driver_register(&vidtv_bridge_driver);
 	if (ret)
-- 
2.43.0


