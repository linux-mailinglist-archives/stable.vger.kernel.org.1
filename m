Return-Path: <stable+bounces-274417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i0vKLExeVmq64AAAu9opvQ
	(envelope-from <stable+bounces-274417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:05:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA88756C81
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=MROQCDfO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274417-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274417-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61842312C9BE
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3864A33FD;
	Tue, 14 Jul 2026 16:02:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D348BD4A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044938; cv=none; b=nP/BLEDMqyYvBrDGHM8i65FCvfxVtcLHl7+MLPbW9+LOZm5vMhwyYK0T534sH3wTk8AUuK5cIepNjrR7d2nGpdvhOVNMreUwXF2XH+vrM+BP+trQ9CH8P0QD9XygWFOX0HDC9XrDd6/bOCm8Xa25+vSwZR7i/MbMxy7aOhLreCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044938; c=relaxed/simple;
	bh=qzaZOmD9nw34VDtQ+m1Y+uXGscrkzAN1P93jV8Ih/WE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uINzvLA1resypAHIxKPx5gsLlRRqfAa9Acu4j2+8I6bsCWnxSPswJNwKYKwZdre2+EuKBIbXYpLVJoUcUuIO4RacxBSvJzdKITI31ZIAjA6sKxydsus6LpjZKanMlAMHolrQqqXQVxFwyq0pAvLYsVSI2okHNtObNYm5JMvH/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MROQCDfO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70791F000E9;
	Tue, 14 Jul 2026 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044937;
	bh=JGPRLHzI1Z2hSQ5m84hxEnYH4d1UdzdA/5Sd6fy/1d0=;
	h=Subject:To:Cc:From:Date;
	b=MROQCDfO+RDPQoePQwgc5hqVoigaCS9+r+fhUWMHaVqVKNNFT2aDE3BP1z0Xxi6zJ
	 rA/xlXzvwXUGCUD52AffPw1aMZ5dA+r7nsDWgT5NLA8YM29JZjdZI3E+Q0LMQGCV/c
	 0dHcsob966xhkem698VY7b9flcInB/BO0Tc5jVsI=
Subject: FAILED: patch "[PATCH] usb: dwc3: fix dwc3_readl() and dwc3_writel() calls in" failed to apply to 6.18-stable tree
To: ben.dooks@codethink.co.uk,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:02:11 +0200
Message-ID: <2026071411-expose-starless-4335@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274417-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ben.dooks@codethink.co.uk,m:Thinh.Nguyen@synopsys.com,m:gregkh@linuxfoundation.org,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,synopsys.com:email,codethink.co.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FA88756C81


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e0f844d9d74200d311c6438a0f04270834ba5365
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071411-expose-starless-4335@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0f844d9d74200d311c6438a0f04270834ba5365 Mon Sep 17 00:00:00 2001
From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 3 Jul 2026 17:20:33 +0100
Subject: [PATCH] usb: dwc3: fix dwc3_readl() and dwc3_writel() calls in
 dwc3_ulpi_setup()

The dwc3_ulpi_setup() calls the register read and write calls with
dwc3->regs when both these calls take the dwc3 structure directly.

Chnage these two calls to fix the following sparse warning, and
possibly a nasty bug in the dwc3_ulpi_setup() code:

drivers/usb/dwc3/core.c:796:45: warning: incorrect type in argument 1 (different address spaces)
drivers/usb/dwc3/core.c:796:45:    expected struct dwc3 *dwc
drivers/usb/dwc3/core.c:796:45:    got void [noderef] __iomem *regs
drivers/usb/dwc3/core.c:798:40: warning: incorrect type in argument 1 (different address spaces)
drivers/usb/dwc3/core.c:798:40:    expected struct dwc3 *dwc
drivers/usb/dwc3/core.c:798:40:    got void [noderef] __iomem *regs

Cc: stable <stable@kernel.org>
Fixes: 9accc68b1cf0 ("usb: dwc3: Add dwc pointer to dwc3_readl/writel")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Link: https://patch.msgid.link/20260703162033.2847599-1-ben.dooks@codethink.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 517aa7f1486d..ceb49f2f8004 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -789,9 +789,9 @@ static void dwc3_ulpi_setup(struct dwc3 *dwc)
 
 	if (dwc->enable_usb2_transceiver_delay) {
 		for (index = 0; index < dwc->num_usb2_ports; index++) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
+			reg = dwc3_readl(dwc, DWC3_GUSB2PHYCFG(index));
 			reg |= DWC3_GUSB2PHYCFG_XCVRDLY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+			dwc3_writel(dwc, DWC3_GUSB2PHYCFG(index), reg);
 		}
 	}
 }


