Return-Path: <stable+bounces-261638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OnehFMVOJWq5GgIAu9opvQ
	(envelope-from <stable+bounces-261638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:58:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A696502BD
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:58:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=AY0fce3o;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261638-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261638-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DC1A3059796
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABE2EBB9E;
	Sun,  7 Jun 2026 10:48:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56C1A6822;
	Sun,  7 Jun 2026 10:48:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829305; cv=none; b=HRv/ugOuPqrs0xfPNk27RKGg8rPsvmo3dl0XylSPdYsjQimcOVfm5io5yFTYgdw0MA6JeHaNVaut92lwYAbmtwKhLxzQsfV19drv+izFBNYV9C5bol/BdBJMUGsGFsCIBclO88JnP2dVNOr+YVFPMfslkT2VzdtBkAhLyAf3lBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829305; c=relaxed/simple;
	bh=KLCWGKW4zajk7CptpCHBNvDMn+WhkNAVyYt4d+aHOZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zguu/zS+mae6pg2RKMhdXyZDQfpEZXEIdcu+Gc7msWWYuican+K/WpOr1p4pONRchVIWzhKcWC2prDE9INaC1mYCzmA6q6puSMTfof6Ix0vVXIikebPobsBsTGFkAu3sa0LGb030SvQNvkMGRUL/tVEo5gqkVoMOcUzI/5Rxem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AY0fce3o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0161F00893;
	Sun,  7 Jun 2026 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829304;
	bh=ZGsAA2wL2Zfw2LhiJZsut7pnOA55s2xuTu985kY3LU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AY0fce3ooJTdpaIWntSznbyT2ZRiQYJpwxIohS8Ri4WFtNJc/n6UEYnIm34z/GhYD
	 cysbpkej62O2ksy8MMhSjabdThZF270UmXVWcP5eksVS5PUbVBDo7wOSu7wLCKzd2O
	 fhMSM1UHzu1g2Lsxfmhl9CVlah02r+ahsd0Y3SV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: [PATCH 6.18 213/315] misc: rp1: Send IACK on IRQ activate to fix kdump/kexec
Date: Sun,  7 Jun 2026 12:00:00 +0200
Message-ID: <20260607095735.381826639@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-261638-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,windriver.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4A696502BD

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -148,6 +148,7 @@ static int rp1_irq_activate(struct irq_d
 	struct rp1_dev *rp1 = d->host_data;
 
 	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
+	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_IACK);
 
 	return 0;
 }



