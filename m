Return-Path: <stable+bounces-203418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4282CCDE5BD
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 06:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A3B30084EA
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 05:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9091FDA8E;
	Fri, 26 Dec 2025 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coURInNx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8819309C
	for <stable@vger.kernel.org>; Fri, 26 Dec 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766728700; cv=none; b=bXQVTLkyT1ZYDYhNpecT0tQbB6X12uG5eaIPL8XlhfgNBwYHWiu9yPV78tSSC8LC9kS34Ff4VFFbkOtACalkQuBBoEJwocFF3RfaCZP/2wHAYMHgCxlFaRfwx4zWkyZ4KWzXFZBEEjB1KsGvx7nrP+TQiXd8q4pSDNNZfSuZzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766728700; c=relaxed/simple;
	bh=NTTVqERX9FTQEL3McWJAQL3aH1Bf120MwcBg4zvWWYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtRjkJIQuIVZK66CiYp1AwKydYpAsRwgjRwDt+vtituu9By2PE3LtOi+uWK7h3KmaDQMqraO9D20x4OlACKVZxtDTBcbSK3WN9rnBjsOKxIf9JDiaBpPZOwtGwEJgOI4p3GLdCgIiDnrxb/lvjgtOXX91hBsJuiBekwwgg1poao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coURInNx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7caf5314847so4378679a34.0
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 21:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766728697; x=1767333497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J35MMwRLRI1OhwUaCUkOR32KgBWoW2oQB2rGPnLXRWk=;
        b=coURInNx9GER0/G1k4Au9SakBpGc+uQxuTYgU243eIKI2cY1b6xL29z7ve5RTGOIl9
         7DG61Ws7s6CVXAuxor7U57loHSDebVqG1aZAyTnYrCFbPpM3oDzSwgLzuKesqr2eFcke
         YpOPfZqoIZxC8vHx0NKJZStK8dQualaW0sAKP6PaMwitW6TcBEeLjqdcg46bTZX/oePk
         IMLia6GnGjMlwQJicHJnjfPITDkP0UMPir9lKwXN38szXj3XYce0DFXzDNTtwqC48LJ1
         F5BbJZqGVIZA9EcM/ylCNSEO6FezNJ74X0dEKpzgwclVJx8qWMRu3YI2VzLgm94d9fnd
         Ty2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766728697; x=1767333497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J35MMwRLRI1OhwUaCUkOR32KgBWoW2oQB2rGPnLXRWk=;
        b=MdZmQWxxi2tIfjmGvblSf9GXvoC7OTiljT7HhtmpIcFUO5FI4TPSq97LrVjBUhdG58
         Yha0K2Es0ft3oXWGH3e0/NvXkpZ7XWzxXr3dVdJ371BQI/LnoD3EGSqYBznJ8UDm4MqW
         YiRVSYwb8fG2Xj5iB+Khlhrj4UZS64DZWM+VENIq8iOBl+Ko+xLUIeH10owof4Ew4120
         9HzbdgxCKQGkaOfpqpSLTop0lNHNd9euFwypEH/ndDuxX8DRnG6AqLpoqeZ0s7HNqkLP
         2hSnpJkFVh6Dxc2LxG0sxsziptylX11vAWbUhQ6XIsC3OkKUeYiabVay3TQnWSCsaxfi
         lnRA==
X-Gm-Message-State: AOJu0YynilVUIh9YdWctjR5SExUvyytRwjcdrLWPrvKNEhU8bAQVXUcw
	ZGVXFTZV0AROmLLyKpmfY3PoxpcizLxZuOvFxNLIcZBgrLZ4ti8M3ZqLYKv3sw==
X-Gm-Gg: AY/fxX4JpUgFv3d00pThEHoXDQfcOfYbDPUfBxz48k78OyK2j2agl4V6ArBp3eT0/qw
	wtZZfPVBLJxOQHqCNmfSJbAdmBAoLudR0Q25RlQ8/ScxH85j8eP535wjnuoAVkRcYtmOpP4ZvRH
	UaT2FDntTtBP7fTzP8eDFWxqSGaREZJCoqrqzQzBlteM2sWXL86w2nVROGctOJUp3tio1pLivEj
	Nlm/vqWyh+CXqoIXxc2UjIDPFHFlTuq6tqLaaExCm+M1+wQFrwsoAIU2gpobZPuZRNhD2ImqGuz
	NZKWW+3/n9jqvDlngt7GHackcHU5M8O96Jn74F6srjoDuwzqNEdSdL6f8geOyaEQWHiEL/c3jLT
	ie8gtlkR35n/jBF67RzG33cGtmo0CcQnhb2PYLVu1kHEDu7E0WcbgYvHxxrEYMuuf+ffgXx2Ztv
	Fq+vSSClj/pCXbU9W1eC2A1k8PWII8uskk/RH/hnjgewI8VIyIpwwj4iYn5Y4=
X-Google-Smtp-Source: AGHT+IFYcCSgngrAqqt/msC31T0xeYSRISiEwO4YLCgkxzXcsMbAQ6iCxcn4ohRzGkd20cN3NXVt5Q==
X-Received: by 2002:a05:6830:2e05:b0:79c:f9ff:43e with SMTP id 46e09a7af769-7cc66adcd8bmr11340183a34.28.1766728697341;
        Thu, 25 Dec 2025 21:58:17 -0800 (PST)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66645494sm14532416a34.0.2025.12.25.21.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 21:58:17 -0800 (PST)
