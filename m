Return-Path: <stable+bounces-152260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EFDAD2FA4
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 10:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8775318947BB
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 08:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108A9280320;
	Tue, 10 Jun 2025 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Czd4aqdl"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E31528001E;
	Tue, 10 Jun 2025 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543151; cv=none; b=XYnsbwmI2SFewssmNywWMl3uvsGfmjzUwXG0qHk9LbKqFlJd1LUfCQovNTrSVDiZqMv7WrVuEXCt7+kzQw44kLt3RgExTZw8F/KLqM5x5wV38f11a/ILjdbaE1Y1CugJ4M72rC5jULBxHNN2efCHOE/4oqaCzslWMX9POdrGF24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543151; c=relaxed/simple;
	bh=1ZSmI9lvwDB6tpuNoVo3E74omalZrE+mFOkIzdIE/jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UlGQFpMoRWY2Y4xXfYq9rXDWWpmHjoyT/UHmtwo+fTt4cic0ShXabIkN9Tm4VGwky1Gxb9oUukz2cL7A84CXKye3uo4elS/zLAtS2ewi/sKPgd8ZMsZOx6bVMA8qJcr54rfy/A0dyCT+CVaN0WV3bKB+3EdRiP7lvhGGbUxuyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Czd4aqdl; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749543147;
	bh=Ocg4iD09njQ9RxLUrunmzP+uw7AMZoj4Hx52RuiUvSA=;
	h=From:Date:Subject:To:Cc;
	b=Czd4aqdl6pmTuYiC7L5hKJFbLsdMtoL3HXDodZZUfmT2Psrt+LidaDIwkDDcu9lvi
	 WanrH/ky/X/uUEqDj3gQBWD1vqWNnGd4MgeV2LHs8WzwEZ2Hbs9O9jvaST1+SZLktd
	 7vSXPVqNt7Wa2vQ0WMLuBPLzyffJ6O4hwa3YaZiU5gV4EF5Otb+9Xzb3qvlfojV5yZ
	 iMvhwxNlInPYBmaPNuamjso4mgQUBzBLL72YJ53S+OtYaXyR+NCEUAz9I3WUKVlM9f
	 k/LrHQUGRSS90gPpn1Qqvu5+cJBha99o3ARoDilZm8+GuQ21Y3tdfVrbHy2RAO7w0I
	 kluFN0aaLqDxg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 6E0AD66732; Tue, 10 Jun 2025 16:12:27 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 10 Jun 2025 16:12:14 +0800
Subject: [PATCH 6.6.y] net: make for_each_netdev_dump() a little more
 bug-proof
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-nl-dump-v1-1-2f05a5fa8358@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAN3oR2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0MD3bwc3ZTS3AJdM0MLcwMDSwPTFJM0JaDqgqLUtMwKsEnRSmZ6Znq
 VSrG1tQBAUWbGYAAAAA==
X-Change-ID: 20250610-nl-dump-618700905d4f
To: stable@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>, 
 Peter Yin <peteryin.openbmc@gmail.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

From: Jakub Kicinski <kuba@kernel.org>

commit f22b4b55edb507a2b30981e133b66b642be4d13f upstream.

I find the behavior of xa_for_each_start() slightly counter-intuitive.
It doesn't end the iteration by making the index point after the last
element. IOW calling xa_for_each_start() again after it "finished"
will run the body of the loop for the last valid element, instead
of doing nothing.

This works fine for netlink dumps if they terminate correctly
(i.e. coalesce or carefully handle NLM_DONE), but as we keep getting
reminded legacy dumps are unlikely to go away.

Fixing this generically at the xa_for_each_start() level seems hard -
there is no index reserved for "end of iteration".
ifindexes are 31b wide, tho, and iterator is ulong so for
for_each_netdev_dump() it's safe to go to the next element.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
The mctp RTM_GETADDR rework backport of acab78ae12c7 ("net: mctp: Don't
access ifa_index when missing") pulled 2d45eeb7d5d7 ("mctp: no longer
rely on net->dev_index_head[]") as a dependency. However, that change
relies on this backport for correct behaviour of for_each_netdev_dump().

Jakub mentions[1] that nothing should be relying on the old behaviour of
for_each_netdev_dump(), hence the backport.

[1]: https://lore.kernel.org/netdev/20250609083749.741c27f5@kernel.org/

This backport is only applicable to 6.6.y; the change hit upstream in
6.10.
---
 include/linux/netdevice.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0b0a172337dbac5716e5e5556befd95b4c201f5b..030d9de2ba2d23aa80b4b02182883f022f553964 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3036,7 +3036,8 @@ extern rwlock_t				dev_base_lock;		/* Device list lock */
 #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
 
 #define for_each_netdev_dump(net, d, ifindex)				\
-	xa_for_each_start(&(net)->dev_by_index, (ifindex), (d), (ifindex))
+	for (; (d = xa_find(&(net)->dev_by_index, &ifindex,		\
+			    ULONG_MAX, XA_PRESENT)); ifindex++)
 
 static inline struct net_device *next_net_device(struct net_device *dev)
 {

---
base-commit: c2603c511feb427b2b09f74b57816a81272932a1
change-id: 20250610-nl-dump-618700905d4f

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


