Return-Path: <stable+bounces-213571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL3PI+5dg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:55:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0AE798A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4B0D30246E7
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100941B379;
	Wed,  4 Feb 2026 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BWdq+nin"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8741B352;
	Wed,  4 Feb 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216779; cv=none; b=n3HpE50CJW+KhKymaxP8ctOvBQ5Z67dkolJ3vV8dS3kIS09dxJtTkqCeIDDS4bb+3EdO/ZQWdJpmV57kR1LG8kTsd7bLs0iau6j22yqYVpiGrIZq2xVSd5B4oBS7cw4aM/0fqtTMXiLWkd86Sp0G5BYoTjdG0RtW+IgnmskKH+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216779; c=relaxed/simple;
	bh=i9rWIN9PrW4jTm+L4u59riP8NQAVaoFtYZkYC50shgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9gvXl86FdROYWdl4qday1JhD8cYHSs47xe6KIeM2XlUhXAtNxtD5Q9NOnCnF0jkFYoFBn6D5Om5N2XV11v2Ch39SpmIum02dkq/Fly/lNPUwy8+PiShyu+sCiCckdJCYiduS7/iL3z4Z5OHOZgMkzNAz0QtS30kaDFW0I8g77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BWdq+nin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AD5C4CEF7;
	Wed,  4 Feb 2026 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216778;
	bh=i9rWIN9PrW4jTm+L4u59riP8NQAVaoFtYZkYC50shgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWdq+ninEiLNXc03jw/BVzcGzhO/j9jKwYfDd75L2TeZ2W2Wh/7RMa6wiJyQoxtJs
	 C/WgukEomaCPDigXMcHf8k4zRugYGkjObsw2huOJWG2HUDc5GjHA6YCvjAQdheDG5o
	 R4l8HiebCZZCmU+rFQd8fj+NDpLDGe6F1o7fB+Fw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.15 029/206] usb: dwc3: Check for USB4 IP_NAME
Date: Wed,  4 Feb 2026 15:37:40 +0100
Message-ID: <20260204143859.252990160@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213571-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synopsys.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 97B0AE798A
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -778,6 +778,8 @@ static bool dwc3_core_is_valid(struct dw
 
 	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
 	dwc->ip = DWC3_GSNPS_ID(reg);
+	if (dwc->ip == DWC4_IP)
+		dwc->ip = DWC32_IP;
 
 	/* This should read as U3 followed by revision number */
 	if (DWC3_IP_IS(DWC3)) {
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1175,6 +1175,7 @@ struct dwc3 {
 #define DWC3_IP			0x5533
 #define DWC31_IP		0x3331
 #define DWC32_IP		0x3332
+#define DWC4_IP			0x3430
 
 	u32			revision;
 



