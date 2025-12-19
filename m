Return-Path: <stable+bounces-203060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7DCCF512
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 885BA3007DA4
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E1320383;
	Fri, 19 Dec 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbsybEQ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CB31B819
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139362; cv=none; b=BteUjh/r8hGy1loZYNzsNAPL7bZ+Zy9Gs25KSyXwrUQblPOlE/OLuuaB9vV6RuuHj5oNIPcpveDwAMxOc9k0WKSD5Z0JsYf390LYxGXewl9Lr9DxXVGTj/oOUQMezneV7J4cTFUQJcMxfYFkejq+01cTjohHV0/ZEcGcQOmqvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139362; c=relaxed/simple;
	bh=qidbgDXVZp6ykR2+/5IXt/BtQBS3pxJcPWemvyiEHMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5WyXrB0H3dy81sAjxmdCImYl9j4AU60uVSiLtC5qYu7US6ZQRyxTS4Ji2PVuwrD/69ectIqpZBYcuSocsB0QsVtK+8i4GMnxqIjFYuRyomJEiPtsAJe1ubBqCqHSfZ8UB4Ksb0pH6YvugASbAljW7/LRwesTp33wyuGhqnq7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbsybEQ8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88a346c284fso17481966d6.3
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766139359; x=1766744159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycLYVRrePvHyQPkdfYXnS+tZaNi7CZqNfdDOVcOxfeg=;
        b=VbsybEQ8dfQH3x0pTBecsAEJtVK4aTld2mAtOucwURN0giqhqd8Bg+5QdOUAmGx4tr
         Q6HzK6o4tWn7uClhmjnqiixmTsaZ84e9jSV5h1uteyCudhFsaCAGyj/oheb7MbNxnmGc
         FANhdX5C69jI0kUYdyOitrttA7kNRNPT0EniuZPQA1SyeA4g90BoB5oiBMTYLqjQBxSy
         GITI7or/8zriYlDc+Car6LajDRGBQOoUxR9AblLHXJovuMYfUTqj1mu9wnRMGPIM5iCc
         ka0Ryy1WmVJ3ZgOKQvLZCtaz+0E2Z0jCFpxh7Sj/P6AtRSgGxlyLyFd0P6F+4B+viILc
         EttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766139359; x=1766744159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycLYVRrePvHyQPkdfYXnS+tZaNi7CZqNfdDOVcOxfeg=;
        b=FVR/IjkBgoGWJR8pywm8D4IX4OVOC/s+emX0edRABkijcMtMczyMOrlehWgran2T30
         6JkeGrG6av31shEtYoHUMrYigekWVMsT1r93D64la8F8Rvxk29ycLH4fhYTQmZAYK9xO
         3u1KW9CCyZf4IE3yc2Qe6+isPdELdFK2ihjy8Xy1kGnMxyzQeRNlnO9hqwJ9q5IJJ3a5
         IBjXjEu4xKyW/vMiX3NTb9JpgucmYd+XkOX1T7fawta4Y+c/k32ayKxQvS/RlSFSMFMv
         A6XjZMuA6sK2FVmaS+r9aontnNsbF+f29dmenaxJIJycPJ7D9tQfMWKDNo1Gl/Jh5D7l
         MZeA==
X-Gm-Message-State: AOJu0YydAMXgbc6CmnXaMgdXQwPXeTPeyRsLVtHzrLhRcLmAZ2lBa/nz
	2N12lBi1Q4dy7vnfDGmKlmJF/f+aO0BuPZq033PciEBptgDMWHfgDNfyX9UsU4my
X-Gm-Gg: AY/fxX7FBl87DCSUFamtfewh1d9FOWNrkgpZMS4jSDQctXLPep8PBuDpPFOfobGdH6W
	GMUvq5e79yygVo1exHXyhiNwyJ4tc4a3/FXwTOHjEQw/ZWQ+PYDa0oOwj8sybZUvuF+PTOoSBnH
	GtqjJHC82s2EEQmFwu87Pcpu4iCvRuZb3GVxOgJp6bufm8DqPQlJ1WRxjIj5QfaiKrW9/cL3JPb
	KttUBhEX0vWd85PL21HWKE/hQmlI2PkkAha5Fhw7sQaKgwcrHHGbhQE39BFQDuX+SKfWmitn3y+
	GJx430ThwmKQkmi5duDYhJNoRfBu4RO6VnCCc7Ev/r01jSVzlrIttSB3cNsXMgd5YzDaRXAY6DY
	omWqH9IUiBZKI8aYkIZ5aNDHgrnjXC90/qDk/e2ffz4SEb+L9HxMGOyKjDTQRb5vn0S8E7XbR/I
	6tv/CRw7bX7sNUC/eZcoD3A6eNO+oErjt8CZvZXfFksXB5qqCY7OCf0NDtPRw4pOlmieTujw==
X-Google-Smtp-Source: AGHT+IFP1l0H8w7uU/D8+kdFU7GHAv1bX+mUdByw7g4p3XknF46ejff2+Hy3IGYyfcaHj80+Rm+ZPw==
X-Received: by 2002:ac8:6f11:0:b0:4f1:aba0:9329 with SMTP id d75a77b69052e-4f4abd15f01mr30950521cf.33.1766139358652;
        Fri, 19 Dec 2025 02:15:58 -0800 (PST)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997ae49esm16761256d6.28.2025.12.19.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:15:58 -0800 (PST)
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
	Aaron Conole <aconole@redhat.com>,
	Adrian Yip <adrian.ytw@gmail.com>
Subject: [PATCH 6.1.y] net: openvswitch: fix middle attribute validation in push_nsh() action
Date: Fri, 19 Dec 2025 04:14:10 -0600
Message-ID: <20251219101411.1970581-1-adrian.ytw@gmail.com>
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
Acked-by: Eelco Chaudron echaudro@redhat.com
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20251204105334.900379-1-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 5ace7ef87f059d68b5f50837ef3e8a1a4870c36e)
Signed-off-by: Adrian Yip <adrian.ytw@gmail.com>
---
 net/openvswitch/flow_netlink.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index d0b6e5872081..d4c8b4aa98b1 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2786,13 +2786,20 @@ static int validate_and_copy_set_tun(const struct nlattr *attr,
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
@@ -3346,7 +3353,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 					return -EINVAL;
 			}
 			mac_proto = MAC_PROTO_NONE;
-			if (!validate_push_nsh(nla_data(a), log))
+			if (!validate_push_nsh(a, log))
 				return -EINVAL;
 			break;
 
-- 
2.52.0


