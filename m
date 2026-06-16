Return-Path: <stable+bounces-263892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z6GxFC9pMWrGigUAu9opvQ
	(envelope-from <stable+bounces-263892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:18:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EB690E3A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:18:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IrLkrKjr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263892-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263892-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC2233030ED7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812743E486;
	Tue, 16 Jun 2026 15:17:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBA43E9CE;
	Tue, 16 Jun 2026 15:17:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623021; cv=none; b=pC2zTL6SRfKsKfMEboWaRciOrfy81uFVYj9Vq5lFL1S5I4SO/4WqtCvTGG9ksskbKOchTd5dy1uQddOAdR61ncMa8HbUiCU1yvVRyNXp2M5IERVLAIhp1lqomy2AHRzT3XibDzCDlSdOZEOIQwKPc4C5nJD2T8oCu1BIWYjqC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623021; c=relaxed/simple;
	bh=4nIIU7ZYpxfLJElAn6yhHFO8ZvA0H9zgDw4k6r7czbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQTW8UVvuNg/gqeGawkL5VY5OOVUQdP5YgyJBwc6z36XhF00w+/OwHLuBBvzMw63QMxS901FJITy6QAJajp8ICGW75f+6CFi2xeO8qx+iBmRw1X+GIj5RiQwbQpprp9S1poKcHSRzzShsV2LtRkNAmloqGKPeE70+M8btBwDj+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrLkrKjr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312FB1F000E9;
	Tue, 16 Jun 2026 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623020;
	bh=V58vMTf/gIbdDE9TJu4f0/E3AG91MdxIUeV+k1wUwTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrLkrKjrHEyivl+VBh75Lk1r2izkBGYmHAh/MI+3fwPXXEBvZ3j1OhT09ByrR8hW7
	 fl34X9MCq0ZC+MSHdFaD7REehsI3fKP1xDujdTCvQ0Rb+vq1gRVUBKes5h0G/gt1MZ
	 RvysIk5+9Eav/j/HLWV0EIF9XKJOPeTgFVztCfoU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 040/378] wifi: fix leak if split 6 GHz scanning fails
Date: Tue, 16 Jun 2026 20:24:31 +0530
Message-ID: <20260616145112.005123961@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263892-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pchelkin@ispras.ru,m:johannes.berg@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E78EB690E3A

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 358cbc9e43d851..27a56ee2e8f0b3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1071,6 +1071,7 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 	struct cfg80211_scan_request_int *request;
 	struct cfg80211_scan_request_int *rdev_req = rdev->scan_req;
 	u32 n_channels = 0, idx, i;
+	int err;
 
 	if (!(rdev->wiphy.flags & WIPHY_FLAG_SPLIT_SCAN_6GHZ)) {
 		rdev_req->req.first_part = true;
@@ -1100,8 +1101,14 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev)
 
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




