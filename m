Return-Path: <stable+bounces-123426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B56AA5C564
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780851684DB
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C325DD0F;
	Tue, 11 Mar 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="All/XwmZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579025D8F9;
	Tue, 11 Mar 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705921; cv=none; b=k4gO1FgG+TRmbbX6Yo+lsqDzCBOfc1/QRUoOvZA9GEe3XJKpyDJ6/QJQ7I/ay+zw/whGDs8vmehOhC9PmyoyV8+D9T6JxbXnuQY5Wnf15wzehS5ze2brqFqldyj7X70t6VgqVoNbSe4Vk6u7NAL6m2a+0jgIOWZzhsTTx4W7wQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705921; c=relaxed/simple;
	bh=RHaKIKHnJTBHkKnxOUgnbhnBjiFP/I2fX11x9fzFptA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M70kru2sN07eBWG+fQc3aKZz1QlYUuk2htM1MfX7E+sQEuoP7GEDo4hPgJx+jT5ng4bSRZQyEgOXNK6L0sKRA11Oemy+BJVd+kwR30JZuYxwCwGE06IBunQni6QdOmK4eh6cbh/Ej6kKOy5pMQJKOaTwW4Ndb3ypxnKgQhpFWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=All/XwmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4C6C4CEE9;
	Tue, 11 Mar 2025 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705921;
	bh=RHaKIKHnJTBHkKnxOUgnbhnBjiFP/I2fX11x9fzFptA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=All/XwmZAGHchwVsdh8PKdR/f28J4wFQxHijuILHVduAdmwJQLBhaVtKQZmR0G4pJ
	 x39dYoMVlungs7fqNnIkygAehxKHPYpiUeWEdUeb+tOfemkhDjIVOSCvt3XsGi9Itz
	 0An3PI0oQKR6ynr1JzmIXqJXLxsvYEKUO2QWPneA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Forest <forestix@nom.one>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.4 183/328] USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone
Date: Tue, 11 Mar 2025 15:59:13 +0100
Message-ID: <20250311145722.174548065@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 159daf1258227f44b26b5d38f4aa8f37b8cca663 upstream.

The fastboot tool for communicating with Android bootloaders does not
work reliably with this device if USB 2 Link Power Management (LPM)
is enabled.

Various fastboot commands are affected, including the
following, which usually reproduces the problem within two tries:

  fastboot getvar kernel
  getvar:kernel  FAILED (remote: 'GetVar Variable Not found')

This issue was hidden on many systems up until commit 63a1f8454962
("xhci: stored cached port capability values in one place") as the xhci
driver failed to detect USB 2 LPM support if USB 3 ports were listed
before USB 2 ports in the "supported protocol capabilities".

Adding the quirk resolves the issue. No drawbacks are expected since
the device uses different USB product IDs outside of fastboot mode, and
since fastboot commands worked before, until LPM was enabled on the
tested system by the aforementioned commit.

Based on a patch from Forest <forestix@nom.one> from which most of the
code and commit message is taken.

Cc: stable <stable@kernel.org>
Reported-by: Forest <forestix@nom.one>
Closes: https://lore.kernel.org/hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net
Tested-by: Forest <forestix@nom.one>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250206151836.51742-1-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -430,6 +430,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x0c45, 0x7056), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Sony Xperia XZ1 Compact (lilac) smartphone in fastboot mode */
+	{ USB_DEVICE(0x0fce, 0x0dde), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },



