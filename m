Return-Path: <stable+bounces-244025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hj6Kp60+WnCAwMAu9opvQ
	(envelope-from <stable+bounces-244025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:13:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A134C9535
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4542304339D
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529D3C0636;
	Tue,  5 May 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3d1IWtK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6E3D16EC
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972367; cv=none; b=ALDKBjyJPwkwzBgGpoMy6hijy6JDlP3x8Yh+g2499YtZpuoXVteHaNOjDjcFZ562ZDoceLUPBtp7Hxqwq3ZEttgy6HuDXLBiOS+JTcOsVew8flgoBEoM+Aue0OSPxOnLXYs6wiHnU97KgRzjv7kUAiacsCjkTg0fceaVWYre0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972367; c=relaxed/simple;
	bh=ES7r8hh3t5MoXyYNPDh7ECZ6Siwy/fIWOIkEuMhHPCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IyHP3OKOz/FoJIVZGUXUmCQGWUgNSQQTUPSb3lKYRhPAjOGY6PSWjiPbclksqZnmy5y3IDXQMahyeT0bWBt14dUpwdUaCQjivin9BVIeNhjJQKCOgslcVE6Okcg/Ptp2fwG/wcQuYD3+uF9LHUTg4aFigeV+zdM9V5qQobdAAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3d1IWtK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-362e50b4641so2848924a91.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777972365; x=1778577165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pT76M5XvZ7WL+LrVhY8ppYSbulf6Va7vbJcXm5Lk6Nk=;
        b=Q3d1IWtKluXqj1dN54mD2dGENSi9g4TxvPOdhafiTf8TxohzYaovTcFoTW/jis9rH7
         OigBxn9QgGwLJx/TJiSTkSajt6rHRrzXa7h6n08Sc4mJqLV69GBal4wFe4LOIxuCBzeW
         /ImWlUgB8ta/uwnvlLWeqzZl9a7co8g4aCRh0azK1EcNnjxSoZBE3xatq8UxPC86UBPc
         uvFF9kyOIMT3jgc58QsFUO/9WUv6U+GZUDGNEPgtOSsCNVz/GxkJrdrVB738pm/YDt6c
         zppVIIPWvVxoKYLOTAAQ/6GYuuxuBxnBjRMPiKDM3bP2XVzEyevKRmGNcMRmy42IvF5R
         Rhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972365; x=1778577165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT76M5XvZ7WL+LrVhY8ppYSbulf6Va7vbJcXm5Lk6Nk=;
        b=Mib41Qre9qMJsFzUJA2TzgDTZ9KkjyV1qPhpTxdFhmDm/yG3JAubAmez/f+9sa13uQ
         uPw1WnAXwx8ae0n7EPJIO0yJqwd6R+6DJocEUoDIuHytgueICgclU+unBwlSXHbA41UN
         wD1LNfEwkmtrZZ5DSR8PJgTrwa7hJYxBv4cR18FcZSjBleTcwRszQrWlwn8lqvF98wEI
         PHx/9zc0VkzO1Y/b3II9Dju5OUiSuhqmTRkbplmiW80/TL2gjorYiR/XSvrgzRV21z4c
         EANAuEL1rN2IKfj0AkAdr3fijmIms7Sw0U5bjlLydrx0XH8Wr56xw1ZUlQQJD/PjgX/v
         /s+g==
X-Forwarded-Encrypted: i=1; AFNElJ8KG4CqJLgSIRJGzgahcVqdtZjtZr1c/X/I71QrcxGfbupVpkTbQDK7o6BeNEYXI5G8syN/2yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DRbt+ulAdgEVl/67DVi6G5t2E1vzyUUnyKfTXD6+r9SJDyJR
	0oa+eQhJQBgIjh2+iwkwBW3BzmMrc1M1dE9vbbgiKOsxEEdU+rtgFXMB
X-Gm-Gg: AeBDiesOJV1DgOr14rcmq+pYCqgbFvqApjbC0SWeAxsaSTpQlK29Qx/spO+88DsCJAc
	YWgzYP8qf0vy3bRVEQlr4ojKVeBqCnNF0PiUnBbt3Zm9SQ+BGtaVDPcgkzr5rOcklaiqkUP2rik
	7ruppCK9EZ50K/xtCHH0ntaHBDyCNqwTBcAEkwseKRto0+JWmutaZ5pKxlQHxM/RZTQYcrqZBtv
	tvnpMXKwNn5/bsR7xDd7EW1Tbnwe6guOLd8Gp65Z68NQhPJjN9gu0SK/I3RfsB5V2BdCMVVjvG6
	p9hQ6PbQGDlxWHcvy3dKUbOdPxBvFA474vCAOziwOFVRvlukPC61PmYva8SsieWkatu4WrlHyJD
	EfeR6FuBk6RNY3QGUZQ2Ghv6zPXQUdq2+9UxggxiCCa53jpaRscVgAsW4JAoDT/fsuUioDrv4ZY
	po1kNJAUbGhgcaHRtuMglS52JBTuzR9UxNRF0OPrs23w==
X-Received: by 2002:a17:90b:3901:b0:361:45df:102 with SMTP id 98e67ed59e1d1-3650ce714a8mr12247878a91.17.1777972364997;
        Tue, 05 May 2026 02:12:44 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2ac19sm21648683a91.3.2026.05.05.02.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:12:44 -0700 (PDT)
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
Subject: [PATCH v3] firmware_loader: fix device reference leak in firmware_upload_register()
Date: Tue,  5 May 2026 17:12:31 +0800
Message-ID: <20260505091231.607089-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23A134C9535
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244025-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
v3:
  - Move fw_sysfs->fw_upload_priv assignment after fw_sysfs->fw_priv is
    initialized, so the alloc_lookup_fw_priv() failure path does not enter
    fw_upload_free() with an uninitialized fw_sysfs->fw_priv.
  - On alloc_lookup_fw_priv() failure, call put_device(fw_dev) and then
    free fw_upload_priv and fw_upload explicitly.

v2:
  - Remove the free_fw_sysfs label.
  - Call put_device(fw_dev) directly in the alloc_lookup_fw_priv() failure
    path and jump to exit_module_put.

 drivers/base/firmware_loader/sysfs_upload.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index f59a7856934c..efc33294212f 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -343,7 +343,6 @@ firmware_upload_register(struct module *module, struct device *parent,
 		goto free_fw_upload_priv;
 	}
 	fw_upload->priv = fw_sysfs;
-	fw_sysfs->fw_upload_priv = fw_upload_priv;
 	fw_dev = &fw_sysfs->dev;
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv,  NULL, 0, 0,
@@ -351,10 +350,12 @@ firmware_upload_register(struct module *module, struct device *parent,
 	if (ret != 0) {
 		if (ret > 0)
 			ret = -EINVAL;
-		goto free_fw_sysfs;
+		put_device(fw_dev);
+		goto free_fw_upload_priv;
 	}
 	fw_priv->is_paged_buf = true;
 	fw_sysfs->fw_priv = fw_priv;
+	fw_sysfs->fw_upload_priv = fw_upload_priv;
 
 	ret = device_add(fw_dev);
 	if (ret) {
@@ -365,9 +366,6 @@ firmware_upload_register(struct module *module, struct device *parent,
 
 	return fw_upload;
 
-free_fw_sysfs:
-	kfree(fw_sysfs);
-
 free_fw_upload_priv:
 	kfree(fw_upload_priv);
 
-- 
2.43.0


