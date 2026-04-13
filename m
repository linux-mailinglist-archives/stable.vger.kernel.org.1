Return-Path: <stable+bounces-235871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAomKh1I3GkCOwkAu9opvQ
	(envelope-from <stable+bounces-235871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:34:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E33E6A78
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A1773003BF2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C041DE8AE;
	Mon, 13 Apr 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="EOAc4R+n"
X-Original-To: stable@vger.kernel.org
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1521CA6F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044014; cv=none; b=DMdMO4lnWN2gfU4qK0DYR5TL3ld0iCYPBts+UkBFDBMIeG2Lj/3oxaSq0A46mjKNDpDgOeCwSgXEWJV68Fv9QgbHYm8LQVnwctFaMFA0+Rt/BWOlVSSWvdfNpKWYwLcD9M6T9gtPVrRWnLnfSCHg9AmUnWLqgmJkSAxG75ARQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044014; c=relaxed/simple;
	bh=QahBc1mPe2ZsYDuTT3SH67YCUSQ8H3KUkvoUGntnbuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQXueBStXujfbRAmOCAmKr1C/q8rYYZUzG1UwRd4zkioa4na8IVUYXza7WwaLfYBA8M3z7f1V0K1JdahcHM0N+ejdD6Pws4a/GKqqIKnRNSKPQ90JUNbtfs07Zf/Slo1sEvjDFppfNFOSt6R+r2hLVGYoFEHKew+1AKIIb2nNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=EOAc4R+n; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1776044009;
	bh=CKWJ8adBqHEK0S8UEdWGJBcrStEi5oVNXbP7Bhu43sg=;
	h=From:Subject:Date:Message-Id;
	b=EOAc4R+nSlgc921EHi0GVglM3wFUQHXppHKvq3DN8lMZq4gt00WwNjNrzTY+1DFsW
	 ldCx0lEEwJXvEbauuOsghOAuourriLJuraVrO4hafBozmP+jpLiFVwEgIxEXR/bJ9k
	 iHu+oDo7NIrPaajIsl/ARG67KD5inif0s0cSWF58=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.23) with ESMTP
	id 69DC47BE0000292A; Mon, 13 Apr 2026 09:32:48 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 8605948913356
X-SMAIL-UIID: C7865F5684A949E0B922B949EB68AADE-20260413-093248-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	ira.weiny@intel.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alexander.h.duyck@linux.intel.com,
	linux-nvdimm@lists.01.org,
	dingiso.kernel@gmail.com
Subject: [PATCH 5.15.y] nvdimm/bus: Fix potential use after free in asynchronous initialization
Date: Mon, 13 Apr 2026 09:32:46 +0800
Message-Id: <20260413013246.836999-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,intel.com,linux.intel.com,lists.01.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235871-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.cn];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sina.cn:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B46E33E6A78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ira Weiny <ira.weiny@intel.com>

[ Upstream commit a8aec14230322ed8f1e8042b6d656c1631d41163 ]

Dingisoul with KASAN reports a use after free if device_add() fails in
nd_async_device_register().

Commit b6eae0f61db2 ("libnvdimm: Hold reference on parent while
scheduling async init") correctly added a reference on the parent device
to be held until asynchronous initialization was complete.  However, if
device_add() results in an allocation failure the ref count of the
device drops to 0 prior to the parent pointer being accessed.  Thus
resulting in use after free.

The bug bot AI correctly identified the fix.  Save a reference to the
parent pointer to be used to drop the parent reference regardless of the
outcome of device_add().

Reported-by: Dingisoul <dingiso.kernel@gmail.com>
Closes: http://lore.kernel.org/8855544b-be9e-4153-aa55-0bc328b13733@gmail.com
Fixes: b6eae0f61db2 ("libnvdimm: Hold reference on parent while scheduling async init")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260306-fix-uaf-async-init-v1-1-a28fd7526723@intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 drivers/nvdimm/bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 84d197cc09f8..47d13ef9e07f 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -492,14 +492,15 @@ EXPORT_SYMBOL_GPL(nd_synchronize);
 static void nd_async_device_register(void *d, async_cookie_t cookie)
 {
 	struct device *dev = d;
+	struct device *parent = dev->parent;
 
 	if (device_add(dev) != 0) {
 		dev_err(dev, "%s: failed\n", __func__);
 		put_device(dev);
 	}
 	put_device(dev);
-	if (dev->parent)
-		put_device(dev->parent);
+	if (parent)
+		put_device(parent);
 }
 
 static void nd_async_device_unregister(void *d, async_cookie_t cookie)
-- 
2.34.1


