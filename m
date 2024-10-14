Return-Path: <stable+bounces-84555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68999D0C1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738A71F22A5D
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E94087C;
	Mon, 14 Oct 2024 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKQ9sDcg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938B611E;
	Mon, 14 Oct 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918410; cv=none; b=Qgnht+lUp0y5Nz+RGem3tDx4xX18dZQs5JX8aQrgq9BabwXltffSPo6ap6+buDzY+j4n2BdcAK1RyBu63cmv8bjeOeZ2w+xYbMgELrkqe6Hg0UdLFYpveU4CymNafk8jdY4EhF6T5+WgUDBbDZLUwCtRbb3WarX0L+tn3r0QQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918410; c=relaxed/simple;
	bh=wBhWymdP7MZ8VSkddSHy5rirVl3yF/IZ8qEm7EAur64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK2W0wrHzirv7h+CqIh7+MFktADOJV2mnJ+/msFnSpszTU0wmO+3fQw3AwOnQ0Mif2RBJ0EhVsjGEs9cRiMIFydR5ZRx6fdFvS7Z7DZJ4IFvQ3q/LNraWl1MLxkKBYMSNVC640xd4LepAV7sF8okrTbqpYW87CUquKhgRibXS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKQ9sDcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F71C4CEC7;
	Mon, 14 Oct 2024 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918409;
	bh=wBhWymdP7MZ8VSkddSHy5rirVl3yF/IZ8qEm7EAur64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKQ9sDcgrH0BUfEE686rwITJUzY5fx8BTgCrp6Ock8BCHeRCbxJJZ/fH5dA00hP5i
	 sfe/lgwkc2UVNoN+ASdp7c9AY15RBbAWT8HvnMUGFyWUoRIPtFlrjukihqFXMeXwWa
	 9dyN4qs5fnO+JRBuM4oK6Ho/htx9ulvft0ygEvx4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	Jann Horn <jannh@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.1 314/798] firmware_loader: Block path traversal
Date: Mon, 14 Oct 2024 16:14:28 +0200
Message-ID: <20241014141230.286917708@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit f0e5311aa8022107d63c54e2f03684ec097d1394 upstream.

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
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Link: https://lore.kernel.org/r/20240828-firmware-traversal-v3-1-c76529c63b5f@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_loader/main.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -791,6 +791,26 @@ static void fw_abort_batch_reqs(struct f
 	mutex_unlock(&fw_lock);
 }
 
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
@@ -811,6 +831,14 @@ _request_firmware(const struct firmware
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
@@ -886,6 +914,8 @@ _request_firmware(const struct firmware
  *      @name will be used as $FIRMWARE in the uevent environment and
  *      should be distinctive enough not to be confused with any other
  *      firmware image for this or any other device.
+ *	It must not contain any ".." path components - "foo/bar..bin" is
+ *	allowed, but "foo/../bar.bin" is not.
  *
  *	Caller must hold the reference count of @device.
  *



