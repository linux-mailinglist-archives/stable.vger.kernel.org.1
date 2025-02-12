Return-Path: <stable+bounces-115019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC195A320F8
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6717188A64A
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEC0205ABA;
	Wed, 12 Feb 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SzsOk28V"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E927183A;
	Wed, 12 Feb 2025 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348642; cv=none; b=mLgy3F2Wjit/6l/pzL1pqmWY5WSpWiZbRdw66DVjLYtPLHmwqX0o80JExSh+t0i7ctPIQBYw3fCShXQ/8WT1xbZfEddUjIISpAK3z9lS1YitDD5+Gfe0kLupdmD+H7uz15uL10990o7SIJiBeCcL7SKZpvzhAB6oHYSfXJTxC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348642; c=relaxed/simple;
	bh=d0rMPfnONv/9V88xXXShYjjqNokK2s86RyuUEgMmcI0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIEol5acXlp+umQC4dBNBCR9nC19bDULZsODwt1khU4U1TrgmlL07b5Jb3HY4AE2Cp4irEBjegQqiDmGubnvcGODy2P6m+WM3smhepkoOVMQgMgsAqb+MJu4TpKmlnNP7fg5wpfMyWKnhBA2augPYvmW7s1j9ERT8QN1Ggw6llg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SzsOk28V; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E51D4328E;
	Wed, 12 Feb 2025 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739348632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RR2/+YTVmAUHPpKBQsKq78NYGWJcAyMxsNjAeG/knP4=;
	b=SzsOk28V8Ypgm0NnAD52AU2GxIBtbWOEXyQS/dJYPFwn9LVPqnA8XfXFsJtAUcBCAkPsp5
	KKnZ8itnI5uvJHTxKK7w2+IUAywMcCyy7IS/mZI7Yhe4snIoB+4MkDdBd9pTWg+B1szRPJ
	tGyxtKzwFSr7FceHFyn3HidLDqIlFZAyOHK+27ZFrYJm1qydnw45m4ayCDfdXDc27PT9U6
	j7nnddQxUX8QX09nfrFDC6HRuudDVpDLw+55mQzbbGvPjOpKC7fl8bUBos39qcsXRySOzk
	RHP1sVBGYgJmnqBfbjn/ZkIJNQG6Jclh8b7pKwiZKi8KVn1/oeEVo+/I4ZkGkw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 09:23:48 +0100
Subject: [PATCH net 2/2] rtnetlink: Release nets when leaving
 rtnl_setlink()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-rtnetlink_leak-v1-2-27bce9a3ac9a@bootlin.com>
References: <20250212-rtnetlink_leak-v1-0-27bce9a3ac9a@bootlin.com>
In-Reply-To: <20250212-rtnetlink_leak-v1-0-27bce9a3ac9a@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdehgegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhin
 hdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

rtnl_setlink() uses the rtnl_nets_* helpers but never calls the
rtnl_nets_destroy(). It leads to small memory leaks.

Call rtnl_nets_destroy() before exiting to properly decrement the nets'
reference counters.

Fixes: 636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.")
Cc: stable@vger.kernel.org
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 94111d3383788566f2296039e68549e2b40d5a4a..e4ac14c081a48e36f5381e025a3991c90827c2bf 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3441,6 +3441,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	rtnl_nets_unlock(&rtnl_nets);
 errout:
+	rtnl_nets_destroy(&rtnl_nets);
 	return err;
 }
 

-- 
2.48.1


