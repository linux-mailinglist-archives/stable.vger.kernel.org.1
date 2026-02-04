Return-Path: <stable+bounces-213423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OQBN61bg2mWlwMAu9opvQ
	(envelope-from <stable+bounces-213423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:46:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED16E7547
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC9E3013681
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD16540758D;
	Wed,  4 Feb 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+JcxjQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BE33344B;
	Wed,  4 Feb 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216287; cv=none; b=uVf+Hp8DzJIu4x3B/c0EIwfz62YsGKngKrGVYoYmFqfqexX0pqXZKiph8TWPjh0mXK5ZT3ldV/cVzYEchC/D43nFamsHjGm253SdJXKLlopyo6w7BIokmeFu4UQp/5etq/7c0J5wQ3yR8J5uqEdM+nfw5J+m+lCKC4h048+bbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216287; c=relaxed/simple;
	bh=J4VfdgJ5rBjhuYjOyNP8pLJpvMjRWAQGppUKThdcV6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijQu0SbHeqfPxFJa7sKKPthV82JQI4s8T0M9KHPHNn+G7q/1VVdepfGfC6BqzbhH9WhnJuTCr/B8sPYbPJAPmcojP9Vx1ES/E091SuMu+iIBl0qRVYFkVt/dW7YH69+Ez45I4FLnkAy6Xg6Xf53xQMMB204yG6muta2DEi/jrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+JcxjQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C62C4CEF7;
	Wed,  4 Feb 2026 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216287;
	bh=J4VfdgJ5rBjhuYjOyNP8pLJpvMjRWAQGppUKThdcV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+JcxjQu+krqRuGw7CX2pzdRRCflZ8ygq+RcsvHpue4zMcuHnrgmdeJ149mJgkUmi
	 ttO4U31AavKoBF+RDeSc4brX1862065nziYGwdphSOcUD7dxtXAhYmhUKm14bYfqVZ
	 5J7dDWHPYOK8SUbtZ0di4U10ken5hdsH7SzqlHtU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Shengwen Xiao <atzlinux@sina.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.10 026/161] USB: OHCI/UHCI: Add soft dependencies on ehci_platform
Date: Wed,  4 Feb 2026 15:38:09 +0100
Message-ID: <20260204143852.703924076@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,sina.com,loongson.cn,rowland.harvard.edu];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213423-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.152.150.128:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1ED16E7547
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -359,3 +359,4 @@ MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("Hauke Mehrtens");
 MODULE_AUTHOR("Alan Stern");
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: ehci_platform");
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -190,3 +190,4 @@ static struct platform_driver uhci_platf
 		.of_match_table = platform_uhci_ids,
 	},
 };
+MODULE_SOFTDEP("pre: ehci_platform");



