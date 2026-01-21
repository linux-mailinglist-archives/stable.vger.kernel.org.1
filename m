Return-Path: <stable+bounces-211057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNpPCP0wcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-211057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:03:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C189E5CC61
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 657A678C876
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE2346A05;
	Wed, 21 Jan 2026 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zn3dHnMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF333B945;
	Wed, 21 Jan 2026 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020293; cv=none; b=J8g5bCIwU9qdHi69SifrgQQV99Ho/ICu7PYsPBZ5mMoHQog80OmPqrKLS0aAxoCYGC5GYQbQpU9oNXrNdf6//AJ1W1JIRtRDR9iid9/TRC3HLaPfSIs6cPr710GGsImtq8DqYJoZ3R3CAHRLkHPTk40wJ3UpZSLTQ++BuMV3tLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020293; c=relaxed/simple;
	bh=xTj7JxwrCL9vYMlTzlXKulmTPpji20XIYxfLAl8R3lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLr7HyNWGncM0S8OImiM5GdTpdeKkBRwHG2w8OYp8dUGM/nFYE4L5YntBlDdqUKQH7UqJnk5FLz3h3CqTcH8sOQ2BJrF7FYJCxqTycys0Y4y3t09T7dkHa/c6LTuqrbLu93my9a3QXIRMTHkcKNe2w4bgEo+CU/t4zeuJan932I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zn3dHnMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D08EC4CEF1;
	Wed, 21 Jan 2026 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020292;
	bh=xTj7JxwrCL9vYMlTzlXKulmTPpji20XIYxfLAl8R3lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn3dHnMiylOJ++sJMmN9UXVKVjlZs5T1gxGVknYAObasb6zS+I7ZRTItiKfQtxXDJ
	 pdNKBwsQ2bKxWHri9MfTsuMKz+BBqtOqF9mZDo/kNwKEyTNRsFk9w4lnl5PRUh6lzf
	 CPMmt2WpBlv1F7iLLEe0tqc7TmZvfXUb24QAXgeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Chang <waynec@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 116/198] phy: tegra: xusb: Explicitly configure HS_DISCON_LEVEL to 0x7
Date: Wed, 21 Jan 2026 19:15:44 +0100
Message-ID: <20260121181422.727885876@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211057-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C189E5CC61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Chang <waynec@nvidia.com>

commit b246caa68037aa495390a60d080acaeb84f45fff upstream.

The USB2 Bias Pad Control register manages analog parameters for signal
detection. Previously, the HS_DISCON_LEVEL relied on hardware reset
values, which may lead to the detection failure.

Explicitly configure HS_DISCON_LEVEL to 0x7. This ensures the disconnect
threshold is sufficient to guarantee reliable detection.

Fixes: bbf711682cd5 ("phy: tegra: xusb: Add Tegra186 support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Link: https://patch.msgid.link/20251212032116.768307-1-waynec@nvidia.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/tegra/xusb-tegra186.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -84,6 +84,7 @@
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL0		0x284
 #define  BIAS_PAD_PD				BIT(11)
 #define  HS_SQUELCH_LEVEL(x)			(((x) & 0x7) << 0)
+#define  HS_DISCON_LEVEL(x)			(((x) & 0x7) << 3)
 
 #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1		0x288
 #define  USB2_TRK_START_TIMER(x)		(((x) & 0x7f) << 12)
@@ -623,6 +624,8 @@ static void tegra186_utmi_bias_pad_power
 	value &= ~BIAS_PAD_PD;
 	value &= ~HS_SQUELCH_LEVEL(~0);
 	value |= HS_SQUELCH_LEVEL(priv->calib.hs_squelch);
+	value &= ~HS_DISCON_LEVEL(~0);
+	value |= HS_DISCON_LEVEL(0x7);
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
 
 	udelay(1);



