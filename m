Return-Path: <stable+bounces-264239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x2dbMRRzMWqajgUAu9opvQ
	(envelope-from <stable+bounces-264239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC86919CE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=K+IGvcEb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264239-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264239-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98A7030BF8B5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E611645348A;
	Tue, 16 Jun 2026 15:47:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C144DB95;
	Tue, 16 Jun 2026 15:47:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624865; cv=none; b=RI9Vz/jMVJ8IqRiifioVbDzOy5I5OmZlaA8C+uyT8zGgp6iF3zWWLCJrYcFsGGGDRdhKEvGgpSoydCiUKwxSjF0eWMExenTobXOSdWqr6QN5pzrxhbliJ45rXJO+PcIWvQRVrixopObzEjKU+FjO/Sw7blT8Tih0BqopWHhgk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624865; c=relaxed/simple;
	bh=mnoML2c0/3ske3G/ZxvkT6/fp5dsUr67I3UgzY5jUqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzzBY9+7F3PHB4SP+FI9+ChPo/8j7ikY1y5Muap+juooR1jiCZIlm/h+hiYh57jtK5Y4lFW1BFmm++b2mdhosjOX+ERD5xkP7+SQ23vToLf2J6krRoUuYmn0mTcwn4TRQPSq42AX0swXLEh7TYHkOmmAw3Y2tZivFwZWRaykq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+IGvcEb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6250C1F00A3A;
	Tue, 16 Jun 2026 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624864;
	bh=doveR8SFvbsLpmxqgxcvu9lqCMiYy71m9WL2UL5WIUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+IGvcEbv5IrF4yNZ07EOKCWoDKVsgWOPwFJIcxKckxyqqqENgDNjFwFGzO96ajE6
	 tbwJhvhD9oI8JxQH8Ht1fAa5CBPMgsXNZ+uMRyRg07KbFrNuQR++QjegH5U+MjdRXb
	 PJdAZo0lj/ZuaBqWP/9tFs4DhljklBWHJ0aj87mE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 041/325] wifi: fix leak if split 6 GHz scanning fails
Date: Tue, 16 Jun 2026 20:27:17 +0530
Message-ID: <20260616145059.776864714@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264239-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pchelkin@ispras.ru,m:johannes.berg@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,linuxtesting.org:url,vger.kernel.org:from_smtp,intel.com:email,ispras.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3CC86919CE

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit e8694f7cc29287e843648d1075177b9a2000d957 ]

rdev->int_scan_req is leaked if cfg80211_scan() fails.  Note that it's
supposed to be released at ___cfg80211_scan_done() but this doesn't happen
as rdev->scan_req is NULL at that point, too, leading to the early return
from the freeing function.

unreferenced object 0xffff8881161d0800 (size 512):
  comm "wpa_supplicant", pid 379, jiffies 4294749765
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 f0 81 13 16 81 88 ff ff  ................
  backtrace (crc c867fdb6):
    kmemleak_alloc+0x89/0x90
    __kmalloc_noprof+0x2fd/0x410
    cfg80211_scan+0x133/0x730
    nl80211_trigger_scan+0xc69/0x1cc0
    genl_family_rcv_msg_doit+0x204/0x2f0
    genl_rcv_msg+0x431/0x6b0
    netlink_rcv_skb+0x143/0x3f0
    genl_rcv+0x27/0x40
    netlink_unicast+0x4f6/0x820
    netlink_sendmsg+0x797/0xce0
    __sock_sendmsg+0xc4/0x160
    ____sys_sendmsg+0x5e4/0x890
    ___sys_sendmsg+0xf8/0x180
    __sys_sendmsg+0x136/0x1e0
    __x64_sys_sendmsg+0x76/0xc0
    x64_sys_call+0x13f0/0x17d0

Found by Linux Verification Center (linuxtesting.org).

Fixes: c8cb5b854b40 ("nl80211/cfg80211: support 6 GHz scanning")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Link: https://patch.msgid.link/20260601094157.92703-1-pchelkin@ispras.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4a1cdfc3221ca4..199c63de01457a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1071,6 +1071,7 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	struct cfg80211_scan_request_int *request;
 	struct cfg80211_scan_request_int *rdev_req = rdev->scan_req;
 	u32 n_channels = 0, idx, i;
+	int err;
 
 	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ)) {
 		rdev_req->req.first_part = true;
@@ -1101,8 +1102,14 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 
 	rdev_req->req.scan_6ghz = false;
 	rdev_req->req.first_part = true;
+	err = rdev_scan(rdev, request);
+	if (err) {
+		kfree(request);
+		return err;
+	}
+
 	rdev->int_scan_req = request;
-	return rdev_scan(rdev, request);
+	return 0;
 }
 
 void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
-- 
2.53.0




