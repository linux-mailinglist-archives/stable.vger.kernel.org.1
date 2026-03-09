Return-Path: <stable+bounces-223713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP6yJ5cFr2knLwIAu9opvQ
	(envelope-from <stable+bounces-223713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:38:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0523DBB2
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9378B301DCD0
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127732F5487;
	Mon,  9 Mar 2026 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="B6v4wGyZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C92EC0BF;
	Mon,  9 Mar 2026 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077725; cv=none; b=OdCcVbqMtcKHyi3duiDkTwan79zArAAuC+sf+l19a3Q7GHVIYWWQG37SncrM7bfP5E8wH7S0IhWdCwOuIf2C8HaD4ZtLohhlGZEGkOJbeavDN0iz/ViJeVN6FhbVuXM99Lo9A7/DDqnPCT1WbD5SBFJtT5wuntJ6sw4YrMXswps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077725; c=relaxed/simple;
	bh=Zjd03do5gKjHqUSoZTGcjO7reSdbY96AmNZ7hBLF3Lc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9m7mItDPdtNRLsgi/27u9pNOfg298QgXQznkRB8pCU/QXmgpOxUb26ORLwj3p5ena0fPO76mghgsmLahD99VjFlrKwA3w0kwQCmlfYl5MjvAWFNHQXuo/Zyok3jyt3xXA/AQ52FZ1Tt1fv6K9skakVD0jojsIgLg7EKxNwbSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=B6v4wGyZ; arc=none smtp.client-ip=185.70.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773077713; x=1773336913;
	bh=ocFxelYsMaArvU/mRizrO1UtenfQnpnGvRa+I77q7GE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B6v4wGyZGqjM1fT/1iSHkgiLKaadYMgfDjfSe/JbwmvUgd45ywAwQBCv5rZTPCGtW
	 P5RzOurRIdlwUWthAVHxdxzPXcZg4HK9cUvD6JekyM6L14T2m9yD5aNLDmNolIB4JQ
	 uVyxthxiH+UD0SH2c4IvJwMnugiLvoGx43U3XCEQQmZHoPcwvOE3wp54pFDZxNEm2z
	 bp+7JxKHXjjGuBGAla5JsUpZ8xO0AMSGucnm7bfVbE2KvLaJY21MUFQ/WQohPEWPbQ
	 YRNIwtBHwHHTlG7g5Z9acUeOUzWQSor+QyomyKNRLzxdsE95+SXwarnk9gnp7+yZg0
	 nhAa1kwl+1g7g==
Date: Mon, 09 Mar 2026 17:35:10 +0000
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
From: Paul Moses <p@1g4.org>
Cc: horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net 2/2] net-shapers: don't free reply skb after genlmsg_reply()
Message-ID: <20260309173450.538026-2-p@1g4.org>
In-Reply-To: <20260309173450.538026-1-p@1g4.org>
References: <20260309173450.538026-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 8f63974aae1124f6a525b8966c4432100d2361de
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4AC0523DBB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223713-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,1g4.org:dkim,1g4.org:email,1g4.org:mid]
X-Rspamd-Action: no action

genlmsg_reply() hands the reply skb to netlink, and
netlink_unicast() consumes it on all return paths, whether the
skb is queued successfully or freed on an error path.

net_shaper_nl_get_doit() and net_shaper_nl_cap_get_doit()
currently jump to free_msg after genlmsg_reply() fails and call
nlmsg_free(msg), which can hit the same skb twice.

Return the genlmsg_reply() error directly and keep free_msg
only for pre-reply failures.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Fixes: 553ea9f1efd6 ("net: shaper: implement introspection support")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/shaper/shaper.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index 3ad5a2d621a91..ab0de415546d6 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -760,11 +760,7 @@ int net_shaper_nl_get_doit(struct sk_buff *skb, struct=
 genl_info *info)
 =09if (ret)
 =09=09goto free_msg;
=20
-=09ret =3D genlmsg_reply(msg, info);
-=09if (ret)
-=09=09goto free_msg;
-
-=09return 0;
+=09return genlmsg_reply(msg, info);
=20
 free_msg:
 =09nlmsg_free(msg);
@@ -1314,10 +1310,7 @@ int net_shaper_nl_cap_get_doit(struct sk_buff *skb, =
struct genl_info *info)
 =09if (ret)
 =09=09goto free_msg;
=20
-=09ret =3D  genlmsg_reply(msg, info);
-=09if (ret)
-=09=09goto free_msg;
-=09return 0;
+=09return genlmsg_reply(msg, info);
=20
 free_msg:
 =09nlmsg_free(msg);
--=20
2.53.GIT



