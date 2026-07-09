Return-Path: <stable+bounces-273060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +d/hBUofUGpktgIAu9opvQ
	(envelope-from <stable+bounces-273060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:23:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC6735FF6
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:23:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cc1B51YO;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273060-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273060-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B926A307A325
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BD3BB101;
	Thu,  9 Jul 2026 22:19:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45E3DE429
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:19:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635546; cv=none; b=OEw33NKdDmrtAT0oP3x0A7MoVN76bCvy+UsEF08aU47GiQTLXvRl1r6wg+vliSv/+JCNN24ef4EYNAlhYRZ/lwaNj9iXFt4AlaE5uUppa2NqUBpLtf9EGY7+PII65zrF9QbwvtGIad4utbmZgDHazvooLtZ82lF3wtPrOOQZV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635546; c=relaxed/simple;
	bh=Z8Zh1AJp/esp9tFm2eyTQefg9Fl7D1o7AgqFROZ1ab8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dj0G5BZcvlJznzAx5Z5xKAdeRziSV7kS6uEH2W/hjyIOLXAF5FbgWGPttRrwjMxDwLCT69AXrgEPt1k2XJ7h0dUrSEu0PKy2gVbBoqL4DaM3rM9drkrFBZp71LwGdfDeRma+JmwDAWG0Y6XBVL8R36yIEdcJlgCCKK0HedbUbSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc1B51YO; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso2320315e9.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783635543; x=1784240343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BqQgw4jCCe/BvKpqMgYyZ70b1id8WmzXWyq/OSrYdlk=;
        b=cc1B51YOtA/6A1kmzmBig9+12v9yAztZhxpH3H685lT903ZqlkL2wm+Z+wm8vttkNz
         lKgMwnobY/phweGr4fHRs3TCP7u/azwuLQKW9j6RVCIAdpb/B+4KCLFGi7eYUWwyheeZ
         kCJvPXXEXeKY1dNFWGsgriCdwpRga/x143RZZyYpSE8TtbNnTHsfir8emVgSpy0itoRj
         rTUOM3248rbSnl1CdISiqEGI5QPVkI6886LwIDY6pBeBfmelDt3wl/g7Hn8gAITPi8E5
         Evy5a50r9+WdNzdetE6fAp/LgF08xbgfvu/RL+uaZOXXc1GKv4CP53bNqr+psE/IvXDZ
         JsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783635543; x=1784240343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BqQgw4jCCe/BvKpqMgYyZ70b1id8WmzXWyq/OSrYdlk=;
        b=i6vroESe/LeIdLLZVm8N939Ti85GGfNTAPSdPp8nH19az4OcTR3+D22xhq9TL5501c
         SZJdefEvflcjMnAZa9Ko+fERs+gIlRGTdtQCSYd5Ewa1SQ7CK/H0jL1Ln70lMhu3ZQUh
         QJ+iCP0Pmjxur+Dp2ewT0Gd55Um5fCZxvQYRv/XSsAaTxK7tH4mnlSCiUkjNKB+zIilI
         LRyN52Vw7Er5XedtcKp40S4eK0vT4IvZqLd+YANDjsvQJUWWV9x5WxRBUke0hzDzAQ7r
         DcdPSIsPVFl2wW/UxoeYksCQOSa643MqQTPC4lgpyGTvqcwg/axm3EnMII6ucQJeJgj+
         xFfg==
X-Gm-Message-State: AOJu0Yz0pQfM8h1tKM/xbVQwFWwzbl1C+/+qsmsg14GxpwG9FYE/Ohrk
	WTIQC0+bQnsLWpe7miqUmLStdzMMBzfZhoorOq0+bZ0VyWvtrzFE49Zh
X-Gm-Gg: AfdE7clLdqIFhlBoK9Xfnc9dfxFD+rp8Qan6xeK2VEaynw+wo19x11dp/Gw4199/P7R
	BIZ9wTEsnixndBGOm24VdOSI1PwjkCJ94k2Y9KVArGwtSwDlJZ3rRpdU6ff9Rly6naIRXKdDtgf
	m1RnIR+PP/gjOK9s8RspzuSw3R6+xeWLVkta8qucp8rdnF0awvkT/e67Rlhc/C8dPDpqUne2qhj
	HPpz1qM3qZWxlSBKc/NeUfRHy+TTL3jcdAFkXATJ7s9d+Se9Hjm+sOCE+vByCsJ7qpK7GMzMlqm
	5v+5jx5nYy3SYAOFwok76qgnankBbkcYlBhzUxrGzEjLCZmDHjR3/Yeyh9JALpyni7C5SfX1u8C
	oYLRBXKZKdp6wJpimvRnBVaGkaunkamKy4/yoamv7DLTmBCCtJ+DQCv6w0AsCtSKpUo/iKt9mFl
	IZ3Aj1P5QCOG5hvUO0Tme50WGXuNZhYz1m09MGaCD1DVxkJNW+GNSi2z3VrIodaSdgtMUWtWS3
X-Received: by 2002:a05:600c:6211:b0:493:dcad:84da with SMTP id 5b1f17b1804b1-493e683c3b2mr83501675e9.1.1783635542767;
        Thu, 09 Jul 2026 15:19:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6e8844sm102269415e9.10.2026.07.09.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:19:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: alex.aring@gmail.com
Cc: stable@vger.kernel.org,
	syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com,
	David Carlier <devnexen@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: hwsim: serialize pib updates to fix double-free
Date: Thu,  9 Jul 2026 23:18:58 +0100
Message-ID: <20260709221858.158063-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:stable@vger.kernel.org,m:syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com,m:devnexen@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alexaring@gmail.com,m:syzbot@syzkaller.appspotmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,syzkaller.appspotmail.com,gmail.com,datenfreihafen.org,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,60332fd095f8bb2946ad,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAEC6735FF6

hwsim_update_pib() does an unserialized read-swap-free of phy->pib:

	pib_old = rtnl_dereference(phy->pib);
	...
	rcu_assign_pointer(phy->pib, pib);
	kfree_rcu(pib_old, rcu);

It assumes the RTNL is held, but ->set_channel is not always called
under it: the mac802154 scan worker changes channels via
drv_set_channel() without the RTNL. Such an update can race an
RTNL-held one on the same phy; both read the same pib_old and both
kfree_rcu() it, double-freeing the object. With SLUB percpu sheaves
batching kfree_rcu(), this surfaces as a KASAN invalid-free in
rcu_free_sheaf().

struct hwsim_phy has no lock for pib. Add one and make the swap atomic
with rcu_replace_pointer() under it, dropping the misleading
rtnl_dereference().

Reported-by: syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60332fd095f8bb2946ad
Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: David Carlier <devnexen@gmail.com>
Cc: <stable@vger.kernel.org>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 6daa0f198b9f..a9bd1555d2dc 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -72,6 +72,8 @@ struct hwsim_phy {
 	struct ieee802154_hw *hw;
 	u32 idx;
 
+	/* Serializes phy->pib_updates. */
+	spinlock_t pib_lock;
 	struct hwsim_pib __rcu *pib;
 
 	bool suspended;
@@ -102,8 +104,6 @@ static int hwsim_update_pib(struct ieee802154_hw *hw, u8 page, u8 channel,
 	if (!pib)
 		return -ENOMEM;
 
-	pib_old = rtnl_dereference(phy->pib);
-
 	pib->page = page;
 	pib->channel = channel;
 	pib->filt.short_addr = filt->short_addr;
@@ -112,7 +112,10 @@ static int hwsim_update_pib(struct ieee802154_hw *hw, u8 page, u8 channel,
 	pib->filt.pan_coord = filt->pan_coord;
 	pib->filt_level = filt_level;
 
-	rcu_assign_pointer(phy->pib, pib);
+	spin_lock_bh(&phy->pib_lock);
+	pib_old = rcu_replace_pointer(phy->pib, pib,
+				      lockdep_is_held(&phy->pib_lock));
+	spin_unlock_bh(&phy->pib_lock);
 	kfree_rcu(pib_old, rcu);
 	return 0;
 }
@@ -952,6 +955,7 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
 		goto err_pib;
 	}
 
+	spin_lock_init(&phy->pib_lock);
 	pib->channel = 13;
 	pib->filt.short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 	pib->filt.pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
-- 
2.53.0


