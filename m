Return-Path: <stable+bounces-263941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HyMLBoJqMWo8iwUAu9opvQ
	(envelope-from <stable+bounces-263941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:23:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B6690FBF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:23:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=eaxtXC09;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263941-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263941-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B1623030038
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DE2449EA8;
	Tue, 16 Jun 2026 15:21:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7044418D7;
	Tue, 16 Jun 2026 15:21:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623302; cv=none; b=gbw7wD3VXVqMQublUkhHUHw0csDZLPii02lVjS0GVGeK9KzQLCcDBPeHSEKrTwaX0oUhE5LlYMuZYfo+PdPtAb+2Z7tJI5+Q76u0ehOJYHIkrmPkXrdsjI/vHwkV3ONJfNoBWviVqxx0hdSxKr2hBPkUNsZYHikgX9RShF83CXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623302; c=relaxed/simple;
	bh=hf/MacHu356K8TPA8DtgpxIjxbvZhddtMykq8WizSTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6oB0rsbZJ/ITW4eBpuYAxEx7reK4UI+uiWcAsdwO2bOqWZjz31ZmKwjlWg89VdREh7nD2ikwsRK8/VUdw7IJvntsYEfE57SyeRtI5eZdLjfgVstOpVfdtp8rx+1/8Gg3Dw56VCZsa1Cn25xK0UbzBZh6gJD83TX43eaQpGN3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eaxtXC09; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D79E1F00A3A;
	Tue, 16 Jun 2026 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623301;
	bh=2Pe7o7w69c9rgl5uWxD6HzpTgvnSCxkR8F+YHxKpA0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eaxtXC09r60BcxxxExM/UPxPVNbTl+FS22NoKPFB0Diz/2yfwCq9s1+z6gTUdS/DH
	 5OtBJUfhxqIyoogYuRakXpLf5csn/wk/Rm1L5f+J28Oh/jjhURTazGY6/n5uJNQ/35
	 cQulbDFL+Ve8gpWYvbpRJXwIi2rtZfIqOVPhBifo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Moreno <amorenoz@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 123/378] net: openvswitch: fix possible kfree_skb of ERR_PTR
Date: Tue, 16 Jun 2026 20:25:54 +0530
Message-ID: <20260616145116.820999093@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263941-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:amorenoz@redhat.com,m:aconole@redhat.com,m:echaudro@redhat.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C4B6690FBF

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Moreno <amorenoz@redhat.com>

[ Upstream commit ee30dd2909d8b98619f4341c70ec8dc8e155ab02 ]

After the patch in the "Fixes" tag, the allocation of the "reply" skb
can happen either before or after locking the ovs_mutex.

However, error cleanups still follow the classical reversed order,
assuming "reply" is allocated before locking: it is freed after unlocking.

If "reply" allocation happens after locking the mutex and it fails,
"reply" is left with an ERR_PTR, and execution jumps to the correspondent
cleanup stage which will try to free an invalid pointer.

Fix this by setting the pointer to NULL after having saved its error
value.

Fixes: 893f139b9a6c ("openvswitch: Minimize ovs_flow_cmd_new|set critical sections.")
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Link: https://patch.msgid.link/20260604121946.942164-1-amorenoz@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/datapath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index bbbde50fc6498f..f0164817d9b723 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1316,6 +1316,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 		if (IS_ERR(reply)) {
 			error = PTR_ERR(reply);
+			reply = NULL;
 			goto err_unlock_ovs;
 		}
 	}
-- 
2.53.0




