Return-Path: <stable+bounces-259275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II3IER4yG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E8612BCF
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 708703003D0A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93305241C8C;
	Sat, 30 May 2026 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nf6A7GJx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85C4315F;
	Sat, 30 May 2026 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167196; cv=none; b=phxYimBWSqlkk8kw/1bWnpQz4W+Z8sX+N67+5VMKRGvmeP3w4KRHlKgVw3sz2szuxNJU8wOh0wp4iGMXkfTPaYICGU+x4nsh1i8Vd7c03jgAGGNgvDTUXYH5bxJdVVXhdlwU7vYQBviEt3blFQMm9TMLwBHhut1pi8WiBewRAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167196; c=relaxed/simple;
	bh=wI/TQX/d0bif79gpHKLmVnfvqZIeE9eIWdv01TLTXAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTtWYEaMFBAIZl0YGN7IiwfqANfvTc9WUSBOnXe9SSZuB+LDumWbBhrW848/XD6diMIqk+SN7o/88J0BTJCnvGveD7hrFcLTNM+ekU3BWXZnveAOmHU89y3Uw0O5r5zLeJ/RyLfAOH65aPxCfXz9nXz8DIlMnG9fqFJd5opu2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nf6A7GJx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FF91F00893;
	Sat, 30 May 2026 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167195;
	bh=k9gHuoEeYdPKNbGPlw4ePF7KBmcEmj1EbzPBlyuMtcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nf6A7GJxRAVRzDPpf/oASlq+z/py8AUeQDaxLNZv/YR2OZXyeeNa4aaXA5g+hXefz
	 IcXKV87Nk3kmRFfAAfN9nNICjOrgu4v3ZgKw9IFNZmwWaNognIHaRSuL7f7F73sGtA
	 /Fqv0UYbrV63Rv2RQv5kPK+VvU4g0lMb5IpQiKEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 579/589] HID: quirks: really enable the intended work around for appledisplay
Date: Sat, 30 May 2026 18:07:40 +0200
Message-ID: <20260530160239.817638556@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259275-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: 133E8612BCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 84a9c9e761bcd..3a7b231759098 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -222,7 +222,7 @@ static const struct hid_device_id hid_quirks[] = {
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




