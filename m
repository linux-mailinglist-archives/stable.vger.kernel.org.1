Return-Path: <stable+bounces-69651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B995788F
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 01:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA6B21780
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F611DF680;
	Mon, 19 Aug 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/qSnVF1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C916158540
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109546; cv=none; b=rcsobP5YKrNrVFYxYNCOGBQERdr25/wH5CPG+oMOLpUL6Cd2LznsjD8nxPZLUf+3kaV/pdwbLhgsFjr8m/P+XoRXTHp1b5Ji/1IsLy5WbHYFwO6/6BB6S+6ZQ0Gw+91aNNX/8f7JsSxMm2Rav6TATEa+hDzo0rQTEkYRbO9Kh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109546; c=relaxed/simple;
	bh=wX8NbBXQBrdyUGgBeSeW/c9rTIGze/4Vpvy0VE232zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AZY8EwvT6zajs1CZJbZNAI+WR7JTerqh7LDjZHfUs6JRuQEbS8FgKr2Oot7hfXFGqyY2tvqr22QNz6+vZEraQhjYUdoYN9hUOKxDKzSWvLsfY89PT2bGX8zbDfHq6E6ET/c01DN54vXZAJ/0+RcEAxrKRQ3Kr4ggwKvPfUGCkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/qSnVF1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427fc9834deso12375e9.0
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724109543; x=1724714343; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDASe2w1nbsUY7utMAWevajDhQKvxWgLrQmMY48v4OA=;
        b=s/qSnVF1DzCzaj21QrLSJjpfhze5/VrpMQwqwyix0e4tbOScigISYVToG3liM8bVX5
         Haf9rGyD4324VE7o/c3bIVewZuF/zTppcnpcfeW+O8n0sMtnewNKzhKtUac1ls4vDkIu
         R0DVbfg7lVjhiXShF/VXS28Gh4xOqN17ODkuqoRkO2dm8yB1J3uZmdw1hRmGx1Q3q+eU
         1szfd2IMqaWgeD58icpvcuMipw1wrSsomH8AdMe7fwff3t0HkIxpC/93nLJmQ96kzBzu
         M5zZiPdnl1MRQB38q3ychSBxYSi/J2HN+mU6vAfwDtLgegAEBq/VCdp9hYLdXB8vwztq
         PGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724109543; x=1724714343;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDASe2w1nbsUY7utMAWevajDhQKvxWgLrQmMY48v4OA=;
        b=W4tTCagWDy0oeU/ZIxln/vnf8J4EBcUS0o2CuxIB+NnqTGvEITqcl1H3weGly91ryW
         Zm3vlfTAM9es4t+7Ml0uwecC/2n3qbqjNbtBXvxTP4Bsp4kuG5j5WOLl2r+2yY8D/A8/
         7rROOZlBfCPTGcTkVmqB0xvhGsec4cmc5c9D5EtEnqrBba7Y3bXlOFaFDT8vIts/zyCp
         iy88Vj4tIDlQ323XhZ8eXyWoSrRCbSlRSaJhBKtclCoamFu/f16WUu8aOBRXXCTu/reM
         YAkQw35EHto6BG3K5qUJKuIIl3U8Qq2pj+qQuy4KAVowa2memQcjmCKse1/FSBsW20pv
         IYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO3i/BbBVLKmHr0/779t2IGcqohFHVV0ABesjw8zsYkJPg646JYiKhU5wN6U9Nb1RDPzWzZyTW1dwAhEhcTvq1VbPoZbeq
X-Gm-Message-State: AOJu0YzuugonSXiodKkz3ad1Hf/dkHzxzs+QAzqyj6vVyBsoZXybOgC2
	qYsjLCoG8zEQsWvjoa88S2LmkH0DVYG5OMBCy3tiTq380ktlKid3esuGyeTMmQ==
X-Google-Smtp-Source: AGHT+IEowi/AXjbFJ4MDRHw9klgdIxfih+x+0EQB1QueLuWcTKVN3YN1u6GaG8Dts6uQ+oiUJdH8cw==
X-Received: by 2002:a05:600c:500a:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-42ab6060f29mr245635e9.4.1724109542656;
        Mon, 19 Aug 2024 16:19:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:90ba:acf6:9644:9e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189849a9asm11530116f8f.45.2024.08.19.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 16:19:00 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 20 Aug 2024 01:18:54 +0200
Subject: [PATCH] firmware_loader: Block path traversal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-firmware-traversal-v1-1-8699ffaa9276@google.com>
X-B4-Tracking: v=1; b=H4sIAN3Sw2YC/x3MQQqAIBBA0avErBMmqZCuEi0sxxooizEqkO6et
 HyL/xNEEqYIXZFA6OLIe8ioygKmxYaZFLts0KhrNBqVZ9luK6ROsRdJtKtqnTcNViN6qiGHh5D
 n55/2w/t+l+n30GQAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724109537; l=3264;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=wX8NbBXQBrdyUGgBeSeW/c9rTIGze/4Vpvy0VE232zk=;
 b=wz5LIEHqC3CQmStBt9gjBpcSVQeSUL0D2wRLgBcE6MkUdkGblRn6xoHX0mVOzmqmxhvpu67gt
 jILxKHR2Nn6AbSHQtciQ7SXnZe6GOzAyhcIy6jTB1IqpQ0IqroLkWiF
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

For what it's worth, I went looking and haven't found any USB device
drivers that use the firmware loader dangerously.

Cc: stable@vger.kernel.org
Fixes: abb139e75c2c ("firmware: teach the kernel to load firmware files directly from the filesystem")
Signed-off-by: Jann Horn <jannh@google.com>
---
I wasn't sure whether to mark this one for stable or not - but I think
since there seems to be at least one PCI device model which could
trigger firmware loading with directory traversal, we should probably
backport the fix?
---
 drivers/base/firmware_loader/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index a03ee4b11134..a32be64f3bf5 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -864,7 +864,15 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	if (!firmware_p)
 		return -EINVAL;
 
-	if (!name || name[0] == '\0') {
+	/*
+	 * Reject firmware file names with "/../" sequences in them.
+	 * There are drivers that construct firmware file names from
+	 * device-supplied strings, and we don't want some device to be able
+	 * to tell us "I would like to be sent my firmware from
+	 * ../../../etc/shadow, please".
+	 */
+	if (!name || name[0] == '\0' ||
+	    strstr(name, "/../") != NULL || strncmp(name, "../", 3) == 0) {
 		ret = -EINVAL;
 		goto out;
 	}

---
base-commit: b0da640826ba3b6506b4996a6b23a429235e6923
change-id: 20240820-firmware-traversal-6df8501b0fe4
-- 
Jann Horn <jannh@google.com>


