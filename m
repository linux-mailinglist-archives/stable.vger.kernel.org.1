Return-Path: <stable+bounces-211063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPHBDdwycWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:11:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBE65CE38
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915F880E427
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936ED36657E;
	Wed, 21 Jan 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1TNzaC3Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25540342503;
	Wed, 21 Jan 2026 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020313; cv=none; b=R1WIQCgN63Ah0+A0pkKk+vEZVjgo/LAM3zaYgxlSK7a6elAXPXLKFxiNlWxRMSpigOPG9oJy1MWlAyainQr22LfXC7BTLZwSCERcY7sSXp2kAzY7mmAKAh1yyAm6IAJ1s8AdLIn72Y1LCNwjcWnN/0rN78AZzXhwxaucjqp3kEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020313; c=relaxed/simple;
	bh=ap1+AHDzY5UscF1ipB/KwTiyfd55SvsM3ChJj+2iirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iA1tLhVtDS1afuIGixc6c1CF74MtlkRdSPra6uH0hBZa5ucLVq795CL8ruzKNy4q+K0fNnyvco9D7a9R5ivVtr0EnLpZ2AlmnJyI0fp0Q/CivagTlFZAUdbiNqcCFzRLtYz8ChMSd2RMPiMXz6DnYI6eY/lAoHqlCAzQln8iqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1TNzaC3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E2FC4CEF1;
	Wed, 21 Jan 2026 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020313;
	bh=ap1+AHDzY5UscF1ipB/KwTiyfd55SvsM3ChJj+2iirA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1TNzaC3ZOvHwhzX7eheQ3L6oyCTQ1KniDW+WMnb5VHeIGiQ58su1RsJPLET7L3Cr4
	 6zMg45mqHBYcDphblgZTHM/k7RX/K+CtUZX5IAiIMBM0kqBQZe80MFOUPLB6n/HG5M
	 jHzIwaq+JBGt+dCsrwdQq5TLW8uL0nUg12B3TNVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.18 121/198] usb: dwc3: Check for USB4 IP_NAME
Date: Wed, 21 Jan 2026 19:15:49 +0100
Message-ID: <20260121181422.904887471@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211063-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synopsys.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: AEBE65CE38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -991,6 +991,8 @@ static bool dwc3_core_is_valid(struct dw
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
 	dwc->ip = DWC3_GSNPS_ID(reg);
+	if (dwc->ip == DWC4_IP)
+		dwc->ip = DWC32_IP;
 
 	/* This should read as U3 followed by revision number */
 	if (DWC3_IP_IS(DWC3)) {
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1265,6 +1265,7 @@ struct dwc3 {
 #define DWC3_IP			0x5533
 #define DWC31_IP		0x3331
 #define DWC32_IP		0x3332
+#define DWC4_IP			0x3430
 
 	u32			revision;
 



