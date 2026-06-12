Return-Path: <stable+bounces-262885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75yjOsnKK2poFAQAu9opvQ
	(envelope-from <stable+bounces-262885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB36678041
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kUd4WPyZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262885-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262885-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2666031B8CEF
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88F36F91D;
	Fri, 12 Jun 2026 08:59:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E13264FD
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 08:59:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254789; cv=none; b=FfJC0XAjVzB4GGK/L0R+ba6/5ANEDpxkO3AOOwmVbM8U+NXxkUQkzXeSNnOM/tf7+CgXh8oh6M58pgZaZbXfmJX56NApRX7SqMWt0QPZESpzaAyxZBSCwaFacQRBO8QRbygXCcURs+js0C14MNqc4CDVzKvmPfT5jBw1z7tqrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254789; c=relaxed/simple;
	bh=V9K27Z1kCTaIw8JicL5nH448Qqv6eCiY4PFrU2QptTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlMgF6m38TZULdtDjaWv6NPedH3FmZTo4eKJtOlKnrRoojlcT8z/GPcNLC/LCPelriYNmSm4YMXrHJ6TfiQyvX7Owrew4K9D3GjXU7Kh0Zk5lxM02Q3fgnXABykoO0JNsyKQ5hmxR/0G5b2ZolHem3JKo3XIQVymhMKwk1QI32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUd4WPyZ; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f420455so415207b3a.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254787; x=1781859587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JT58991Fc/kvJc/k1XrxFwWPuGlglWdrNDxsq4ctiO4=;
        b=kUd4WPyZg8mRDSmjDki8oiCqhOyd4qOhFOt1p8oKzzw26s9v7rCBRi2hsJUB6RqAPo
         uWPMJo6qcf8Mfn4c7x/HD3dOfcZdshwO6yDFa+cKxFgThsgsiU+tei39zAY1yFNrRrG6
         5OaRudDeWvMpOg61bZjooq3uvG/0Zoh0TB/1YeRhnbt9859AuQdf6Wy8CV2CKyfyism3
         7HwUaJQv7Rs8T7Uq8j4GKfTwyjloY1xptmBJ8LM5gMwsWQVGAD9WyFeXx02T/bHOforC
         FWMJT88/G4n8zo0T8B078VeOyvq5nsZOfip7wlY9JHkLLhYrKzUsC9jAlkAH43VFNXxQ
         do5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254787; x=1781859587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT58991Fc/kvJc/k1XrxFwWPuGlglWdrNDxsq4ctiO4=;
        b=pXDLrGMJWE/QVRTX3REW0y+sUz5Wc+xY/2+X9a0vwL0J5kcLVSx+Bqhim3v1RI5q33
         OJhE76UD+x90jew0xhj3XKVdCbNwd6Iex51122X3Avge19oolTTsG89BCZl1eNN3YuNT
         sXk1WE6NP20c2J26mmNwtVxz+xjejaGUkgx2zn313pW4dAng7gxMxPtm62e3tr7RIuf3
         Yz8JSJEUQdYrYwsNw5DnDjbhSxp7g4/43pBB1CuP14WKZaXE1fjPw73hpnUGOq5IN4Gp
         Q28u1HuCgQwfW81WzYVPoR1vms6virUGTBmQlbCpygDhQp8+Ids6jaciEnhNuSYBDlW+
         twBQ==
X-Forwarded-Encrypted: i=1; AFNElJ++TN5S1DatXm988ft4NdRN+Ns1DZ5itqtPyTdtc7eweebPOXKnJHBownoog1u2MIcr1kh3lFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkv+WmcH1tOtxTA8+jkBgVEmgAVILGyq1G4p+SjBa31GUH6WsA
	70GvXfbZBP8CFaLH1OPA0v0R+kllL6Kvw5UgfbpdqbxpjDjBw4+q1Aah
X-Gm-Gg: Acq92OH3Dir8lQv56mvYsjUuXVl3EsK7HNiu7xL00FjAeu+ia5GmqXatrOm8/SCf2MC
	POXOsOKbDVJ9Z5Hh3c52icJ5e1T+ssKUgRLyKpUb9x83phnL7KIr/71LjfoD/HrYxVixqjsRT1a
	jwNfHrmGZ3ahF/JpUAxzEMTGsaGSZrAPwlj0bnwUC0xPUdITMUoEVrqSqQWoskbNic8KrIopV89
	8kz030BE367bjT98PRPOEJnVvUtyljIFPdF5g+6aj7Qg3Ovu65TWrJ514mY0fwVNMHSanyIk2Zg
	4QxPbd8lIwI8gMXKtUlBRELbqe9KiwI2WzLIg0MAe/6rbxahTNrbtZ0jHMesNSfg9eRdVMXA9r+
	Z7IGAYZiBnsItLQmkeYH1l66FEqeIaqo2sqIzpoNGLKgl2cXZpjYB38ugLx5AvS4XcEwVD/FA/2
	Nwh+UqP5uVqFzkz8Xx57f3uR/ZTDf+XDmrXSWb6qMQUogRSldH
X-Received: by 2002:a05:6a00:301f:b0:842:7296:dba with SMTP id d2e1a72fcca58-8434cd49168mr2176839b3a.7.1781254786995;
        Fri, 12 Jun 2026 01:59:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:59:46 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 0/7] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Fri, 12 Jun 2026 16:59:34 +0800
