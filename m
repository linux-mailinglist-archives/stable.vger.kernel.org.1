Return-Path: <stable+bounces-274586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NRc/EsCyVmpSAQEAu9opvQ
	(envelope-from <stable+bounces-274586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2C759219
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R8FD+JZD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274586-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274586-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EFF9301E466
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B03E171E;
	Tue, 14 Jul 2026 22:04:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3F37E5E3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066671; cv=none; b=B3Qio2ejfW7ul+A1ZA4lnMWIXhk9hpnIELRb6DdjoXI9ZRcx+6sFUlll/GvioGz77AkuZiG+T7XeTsHgnTo4zA4kjPnDLCr8lHkneUivfKLZomFlj43UaBKEx04xcjIkgK0unacJ/nWV4g1BF7Xiaij0fEx4ovTRWXrkRS9jzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066671; c=relaxed/simple;
	bh=fWtOH2LfXQcNuwTkOuzYY6BAytKoxt/PAYIKkigl72Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEQHxXBXzyukSscXzurAHh4aCulhulZSlbJ1lKXgGaIwQwiz9NQQSyF1npoJI+/7+CKjqEdfApALd9d1U5Xroj+0EO+HVnP3Tx9voEkpUGJPDoJ7DE1frtlKUAw38BUdSdnDzmYKiRgWU/ZNbYIMQYyuGLSYK6jG+CwHtuGd230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8FD+JZD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FBC1F00A3A;
	Tue, 14 Jul 2026 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066670;
	bh=xHpwOvvfSXMrQsDthRp4dsJozTchtQ8ro5xNDZ22bCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8FD+JZDexRuJpOOytV2Qm7s+uwVyyhg+nJNsTHDT/c+YxvxhuuwRkxtZoX9A+6LP
	 IoOkQwkWqc3N7GPwLSdDZFlSfi5WBqum10dzHR+mbqkpqxvCzDlRheb4DjHh0s5kxw
	 oSzYnAjAuteJQtfcla8Mt+NqjCGuNmciQdOIOBucnJ9PaMeYOD2zpbfr3puTaK0vYk
	 hn4BM42ehZB+3yeNJjX4ACNSrmsXcH7+cl9Qoex8qw7Vdhu/PmtrkrZ8X05pQlCg55
	 q990UZcA+sHtkMxSrEE8gHbXWC/CsJbdC0bFo0YvY5BnKyMvdhisn9Hhfyj3pe6PaK
	 MOPqAgRb2yoEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable <stable@kernel.org>,
	Luka Gejak <luka.gejak@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] staging: rtl8723bs: fix heap buffer overflow in rtw_cfg80211_set_wpa_ie()
Date: Tue, 14 Jul 2026 18:04:26 -0400
Message-ID: <20260714220426.3334125-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714220426.3334125-1-sashal@kernel.org>
References: <2026071335-spindle-refutable-39c3@gregkh>
 <20260714220426.3334125-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274586-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:hossu.alexandru@gmail.com,m:stable@kernel.org,m:luka.gejak@linux.dev,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:hossualexandru@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.dev,linuxfoundation.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42F2C759219

From: Alexandru Hossu <hossu.alexandru@gmail.com>

[ Upstream commit 5a752a616e756844388a1a45404db9fc29fec655 ]

supplicant_ie is a 256-byte array in struct security_priv. The WPA and
WPA2 IE copy paths use:

    memcpy(padapter->securitypriv.supplicant_ie, &pwpa[0], wpa_ielen + 2);

where wpa_ielen is the raw IE length field (u8, 0-255). When a local user
supplies a connect request via nl80211 with a crafted WPA IE of length 255,
wpa_ielen + 2 equals 257, overflowing the 256-byte buffer by one byte into
the adjacent last_mic_err_time field.

rtw_parse_wpa_ie() does not prevent this: its length consistency check
compares *(wpa_ie+1) against (u8)(wpa_ie_len-2), which is (u8)(255) == 255
when wpa_ie_len = 257, so the check passes silently.

Add explicit bounds checks for both the WPA and WPA2 paths before the
memcpy, rejecting any IE whose total size (wpa_ielen + 2) exceeds the
supplicant_ie buffer.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable <stable@kernel.org>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
Link: https://patch.msgid.link/20260522004531.1038924-4-hossu.alexandru@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 5cfe245db9b2dc..9c9110cc28828f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1481,6 +1481,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa = rtw_get_wpa_ie(buf, &wpa_ielen, ielen);
 	if (pwpa && wpa_ielen > 0) {
+		if (wpa_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa_ie(pwpa, wpa_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPAPSK;
@@ -1490,6 +1494,10 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
 
 	pwpa2 = rtw_get_wpa2_ie(buf, &wpa2_ielen, ielen);
 	if (pwpa2 && wpa2_ielen > 0) {
+		if (wpa2_ielen + 2 > sizeof(padapter->securitypriv.supplicant_ie)) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		if (rtw_parse_wpa2_ie(pwpa2, wpa2_ielen + 2, &group_cipher, &pairwise_cipher, NULL) == _SUCCESS) {
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_8021X;
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeWPA2PSK;
-- 
2.53.0


