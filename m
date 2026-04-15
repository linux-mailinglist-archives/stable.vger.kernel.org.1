Return-Path: <stable+bounces-238197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN0YIwfh32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:03:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F4C407440
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AADFF3025179
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD98383C9E;
	Wed, 15 Apr 2026 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqnXHjLf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED769330B10
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279810; cv=none; b=lWlYQWzoA1VYEa0fPbysp3P8uGIEtu6d4fNXonSa/So2fRkAJ9wtlN3Kp7DMhaGjBKxxGxOBYNSvxdyNfMa6uadYju5u9oMn6XB1aTbhsAZjxtJTDY2TTChnPb3GZeYSpj4Ql+paOK989giwjycTiLHZ2wQqqqRlaiMT+lE7noU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279810; c=relaxed/simple;
	bh=9UFC+iDWRtJNrO7vNXJjscF75KHcs20tnIoUObrAcx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHs5tLRjEa6JLZ+WfM3DULe6ZGC3F9aWuCdMr8l/RDd+IpPYyf7OTueqFcnMMG0uWVdgKyqgGR4u3FBdgXiDxN6/18KRkkAWogUPeKhpWlWcBlyjgFsxsRNq4qlGRlFY8sFWvc7njVGRGZ6bi98jw3ndxwSgL6D5BrWX5TkS93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqnXHjLf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-823c56765fdso3984931b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279808; x=1776884608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uvy87bgL4dIY+61I0JGqZLh1grbMWSFcGN37dMr2Ck=;
        b=dqnXHjLfjZFiXWVlhWWpzGHUvRpf0Zzkf1WUXCWIXXZsYgYarAI1PMB2UVDSgj7fIj
         r3KquMtuR/uDWyUqqKJmPRBhoCDQjtUOCsGAK87Q0wCj3iLMLbgk3fUIKNtEHkdyCt2I
         okJU+A99EN/xAZpRhsvmQ+DmsRu/iZuc1np8r9v5ANrup04EWC7/9u6Cdv8r8k3jQZTX
         NQl+/jkdBerwZimZ94EGlFiNZygJ5UYlWk+YdhKPGFDSdedegLXcsQcQyCD/XAO+GyOc
         +n2a5QhkMdRY/o7PfgLDoPOiR9y9UFj3exVj3yUPaUHOzOQhAaZi/lh8FtkaJ4oOI/aU
         ho2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279808; x=1776884608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uvy87bgL4dIY+61I0JGqZLh1grbMWSFcGN37dMr2Ck=;
        b=h1KRxoHJECZskHG4dGZw9dMfKiwrB2OmgebmYJFd0yZDTbxUjccl7QlH/crp+39Iy4
         s+TU9ZRzbHDUtoFrJVS/0wBp6qvongj80xHFSEw2ozAWczCdGErcxTJ4735+PMgPL1V5
         rY5ZYhSd5metiTrk6PpieF6QD2UYGuB7InkTs95FS9h3fF7djJjY1yKUWbku47bsqVtH
         SCIbLtjz4PLGEUgxZ/n8AVhIqWsMpopSARvxE3UQJDlYmmL+5oGyigJPSq1QXNZkSwiW
         d6qJLFmgFF0s8zgSCLk6+pvVk9BNO1fiWikzQ08lZ6531/2pEWGHc4PYgi+iPoQpgspB
         Zl0g==
X-Gm-Message-State: AOJu0Yxr9KnoSNJKToWlsDCYeb28abmCwUstZeIT0sSGIlshLSZ0ReJN
	aoas2VhQ0uXVx9Md6yvPFVOeGFtzs6tTDHWl18VECDKztnbjmxugBuTb
