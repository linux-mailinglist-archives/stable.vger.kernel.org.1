Return-Path: <stable+bounces-244956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VAY3NwxD/2lU4AAAu9opvQ
	(envelope-from <stable+bounces-244956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:22:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BB4FFFE0
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050503014941
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB2030EF9A;
	Sat,  9 May 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjh3neru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92754DDCD
	for <stable@vger.kernel.org>; Sat,  9 May 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778336518; cv=none; b=Zm39znhiW1HilLBcswdEREdlCmd4l3kjM+DAwPhwDNpXeK5HtT+duN/bptPCrRSHl2qnUQEmeFJmLRB1IVDfSNNJ+NSkgDYoGAO12XyiddolDllPFdrqkqUuGXcAfmApRN6Z5GpbJbOlCA+52kgIZIBGb04ofd7UKBc8GgOEcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778336518; c=relaxed/simple;
	bh=pLOPgvP8/md3i61/Iy1kMcHOo9DQefk7H1SNISo92Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utz1G2ruXzkqwjqBzpvdvRJtG4fkKWILfmPMNpmUtI+8tQ07xbfVqpYra6ACwbjwlQFvRbN4a4MqIYw2Ow4adnx3lcaQKbMwGTjPpx97lAtBt9zi1RxIod9NkJEcPYwhpltrlUgMth05l7p6k32vSVO9fzIChygLygI6zsVr8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjh3neru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38AEC2BCB2;
	Sat,  9 May 2026 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778336518;
	bh=pLOPgvP8/md3i61/Iy1kMcHOo9DQefk7H1SNISo92Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zjh3neruxZ3w3OKodTrXwT41WtNP9Uao3Zy5X9qg0Ut4bvYOo7rGOe3VOh3F1L488
	 WSwumXGNXLLbqXf8p65Dax3wjwhSDsvgVUyqDBwSi5Nt2OR4D0bcGY8+gosysv3ZWl
	 kuJfmFBjxaidkTbLHj3fLwXwC3otIXz8V8kjS1yIRiqJ7qi+t22belGe4a0Q4SaW6R
	 1KMmz3tXiH3LkoDaMvVtCwdUS34dTsZECmNrIV6EKfNqcuChV0KGUk9wNDaZfWDF+j
	 vn8ADbIw31cCu82SGTBHPNOvJmSEXgKqc/i2bskvnVnHjlmpU5G+BazHpn9S6zt2rO
	 eWzJAhHtlkSXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] gtp: disable BH before calling udp_tunnel_xmit_skb()
Date: Sat,  9 May 2026 10:21:55 -0400
Message-ID: <20260509142155.3462128-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050428-flaky-polish-d0e3@gregkh>
References: <2026050428-flaky-polish-d0e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A6BB4FFFE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244956-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 5638504a2aa9e1b9d72af9060df1a160cce2d379 ]

gtp_genl_send_echo_req() runs as a generic netlink doit handler in
process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
on softnet_data.xmit.recursion to track the tunnel xmit recursion level.

Without local_bh_disable(), the task may migrate between
dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
per-CPU counter pairing. The result is stale or negative recursion
levels that can later produce false-positive
SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.

The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
the data path runs under ndo_start_xmit and the echo response handlers
run from the UDP encap rx softirq, both with BH already disabled.

Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
commit 2cd7e6971fc2 ("sctp: disable BH before calling
udp_tunnel_xmit_skb()").

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260417055408.4667-1-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 33b78b4007fe7..d7f644dfaa8d9 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2401,6 +2401,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	local_bh_disable();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    fl4.flowi4_tos,
@@ -2410,6 +2411,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.53.0


