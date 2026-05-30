Return-Path: <stable+bounces-257941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAccM1QiG2oN/ggAu9opvQ
	(envelope-from <stable+bounces-257941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:45:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4D1610550
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A27AE3100D56
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B734A3C4;
	Sat, 30 May 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJR3fpNl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5134389F;
	Sat, 30 May 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162692; cv=none; b=fdIo++dOGssMWngah1XpNia1U/M5UuEImuFGIW1AhAY+JqgKN056j9UYZREqEW4yxJfl0ndHojjOESvwTOgp9lTMoXfM/xbZVIIN9s57YLO13oF838603IZuJ7Uh+IdTGehv3uOTLV9d6SVqSXIqWmDCNhhgvfg+Ixkj5qHic38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162692; c=relaxed/simple;
	bh=paPNAW53qRrepW114FueDOXPxvzhWv/C92ca98329HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVdYHHgL4E0LQH8UpDZdIZpj/M+Y7h1AzCBD7jREbfmacRWw41Wkq99UN0FzoE+WAyWJEQiwOe3bQZQy2WQHjgsy0S7XO2qjD8cPGsIdf5eUpIvnCfwXe3ooXefSkWorVlgtOa63X2SpqMKBMn5LJokc8f9lYalM14uiG7mCOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJR3fpNl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656C91F00893;
	Sat, 30 May 2026 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162691;
	bh=f7wCqchWpnC3w3PEZ4DLo2mhtffRCUh+2ujbdsfXVX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LJR3fpNlJv4NmTPTWJ3LTY5MQpIQC4+xkQOh7zD0Da4S2LeA9JwJZ9jUpV33vElVP
	 tFhMNh/6MwHjwMfla7A15cWVEiJLIEPfTk5s4SGaOchUFtkGtVXUGaI7fyWpJgE8Ww
	 e4KwtiSTeLcYLyTcrW+SDVo/z+r29yr0a4ehLnns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	leo vriska <leo@60228.dev>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 012/776] HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3
Date: Sat, 30 May 2026 17:55:26 +0200
Message-ID: <20260530160240.573328879@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-257941-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,60228.dev:email]
X-Rspamd-Queue-Id: 3F4D1610550
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: leo vriska <leo@60228.dev>

[ Upstream commit 532743944324a873bbaf8620fcabcd0e69e30c36 ]

According to a mailing list report [1], this controller's predecessor
has the same issue. However, it uses the xpad driver instead of HID, so
this quirk wouldn't apply.

[1]: https://lore.kernel.org/linux-input/unufo3$det$1@ciao.gmane.io/

Signed-off-by: leo vriska <leo@60228.dev>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 37beb969268c3..66df53c20ed08 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -22,6 +22,9 @@
 #define USB_DEVICE_ID_3M2256		0x0502
 #define USB_DEVICE_ID_3M3266		0x0506
 
+#define USB_VENDOR_ID_8BITDO		0x2dc8
+#define USB_DEVICE_ID_8BITDO_PRO_3	0x6009
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 2a07db02ad932..9eb4d02cc6d77 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -25,6 +25,7 @@
  */
 
 static const struct hid_device_id hid_quirks[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_8BITDO, USB_DEVICE_ID_8BITDO_PRO_3), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
-- 
2.53.0




