Return-Path: <stable+bounces-236850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJuDAPgc3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0293EF8FC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24D053035A72
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ABA2874F8;
	Mon, 13 Apr 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HVKR4oK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2523D297;
	Mon, 13 Apr 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097953; cv=none; b=OcHu58pP9Kfwvq9IDbts5A/SCcoNEyBfiLC3rORYcUbaJ2/H3h6OmlNncaHejtsYjqZEPIaSvcJHYUu45IHbmzG2Ke/Ms422XMCg8skaiCfG26zYgKBGr0Fl9FireVMq3AftgFATlzGEVpOHCXPuYRWV44WJcTV8Q1AoTAMmhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097953; c=relaxed/simple;
	bh=AQxW0/OV9GTcN017ZfXrWJJniGeGCEuCuxTBKK+86vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSCMTC9TDNeTyDlMxD4XGf1Y9mOA+rH6Y3Bxaf01H923FQWmbLx3LF1Hoibsn1x+Hqk8Zz8a1Obq1wh7o+V+X7NbbWP8t/+M0SkdNa+FNjQPz0YakjXtr7tT/7D4GapkziqdSc5rrDst5+vAH4D9W3lD8rxGj3CJmIMlMFmwHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVKR4oK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC73C2BCAF;
	Mon, 13 Apr 2026 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097953;
	bh=AQxW0/OV9GTcN017ZfXrWJJniGeGCEuCuxTBKK+86vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVKR4oK1chQysobQ6YC6uIcvXFtLy3hbwIwmfLPHklA3Bpi3GeNEmTlp2Fh1QLf+/
	 VV9wlekOAxD8BELh5nseHfY+JWRbbImx9/lqQoxfv3yGWq/iPhv9Zeh6SrtazpuqL9
	 +zHe7momht2o76eGlAo73YvYLTEArNZkYxVb3BZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Valentin Spreckels <valentin@spreckels.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 305/570] net: usb: r8152: add TRENDnet TUC-ET2G
Date: Mon, 13 Apr 2026 17:57:16 +0200
Message-ID: <20260413155841.924558998@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236850-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 5F0293EF8FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Valentin Spreckels <valentin@spreckels.dev>

[ Upstream commit 15fba71533bcdfaa8eeba69a5a5a2927afdf664a ]

The TRENDnet TUC-ET2G is a RTL8156 based usb ethernet adapter. Add its
vendor and product IDs.

Signed-off-by: Valentin Spreckels <valentin@spreckels.dev>
Link: https://patch.msgid.link/20260226195409.7891-2-valentin@spreckels.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index e70f3cb8bad94..59baa673738b6 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9857,6 +9857,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
+	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
 	{}
 };
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 2ca60828f28bb..1502b2a355f98 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -32,6 +32,7 @@
 #define VENDOR_ID_DLINK			0x2001
 #define VENDOR_ID_DELL			0x413c
 #define VENDOR_ID_ASUS			0x0b05
+#define VENDOR_ID_TRENDNET		0x20f4
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);
-- 
2.51.0




