Return-Path: <stable+bounces-203130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F1CD2C12
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 10:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E020A3013388
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 09:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728D2FFDEB;
	Sat, 20 Dec 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxRVzNp3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F52FFDD8
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766222423; cv=none; b=Sk84hjUS6OZfgURjYWQ3rYohZc2WCChZ2UUJMfXOokwqAwfMFZHMG23Ei7sOUbRLp5YWUn7QFgZ0UlQYUw9KKo0VI8lD9QVUe+EwuJmCJI9Z3VNz8sWuKIG0DCcPzC7RAvYsP6gJkEC3rL+1ilDtKvE2/kIevRTEGtLmzMo9rDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766222423; c=relaxed/simple;
	bh=Daaz4o2vbQEuaBUAI80RqVDPPgdoj+8ZAOZ5YUluhgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPcIqD+Rct3GYqT+EhwGrHGBDFe2trFHtYm9uMfEXjqolgpLq0GCKocNetqWZ5LKMl6qab9jCmTiIQ6ZJj86gULkRtxMOL0+oDlp3H2nGiwFBPycjtXUHKqeGKNXO6C+9tOYk+H5guS4a5yhowe5bZJEZyZfo785RRmMMqZPFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxRVzNp3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed82ee9e57so31459011cf.0
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 01:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766222420; x=1766827220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNisCTFh/jvdeWyigS/01un+TGTuRdNBQti/UMEC4vk=;
        b=hxRVzNp3LGchbE9Y4As7FOOLEZmASRR2YEAqx/eRxEObLi+3t45LQmM6KCNCmcmUw+
         veLxnJc6t5LXWjaM6o1v69mJYufAc90Z+C9qsm0ZuZ56UzNNRAJbfH6j4G2o9RK0cfDU
         GwXoyA5b0HhpF1maXPQaeOseBQNdWs1fAnMLQTegwaw/jVDkykbkQlaj8v5yLzlUh6No
         QHxsEIjy0F1bglsDH1G2J/Yh7PTSCryLV6h2SlHM/GKn44uhD+mefFfTbZw+woo267/y
         yTYQTubSzyzn1LvudLnfQnklbiABo/05ZjRAtoQQA3z/oW/8MUQvorzpcZGJRGlag9ZH
         XsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766222420; x=1766827220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNisCTFh/jvdeWyigS/01un+TGTuRdNBQti/UMEC4vk=;
        b=SkO3eEwlxmzNiK1QptpICPZYR88mAhjVrXDMucofl9lAfp6bRi1w7PISQVtomWjQG6
         lKSsd73gtEivenQjaXUCk43lYXqDOfbRPUY60Arqwrr8nFcreGQvwk8XRuUabqEc3k6/
         z7/SvihdGHHJiwGJjCUPq57XZtW2bvlByFOYYbqrymedEyXuCLuuj9QdfS9jq7b1epc7
         i0hNmsnnvtUy0XwhmnCA1GIyEalPBcmEbkp1cULzun5F5FUW0zppsgdYp/vGtN3CzeUm
         YW65uKvYwCWwPhis+sdw3kW2C6KZ2Onf1hkcT/LJGntcWS9C8vPZVejyvHq8yG/a8cdN
         r9kQ==
X-Gm-Message-State: AOJu0Yy03YGZNAVFA74j+o8GrPW/i2DhIg5XCMhwacQb+3cfk8m+41Hs
	loZflHTkAFpKiC2nJD50UIueQ0qyHwec2twYI5/13GMaPJJIajVwKzrqhWRNVGsz
X-Gm-Gg: AY/fxX4POeEMr5pM8aHgEFBRfGeMcZKSWf2Zxt0oWTP1LSw26gZlNwpY73sX/qg3Yyf
	iFAUV7Ne+FUU+uVsALNo8VioSRvZnydWrD+hVC8/cGnlfomPSS2mQ3d5Dryq423ppauRJrTfw5/
	kWjztf9/WTp1QQEP8OMEbz/mMVkAK3n7L5Z7WXxsl/5I7Y5eo3cRebtRrNvo0qtvgojpBCoNV6E
	yW3JSnkto799NADmTumc87+f758mRRdJLZECLpo3kv/KdqkITRdqL7Hya+4Ftk8b5+1uFZCjVFe
	vpas/8vMnJ2vS3iSRSmTgRDszzN2yXoUtFA93UfdkKYyU25tkbjyeR1MOUJyWfgSOTxUdtsGQ8M
	jdbk8yjv7iIsHLsqjqdMrsy9jsb07sUbmp+XflOWjCwDVyXng5Fcq+QKUZqug/rZy9JS/6zrYaV
	TSimILAX11pUWJVR1k/kHprH490N0i2pB7sCzPWDJYGPm3dzOUgSv0VMl36NY=
X-Google-Smtp-Source: AGHT+IH4H4ZkvasR68lLmuX0dZ89HpmVFzvwt19Y2Ioa5zSggk5Vy5oNmMJVbQfs+uP7Jh5uMApNzQ==
X-Received: by 2002:ac8:5d8a:0:b0:4b6:24ba:dc6a with SMTP id d75a77b69052e-4f4abd80e8dmr83852041cf.38.1766222420211;
        Sat, 20 Dec 2025 01:20:20 -0800 (PST)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d973ad605sm36305876d6.23.2025.12.20.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 01:20:19 -0800 (PST)
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
Subject: [PATCH 6.17.y] net: openvswitch: fix middle attribute validation in push_nsh() action
Date: Sat, 20 Dec 2025 03:18:17 -0600
Message-ID: <20251220091818.562528-1-adrian.ytw@gmail.com>
X-Mailer: git-send-email 2.52.0
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
index 1cb4f97335d8..2d536901309e 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2802,13 +2802,20 @@ static int validate_and_copy_set_tun(const struct nlattr *attr,
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
@@ -3389,7 +3396,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 					return -EINVAL;
 			}
 			mac_proto = MAC_PROTO_NONE;
-			if (!validate_push_nsh(nla_data(a), log))
+			if (!validate_push_nsh(a, log))
 				return -EINVAL;
 			break;
 
-- 
2.52.0