Message-Id: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-262885-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixie.tju@gmail.com,m:shawleon@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,gondor.apana.org.au,google.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FB36678041

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the tunnel link netns t->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in the link netns can rewrite a tunnel
that lives in the link netns. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
ioctl path. This series adds it on the RTM_NEWLINK path.

Each changelink is gated at the top of the op, before any attribute is
parsed, because the per-type parsers can update live tunnel fields first
(for example ipgre_netlink_parms() sets t->collect_md). The check is
skipped when the link netns is dev_net(dev), where the rtnl path already
checked the cap.

The check goes through a new helper, rtnl_dev_link_net_capable(), added
in patch 1 next to rtnl_get_net_ns_capable() in net/core/rtnetlink.c.

Tested on net/main. For every tunnel type in the series a migrated
fake-root changelink is rejected with EPERM. For vti6 SIOCGETTUNNEL
confirms the link netns hash is left unchanged. Legit non-migrated
changelinks still succeed.

v5 -> v6, addressing Kuniyuki Iwashima's review:
 - Correct the Fixes: tags to the commits that first added x-netns
   support / namespace changing for each tunnel type, where the cap gap
   has existed, instead of the later "fix namespaces move" commits.
 - Add Kuniyuki Iwashima's Reviewed-by to all patches.

v5: https://lore.kernel.org/netdev/20260611062814.2528793-1-maoyixie.tju@gmail.com/
v4: https://lore.kernel.org/netdev/20260609163110.1717419-1-maoyixie.tju@gmail.com/
v3: https://lore.kernel.org/netdev/20260604125055.3254652-1-maoyixie.tju@gmail.com/
v2: https://lore.kernel.org/netdev/20260601034148.1272080-1-maoyixie.tju@gmail.com/
v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/

Maoyi Xie (7):
  net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ipip: require CAP_NET_ADMIN in the device netns for changelink
  net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for
    changelink
  net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
  xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for
    changelink

 include/net/rtnetlink.h        | 2 ++
 net/core/rtnetlink.c           | 8 ++++++++
 net/ipv4/ip_gre.c              | 6 ++++++
 net/ipv4/ip_vti.c              | 3 +++
 net/ipv4/ipip.c                | 3 +++
 net/ipv6/ip6_gre.c             | 6 ++++++
 net/ipv6/ip6_tunnel.c          | 3 +++
 net/ipv6/ip6_vti.c             | 3 +++
 net/xfrm/xfrm_interface_core.c | 3 +++
 9 files changed, 37 insertions(+)


base-commit: 512db8267b73a220a64180d95ab5eebe7c4964a8
-- 
2.34.1


