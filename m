Return-Path: <stable+bounces-26201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D829870D89
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD090B22D1D
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E3047A5D;
	Mon,  4 Mar 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pv33rsAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721A1C687;
	Mon,  4 Mar 2024 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588105; cv=none; b=C6YceoRUtIy7pWtbrp33GYIJ2a72ovaR1jkMexfGN+EP26mDhWo6fUh721OPnj5fN7fW1iQWPjslgs6cpBJEnBFEgnRCXWt6v/Mnbc5R06mpU6ynQ58JHRPYSObLRy0ULf5Vcr+KNkGB/iwBLINyJT/objiCQtyirTJaeSLtD20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588105; c=relaxed/simple;
	bh=mMRkkQWrjE5Yd3N38l36W7hE6fTchs7mcDbdodcD8d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faNWr5Fhkaqgg8YfuvFF//1D0DuG9w72NVzrhvQl3bCr7GgGzjkWtOnWYoNr0xiNVAesugn5E8aDr51s9VT/rqiN0+r7rs/LSy3c64liUtK3cDjyZey29fseH2cRPjn+mYHnI7eLankjFN9BAns1kGeNcGzhg4wxq1iW9vkfWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pv33rsAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA55C433C7;
	Mon,  4 Mar 2024 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588105;
	bh=mMRkkQWrjE5Yd3N38l36W7hE6fTchs7mcDbdodcD8d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pv33rsAQ+m5UeDte8G8Pasd+JNx6BZGbtj7ozvBpEg8Z1zkiELDvxVwTSN/dcBzE/
	 Tn1+b6vNGpxNgqGBXgE8hQG6hoC/MznfsUuZlX3VKkzIpaPSLqs9g3Y6zlW1VJ/thp
	 b9Q/ZWMOYSfCSuG3FhUJrbtb+2a+1WBvS22SpGHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 08/42] ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()
Date: Mon,  4 Mar 2024 21:23:35 +0000
Message-ID: <20240304211537.914894383@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211537.631764077@linuxfoundation.org>
References: <20240304211537.631764077@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 10bfd453da64a057bcfd1a49fb6b271c48653cdb ]

It seems that if userspace provides a correct IFA_TARGET_NETNSID value
but no IFA_ADDRESS and IFA_LOCAL attributes, inet6_rtm_getaddr()
returns -EINVAL with an elevated "struct net" refcount.

Fixes: 6ecf4c37eb3e ("ipv6: enable IFA_TARGET_NETNSID for RTM_GETADDR")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Ahern <dsahern@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 150c2f71ec89f..0429c1d50fc92 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5436,9 +5436,10 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	}
 
 	addr = extract_addr(tb[IFA_ADDRESS], tb[IFA_LOCAL], &peer);
-	if (!addr)
-		return -EINVAL;
-
+	if (!addr) {
+		err = -EINVAL;
+		goto errout;
+	}
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_index)
 		dev = dev_get_by_index(tgt_net, ifm->ifa_index);
-- 
2.43.0




