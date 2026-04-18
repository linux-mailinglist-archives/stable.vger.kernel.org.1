Return-Path: <stable+bounces-238548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MOnFI4s42kVDAEAu9opvQ
	(envelope-from <stable+bounces-238548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:02:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59674203B0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9905C3008D5C
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2A34D93C;
	Sat, 18 Apr 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHhRD1Hj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA732860B
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776495752; cv=none; b=jxmHsZY3mAaiEuxwkORTRVVdAxqfns9Ml7EUrXrNkukzfPIyxNMYu8h+UZNa3JEvmDBfVJjE/nebzx2htYDe9iEHDBhB93M72jHwe3gFm6URnWE+u6x3/KiL+0yYtzTWyl5h4tmErLef5HZEcr6t5UrD6DTQJR22KkZ3swwyKYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776495752; c=relaxed/simple;
	bh=CcDvIU6z25vhcQ4xVZy8lcj8AJMflIP8uYRdn7I9y5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPz+NBYIDzSiT6bZQHGlm1+KQyebSGrc5IDeo0X20iqcBbAbMl7JPOZuNvw2DycyNNZiMuDG3IUX5zGOtCUeLBoGwuJQAYOFaHZ5MlvoTwalEqzUP+WRdf27efpW1ZJKScNw2MoHz923e6kFH6oJ8INLn6UD86fzp416156Is/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHhRD1Hj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab46931cf1so18486805ad.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776495751; x=1777100551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiTYFjNnjpdpCtpnDwsxuALR8uSM4iRhQ8ijRVO9szM=;
        b=pHhRD1HjdGOBeK+d1xb/DQvb9tKjebI4uoUTcXWnbWtVuv6ZStghKAKqyejvVEa3lR
         i4iaRS7NTPtwBPIqRGFpJebo4dqhavgqmpWCsJm/tWWGNWlnFe3H7T1sP/TsuomwpuXC
         +A8Rd3sRgsVoznhFB8CUn6jQSsatsWmYKWdd566CZd1DyFr48hmAufMkTCaNFv/xPWTK
         62sJCPF0sOgtxNxI5OZJz1hle/m2Ik6fiUzDrFnaRnwfSkT+IcQCDnwSWh/IwdaTenF2
         VDZWrwiBPEZjZDsq8T12ZTz8bTS1xKnA2oMSCkOGvFaKWx/+EUsSO5zU4x/pR+7l5j6z
         i21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776495751; x=1777100551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiTYFjNnjpdpCtpnDwsxuALR8uSM4iRhQ8ijRVO9szM=;
        b=Pj6a0kL+as/KjEl+Uo9f5qAm+JfG2pSleob7vv2Ew+b0jJOmSTS9fgPNsVyWyEaKKm
         EV1HdNZ5Q171Y1jS5gO9pWFeaOLhjzwO8hQHOv2KcA6JX2Bp7uJQFoZwNdDqga9VBLdp
         R9uK5LAVuzkVKsF2dZXfV+EZYCDoQwmtXYks97+7Z/9F68N3rmyXgotBYGrIwd/OCSig
         X94V4C4roR6mD0igRxZYrTl9CXOGtN8qd5z5GbjrwR2hCuzh6sTKefO+AV5ONqQMRQce
         u6CZ86RDo67PAiBmENVRHfGbYMl6Jc3G8NqJLhK8wgKxSsVVI/K8x0la/jC0IFrczR13
         TGpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RCCPsbSnNlFdhotIeLklXcNEgajEsVH5Pod9g22jyiMKrHGTDTdzteMknOrPxyHr7YRl/ges=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTamej8RVN8kir5gxHMhzChy+e2iCa7Gl//R8Fi3pu/eTp3t2
	SVFGwRZerSn9veWfrjZGmBkrasC++GUfS6wAJtMcVCzgtqYtLt080wcHkzBTX9sWeR5Me5Lp
X-Gm-Gg: AeBDievie4Eo2Blm5nbv5GKWd3ZOuv5pA+/1tbiA1s/zd367J3jA8XkjTDhgXB/IsMd
	3nNuXWI11fPEllZK94ltxQpxg9OG6yFl6PXEW6xdCc216wQUwsB64OUbkRVmorSGn5+wAsigKRL
	h1NIfDMy4RITb307L+APOF7kwvUgy3H9tevtEHVRpIrn8uCUXFjA5CFmoxUyo/TB65fqLFW4sBG
	M7fzsiVbxxcg3dS0z55WgaP0sn/VjAXnqzANoNTIgsC/OdvFaL7NIKIZ/JmKCHbmDfWJf2E5X7Q
	DTiN7gYWCcFqwvvdWVBPNL+ISKSth1XYplFY3anHQ02y1UCr/Fu2x2SuyyIBGcegWBkBBRI8hz2
	m7daJhoOTLJ/aCqL74XG3YA3pLSUCnQHB4tRcBhtUDbGWOWpoO8P2p3WNoI24ISiIr2M+Pyiho1
	aaMF7HRd14thI2CwzAYAMGZXgEea6yeRfOH2TpcfkkKS3G
X-Received: by 2002:a17:903:bd0:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b5f9e8d873mr38136045ad.16.1776495750567;
        Sat, 18 Apr 2026 00:02:30 -0700 (PDT)
Received: from lgs.. ([2408:8417:d50:4775:ba08:bee7:5a64:abce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9fedf0sm49448665ad.6.2026.04.18.00.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 00:02:30 -0700 (PDT)
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
Subject: [PATCH v2] firmware_loader: fix device reference leak in firmware_upload_register()
Date: Sat, 18 Apr 2026 15:02:20 +0800
Message-ID: <20260418070220.64542-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238548-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D59674203B0
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
 drivers/base/firmware_loader/sysfs_upload.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index f59a7856934c..a6dab34b22d8 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -351,7 +351,8 @@ firmware_upload_register(struct module *module, struct device *parent,
 	if (ret != 0) {
 		if (ret > 0)
 			ret = -EINVAL;
-		goto free_fw_sysfs;
+		put_device(fw_dev);
+		goto exit_module_put;
 	}
 	fw_priv->is_paged_buf = true;
 	fw_sysfs->fw_priv = fw_priv;
@@ -365,9 +366,6 @@ firmware_upload_register(struct module *module, struct device *parent,
 
 	return fw_upload;
 
-free_fw_sysfs:
-	kfree(fw_sysfs);
-
 free_fw_upload_priv:
 	kfree(fw_upload_priv);
 
-- 
2.43.0