From: Adrian Yip <adrian.ytw@gmail.com>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Junvy Yang <zhuque@tencent.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Adrian Yip <adrian.ytw@gmail.com>
Subject: [PATCH 6.6.y 2/2] net: openvswitch: fix middle attribute validation in push_nsh() action
Date: Thu, 25 Dec 2025 23:56:05 -0600
Message-ID: <20251226055610.3120437-3-adrian.ytw@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226055610.3120437-1-adrian.ytw@gmail.com>
References: <20251226055610.3120437-1-adrian.ytw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 5ace7ef87f059d68b5f50837ef3e8a1a4870c36e ]

The push_nsh() action structure looks like this:

 OVS_ACTION_ATTR_PUSH_NSH(OVS_KEY_ATTR_NSH(OVS_NSH_KEY_ATTR_BASE,...))

The outermost OVS_ACTION_ATTR_PUSH_NSH attribute is OK'ed by the
nla_for_each_nested() inside __ovs_nla_copy_actions().  The innermost
OVS_NSH_KEY_ATTR_BASE/MD1/MD2 are OK'ed by the nla_for_each_nested()
inside nsh_key_put_from_nlattr().  But nothing checks if the attribute
in the middle is OK.  We don't even check that this attribute is the
OVS_KEY_ATTR_NSH.  We just do a double unwrap with a pair of nla_data()
calls - first time directly while calling validate_push_nsh() and the
second time as part of the nla_for_each_nested() macro, which isn't
safe, potentially causing invalid memory access if the size of this
attribute is incorrect.  The failure may not be noticed during
validation due to larger netlink buffer, but cause trouble later during
action execution where the buffer is allocated exactly to the size:

 BUG: KASAN: slab-out-of-bounds in nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
 Read of size 184 at addr ffff88816459a634 by task a.out/22624

 CPU: 8 UID: 0 PID: 22624 6.18.0-rc7+ #115 PREEMPT(voluntary)
 Call Trace:
  <TASK>
  dump_stack_lvl+0x51/0x70
  print_address_description.constprop.0+0x2c/0x390
  kasan_report+0xdd/0x110
  kasan_check_range+0x35/0x1b0
  __asan_memcpy+0x20/0x60
  nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
  push_nsh+0x82/0x120 [openvswitch]
  do_execute_actions+0x1405/0x2840 [openvswitch]
  ovs_execute_actions+0xd5/0x3b0 [openvswitch]
  ovs_packet_cmd_execute+0x949/0xdb0 [openvswitch]
  genl_family_rcv_msg_doit+0x1d6/0x2b0
  genl_family_rcv_msg+0x336/0x580
  genl_rcv_msg+0x9f/0x130
  netlink_rcv_skb+0x11f/0x370
  genl_rcv+0x24/0x40
  netlink_unicast+0x73e/0xaa0
  netlink_sendmsg+0x744/0xbf0
  __sys_sendto+0x3d6/0x450
  do_syscall_64+0x79/0x2c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

Let's add some checks that the attribute is properly sized and it's
the only one attribute inside the action.  Technically, there is no
real reason for OVS_KEY_ATTR_NSH to be there, as we know that we're
pushing an NSH header already, it just creates extra nesting, but
that's how uAPI works today.  So, keeping as it is.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Reported-by: Junvy Yang <zhuque@tencent.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20251204105334.900379-1-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 5ace7ef87f059d68b5f50837ef3e8a1a4870c36e)
Signed-off-by: Adrian Yip <adrian.ytw@gmail.com>
---
 net/openvswitch/flow_netlink.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 836e8e705d40..1d9a44d6216a 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2788,13 +2788,20 @@ static int validate_and_copy_set_tun(const struct nlattr *attr,
 	return err;
 }
 
-static bool validate_push_nsh(const struct nlattr *attr, bool log)
+static bool validate_push_nsh(const struct nlattr *a, bool log)
 {
+	struct nlattr *nsh_key = nla_data(a);
 	struct sw_flow_match match;
 	struct sw_flow_key key;
 
+	/* There must be one and only one NSH header. */
+	if (!nla_ok(nsh_key, nla_len(a)) ||
+	    nla_total_size(nla_len(nsh_key)) != nla_len(a) ||
+	    nla_type(nsh_key) != OVS_KEY_ATTR_NSH)
+		return false;
+
 	ovs_match_init(&match, &key, true, NULL);
-	return !nsh_key_put_from_nlattr(attr, &match, false, true, log);
+	return !nsh_key_put_from_nlattr(nsh_key, &match, false, true, log);
 }
 
 /* Return false if there are any non-masked bits set.
@@ -3351,7 +3358,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 					return -EINVAL;
 			}
 			mac_proto = MAC_PROTO_NONE;
-			if (!validate_push_nsh(nla_data(a), log))
+			if (!validate_push_nsh(a, log))
 				return -EINVAL;
 			break;
 
-- 
2.52.0


