Return-Path: <stable+bounces-44009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48C8C50C4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC891C20D46
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24976045;
	Tue, 14 May 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e02X8lE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E66D1D7;
	Tue, 14 May 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683667; cv=none; b=mnlds6yMHF6olFrNybRfOb5Hl9oMgQwsP7tiWgN/LuHGVOpph1ssKP8f1Qc2qneYsIvk1ziUBxDaSWgyz61yKz3/FYVNKedGdu6AVGcinYPLo8gg/l0oWray9mbG0UrzhOYHWUzRNfYGtIimEvPJpfUiOmjVkUG7mcK1mkGSKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683667; c=relaxed/simple;
	bh=Nqcik0J2YwPrnfexbU8TqPYpZ7cDs1OLhMupOo9yE9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnT/n5BH+TffxTEuAGcJyytYoP6xaWRyvJPcGrU+Nai5M5U0LmsTNjQz9nloQuI+jbmIlQrfO5XQFYb8y/QaubLI+FTVgRAcfKt6ejPunGwEy2uV0046tuTydOtOZ9nvzRroxg1FeOKWjJ3ZwDzFAvBFVeZ6x5i8QF09LkpB/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e02X8lE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B2CC2BD10;
	Tue, 14 May 2024 10:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683667;
	bh=Nqcik0J2YwPrnfexbU8TqPYpZ7cDs1OLhMupOo9yE9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e02X8lE0b2cxVW1pDzKGrx3j7UvQExVEQXBASIKKXEAKK5/urwjVYFO6E3CvRgv/z
	 O7mkSKvjrbptZCu8qpMb6bXnDJyc3o2RwosAsBVxf9IOOpdEO15SCVtqwmEzsd+vO7
	 iXMGQpBQZf05gtHerz+hZ92ZjREt+jDiQXyfKZN4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.8 254/336] usb: xhci-plat: Dont include xhci.h
Date: Tue, 14 May 2024 12:17:38 +0200
Message-ID: <20240514101048.207187549@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 4a237d55446ff67655dc3eed2d4a41997536fc4c upstream.

The xhci_plat.h should not need to include the entire xhci.h header.
This can cause redefinition in dwc3 if it selectively includes some xHCI
definitions. This is a prerequisite change for a fix to disable suspend
during initialization for dwc3.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/310acfa01c957a10d9feaca3f7206269866ba2eb.1713394973.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-plat.h  |    4 +++-
 drivers/usb/host/xhci-rzv2m.c |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -8,7 +8,9 @@
 #ifndef _XHCI_PLAT_H
 #define _XHCI_PLAT_H
 
-#include "xhci.h"	/* for hcd_to_xhci() */
+struct device;
+struct platform_device;
+struct usb_hcd;
 
 struct xhci_plat_priv {
 	const char *firmware_name;
--- a/drivers/usb/host/xhci-rzv2m.c
+++ b/drivers/usb/host/xhci-rzv2m.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/usb/rzv2m_usb3drd.h>
+#include "xhci.h"
 #include "xhci-plat.h"
 #include "xhci-rzv2m.h"
 



