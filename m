Return-Path: <stable+bounces-211065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEJZK5MscWl1fAAAu9opvQ
	(envelope-from <stable+bounces-211065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:44:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB495C6D4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A17380FD5C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D130CDBC;
	Wed, 21 Jan 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPlhmJ78"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199FF356A2C;
	Wed, 21 Jan 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020322; cv=none; b=HnJ8w7EsiMZjjVzo0Oedwq2eXlJqlbgtQWZEznCn7L3zWh/wGPyfMWqjXSDSAGQODY89VUx3Gsn5YAnEEfZerRVrzbgj5PK6XEha76aQJQ1NlDB6gX2a0lnowl3G+02zVMJS5/oEEesk7XMV9Hj6euNygNfP+CoIG/LELjshGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020322; c=relaxed/simple;
	bh=wjxk2vTvfKL1wpZwjRVxRGw8gue+qXVIhGS8o3jTuSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlZlIBnWo8Nb3Qi58k4R4300nEbyf3staBIEeh9BTToZydbkyY8JBJ0YEIYVERvrMVD3EdodNOYaZ2fvsHe6aYwz5S6HZfRy+0LwCOV1ox9aNT7dy4aQ/Ap+2GDdML5pVxfd3wpE6bFMUGgiwIN0hZP79ToRzBf76UDZHKedcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPlhmJ78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7538BC4CEF1;
	Wed, 21 Jan 2026 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020321;
	bh=wjxk2vTvfKL1wpZwjRVxRGw8gue+qXVIhGS8o3jTuSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPlhmJ78vzOB+QhlRELsv9n5scDo1zYX6/v2jyv0/70tolNuSUrOMjv9pLdQ2URoJ
	 a7n1G+2J+E/oy/MGXMFFXm8ZAo29geDYmMBuqluV+ppANQqXKVptmjTgsPjnfVvjF5
	 kAvzXvAJ17pztpzqnPMrkfz54IsM8IZwFyqB08E8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Shengwen Xiao <atzlinux@sina.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.18 123/198] USB: OHCI/UHCI: Add soft dependencies on ehci_platform
Date: Wed, 21 Jan 2026 19:15:51 +0100
Message-ID: <20260121181422.977380570@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211065-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,sina.com,loongson.cn,rowland.harvard.edu];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_PROHIBIT(0.00)[0.152.150.128:email];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,loongson.cn:email,sina.com:email]
X-Rspamd-Queue-Id: 2EB495C6D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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