X-Gm-Gg: AeBDiesI03q2ymZwTByXcFXPKV4CUMQbs/bsTdpSKB4Sn7LR33k9v9owwX7F3G8jdbU
	j5sbWye7QQPwjA2E1KCxr+SE0K3cYhSBeHYzSzkNN8O7rxt97eCJtd5p3zNm/KMecs1AfXliK3I
	3RBAxdGZF4TivNLprszEBsX8Otke7+v5GaR6/u6N0iIPntkvwDdOvOa7gdIKiMAx7+1jM0t1stk
	V8eaIURcHHH1UWowQw9fgPxDD+DNyXtBceRMtechdsFMFxefSyQKDtlkcyEOULj/FVuxNGTLwJZ
	U7XfeeDIKeCd3siS+WK3dT2ZF0eUsHy4ycmvFEqng/WTha5EjZa3ygI8So78+F/enV+D1lsRErH
	bmwx3nuuijDFMJqVxeuSpbUMxSqKfKBXCBNqhnbKPimLAY25aK+QDTAOUhjCiAgjKIb/2pxiMP7
	ZmldRbGq7eu6DS7lXvJ5IodORtcy2v7Vwi6Eo=
X-Received: by 2002:a05:6a00:bd91:b0:829:73f4:6ff with SMTP id d2e1a72fcca58-82f0c2b44a4mr22867066b3a.37.1776279808216;
        Wed, 15 Apr 2026 12:03:28 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6f52d45asm1736491b3a.38.2026.04.15.12.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:03:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	David Brownell <david-b@pacbell.net>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: sl811_cs: fix failed platform device registration cleanup
Date: Thu, 16 Apr 2026 03:03:18 +0800
Message-ID: <20260415190318.3812066-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238197-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,kernel.org,pacbell.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2F4C407440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in sl811_hc_init(), the embedded
struct device in platform_dev has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  sl811_hc_init()
    -> platform_device_register(&platform_dev)
       -> device_initialize(&platform_dev.dev)
       -> setup_pdev_dma_masks(&platform_dev)
       -> platform_device_add(&platform_dev)

This leads to a reference leak when platform_device_register() fails.

Manual review also shows that sl811_hc_init() sets platform_dev.dev.parent
before calling platform_device_register(), but does not clear it on
failure. As a result, later calls may incorrectly see the device as busy.

Fix this by calling platform_device_put() and clearing
platform_dev.dev.parent when platform_device_register() fails. Also make
sl811_cs_release() only unregister the platform device when it belongs
to the current pcmcia device.

The reference leak was identified by a static analysis tool I developed
and confirmed by manual review.

Fixes: c6de2b64eb575 ("[PATCH] USB: add sl811_cs support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/host/sl811_cs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/sl811_cs.c b/drivers/usb/host/sl811_cs.c
index ada91ca33f65..096f5fff0bfb 100644
--- a/drivers/usb/host/sl811_cs.c
+++ b/drivers/usb/host/sl811_cs.c
@@ -90,6 +90,8 @@ static struct platform_device platform_dev = {
 static int sl811_hc_init(struct device *parent, resource_size_t base_addr,
 			 int irq)
 {
+	int ret;
+
 	if (platform_dev.dev.parent)
 		return -EBUSY;
 	platform_dev.dev.parent = parent;
@@ -108,7 +110,13 @@ static int sl811_hc_init(struct device *parent, resource_size_t base_addr,
 	 * by referencing "sl811h_driver".
 	 */
 	platform_dev.name = sl811h_driver.driver.name;
-	return platform_device_register(&platform_dev);
+	ret = platform_device_register(&platform_dev);
+	if (ret) {
+		platform_device_put(&platform_dev);
+		platform_dev.dev.parent = NULL;
+	}
+
+	return ret;
 }
 
 /*====================================================================*/
@@ -128,7 +136,10 @@ static void sl811_cs_release(struct pcmcia_device * link)
 	dev_dbg(&link->dev, "sl811_cs_release\n");
 
 	pcmcia_disable_device(link);
-	platform_device_unregister(&platform_dev);
+	if (platform_dev.dev.parent == &link->dev)
+		platform_device_unregister(&platform_dev);
+	platform_dev.dev.parent = NULL;
+
 }
 
 static int sl811_cs_config_check(struct pcmcia_device *p_dev, void *priv_data)
-- 
2.43.0


