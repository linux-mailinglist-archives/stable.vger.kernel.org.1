Return-Path: <stable+bounces-265351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pWsBAy2HMWrmlgUAu9opvQ
	(envelope-from <stable+bounces-265351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D246931E4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:26:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VqH5UPQX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265351-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265351-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40FA2300DD51
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D21A449EA8;
	Tue, 16 Jun 2026 17:26:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217544BCBE;
	Tue, 16 Jun 2026 17:26:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630762; cv=none; b=K01rF4aCZEM0iyIYrcHRzn1m8td27gYjVQ/7ZnX/VU1Gyk4SRGtyqMmlLbyypBhp8NJRotDlb14hB2JZOEpCOybOSpTNC2n+83YIBLdWqlg1K9/qVs8dEP8ChjlZIP4pyWRcL9eY5Lkrpq4PJOJKL1B7rXEpUG520okLBXWvEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630762; c=relaxed/simple;
	bh=C0kEhHtjjSASA03K8ppbB4mcQS6BaRUQxLnmZLu/8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svEBrRCPSg5Ag3ahZf5TBtxjo5SZmKXtCvR0sb9FhZZ/VpWmBHffW5PGBUuUntRhfXclABWp1O76EcVoGZXOoO+4URIfJeoR6VITmVQpRyUb/goa4LVl8pxq5t+QvEXPFEhvnRUOFPAfn5N/AGxh1xf9atxdswY1EG1rft/ZlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqH5UPQX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC481F000E9;
	Tue, 16 Jun 2026 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630761;
	bh=xXjhlIs8zxJr76IrwrGSVAUPqWNvCAKjbp8TWs9AfyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VqH5UPQXCydvhHXP6As8OWzrtAYQQI9fQR1SaktpGIwZNK9DJdeg7TsaBSYkuZqbJ
	 C4CTf0/dhjig12WKmOi/G9eV/XojAiY6UYGgV96qnjCVh0KDpLcLWpWWuIcavv1sRx
	 Ed+fMUNDlP/aVDRw6UUysOFH/chrO0BWKmqQkDl0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 091/522] Bluetooth: btusb: Allow firmware re-download when version matches
Date: Tue, 16 Jun 2026 20:23:58 +0530
Message-ID: <20260616145130.136016991@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265351-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shuai.zhang@oss.qualcomm.com,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38D246931E4

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

commit 82855073c1081732656734b74d7d1d5e4cfd0da7 upstream.

The Bluetooth host decides whether to download firmware by reading the
controller firmware download completion flag and firmware version
information.

If a USB error occurs during the firmware download process (for example
due to a USB disconnect), the download is aborted immediately. An
incomplete firmware transfer does not cause the controller to set the
download completion flag, but the firmware version information may be
updated at an early stage of the download process.

In this case, after USB reconnection, the host attempts to re-download
the firmware because the download completion flag is not set. However,
since the controller reports the same firmware version as the target
firmware, the download is skipped. This ultimately results in the
firmware not being properly updated on the controller.

This change removes the restriction that skips firmware download when
the versions are equal. It covers scenarios where the USB connection
can be disconnected at any time and ensures that firmware download can
be retriggered after USB reconnection, allowing the Bluetooth firmware
to be correctly and completely updated.

Fixes: 3267c884cefa ("Bluetooth: btusb: Add support for QCA ROME chipset family")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3440,7 +3440,13 @@ static int btusb_setup_qca_load_rampatch
 		    "firmware rome 0x%x build 0x%x",
 		    rver_rom, rver_patch, ver_rom, ver_patch);
 
-	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
+	/* Allow rampatch when the patch version equals the firmware version.
+	 * A firmware download may be aborted by a transient USB error (e.g.
+	 * disconnect) after the controller updates version info but before
+	 * completion.
+	 * Allowing equal versions enables re-flashing during recovery.
+	 */
+	if (rver_rom != ver_rom || rver_patch < ver_patch) {
 		bt_dev_err(hdev, "rampatch file version did not match with firmware");
 		err = -EINVAL;
 		goto done;



