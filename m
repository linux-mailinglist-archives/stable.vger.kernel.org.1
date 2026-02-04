Return-Path: <stable+bounces-213900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGEAOJ9kg2l1mQMAu9opvQ
	(envelope-from <stable+bounces-213900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:24:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F72E8746
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C3A30F20EA
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9809284B37;
	Wed,  4 Feb 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQQVDiZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E428D8D0;
	Wed,  4 Feb 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217889; cv=none; b=mG+MXjNCdrsIEOcQBhrd1AcxOaiU9fiAyozeMl8t3OkvB0g3BLgPXZMerqrQUSqaYomMxrBq2karQWmF59rCQZgoseGrkO2qjqideBnQ0GCTuAuL5Xgtp/AAE/Lyp4HaITnph4VXfSQKpQB2lID6/yB41TEf6F0zgfgKsvywSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217889; c=relaxed/simple;
	bh=f/1T4mHwkiiW3lb4u2DASRhiQS9Ff2NssFj4DNaNO1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZstYgH4l+Pgzf/u9lBXzMavJk96wQLrvXBYmY9FXjoNck1ysOoguVsEZZDetATBTPoHZjrn15gGf/C8QzaFpKyuHaZuHjeHmVXyQwRM6WwtlqG3AH9ZKMVlHYTW56Q95PEJv8xE1U3zMu7FRMVYz+FGgfT/srXKm+GRDMIj9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cQQVDiZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8232AC4CEF7;
	Wed,  4 Feb 2026 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217889;
	bh=f/1T4mHwkiiW3lb4u2DASRhiQS9Ff2NssFj4DNaNO1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQQVDiZitOPcHZuRLSoE+cr8gKes8zMB3PPCH5lK1Hk5y0TFNs6p/EgdmAU+CZCBp
	 Ktj9J4hQM70cORvh3TSUyR22TicknPd7dhtv4HZTiL/eZQUCHspBxO/yWe5id/jTEb
	 ED3P+cQHQaeBglqYuL5kcBsHUbPPAVMHIkGZuHxg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c46409299c70a221415e@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Matteo Croce <mcroce@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 149/280] bonding: provide a net pointer to __skb_flow_dissect()
Date: Wed,  4 Feb 2026 15:38:43 +0100
Message-ID: <20260204143914.994201696@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-213900-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c46409299c70a221415e];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 63F72E8746
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5f9b329096596b7e53e07d041d7fca4cbe1be752 ]

After 3cbf4ffba5ee ("net: plumb network namespace into __skb_flow_dissect")
we have to provide a net pointer to __skb_flow_dissect(),
either via skb->dev, skb->sk, or a user provided pointer.

In the following case, syzbot was able to cook a bare skb.

WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0xb57/0x68b0 net/core/flow_dissector.c:1131, CPU#1: syz.2.1418/11053
Call Trace:
 <TASK>
  bond_flow_dissect drivers/net/bonding/bond_main.c:4093 [inline]
  __bond_xmit_hash+0x2d7/0xba0 drivers/net/bonding/bond_main.c:4157
  bond_xmit_hash_xdp drivers/net/bonding/bond_main.c:4208 [inline]
  bond_xdp_xmit_3ad_xor_slave_get drivers/net/bonding/bond_main.c:5139 [inline]
  bond_xdp_get_xmit_slave+0x1fd/0x710 drivers/net/bonding/bond_main.c:5515
  xdp_master_redirect+0x13f/0x2c0 net/core/filter.c:4388
  bpf_prog_run_xdp include/net/xdp.h:700 [inline]
  bpf_test_run+0x6b2/0x7d0 net/bpf/test_run.c:421
  bpf_prog_test_run_xdp+0x795/0x10e0 net/bpf/test_run.c:1390
  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4703
  __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6182
  __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6272
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94

Fixes: 58deb77cc52d ("bonding: balance ICMP echoes in layer3+4 mode")
Reported-by: syzbot+c46409299c70a221415e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/696faa23.050a0220.4cb9c.001f.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Matteo Croce <mcroce@redhat.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20260120161744.1893263-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index dd0ea86d7934a..b0bc811aaab91 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4128,8 +4128,9 @@ static bool bond_flow_dissect(struct bonding *bond, struct sk_buff *skb, const v
 	case BOND_XMIT_POLICY_ENCAP23:
 	case BOND_XMIT_POLICY_ENCAP34:
 		memset(fk, 0, sizeof(*fk));
-		return __skb_flow_dissect(NULL, skb, &flow_keys_bonding,
-					  fk, data, l2_proto, nhoff, hlen, 0);
+		return __skb_flow_dissect(dev_net(bond->dev), skb,
+					  &flow_keys_bonding, fk, data,
+					  l2_proto, nhoff, hlen, 0);
 	default:
 		break;
 	}
-- 
2.51.0




