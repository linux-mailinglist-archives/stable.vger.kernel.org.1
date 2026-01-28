Return-Path: <stable+bounces-212034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKvSDIwtemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:38:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A70A41F9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C10E305AB5A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120736999A;
	Wed, 28 Jan 2026 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QVT5w8tu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80022D9780;
	Wed, 28 Jan 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614177; cv=none; b=FKegxfPc7834TnAMqwAowYlBPcchR3xo9Wt1ikjv1yHTDm1v2T0qnCqL/H234Mp3UcxJGT6jlPcPYJdsm8J0Bn/5OB1VfNyrWVQRbGie63eKP6VcMTQaIWy7SGjlrF6MC/ygsCIQvxas4PNHwfMo2//VVDcbvig6TzqW/+xcGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614177; c=relaxed/simple;
	bh=MIec4OYlrKtjN9rzD2dWTzxRNOQJaFlbG7WK0MXy5XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaCuEdWphoKvfBiXGXvZx/NtJsu1M6silH+3O5twpHodcEbVByflmBFHh6S0GjPGkSmHW6Rs1V1g/PlnriiwRzuCzsATMH5UmB5SptEpFYarIQpswEeSDPJanGpGrNf19obkPg+ayPlr/yu3jexRIp+0SCg9WeumfKODBpYd5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QVT5w8tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D3CC4CEF1;
	Wed, 28 Jan 2026 15:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614177;
	bh=MIec4OYlrKtjN9rzD2dWTzxRNOQJaFlbG7WK0MXy5XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVT5w8tuwRj8tMn7e3WQaGGjMOsc3QQxhARfw45RKuHwZzb8U8NgqJVMhRysiwbiu
	 vpkxQkL6NbgrXVcl+y5W+mu4xm4+AEAjAGdOMqxCoqg1psTBaMYSLTZ6sfnOYzz+jM
	 q+f+KjFyN/ggP4AJJHaCrbmxyBOmoxm2qNMTA7F0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Shengwen Xiao <atzlinux@sina.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.6 058/254] USB: OHCI/UHCI: Add soft dependencies on ehci_platform
Date: Wed, 28 Jan 2026 16:20:34 +0100
Message-ID: <20260128145346.787561410@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,sina.com,loongson.cn,rowland.harvard.edu];
	TAGGED_FROM(0.00)[bounces-212034-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,loongson.cn:email,0.152.150.128:email]
X-Rspamd-Queue-Id: 02A70A41F9
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 01ef7f1b8713a78ab1a9512cf8096d2474c70633 upstream.

Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
loaded first") said that ehci-hcd should be loaded before ohci-hcd and
uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft
dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci-
pci, which is not enough and we may still see the warnings in boot log.

To eliminate the warnings we should make ohci-hcd/uhci-hcd depend on
ehci-hcd. But Alan said that the warning introduced by 9beeee6584b9aa4f
is bogus, we only need the soft dependencies in the PCI level rather
than the HCD level.

However, there is really another neccessary soft dependencies between
ohci-platform/uhci-platform and ehci-platform, which is added by this
patch. The boot logs are below.

1. ohci-platform loaded before ehci-platform:

 ohci-platform 1f058000.usb: Generic Platform OHCI controller
 ohci-platform 1f058000.usb: new USB bus registered, assigned bus number 1
 ohci-platform 1f058000.usb: irq 28, io mem 0x1f058000
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 4 ports detected
 Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
 usb 1-4: new low-speed USB device number 2 using ohci-platform
 ehci-platform 1f050000.usb: EHCI Host Controller
 ehci-platform 1f050000.usb: new USB bus registered, assigned bus number 2
 ehci-platform 1f050000.usb: irq 29, io mem 0x1f050000
 ehci-platform 1f050000.usb: USB 2.0 started, EHCI 1.00
 usb 1-4: device descriptor read/all, error -62
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 4 ports detected
 usb 1-4: new low-speed USB device number 3 using ohci-platform
 input: YSPRINGTECH USB OPTICAL MOUSE as /devices/platform/bus@10000000/1f058000.usb/usb1/1-4/1-4:1.0/0003:10C4:8105.0001/input/input0
 hid-generic 0003:10C4:8105.0001: input,hidraw0: USB HID v1.11 Mouse [YSPRINGTECH USB OPTICAL MOUSE] on usb-1f058000.usb-4/input0

2. ehci-platform loaded before ohci-platform:

 ehci-platform 1f050000.usb: EHCI Host Controller
 ehci-platform 1f050000.usb: new USB bus registered, assigned bus number 1
 ehci-platform 1f050000.usb: irq 28, io mem 0x1f050000
 ehci-platform 1f050000.usb: USB 2.0 started, EHCI 1.00
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 4 ports detected
 ohci-platform 1f058000.usb: Generic Platform OHCI controller
 ohci-platform 1f058000.usb: new USB bus registered, assigned bus number 2
 ohci-platform 1f058000.usb: irq 29, io mem 0x1f058000
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 4 ports detected
 usb 2-4: new low-speed USB device number 2 using ohci-platform
 input: YSPRINGTECH USB OPTICAL MOUSE as /devices/platform/bus@10000000/1f058000.usb/usb2/2-4/2-4:1.0/0003:10C4:8105.0001/input/input0
 hid-generic 0003:10C4:8105.0001: input,hidraw0: USB HID v1.11 Mouse [YSPRINGTECH USB OPTICAL MOUSE] on usb-1f058000.usb-4/input0

In the later case, there is no re-connection for USB-1.0/1.1 devices,
which is expected.

Cc: stable <stable@kernel.org>
Reported-by: Shengwen Xiao <atzlinux@sina.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260112084802.1995923-1-chenhuacai@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-platform.c |    1 +
 drivers/usb/host/uhci-platform.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -376,3 +376,4 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("Hauke Mehrtens");
 MODULE_AUTHOR("Alan Stern");
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: ehci_platform");
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -191,3 +191,4 @@ static struct platform_driver uhci_platf
 		.of_match_table = platform_uhci_ids,
 	},
 };
+MODULE_SOFTDEP("pre: ehci_platform");



