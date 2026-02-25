Return-Path: <stable+bounces-218926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CjvNbhZnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:08:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFBC190995
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F7C317EC03
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6946726B742;
	Wed, 25 Feb 2026 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R+OMztHY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79A26CE2D;
	Wed, 25 Feb 2026 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983821; cv=none; b=d9mBDZPSDAqSAwRfdNZjryNn+OgpACowZqOkDDNrm5NM8NF+M6oZX4cGd/JEBtj674bCxiU50pWbWZ1zpb4JlHwDOm9c0eP5iX2cTocmuCbcKygtHU7APUA0eJOeiYRer090aFRoq9mPcQ2J8WSzSSZQVIhmVLpHdAYszIWu/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983821; c=relaxed/simple;
	bh=XgojT4Umzuxe5d7s9NvANPkt+OVlLO9Yi2nD24gMxyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbSMDsFAKtDBHpM59Q/XrqyKmRxAUD9367sxnrrjTudwiWOyHDsbD9vHUE7rSAPdNa19aY+k2vjZizs/5Voim3gkv2689aN5ALVaGWOuFux0X9dQOkNLpH0+xzN8+tc5n6QaPDK3uh/zdr6sq1xdrbQllmK2z2Gd5msjJeyfBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R+OMztHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E148DC19423;
	Wed, 25 Feb 2026 01:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983821;
	bh=XgojT4Umzuxe5d7s9NvANPkt+OVlLO9Yi2nD24gMxyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+OMztHYyDP2bi2y+TNvIkD3Ia91NBeQE5AnSZLZG1wVdkJp/AzvIAz0jiJLg/h/Y
	 6tA6bhQaPJpvnUnUuHAQcbmEOEif5bEULeBjE68I6hNaOw61kHXKjXfDYexpdzzmoR
	 0k8SWHna6eEEnjuGJL33VTxUTNsl2t7b9NMqcaAI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 105/641] genirq: Set IRQF_COND_ONESHOT in devm_request_irq().
Date: Tue, 24 Feb 2026 17:17:11 -0800
Message-ID: <20260225012351.661316096@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218926-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,linutronix.de:email]
X-Rspamd-Queue-Id: 5AFBC190995
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 943b052ded21feb84f293d40b06af3181cd0d0d7 ]

The flag IRQF_COND_ONESHOT was already force-added to request_irq() because
the ACPI SCI interrupt handler is using the IRQF_ONESHOT flag which breaks
all shared handlers.

devm_request_irq() needs the same change since some users, such as
int0002_vgpio, are using this function instead.

Add IRQF_COND_ONESHOT to the flags passed to devm_request_irq().

Fixes: c37927a203fa2 ("genirq: Set IRQF_COND_ONESHOT in request_irq()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-2-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484c04934..8f1166bc3b1ce 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -215,7 +215,7 @@ static inline int __must_check
 devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handler,
 		 unsigned long irqflags, const char *devname, void *dev_id)
 {
-	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
+	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags | IRQF_COND_ONESHOT,
 					 devname, dev_id);
 }
 
-- 
2.51.0




