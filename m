Return-Path: <stable+bounces-123722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F8A5C6A3
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484517AC9A9
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132325EFB2;
	Tue, 11 Mar 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X3uf9QZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D825E813;
	Tue, 11 Mar 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706774; cv=none; b=TM34wJpntjEckC3IrjmcaEgrKPqsEO4QTfcpX89qI2LRdz5MRjVnN2pQFKfPt4fRIAL7zLBq6TOfuRmXEpNa1RXWrvJzeiujXO411Cd/OnVb9BIOHTXsS5c/oc2Q7Qpdf6OVrCXThx+z/BhAIwVIY1hPZd9qXS65UiemUBhnrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706774; c=relaxed/simple;
	bh=U4nQGqDYEYau6BF7jp3wLufIqNPDGygBh/pgS7Wg79E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE7WtIzjnC6a/d+9Lo6I8qwSEcB8UAQEL6IB3vmwkl4Q4M7xf+UfNhKGK18xKwSQTZ+DMIHrmmE+SCAO6NFgdMs8UdYotDyB4g2bgJ2inm54yNIRcpij/gkJ6radMHAWj30CnboVpqZw+fWxRl5Db4MDmplZ6o1ZIkuBCb6okyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X3uf9QZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2422C4CEE9;
	Tue, 11 Mar 2025 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706774;
	bh=U4nQGqDYEYau6BF7jp3wLufIqNPDGygBh/pgS7Wg79E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3uf9QZIjVXh0MXUm/ESybzrLjzwK92RWA+UgPy4euEKlBuHFITHrqJ1Eesu2Lmky
	 PlHkdISZrF2kUjUoYL7ahsrnPpCPbqEHTU1fQwyAvB6SiBgKbbtiT6sW+87oCbprF6
	 U86/I5RYPzal5YsDHviEzNpWMjY6P8xd++NscW3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Stas Sergeev <stsp2@yandex.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 162/462] tun: revert fix group permission check
Date: Tue, 11 Mar 2025 15:57:08 +0100
Message-ID: <20250311145804.743040165@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit a70c7b3cbc0688016810bb2e0b9b8a0d6a530045 ]

This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.

The blamed commit caused a regression when neither tun->owner nor
tun->group is set. This is intended to be allowed, but now requires
CAP_NET_ADMIN.

Discussion in the referenced thread pointed out that the original
issue that prompted this patch can be resolved in userspace.

The relaxed access control may also make a device accessible when it
previously wasn't, while existing users may depend on it to not be.

This is a clean pure git revert, except for fixing the indentation on
the gid_valid line that checkpatch correctly flagged.

Fixes: 3ca459eaba1b ("tun: fix group permission check")
Link: https://lore.kernel.org/netdev/CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stas Sergeev <stsp2@yandex.ru>
Link: https://patch.msgid.link/20250204161015.739430-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 52ea9f81d388b..3a89f9457fa24 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -586,18 +586,14 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return ret;
 }
 
-static inline bool tun_capable(struct tun_struct *tun)
+static inline bool tun_not_capable(struct tun_struct *tun)
 {
 	const struct cred *cred = current_cred();
 	struct net *net = dev_net(tun->dev);
 
-	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
-		return 1;
-	if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
-		return 1;
-	if (gid_valid(tun->group) && in_egroup_p(tun->group))
-		return 1;
-	return 0;
+	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
+		(gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
+		!ns_capable(net->user_ns, CAP_NET_ADMIN);
 }
 
 static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2776,7 +2772,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (!tun_capable(tun))
+		if (tun_not_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.39.5




