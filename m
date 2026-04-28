Return-Path: <stable+bounces-241631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL8+Mqel8GlAWgEAu9opvQ
	(envelope-from <stable+bounces-241631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:18:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB50484B98
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91B2A3189F50
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600763F210F;
	Tue, 28 Apr 2026 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys0dmzq2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08753F0A9A
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374453; cv=none; b=V7lNcFvUYaxzjOwav7BdNaFDNO2aPA6DhJJOuIfwamYngFz3GJUThEIJ1r1O9VNVHPXPb39z0dWbnnCwkNAn1MkO/Ci0mbkz9BO7JXo85pVdFiXl+GcfAo87vy9BvP8+g82i6FHPJGJbD7QHyGO0/pMAb0AAAJhMxc9G1YF6OYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374453; c=relaxed/simple;
	bh=o8i2uC1zO/a2xkebuFDYmXGH5i+hiWFwIKkf2xAeZHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWTOFW9tc5Owbnwkha3arS6yTKTqhQEAVGjbk3gWxNIjB5Bqf2vVAPVI1LWXjQ3BZicHWUvryKjMHePM88r76OL5KY5iX+DtE3U+6m0ZCEbT9PZTpr2MLIRnJTy5xQ/7j69fmuOpDvd1Q+029kcpATIkKXaPKaHGi6S4p2lpWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys0dmzq2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82748257f5fso6467532b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374446; x=1777979246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=winsu62q5y/m4N8BbYwmfb2kAuzIpiVgfaZfSzGuNDg=;
        b=Ys0dmzq2kEmt/rfD7kGSv1AUCdL+lFmRBLqyN3HK/hVC1Whs7WbYmjwoZ8dDRSCzAA
         Ig8U9fNXfwsmQpD/iOL7w1k7QW3XUZj03wiyUfEK1kQ4uq0tHm5dX6XAzpMxG5XlLECP
         TJ07eSekulVIVT763v4LmonkPj8XVhtylK+PteOjJVF2Kzg+Fl19JN3a49irfVTd821q
         a+/VUYIYcv8lmMTL8AE2OyZ+9t8pVxTFrwuS8Wts+zsVQrVL6YD8rZmcrl9CF1xWByWa
         Rd8+meZMJjYzi/XZhTLbvVGI/UFY6jQm9xp3daIwRF1CETbZeafQqjALz7P05Zx/fDpo
         aklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374446; x=1777979246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=winsu62q5y/m4N8BbYwmfb2kAuzIpiVgfaZfSzGuNDg=;
        b=CgpKU3AwKHIcgrsr75HUUSXV4Nd6/bI+cvqiIkq7m3T0oDxCY8PBj5kTvnDV9Pct4/
         gu94E2O1K2BimARH/BO4AG9gdexMyoYuJKCivL7rYsvzTXM/YWCVVTQRtV7S6g2HxHIg
         PgBRm3rtDaEamoWAQAZEjvTn4ca4NJWdTZLIBC7bv9qjY7qQV3IYgWkylBznh8urd4jo
         RSvh4ZtXlKEv2SSXFr26nEk/3VxEiOajRLOwFw5A/55mxEsK14uLTH+ZDRQ13WzsLsoF
         DRKzn9wOO4j9WElsxWSpdIc7PDHWyj9KYSvmqMZm7A9/a/FJCsvbH9Yexs47uMp2dwGe
         s7DQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jbdAakRMvs/PlI81pKLNrasVERtaDsW6CTwrC+672ATInc7Snmgz47cLPrkySeYNOavXZwHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+UFe8huSHDd5oEB+yfklsMqZA4TuG1T/6s2cZEifqu8/ob20
	i2/tCVfnbzY5/BqU8VcV3gjNCVbOrN4+WH4s8UzHrjX10tePn0mUwRDv
X-Gm-Gg: AeBDievoA9WUdLyF0G8bYEZZPvIThXwAc7pwJRI+/vfNk2aRRk6REKMVYy+nH9JZ/Z0
	0R4/pgcjpZe6xljbeHgm7rD6wVdGcpJuWkwp6N7ZRuBINrMTpfBe96AYLfdjetb1QTRcvcpW0Vd
	OSXzO/xCp9sIwrzMHL5u8RczCbp4An/nbevQTrh22ptNXsXoiLCFo9c3MlZNSDDrAzOn6E3LtmC
	vLB2yPUNmXKM0swtxISesN6K7qESdGpVqhohOmn+byICj3bXm3mgIwuFNq0FcSawtdoMqsoHmuP
	Q1WaDRUuJ4Ox79J+5rDEcoky6dWKA0kpfXaFqZplXmRhEVCfuoVcxt0S0T6lupiSjTLCPJ3yfs5
	4ui+mCDfSWVxNCgE3ttBuw7XahGELQmAultDtGfFyBsDTmtut14y6tL0pLJpDpAeOtB/+OfwQ0k
	HxnYDn3hvayPmw+vIXBmDzZnfjBt3M2CePfrTySuHObpcaD/521VbHuLcb5BRq5VZwsiupIw==
X-Received: by 2002:a05:6a20:9146:b0:3a2:d53f:691c with SMTP id adf61e73a8af0-3a39c14961fmr2707035637.26.1777374446370;
        Tue, 28 Apr 2026 04:07:26 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc33d4e11sm2023328a12.24.2026.04.28.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:07:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	shaw.leon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org
Subject: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
Date: Tue, 28 Apr 2026 19:07:13 +0800
Message-Id: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EEB50484B98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241631-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Maoyi Xie <maoyi.xie@ntu.edu.sg>

After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
ip6gre hash via link_net. ip6erspan_changelink() was not converted in
that series and still uses dev_net(dev), which diverges from the
device's creation netns after IFLA_NET_NS_FD migration.

This re-inserts the tunnel into the wrong per-netns hash, leaving a
stale entry in the original creation netns. When that netns is later
destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
slab-use-after-free reported by KASAN, followed by a kernel BUG at
net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().

Reachable from an unprivileged user namespace ("unshare --user
--map-root-user --net"); cross-tenant scope on container hosts.

Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
file) already uses the cached t->net correctly. The bug is specific
to ip6erspan_changelink() copying the wrong shape.

Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link_ops")
Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
---
 net/ipv6/ip6_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index dafcc0dcd..38ac14cc0 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2261,7 +2261,8 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 				struct nlattr *data[],
 				struct netlink_ext_ack *extack)
 {
-	struct ip6gre_net *ign = net_generic(dev_net(dev), ip6gre_net_id);
+	struct ip6_tnl *nt = netdev_priv(dev);
+	struct ip6gre_net *ign = net_generic(nt->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 	struct ip6_tnl *t;
 
-- 
2.34.1


