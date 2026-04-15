Return-Path: <stable+bounces-238066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAoPBpJR32nLRgAAu9opvQ
	(envelope-from <stable+bounces-238066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:51:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC49402273
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 410C8300C6C1
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032E372EEF;
	Wed, 15 Apr 2026 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCgpz6WG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AE37E2F9
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243083; cv=none; b=ICUIC3ye8wr6/bwXbQzeH0eniElbYgI+ORw2tbsTxCwrirg0ge7jqGLKjcHZ1TehRRL6SiFKkHVZPBdk5MkN6vJwq79/91qZ4FEYxpc4VyfhJH+YYGSK4xKd4uoYUZXJPXwHSRHdahvZgV6OD9DtJakrO/UI/+/48CBPa8Nb7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243083; c=relaxed/simple;
	bh=NzkOE0XXojEPsLDp5AjW4nUeVXuWbIOFyVsKkxFSCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tu7y9Ng+4Xeym+6Lu84fwprs3ayI9EamVFFrk6gqX/AiE/L/zWHzS3o6wrvEeVHb8QQRXFJ4HaeDHqE98+7OlUKSd1JkrN2ajsECiBkI212yw4ik8nPNnx4apCsjqItd6S8fQk3fwaHnD6J0xb5f/3MLEzanGuFPsJTPxYUeIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCgpz6WG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so5781955a91.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243081; x=1776847881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuPGq2uQWBcQ6iaTKDT1PjU7pmFyo/WHC6ytQGe/UTQ=;
        b=rCgpz6WGTSZ3or3WaGoLlQWfVaDJBLJtSk49gj/CyfDnkICOTbj+UjOnOQRLDXRGsQ
         m04NO4VatYv2qhsSrQn6dIz7FwOl9UHGHKOhCsj42kTQtpYGoi7i+7NGk+RU71XV2qWw
         k8lOcnbrQZ9yLYkQB720vOmrRkjW54ODr3QVPXSAX7+lgXZrzIDc0rysvrdY6byezoQH
         5JqnADjK8R5G/8xopRhxtJXXZY8XMqSvZnDwhXTS7G91ycpwBh7OmKFlwzcefIJjBjq/
         f4fbULEZICguAXhlglHf/dKD8F7bpdD9lB9fxptaqw1C3jrSkg2WLnWseBqJfrY1zRtM
         JE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243081; x=1776847881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuPGq2uQWBcQ6iaTKDT1PjU7pmFyo/WHC6ytQGe/UTQ=;
        b=BOHHEeqkEAmf4dFdDitTsW6T0DVUY0gSFGBMd7e1TBV4JhvoluRnIKSFqYX3oJjpQs
         oRF0zqf1N3aeebhe16IokX1Pvi23+WaziMl9RqLE1OvE88A8MNYt29E2f/Mp4mb7ti0I
         hPTBeFXKCug5zYI2V7DRYVxHsyE0Wh96/I75w/XpzX4vg0eYc4cRQMoGKcv38X2serYh
         fWUr0j5GY5+cHnhhvKiLfVpv6MeVdOJpNK/VfgkRoXSyk2dcQ7LVOjs7BykzMs5pTxen
         kdtmlflG+CrX7iObzjViyBnCE/fwOnj5tBUr6CkyQ0qK2xH8T6dOUULidttgnucn4DvZ
         PYrA==
X-Forwarded-Encrypted: i=1; AFNElJ9FgL/aLJ17cDO+671ckliuFrzObtoKK+INiwQkxITt+R8QkLWUfkj80E8vPD9g6ROlAFtbV2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PzgbMv1sJdEV5HF8pngoWesvvSqe13oMOvsS5LEk8v8WExO/
	xOqnLDB4OfIUiaQm+QnpnyQA8cihRGGUdFYHRz3d21OF4wUAqUH0Nkn/
X-Gm-Gg: AeBDietSI2Bvtw0jbG9QLu0IctF1qAo/5g5nbUbAZL7Z5auld5LVgkCMuJCQyaPUxJR
	yQmpN9YZqydM6m0y+py4Dh9KAtgO3P6QCRrTmfJr8gSdOgr28mWP+N7LU9IZ/KjwB/7jbADlWWH
	RYhlyf4qdGrTmBH2fx61/cCkXCbPEYfy/23rVQiqIE9NFdnv2seOudHpFrBZO8q9rdCfmywOoo7
	S7BZODK6+OTtMboonMLN2M+ZU3VAwW/PZsQ657RoX1bcDtGL1pFA2VAEls0zc3HKZ6SLzwAYnnt
	ZgCW5sReBet0OFQkge7ljQhO/6GuaLtxKqxAUkA/6RlxURLEjoNQRW1QgKnTju7Vsmkoh3dJi1g
	CHmBYhIHL8zAukcguYTkjHvF5X09pjzmGL8tnWXuqjnPOFF73iJsUsjXRc82TjQHrK/EAJbgQi4
	G2E/QHzTFhpsdEmyLKxJeTEIUiPHjxBh1I
X-Received: by 2002:a17:90b:288f:b0:35b:9b77:d7c with SMTP id 98e67ed59e1d1-35e4285338cmr21700928a91.14.1776243081584;
        Wed, 15 Apr 2026 01:51:21 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd3074758sm1274513a91.1.2026.04.15.01.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:51:21 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] firmware_loader: fix device reference leak in firmware_upload_register()
Date: Wed, 15 Apr 2026 16:51:09 +0800
Message-ID: <20260415085109.3267323-1-lgs201920130244@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238066-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2DC49402273
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

firmware_upload_register()
  -> fw_create_instance()
     -> device_initialize()

After fw_create_instance() succeeds, the lifetime of the embedded struct
device is expected to be managed through the device core reference
counting, since fw_create_instance() has already called
device_initialize().

In firmware_upload_register(), if alloc_lookup_fw_priv() fails after
fw_create_instance() succeeds, the code reaches free_fw_sysfs and frees
fw_sysfs directly instead of releasing the device reference with
put_device(). This may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by using put_device(fw_dev) in the
failure path and letting fw_dev_release() handle the final cleanup,
instead of freeing the instance directly from the error path.

Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/base/firmware_loader/sysfs_upload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index f59a7856934c..6b701185dcb6 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -366,7 +366,8 @@ firmware_upload_register(struct module *module, struct device *parent,
 	return fw_upload;
 
 free_fw_sysfs:
-	kfree(fw_sysfs);
+	put_device(fw_dev);
+	goto exit_module_put;
 
 free_fw_upload_priv:
 	kfree(fw_upload_priv);
-- 
2.43.0


