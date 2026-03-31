Return-Path: <stable+bounces-232299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NHhEVH/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3D36DEB4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63EF430CBCCC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208F423A9B;
	Tue, 31 Mar 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LKeixFlC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9814423A62;
	Tue, 31 Mar 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976390; cv=none; b=X/SM22Rx4FiLOkqB0Bz75LT1QPmey7GvFve5CNrb9JAsO28RzHpWgZTpFzcSK0ztXnbLc9ucdcikqJbdLVr1vSrohDSiyYoKh5MkBiYNdSSla8CvNDyZqWUwYo84uYVxJo+M9t2L7WZmeVje80T45TBzexOtruCnV3rwTRkP1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976390; c=relaxed/simple;
	bh=WdKOhgQd3iyjSP9VOfUGCMEu0Ku6OqX3AAyRQJ22iG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO8FsMxLsLZ+KFlOEuPe332Q52tMA1DrxyOm1js37covrUfTmyu7uH26dfriO0m5g7VL528Rk3QdS2+MnA0sBkPWIS3yK3yaF9lprlG64aGbPY0MlzZpVPArRY8uHkFl9T33/+puk0V9e2sa+eLsxooUjZduG0Er+agmoriF4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LKeixFlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9E9C19423;
	Tue, 31 Mar 2026 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976390;
	bh=WdKOhgQd3iyjSP9VOfUGCMEu0Ku6OqX3AAyRQJ22iG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKeixFlChEZ3zVGzuzVFk9U77vRks1WCmgAR3isjEwVWn6BryTANMgqhOPz398mwI
	 z19m2pvA+EMPBkaDCkap4L/owuCQqz9WXofSib4l3uoidCo67YFctV7Q0nPgcq46gg
	 /ex/m0ZwudRy18CMLk15KNdaN6Is99BvUE4+hCNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 075/309] xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
Date: Tue, 31 Mar 2026 18:19:38 +0200
Message-ID: <20260331161756.249545750@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,queasysnail.net,secunet.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-232299-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,secunet.com:email]
X-Rspamd-Queue-Id: E0F3D36DEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit daf8e3b253aa760ff9e96c7768a464bc1d6b3c90 ]

After cancel_delayed_work_sync() is called from
xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
states via __xfrm_state_delete(), which calls
xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.

The following is a simple race scenario:

           cpu0                             cpu1

cleanup_net() [Round 1]
  ops_undo_list()
    xfrm_net_exit()
      xfrm_nat_keepalive_net_fini()
        cancel_delayed_work_sync(nat_keepalive_work);
      xfrm_state_fini()
        xfrm_state_flush()
          xfrm_state_delete(x)
            __xfrm_state_delete(x)
              xfrm_nat_keepalive_state_updated(x)
                schedule_delayed_work(nat_keepalive_work);
  rcu_barrier();
  net_complete_free();
  net_passive_dec(net);
    llist_add(&net->defer_free_list, &defer_free_list);

cleanup_net() [Round 2]
  rcu_barrier();
  net_complete_free()
    kmem_cache_free(net_cachep, net);
                                     nat_keepalive_work()
                                       // on freed net

To prevent this, cancel_delayed_work_sync() is replaced with
disable_delayed_work_sync().

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_nat_keepalive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index ebf95d48e86c1..1856beee0149b 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -261,7 +261,7 @@ int __net_init xfrm_nat_keepalive_net_init(struct net *net)
 
 int xfrm_nat_keepalive_net_fini(struct net *net)
 {
-	cancel_delayed_work_sync(&net->xfrm.nat_keepalive_work);
+	disable_delayed_work_sync(&net->xfrm.nat_keepalive_work);
 	return 0;
 }
 
-- 
2.51.0




