Return-Path: <stable+bounces-234342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI5+HFOd1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:24:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE413C09EC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D1AE302C1E7
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AF3D9035;
	Wed,  8 Apr 2026 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQ2poR0Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0823D9030;
	Wed,  8 Apr 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672611; cv=none; b=CeM9DN8n8Bg2ptZa44zj5SIBfzpLGmXQsMywElUARfRz3bQhi7XP47F8sF+oZ0muNxsSeOHrSSYMOSumXrz2x7tz7A5mDe1kmUfEoNVjX83qwH5/iGsUqRuy/rHh8mpppiCXfffIkGArAWn6YYTOoy82NrQ5irH8s0caXUygFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672611; c=relaxed/simple;
	bh=FX2QEFBsvkvNBADE2yfSqXSkC67UbS/E1AMYU23YpeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INy/biMaICSfxzP2FD3Ahe04Ah15qgpom1BfxOghdgTfnGrmd/7pjf8ZHi/kEcu43zrWNpWmek+dY/tXIxow5iBGOPKZh953jar59YkPxz1EwFENS2cbNWZ3e7FTJqD46cQ97UJht7VCayn6ORuZts3UIzBoEPbj74nzPt78pdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQ2poR0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEEDC19421;
	Wed,  8 Apr 2026 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672610;
	bh=FX2QEFBsvkvNBADE2yfSqXSkC67UbS/E1AMYU23YpeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQ2poR0YvEYG7VCyBGlNVq2dKS1UnXE+ONWizPorVJvlBXRqorYoypdubRFaf/Vyy
	 pESsVWbNgXfDSkneeg3CKBCOfCERRxDitCYXw2AT+cOAtBuD8HDqrnW7aDZWoZn64n
	 j0aBsnHm3TOAUxAYOIkXRAJRPIu4xlb5rX917hC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.6 074/160] wifi: wilc1000: fix u8 overflow in SSID scan buffer size calculation
Date: Wed,  8 Apr 2026 20:02:41 +0200
Message-ID: <20260408175915.962999955@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234342-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1BE413C09EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

commit d049e56b1739101d1c4d81deedb269c52a8dbba0 upstream.

The variable valuesize is declared as u8 but accumulates the total
length of all SSIDs to scan. Each SSID contributes up to 33 bytes
(IEEE80211_MAX_SSID_LEN + 1), and with WILC_MAX_NUM_PROBED_SSID (10)
SSIDs the total can reach 330, which wraps around to 74 when stored
in a u8.

This causes kmalloc to allocate only 75 bytes while the subsequent
memcpy writes up to 331 bytes into the buffer, resulting in a 256-byte
heap buffer overflow.

Widen valuesize from u8 to u32 to accommodate the full range.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Link: https://patch.msgid.link/20260324100624.983458-1-yasuakitorimaru@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/microchip/wilc1000/hif.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -162,7 +162,7 @@ int wilc_scan(struct wilc_vif *vif, u8 s
 	u32 index = 0;
 	u32 i, scan_timeout;
 	u8 *buffer;
-	u8 valuesize = 0;
+	u32 valuesize = 0;
 	u8 *search_ssid_vals = NULL;
 	struct host_if_drv *hif_drv = vif->hif_drv;
 



