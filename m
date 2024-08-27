Return-Path: <stable+bounces-71351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2513C961AC5
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 01:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BF4B229FA
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1371D3633;
	Tue, 27 Aug 2024 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQEh/tbJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB51A0B00
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802368; cv=none; b=tXWZrzK+J4VpwLd+2kkhnuG22JomHyofQSk4glk3WaKRDJAd6JafNWiNbGM7imDFnmx3t7hsQte74D45lazThQFVGqr7uT9aWPjVeu74dHb/8ic3wLx/OqByLEBUo2DOcsXAqzKoy0bz0dYqZzYaMfu5jxsu9emkFbraNNrhGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802368; c=relaxed/simple;
	bh=BCStCKZHy7XhhvRovzEvUgG5bJ4qds3fjlr8qdOvdw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o3d1gaF00rA18oQf0FJ5lAvft8jgpSANfQO/qIjsrdqc6p7ydDYcB1LVNylwHVV3PGc5YW1S0hDK2AMxqh64kGS0hxOfPjOtZMV8MZ2l9ayZvpk/eJCxQq32JkgJQ9rqXlaoQyP9ESEG9jEJc1Re54dV4eEbBGrIKlIraA+CqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQEh/tbJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso13165e9.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 16:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724802365; x=1725407165; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/bhdeLl4wjFcvXRY+t77VD96S0BQmh9pkR/u2jVN4o=;
        b=UQEh/tbJ+2phN2N67l+hB1Dv4Op2bxA+g1Fyz/S6KcdwVohviwnyQSQH1fi7foOxPP
         fWkbvvfQtIFVMM/2HbtpkWgxp6TY2mv+8N084w0Ox0EzujybYPbaSeMXKSIvSPWkj/hK
         537JxZMw7RfMgI04zm1Wlo/3FRzPs91bG8BZaAaztnGYXc1P6beMt6gBaPYPseZNkrHV
         V4KQq6bF0y8uC/BLEeEMmW3Uc7k6ydxYwBQDF/VaU05lxmIgFT/7HMy46mjQM+hljoJD
         T67/YrGS7fh7wxT8FJ1g5MgwkDhIyziVQoLbvrejGLviTWTvDncHJdL0GAPZpR54mMjY
         f65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724802365; x=1725407165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/bhdeLl4wjFcvXRY+t77VD96S0BQmh9pkR/u2jVN4o=;
        b=jD1yvi1hnoqsyFmxdnncSO1T1NKPMs3jOhrsrfbUEEdIcgr/oON0iYTEqn/OATXFE+
         RPaZP6Mc+KYwAk2r2I2DnDxqMuqyoev8Mo4DYJr5gPoijVGHri6ViGXwEiIzXK4qSG3w
         5Qx6clc/W/5E9zRpfG8lm9zx1ytWVKy4WOZKjA7Yh637cSMDtvrW0zBtwp3K5VCIqwwA
         ZDWHZ16rno6CQBhCEHJwHoVV7MSJ/Ea7mv71XDE/P90EN5zyOzZ4Vgm5nVIRzvGBh/ZU
         FDNP6rt+NDRRdb1ePf4T2xEpHXPJ0b4XqNHdiGP2D3zU9nV3Rf5Z0jJOejNbeNWX0nTr
         kfjA==
X-Forwarded-Encrypted: i=1; AJvYcCXdfxomweW2NerKwthdOxY2Nae5bdJKebt5d8fMf8iDltha2qTfb+cQL+H6Owk59Lu7TFRJwU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3dwxks0IMNn+5VpFXkDpa2e7d7uyUj2V4lS5V3cv2E/fMuTG
	xmkA9UmHl/E/sWIBrGMatVmhZ+Z2gn8n6sqGrlntg1QBmwIrS94p9H5o9rmkJg==
X-Google-Smtp-Source: AGHT+IFk0QFmBGLj5M8q6u4k9jStQ0/9cIQ1NJUijWXEZ6oLKnApCw8ahWvtZO9eM5vZ5WeSya5yYg==
X-Received: by 2002:a05:600c:1e20:b0:426:68ce:c97a with SMTP id 5b1f17b1804b1-42ba50d0ba9mr274535e9.7.1724802362841;
        Tue, 27 Aug 2024 16:46:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a372:5f0f:af:83bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ffb58sm14266703f8f.79.2024.08.27.16.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 16:46:02 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 28 Aug 2024 01:45:48 +0200
