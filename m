Return-Path: <stable+bounces-261605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eRleABFMJWp1GQIAu9opvQ
	(envelope-from <stable+bounces-261605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:46:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B564FFC1
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:46:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Vkip+qci;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261605-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261605-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CF7A300187A
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248632B11A;
	Sun,  7 Jun 2026 10:46:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478A3290D8;
	Sun,  7 Jun 2026 10:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829193; cv=none; b=YwgO6zW/i3qhGHbSmwm6kVFD2J/h7eumSZ0gZngOGtKA7bqf8RmisVJIAtS7Ga1y6m50VRtip26iYRPvU8mtXiDYWeCEazGOCqpyTyydaheoIpQruA70FllwEY3wX3JeOSXTAZncbeIq9EmZ2huT14UBDQ+gzqoyxeUZHyCZous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829193; c=relaxed/simple;
	bh=kUgGcjDk8Ij8Qnx2mEixeJv7/OiBE0n6E/91n9+NP8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcgIi6pfkB1LxhP9T1C/5aQbWAM8959yHtum6SAf8XJht5/nWX4Rk9Ahx8eGUoq7t33tqiquVONCxBj4h6ln9FtSEs93njVIm+Cs1DqV6Oe0KduJGg47dskaSeK4DkDBV0d366FdE8i2qCxV3i9vCakIcOXXagbRgNSUTc7LnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vkip+qci; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E711F00893;
	Sun,  7 Jun 2026 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829191;
	bh=LKgwGPH804JMOFQPUIRhyvmmP7bzxw7NZ7SFocLSXHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vkip+qciOKL0bHq3pT11xSgBpMySAI85669d2cIdQI9w3u5UMS1KphM+mCvsXdH5s
	 E4KNWO2fDmc3IIFmhjYvwBzBE2XtF1OD+P4tZhW6lC6+R5WDuZhUXRTxyfQ9qjm/Te
	 zkBTbaAv+IpvvMxr/PrKj4LSep5L67z0LqdyzOCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: [PATCH 7.0 240/332] misc: rp1: Send IACK on IRQ activate to fix kdump/kexec
Date: Sun,  7 Jun 2026 12:00:09 +0200
Message-ID: <20260607095736.866437043@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:xiaolei.wang@windriver.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261605-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,windriver.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 146B564FFC1

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaolei Wang <xiaolei.wang@windriver.com>

commit 36770417153644bc88281c7284730ef1d14d8d3c upstream.

After a kexec/kdump reboot, the macb Ethernet controller fails to
receive any packets, causing DHCP to hang indefinitely and the network
interface to be unusable despite link being up.

The root cause is that RP1's level-triggered MSI-X interrupt sources
(such as macb on hwirq 6) may have their internal state machines stuck
in the "waiting for IACK" state. This happens because the previous
kernel crashed before sending the acknowledgment for a pending level
interrupt.

In this stuck state, RP1 will not generate new MSI-X writes even though
the interrupt source remains asserted. Since no new MSI-X is sent, the
GIC never sees a new edge, the chained IRQ handler is never invoked,
and the interrupt is permanently lost.

Fix this by sending MSIX_CFG_IACK in rp1_irq_activate(). This
unconditionally resets the MSI-X state machine back to idle when a
child device requests its interrupt. If the interrupt source is still
asserted, RP1 will immediately issue a new MSI-X with the freshly
configured msg_addr/msg_data, and normal interrupt delivery resumes.

Writing IACK when the state machine is already idle (i.e., on a normal
cold boot) is harmless — it has no effect.

Fixes: 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Link: https://patch.msgid.link/20260518073405.2115003-1-xiaolei.wang@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/rp1/rp1_pci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -143,6 +143,7 @@ static int rp1_irq_activate(struct irq_d
 	struct rp1_dev *rp1 = d->host_data;
 
 	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
+	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_IACK);
 
 	return 0;
 }



