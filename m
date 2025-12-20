Return-Path: <stable+bounces-203129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1049ACD2A66
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 09:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F9803012BC6
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 08:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451142D6E64;
	Sat, 20 Dec 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D776B5/N"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F51D90DD
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766219597; cv=none; b=pbcOvK9klzpKWVDK6+5vrcXcs3CPxK4EbB6+7V2TJdfGz1ESH3F87z8u1RYJRAHXeKlFNBfLvv70sbPda7ZoBv95qtE8d+pC51YIH5XtR5QeuCiayOwfBmF0CWyI2qOP9ciX9XzYdbmP6Bpv1sJU3aM0G1xRpbgpTGz2OtrZfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766219597; c=relaxed/simple;
	bh=pq/FIErWBVljP69u1kYvr72D2kBq6ZOY2UDhmxvBgT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9IOBedgcuIO9x2ew1EIAMvNufYcspZqwziCXg1ryOe/dCk+M+NzS7uddO8do5NEEKmetlsRO1Vt4SCDihZ7gb4sJ4+Abw6C5TDA7gT+cXv74AIzVQq2CYUeS+sjPtA3rqjdK/YmM3G9GdsHG19vXpw24av79cPavLWhGdkAPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D776B5/N; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b22b1d3e7fso245406785a.3
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766219594; x=1766824394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEU8uqiI+VIyXCsQ6KDH6Rq3unniQciJU8YDjqznLQs=;
        b=D776B5/N/4TM7RqJqguLPS120CScD4i91w7k7JsWUzPXIxVT/C0JAa4LGJHexI+0j1
         KqVd2sAtI+MATzqO7VV4lWORqlKnDGPi6RReCqByiLmfgtHwP15g91/EIWzuHkR5dTat
         99pkucA9asjbNvsm1eW67evnqJliSxrlvfokEug1LwA+h1UkkeDbrNVYzy5lXTZZ70Fg
         dnE+6gt/lseGpbKMj1pr+G/Cwz6Ajdpl1gP1IW6ZbmuFBjXyShzWCabh1Uwqfi0wNgPy
         0AQ5vhwjBOnzPuFgObgswz4pJiXlD7sUXnQ5JRuS3ckfHqqYvPeH0ACDy+Q9JL5aGM5J
         +uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766219594; x=1766824394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEU8uqiI+VIyXCsQ6KDH6Rq3unniQciJU8YDjqznLQs=;
        b=E0VWn3GPNlP+Yx+3NMhaQhVKgBXbB9k8Zwmr27MN2JcKZLWXe/XA2stta3bf7U5CKI
         8+bWF1MknrQwtTQl2Q0+V3qrrjHaLiFVNrdpftHAeDWXhqRIC57TPMLTTLissLW+27rW
         baAFquBEQ1jDNJ6EDBwhHUi+xK/Fiqrn6QqbIF0lZTMnTqPnovGyPuDyiBX7vLZQ0IeY
         kw9uon6/zHxkU34LsdvBaPEaPtTmrnf3QK5fBxjLysyO2yzB1W91yBUwbofenrjwWOaD
         cbNQ3pICI744QqZbPQu9MlYiFC8jcYTC8RFeFXNkucNRsiFFFXU0QJi2DtRcCFhPHPtO
         SCgQ==
X-Gm-Message-State: AOJu0Ywo9XpAwiv1cua0wOs5jGmI6Q4aJsvFPo66lDyF2B5+cYSxxxNP
	1lpQ/mXz4xl0VSCAhSDYMkGer9OkEAcQo0LYrFNiCaPq5pfPeRReXMwL0DkYXpxg
X-Gm-Gg: AY/fxX4d9tDRitDJTbSCUp9GsjBs8WGTcwOmWuvXBV4ZItxYvM6yU9z3aSVhgbrw5HL
	9GK2qgQnminofg9MzOhjHn7UQVYAdWesUi02riJCn281YqUHxmMMFc9OaXtZ4Jj/9+1CWHU/nY8
	VyzC3XGilr90AK0J6Q1OXkNtGJx0KJ/zgfrtmbxno+ALBB+on/CrLIoirFsjZYpfDvgwTjsgFRc
	udRifOjAoLG/s5kZ+5MGKEUt40zaZbZX/EF9WrRGtB9UHfP/bQrBiSvj0P6dCzLGp7cCYZEaWRu
	C2QTw/uFovbCgDtV23gaA0iJZTe4j78WygIwUW6fehpjVMYP5OB6jK4J1i+zdkkO3Jlb0WkTwTY
	08aRx3rhByNwVEk/snuwhJM4a7xmNhj1zDlDjVL/7b2Bny9Ihpvak6fGED9doTlyJGgXyc4lAeb
	xH/xsZSOi3UcdpW9R/SqGWbvtNRx6S/PIzjUzmMVfg+4HtYyNcOLCPd5qcnwI=
X-Google-Smtp-Source: AGHT+IHwTXgZOP1rlGicDDiSypRAJDCxM1E4qVtAuLk27EHrOgjXSd/WSrpzvi/lFsSQEuQsBseoOA==
X-Received: by 2002:a05:620a:2682:b0:8b9:a134:90e0 with SMTP id af79cd13be357-8c08f65843dmr798094485a.16.1766219594105;
        Sat, 20 Dec 2025 00:33:14 -0800 (PST)
Received: from nairdora (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623ffe8sm38913786d6.12.2025.12.20.00.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 00:33:13 -0800 (PST)
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
Subject: [PATCH 6.12.y] net: openvswitch: fix middle attribute validation in push_nsh() action
Date: Sat, 20 Dec 2025 02:31:12 -0600
Message-ID: <20251220083119.507027-1-adrian.ytw@gmail.com>
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
index e3359e15aa2e..7d5490ea23e1 100644
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
@@ -3388,7 +3395,7 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 					return -EINVAL;
 			}
 			mac_proto = MAC_PROTO_NONE;
-			if (!validate_push_nsh(nla_data(a), log))
+			if (!validate_push_nsh(a, log))
 				return -EINVAL;
 			break;
 
-- 
2.52.0


