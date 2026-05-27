Return-Path: <stable+bounces-254494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MF4HBKZFmq1ngcAu9opvQ
	(envelope-from <stable+bounces-254494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:11:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA55E0424
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC7AA3056969
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C673B8922;
	Wed, 27 May 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlQQSk7J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CC3B83FC
	for <stable@vger.kernel.org>; Wed, 27 May 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865712; cv=none; b=bPQCp6ev9P7kobCUlG4MqAsnrB9IGnEbMrrWQHkLgvDd927636+osWelpt+eRtQthD4Dh/l3IgkzF+0poXq5WLj/WVe9JhYtkidU86JyrkR8m3bDt5iaiMyw0gXtttAYOUf79v0RE1VWYzEB0X8EhnLLdeZSyN3siTKfVXti3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865712; c=relaxed/simple;
	bh=nF3n2ThfGpO8RdPGXZ/I2wq7DrqFcx0MWM75XEXcINc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdH6Xy4T44N67cY79TKfrQkveoKQdEpTUjlRAwUa7+frKCCkH9106rPzTAtQrF62QL28ObK3WRwGNj3nsURFVT7j1iWQLiCVB7h95VqOatkqNng3Xtw9Dl+Yrs2pZJaF8i2bxMD7qTEDu8LJQfuY9ctJ2HoWKGEcisaVkbAzYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlQQSk7J; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba21d32776so83764075ad.2
        for <stable@vger.kernel.org>; Wed, 27 May 2026 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779865711; x=1780470511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1HoGkmmVirBZLUAZ5b16k6gJacJNZCaTPEXJ7dkR0Y=;
        b=XlQQSk7JALkddYkKlN7MVRnwQXE4NCbT1CMlyJCm1NBPIApP42EGxn7X+35mpmMVX6
         tuAxtZk3mS4wKielM3t8lAJN5oeBHlCxAaV3pEp0XjfBGZSifybXnSVrVnJ1dscSsElN
         013ko/2rl0G75IYMZ+FNaabA4/wobu4lWTwtsCym6ooUzQFua0BIVc8TNudC4J0LnbhL
         7hc3LDJ7/avXJzd7AlwT4rTJn/Apd/U24LWh4G4YjAxayoGjhHuCFuEC1io5jhiECU4S
         xhGB76I/jIq8iHF5hxFaDuAB+BFKjcy5ZY5nkkGxVlUTQHwizHStRDULK3zcLLUmQQmM
         NLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779865711; x=1780470511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1HoGkmmVirBZLUAZ5b16k6gJacJNZCaTPEXJ7dkR0Y=;
        b=BcXn7nn/smIXbSdNiZeo3LAVPm1pkEpvQJs8A2bJxlFKtTc9JbDvd+JjstMl/YoYxB
         ANFH3Y3hCn7YfikOm2aHN5TSdhvP+WLorU6istYeKm0nS5gQsVGRVAUi7+BhO7DYXeqY
         Ie2cCxksreFjHBfMDOFNafvNWrrhOhKpE5SDEwHvekMyeOt8CcIfLMXua7JkHHZgmc/a
         Z1TkRcxffgayqDLIK9uEYRM9SPejsCKGe7nYByjsmeRTLbi3iPB5HhzofwRIhfUwqrA6
         mGTNew/8Pv8ErTJxOQ2oDNLVlwHEA+VLuxuXUPkoDG3m/d1iXAwx0thlw2uN0pOSkcdN
         s3Sg==
X-Forwarded-Encrypted: i=1; AFNElJ9oQidh5VOCZ0a2DPPRaQVjdPkbC8NrGGw0O7RdvSvD4mv3DnaYDgtM6eoQP2+tm3hCEC0pxNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfMZzRHjdakF36l4v5yzmVrQLb6CHyPB9GY+IkSceqSlPAv1Z
	c6HvuAJKEbrz0S7+FXqXdX81Yj+puEyiehPfVcSEgMQ/VVqF3XjkWQhp
X-Gm-Gg: Acq92OEmoFoTO1W+BPYJLjOwiWMXMkePCcSqd7oK1gCI1WDTTwEusRuqErvpAn8RlaU
	z4El/o51qVHu300TWmObWRiYo7ir5p7MuO7NI8z9JSTMEvz0ZibDkjRmMiARhYBfwexZkjpVqtK
	wqNkJrN03e55GORvyaKT34MYBI0UrevhWDN3M7t2D+ni/W4i1sFYmGj1L+Z5cDqtiTP9giS3fwB
	X11nuFPQ4bqe7HLd6qrdIMaJPOSspUGKfmVuiWpQKdUIKQnMyLyTqn53nCKzj4mfFhQBeynU4nb
	eb/mOvdM2OmqNddJEt3jWbGji2A5eEE8eG7DOxImwboZfm6YD+BsfyMrobAIJwcWJv/5B9lMHVA
	6MWd2glfMGPjTAtVSzyjcIvuyKj/Vgk4Tbb1u/ZWBRK3i+gBAqZSEzsR/1nC2Sum59p0pxT53L3
	Sa6CLPVbX7qkzhzFmEzyDt1efty3wTNusGFKgmCM9wZQmazg4NXHTbTJQDVX8=
X-Received: by 2002:a17:902:cec8:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2beb05b5668mr238431435ad.20.1779865710850;
        Wed, 27 May 2026 00:08:30 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b386esm149817855ad.44.2026.05.27.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:08:30 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
Date: Wed, 27 May 2026 15:08:24 +0800
Message-Id: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254494-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ip6_tnl.net:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 03DA55E0424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in
vti6_changelink().") made vti6_changelink() and vti6_update()
mutate the vti6 hash of the device's creation netns. The
rtnetlink path into changelink never checks CAP_NET_ADMIN
against that netns. The only capability check on the link netns,
netlink_ns_capable() against link_net->user_ns, runs solely when
the RTM_NEWLINK message carries IFLA_LINK_NETNSID. A plain
"ip link set <name> type vti6 ..." does not carry it.

So an unprivileged user holding a migrated vti6 device can
rewrite an entry in the creation netns vti6 hash. They pick the
endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") already closed the
SIOCCHGTUNNEL path. This patch closes the RTM_NEWLINK path.

Other link_types are affected too. Any type that publishes
get_link_net and whose changelink touches t->net has the same
gap: ipip, gre, sit, ip_vti, ip6_tnl, ip6_gre, xfrm_interface.

Check netlink_ns_capable(CAP_NET_ADMIN) against the device's
link netns before dispatching to rtnl_changelink(). Types
without get_link_net are unaffected. The newlink path has long
checked capability in the link netns. The changelink path never
did.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 06615bed60c1 ("net: Verify permission to link_net in newlink")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/core/rtnetlink.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index df042da422ef..ac7a3bf438d5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3969,8 +3969,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	if (dev)
+	if (dev) {
+		/* changelink may mutate the link's creation netns.
+		 * rtnl_link_get_net_capable() above only checked
+		 * tgt_net. When the creation netns differs, also
+		 * require CAP_NET_ADMIN there. Otherwise a migrated
+		 * device lets a caller with caps only in its current
+		 * netns mutate the creation netns.
+		 */
+		if (dev->rtnl_link_ops && dev->rtnl_link_ops->get_link_net) {
+			struct net *dev_link_net;
+
+			dev_link_net = dev->rtnl_link_ops->get_link_net(dev);
+			if (!net_eq(dev_link_net, tgt_net) &&
+			    !netlink_ns_capable(skb, dev_link_net->user_ns,
+						CAP_NET_ADMIN))
+				return -EPERM;
+		}
+
 		return rtnl_changelink(skb, nlh, ops, dev, tgt_net, tbs, data, extack);
+	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
 		/* No dev found and NLM_F_CREATE not set. Requested dev does not exist,
-- 
2.34.1


