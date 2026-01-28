Return-Path: <stable+bounces-212032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJM6D60temnd3gEAu9opvQ
	(envelope-from <stable+bounces-212032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:39:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C97A422E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC97431ED421
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AA369960;
	Wed, 28 Jan 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ug1BIqxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE32517AC;
	Wed, 28 Jan 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614170; cv=none; b=mP/WCO6FuPeS+cknWtwGnpdexDjcCUEQvvC2BmEjc6m/yEvDITjkb7tLiRekXBFNOVZMpXX/lZfuqh25UWPRvDrVQGoZT5oSpeDwTSDEINM4BcoX8p544+AZi5HxDYi89b5Mol+zisYFMx389aaiFfBxHJ0bbCKRKikde8qDRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614170; c=relaxed/simple;
	bh=6pRY4tJmNwpm+XlLWZckD0FJcC7PKfpQfhcYlm69kPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Axgq5yd52LVAv83bL5RmXEz53lhGW/73CvCr8Xbu3VfOwYhjNMFsUed2GT0uA/3lZMBhdn+E6jeKsRO3iw2uYNMdQDprbqnygpCDIpMWlTOn/yyqH59PQiFsBGhhBklqL5uNzJTlmnfhaYP/PHku4WP05NSB+eA/rf8m57aM0Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ug1BIqxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D00C4CEF1;
	Wed, 28 Jan 2026 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614170;
	bh=6pRY4tJmNwpm+XlLWZckD0FJcC7PKfpQfhcYlm69kPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ug1BIqxh3M+XHoGE9jfyDHZVEzA86AHMzg88yGOJdntTtLANA946TDaF5d4PzGLqJ
	 icnf8R1cp0XWeYJTKS9uRwGlt3CmYWd734FBxuONQBN8XHenCP1DS9KpkhgiSVoB50
	 OzWO7mbBqbZYsGiub/o/llUqCWZBoHw9qwPD91V0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.6 056/254] usb: dwc3: Check for USB4 IP_NAME
Date: Wed, 28 Jan 2026 16:20:32 +0100
Message-ID: <20260128145346.715420429@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212032-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,synopsys.com:email]
X-Rspamd-Queue-Id: B2C97A422E
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 0ed91d47959cb7573c17e06487f0fb891d59dfb3 upstream.

Synopsys renamed DWC_usb32 IP to DWC_usb4 as of IP version 1.30. No
functional change except checking for the IP_NAME here. The driver will
treat the new IP_NAME as if it's DWC_usb32. Additional features for USB4
will be introduced and checked separately.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/e6f1827754c7a7ddc5eb7382add20bfe3a9b312f.1767390747.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |    2 ++
 drivers/usb/dwc3/core.h |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -892,6 +892,8 @@ static bool dwc3_core_is_valid(struct dw
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
 	dwc->ip = DWC3_GSNPS_ID(reg);
+	if (dwc->ip == DWC4_IP)
+		dwc->ip = DWC32_IP;
 
 	/* This should read as U3 followed by revision number */
 	if (DWC3_IP_IS(DWC3)) {
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1221,6 +1221,7 @@ struct dwc3 {
 #define DWC3_IP			0x5533
 #define DWC31_IP		0x3331
 #define DWC32_IP		0x3332
+#define DWC4_IP			0x3430
 
 	u32			revision;
 



