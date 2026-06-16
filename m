Return-Path: <stable+bounces-264315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nFimKUlyMWoljgUAu9opvQ
	(envelope-from <stable+bounces-264315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:56:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27553691899
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:56:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=h7EEI9MI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264315-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264315-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAD8A31858D3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464A37C912;
	Tue, 16 Jun 2026 15:54:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEF44B69C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:54:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625287; cv=none; b=t0kIqU8TEEQgT1lgP4tPgJHek6eJgzcC+3dC1EHgl51WeonzkPQ+rDxlrP48TT/qhZPtKTc7+qOE+M8jZq87hjvmo0HW1OR9YmV6FkJTeFhz1g9IXqoK/qQZJOGSYKrpObvrpSjFJE+osk2PCavUALF8p6jWK1jbYu5FT4YsXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625287; c=relaxed/simple;
	bh=lt7KJWxHanlC3JXGy1d9pRqJflP/ZJUOJYyG6HzY9II=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TLKqnjGa0Eo7UIqLtDdyWAA5itzjogjL5MLwJNxRMdmel97Wg2V2EZDknOQtpBUQsCqZrlcuid/uRQrx5tZy64kQVKYVWQLrOU1Tv1BetrFpSZa3NK1glmn/QPVzLojqEkEEx31tAaTuXXbsBcf64o9zUnz8DMgbbLIA7QduUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7EEI9MI; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso119171265ad.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625286; x=1782230086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eB2+P3x9rTTEifWl/2rNhxGcg9EpjrZ/39h+Dy5yLtg=;
        b=h7EEI9MIazZBmwH6U7yrPQXgLk0OxB6bV6wPVRYuZpABDC7VJVgfJkHAc7f3UvBqTH
         DGIiRNTbrxQz/LqtfLwysu2p0df0vA504aoYaCq9SpBDPycZJJny+IFsU6Z1XWHC2iT2
         pV3yQHVopVkcxJZX0KuII9XJdWdX+/j3vLiFpgInGvxxQgWUL61iAPTmY1nFzKMOQqRK
         6QDMKdDrNZ2XUvKZtn3ZTJ+rx0255biQqUvBhTMnbLsbrfkJ34gOaOsFyI2DWnEE0zth
         5cCW10H8XdE0d9+6mjLpabwWuvI55gNGQGc34MuMBszmbGav6vWm3k6yVXUHy7KnZpyt
         yk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625286; x=1782230086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eB2+P3x9rTTEifWl/2rNhxGcg9EpjrZ/39h+Dy5yLtg=;
        b=OwAFErOhv2S6qUXCST4Lt+Pn50kCWr1SfpofYCdJWSNp4Q6McHkfeKHprVeL4NcIUo
         sr8Y0P6QUHfyCqrgZV+wMc3OezjokM/z6E4UMXAH4IScxB59bd3EtNUgfJR4LXgSDO97
         TUpDzJrTYxmYsxIg3XBG3n9lPphvzjHY84RwiGas/0g+F1VYAAzi1b2p/PFp1lBOysCb
         37nUBA72XVpwuN/kqOEAjKp/yRqiY5JKHaNcuHQCF1CECnKHPDkwZd4xfwh/whHHNiju
         64zqq61Tggx3bV5WBQ+1MaJvzr7W342Z9VNibcr9gklTC/G9/958fD7A9RTYGnb0fJPM
         Xt6A==
X-Gm-Message-State: AOJu0Ywq5iBZubojd4ryxMOeGhxMQ0AJ6ayG2ANRavGTGOjtgEZhl/oY
	5pIA5g1UjQi4VYjhBAbsY+5rDO7hX9eeLmdK4RM+wOtcvRiXhuTroitZUKh19aDubPqBS4sCg7A
	4RbR8sUFJ6+PGfNxepa9zZvVsVWw1qgmXU4RucCxoazsRIb620kbuaGk1UgPTOk2zLucQ4d1Cfj
	pAYSwjOFR72FGQn75lMgXF1GVzEnDaNNZ/kXdivW/Zmg==
X-Received: from pgac28.prod.google.com ([2002:a05:6a02:295c:b0:c85:9a33:baf4])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9d:b0:3b4:7e2d:a3bc
 with SMTP id adf61e73a8af0-3b8b3146d8bmr3842637.0.1781625285236; Tue, 16 Jun
 2026 08:54:45 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:54:27 +0000
In-Reply-To: <20260616155432.2093908-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616155432.2093908-1-kpberry@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616155432.2093908-5-kpberry@google.com>
Subject: [PATCH 6.12 4/7] bonding: print churn state via netlink
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, kpberry@google.com, pabeni@redhat.com, rnj@google.com, 
	sashal@kernel.org, xmei5@asu.edu, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264315-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,google.com,redhat.com,kernel.org,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kpberry@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:bestswngs@gmail.com,m:chenglongtang@google.com,m:joneslee@google.com,m:kpberry@google.com,m:pabeni@redhat.com,m:rnj@google.com,m:sashal@kernel.org,m:xmei5@asu.edu,m:liuhangbin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27553691899

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 4916f2e2f3fc9aef289fcd07949301e5c29094c2 ]

Currently, the churn state is printed only in sysfs. Add netlink support
so users could get the state via netlink.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20260224020215.6012-1-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kevin Berry <kpberry@google.com>
---
 drivers/net/bonding/bond_netlink.c | 9 +++++++++
 include/uapi/linux/if_link.h       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index f8fc6e5fd803..98e635717364 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -29,6 +29,8 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE */
+		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE */
 		0;
 }
 
@@ -77,6 +79,13 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 					IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 					ad_port->partner_oper.port_state))
 				goto nla_put_failure;
+
+			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
+				       ad_port->sm_churn_actor_state))
+				goto nla_put_failure;
+			if (nla_put_u8(skb, IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
+				       ad_port->sm_churn_partner_state))
+				goto nla_put_failure;
 		}
 
 		if (nla_put_u16(skb, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 1609450e5eaa..087048d620f3 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1552,6 +1552,8 @@ enum {
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
 	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
+	IFLA_BOND_SLAVE_AD_CHURN_ACTOR_STATE,
+	IFLA_BOND_SLAVE_AD_CHURN_PARTNER_STATE,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.54.0.1136.gdb2ca164c4-goog


