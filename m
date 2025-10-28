Return-Path: <stable+bounces-191386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A822C12D78
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 05:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4D33B0CD6
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92529827E;
	Tue, 28 Oct 2025 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlCDlk2p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DC286D57
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761624659; cv=none; b=e0Wr9/HNvNLbmZWyPAIP4BZq2wfY7qZBJAh4yOsMeYAvba2wELAo7EvyArqMVD9bvlKqLCbgdKSC7dTxR3TFpa0X63hNAKkJdDoJ4tEbsaqlmhUfg2Rd3aLOXExG8Kba8T4yN7ClNZcRn8X41Ad7xE6+ebSJvWwaNYgWsecOIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761624659; c=relaxed/simple;
	bh=AtKOGqCoRvLS9nhFLSgO+uSH2h9BAA8HUM3chLNgf9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rUjh29LjQKwf9miCpEdpcSebX0hfwgvxu4hv5esS4w9GHb9es0pd/xmD77QTIuePEhDGGh4MjIs+u652caMYBdqiG/o3S2KV5FMS7tdI4fzcpvQ2dOftLtjYUHO+m02bc3BfDNe79h3NRzF+r9Ry5CTGf5NdKvIDCe0ZAUhySwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlCDlk2p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-79af647cef2so4656806b3a.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761624657; x=1762229457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ct3fZhejSt6azXQEGIIev5bJeimWjXEXm2EsgfaLruk=;
        b=PlCDlk2puN48pBARNFZijAmEK99yoUastQNJPt9+FwwoZ0+WjsNsxQDMTHmnb3sMt+
         RUIgI2gnJIElsZzA5h6eDOqJx0HfjSg+IJA1wpzzPuxbVh3zyCcTAKpHCWtvqGahcuZT
         saj1hLk7TLzbI9WgDxNP2FlEfebJVKrI+4PXIgxPGG4Hft4t8V6A6V4e2jaY/pL6z+bk
         frYOzh+XmMj8M9i70xsG+RFGibtHMYBdvx6cihl+N/jrpyjYU1rnEI+eRlyeoDeAuoGr
         PHgsBy8F+vRaLzXyUdsmzwIulhyHsbIo6XuX0nLnS4G7iEBkrIHBfwk/xCaC9+1w0AMK
         +/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761624657; x=1762229457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ct3fZhejSt6azXQEGIIev5bJeimWjXEXm2EsgfaLruk=;
        b=oK9hssw5jHU+063iX6Qwslp1Q3mbiXB10yr+ULA8DhKbxwPXUPBTTZiEGXNSZcl3bj
         rBGB5WwcqrrfbsR7CPYvKBiIQgYKPedFXx2D0GBfbVP6/46XLaTYwmrneVSE3TSQuif8
         3e6tsgTm2VpGDV44E3LR84Ry3a+hwVHZuFF08EgcNMThEu+5cD6+w+akuz8TdX5C+a0w
         kXnCzna3OycEIdu58Lv+4bbLupgWkJHLQpakdndLezfkCoxfADDL6d6v9SRXQdxY1GXD
         70rqalcRJuU7GV60O3R+tTdE0CvDyn4+8StVA0dS6ENfda+ntaOlH3dtbyv4bFP10g9E
         CUsg==
X-Forwarded-Encrypted: i=1; AJvYcCUjXWEI0fC5wTa3xXxa6zEFTkRoMdk5Op4oxmmxoGCa9svkgDBnGIdhkIwGklwuK0gyUXkcb5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+npinm/zsiVMK7K4Jvo0TCYyA2lso4Zf6hauim6NbJr3ppOg/
	J+gOCCROQavjxUhWB/5R0pQ18Q3eKrrOboFMfu1OUGRWocu42ArdGGoK
X-Gm-Gg: ASbGnct6ibYPHF4THcV6eKlB7grm1vSieLJtUeSapmTeQMO5iXeIG5AeD4tI5Oy2eDA
	FesUDFTf9b86++lF57b8GX1Ap8noaalUaimwSoTXlNAKTYRE8FkBGR0VbGyS+88M5R70gfL70XL
	Pk4G8UtLHCNVVwTVQV6J0fpwVzq850LwjU+39nOKfWDlUz8q8l71WU36odXCcHrLVTyXTflYscB
	03xkWmZSKRHL6TjBUdMBiv42MAJTLipUQ7czQO55Y0W4c+iq1yhWpeF2vk+FktP+DEsgp7zkCZN
	FHsEslhqK3zftacUZKftbLBeGscnbonXC6A8uXFKwPpWf6nXJ2HVWy9HfSnk71UAJ0CaNko8tsE
	/6efQptnZnwzbXIzZ88U06zmbE9H2K6AbYq3fr+KggwwwNQn+E9Fat7SM3hLwR2FLXU4exy3fFg
	FtOYn5fNr52ZeLTvC/J2O1IA==
X-Google-Smtp-Source: AGHT+IHwfz1ouJdbUs7lW8MAtJV14JfgzopRaooMgIeeKG6B+P4jnBmcWNKe4LmDGl9zH7XRHwYM6A==
X-Received: by 2002:a05:6a20:3ca7:b0:2ff:3752:8375 with SMTP id adf61e73a8af0-344d3a4fdbamr2689081637.45.1761624656788;
        Mon, 27 Oct 2025 21:10:56 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b8087fac6d5sm3535839a12.15.2025.10.27.21.10.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 21:10:56 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thor Thayer <thor.thayer@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] mfd: altera-sysmgr: Fix device reference leak in altr_sysmgr_regmap_lookup_by_phandle
Date: Tue, 28 Oct 2025 12:10:42 +0800
Message-Id: <20251028041042.48874-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

driver_find_device_by_of_node() calls driver_find_device(), which calls
get_device(). get_device() increments the device's reference count,
so driver_find_device_by_of_node() returns a device
with its reference count incremented.
We need to release this reference after usage to avoid a reference leak.

Add put_device(dev) after dev_get_drvdata() to fix the reference leak.

Found via static analysis.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/mfd/altera-sysmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index fb5f988e61f3..cb66b2fff536 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -116,6 +116,7 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-EPROBE_DEFER);
 
 	sysmgr = dev_get_drvdata(dev);
+	put_device(dev);
 
 	return sysmgr->regmap;
 }
-- 
2.39.5 (Apple Git-154)


