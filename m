Return-Path: <stable+bounces-256354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AjRLS6uGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:05:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B65FA356
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C0343046578
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EDA318B96;
	Thu, 28 May 2026 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ADcHd0Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B02E92BA;
	Thu, 28 May 2026 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001466; cv=none; b=gPe+azEQaQbQFUZSWlG/nfWestnbsvebrOlfA33JrpAmmn4J5gbWi3M0A3smRnfR7mZ39T1rgdI/dLuxTAKD8TqgolWHDAJ6+ecrUnsipUWfxaj2xZeYqRcyGw8dPI3De4xSM5I53OccM5LOO9Pv0zT4IHrBqsZdgl8avvcBChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001466; c=relaxed/simple;
	bh=DPaMAzXwO9x2tWgXFO9NRmTYhW3RM+xMcfepOzOSuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g87psmSxR/9LdgSXqbc40HWBwU5vVFN4g6xh1OAzgQCusrGPfaFCdzNU7tKEoMHEKT/A40dRPl6AXgEF26evVK9bvQ9aHyTGyJf+ELMFNFtuf+tRYJeG4ZinvsEHhC2wzXC12o9OIsHM4YCEC0taH3fIfuR1mJtv4u+ZrLC48zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ADcHd0Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3111F000E9;
	Thu, 28 May 2026 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001465;
	bh=ddLCLnVnTkMWvIO3ZicetGtzWAdjcb5ZjnVYVi1DY/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1ADcHd0YCVDW97I22uIh6dwovtOG3kMFB62JCiyL68vCbNSHoKhMCsxQoRv83mFxr
	 ZfUEOR1l709TGBwv4GsMcv2hRsuvsI2wf5rbo8QpOzoZf5BlurRc7xoqtfbA1bdYgB
	 VbOE0clx9aU9i8a5+k/sNTWkNFvHK3T0Vm/ZDRj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 136/186] HID: quirks: really enable the intended work around for appledisplay
Date: Thu, 28 May 2026 21:50:16 +0200
Message-ID: <20260528194932.624435136@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256354-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E53B65FA356
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

[ Upstream commit 5f90dcfa8dc32a488581b78e575cdd7808ba5c78 ]

Commit c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for
appledisplay") intends to add a quirk for kernels built with Apple Cinema
Display support, but it refers to the non-existing config option
CONFIG_APPLEDISPLAY, whereas the config option for Apple Cinema Display
support is named CONFIG_USB_APPLEDISPLAY.

Refer to the intended config option CONFIG_USB_APPLEDISPLAY in the ifdef
directive.

Fixes: c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for appledisplay")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index d9e33dde89899..9d396d2e534d0 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -234,7 +234,7 @@ static const struct hid_device_id hid_quirks[] = {
  * used as a driver. See hid_scan_report().
  */
 static const struct hid_device_id hid_have_special_driver[] = {
-#if IS_ENABLED(CONFIG_APPLEDISPLAY)
+#if IS_ENABLED(CONFIG_USB_APPLEDISPLAY)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 0x9218) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 0x9219) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 0x921c) },
-- 
2.53.0