Subject: [PATCH v3] firmware_loader: Block path traversal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-firmware-traversal-v3-1-c76529c63b5f@google.com>
X-B4-Tracking: v=1; b=H4sIACxlzmYC/33NwQ6CMAyA4VchOzvTDYTNk+9hPEzoYAkw0pGpI
 by7g5MmxuPfpl8XFpAcBnbOFkYYXXB+TJEfMlZ3ZmyRuyY1kyALUBK4dTQ8DCGfyUSkYHpeNla
 dQNzBYsHS4URo3XNHr7fUnQuzp9f+I4pt+peLgguuSq2tNUbLqry03rc9Hms/sM2L8tPIfxpyM
 xSkvVKyAv1lrOv6BmVpqhT5AAAA
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724802358; l=5059;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=BCStCKZHy7XhhvRovzEvUgG5bJ4qds3fjlr8qdOvdw8=;
 b=M/HEQjTjC/U763WxcVOSLNY1vqtkzq6Q2MlgFskc+dZkVMGksyYS5Yem86xit5EiUlDuQD2NI
 pw80ckdChqVB81vrHq4p+8FvWfIuN3unDnbl4a69FJ0X+fSpTy7tzsD
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Most firmware names are hardcoded strings, or are constructed from fairly
constrained format strings where the dynamic parts are just some hex
numbers or such.

However, there are a couple codepaths in the kernel where firmware file
names contain string components that are passed through from a device or
semi-privileged userspace; the ones I could find (not counting interfaces
that require root privileges) are:

 - lpfc_sli4_request_firmware_update() seems to construct the firmware
   filename from "ModelName", a string that was previously parsed out of
   some descriptor ("Vital Product Data") in lpfc_fill_vpd()
 - nfp_net_fw_find() seems to construct a firmware filename from a model
   name coming from nfp_hwinfo_lookup(pf->hwinfo, "nffw.partno"), which I
   think parses some descriptor that was read from the device.
   (But this case likely isn't exploitable because the format string looks
   like "netronome/nic_%s", and there shouldn't be any *folders* starting
   with "netronome/nic_". The previous case was different because there,
   the "%s" is *at the start* of the format string.)
 - module_flash_fw_schedule() is reachable from the
   ETHTOOL_MSG_MODULE_FW_FLASH_ACT netlink command, which is marked as
   GENL_UNS_ADMIN_PERM (meaning CAP_NET_ADMIN inside a user namespace is
   enough to pass the privilege check), and takes a userspace-provided
   firmware name.
   (But I think to reach this case, you need to have CAP_NET_ADMIN over a
   network namespace that a special kind of ethernet device is mapped into,
   so I think this is not a viable attack path in practice.)

Fix it by rejecting any firmware names containing ".." path components.

For what it's worth, I went looking and haven't found any USB device
drivers that use the firmware loader dangerously.

Cc: stable@vger.kernel.org
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v3:
- replace name_contains_dotdot implementation (Danilo)
- add missing \n in log format string (Danilo)
- Link to v2: https://lore.kernel.org/r/20240823-firmware-traversal-v2-1-880082882709@google.com

Changes in v2:
- describe fix in commit message (dakr)
- write check more clearly and with comment in separate helper (dakr)
- document new restriction in comment above request_firmware() (dakr)
- warn when new restriction is triggered
- Link to v1: https://lore.kernel.org/r/20240820-firmware-traversal-v1-1-8699ffaa9276@google.com
---
 drivers/base/firmware_loader/main.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index a03ee4b11134..324a9a3c087a 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -849,6 +849,26 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name,
 {}
 #endif
 
+/*
+ * Reject firmware file names with ".." path components.
+ * There are drivers that construct firmware file names from device-supplied
+ * strings, and we don't want some device to be able to tell us "I would like to
+ * be sent my firmware from ../../../etc/shadow, please".
+ *
+ * Search for ".." surrounded by either '/' or start/end of string.
+ *
+ * This intentionally only looks at the firmware name, not at the firmware base
+ * directory or at symlink contents.
+ */
+static bool name_contains_dotdot(const char *name)
+{
+	size_t name_len = strlen(name);
+
+	return strcmp(name, "..") == 0 || strncmp(name, "../", 3) == 0 ||
+	       strstr(name, "/../") != NULL ||
+	       (name_len >= 3 && strcmp(name+name_len-3, "/..") == 0);
+}
+
 /* called from request_firmware() and request_firmware_work_func() */
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
@@ -869,6 +889,14 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		goto out;
 	}
 
+	if (name_contains_dotdot(name)) {
+		dev_warn(device,
+			 "Firmware load for '%s' refused, path contains '..' component\n",
+			 name);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
 					offset, opt_flags);
 	if (ret <= 0) /* error or already assigned */
@@ -946,6 +974,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
  *      @name will be used as $FIRMWARE in the uevent environment and
  *      should be distinctive enough not to be confused with any other
  *      firmware image for this or any other device.
+ *	It must not contain any ".." path components - "foo/bar..bin" is
+ *	allowed, but "foo/../bar.bin" is not.
  *
  *	Caller must hold the reference count of @device.
  *

---
base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
change-id: 20240820-firmware-traversal-6df8501b0fe4
-- 
Jann Horn <jannh@google.com>


