Return-Path: <stable+bounces-241962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMHXBgOS8mmDsgEAu9opvQ
	(envelope-from <stable+bounces-241962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:19:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF649B510
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A746301725A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9B376463;
	Wed, 29 Apr 2026 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnc4IVGS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA6396D29
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504755; cv=none; b=J1DlztKPkDhjoez7pCGgj+oFJN9QVq0gDHLNQ0A5fylJstJL93hYtliQXRMZJcVEgqgxy06M4xGCPZ2st1piPXeqV26rikv/hTBbcj1Yto05sIzXRdKf2u8WXV99smCTIq7JQgn1yZPzQ9xvzDS+BHmi03O91lh3qg4gCMaLOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504755; c=relaxed/simple;
	bh=vnf9u5bZr2Jh4vHEhpzns0hJLI6h1CacL4VAyx/kSbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/mXdQQGk+EP4Ll7ZWGke1TVdZr3VJLUyd/5BjZLMgywbWhMx9yJN7xY6rnXvXfe1k+6jY2OznJD5nXatpXYB514EIbNcMDqzeBeO471arq+8yD+nkOFWMLnPqA8Sdkmc/RuIrhjLyZkMDBf7sAxaJj/cIyOrF5tTrxUG6kMipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnc4IVGS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso2113685e9.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777504753; x=1778109553; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg4uL55KM0rpFJAt2ymSaCICrZWf1oCpfyBNCgcrMb4=;
        b=Hnc4IVGS5eyTt3dBGI3jm2Yi6bpyGq2/IUGR094lMMJWJAtbIgU/AOcylkkxkIsEvz
         Dfss/BJgqLchl9JUobzRcrZ/hzevpBuKHvo5Qtt5BL6Ha9wZgK6iZh7huH5HQ4QizekW
         6wfl2WkpR6hreV1/2kHsZxbrwaQpi3TphNw/dgR716Vz06x0TF0VfHIlMWs/DGvGw61G
         UVLQu2Ahx/yphAhkflW72+qQdlyef0tjbrqq7B1RqzWv7rd67inn/DiHm6cEy/oKnvQ4
         iq1GElBXS9UIav1DK2Cj5W0W71i6HVJEfPDJDJbt1OgXhDcI+GaXZdwJf7DKa1WHB27R
         TtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777504753; x=1778109553;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xg4uL55KM0rpFJAt2ymSaCICrZWf1oCpfyBNCgcrMb4=;
        b=f4vOoim5Zn5lnQUPA2JiA5uds0yEFPxD7PohMpr+or0aBcbKhP9S6gT7V1fAu40glq
         OaHHppJhT4bkG/KIEKOS7xFF1qvvO0r7kTiFPJbNRSUncZ/07UL4G54EhsOgX/Cr0FoX
         5AqGpbBajuFOODuhqACBPWZgqSKV9KONPziLjg9RLofwKxrEE1XO9Sqf3zlPaWco/pAq
         029DCYtNYy8FqWcRmWrcxN9JkdKpYIMCANi6YHz20gJFkn7YhELbwCOzFEoIo1KBFgFE
         7Eu8fAYU4nOkJvWKF0T+aAi+A10t0NI0Cmxmtj0ljnhsYqnUrjrma8eT07wAOSQHTEOw
         l+fQ==
X-Forwarded-Encrypted: i=1; AFNElJ9VR9FN2BosOBtT83Gj11r/F+YXid2ThEAQRXXcHCA4LnwOOIF2dkC4GZJcyhxxyat+Q8E77HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmMHpYIrhuYbdym6TQZ0C0osC+OcaVpVJir32mdpg1wkG5YDn
	dBX3eP+sdLefBUYQF5s2txcW2g4slzTz1DIXBQ/P7QHGBax9xZLO0ck=
X-Gm-Gg: AeBDiesM9D05R87EBKxp8q9DutYAV7YhLnrjr+wT9KCV9wsYNVHo34zKHkxBLcepjeq
	a329i2CQV9BE408lDmWWNWtDJKXu5iNT/DxOhqQfgn1LXr5zdY1sR89RZ90Zp3T5sntmpXdh9eB
	4XVnfWFNx1hd5M0w1oXCGjHWunekgFpTRC2+eBA4EvVKxQwG1XG2qMq4CVS3lsQoaHUlIH2EPUc
	G8r9PURJe7NOb34EX65+VXrfIXfebZwEujWd5EICI+ODRooKF9ZZ5T39OEbaTsHn8XhW12ae9mI
	5+AeQfnQyFXi/Kt/I9kbpNwJ1Nno0Y2bkO5TKR3De3n0EwCGVFlozRsQwgI7GUMWcMOysXZ9B/u
	O4xiV0yjz9Qc8aY+LiC5VC3/vjLoBdcsBLf/00IIFyYdYgwF85pTgZlw7EexdbkjTd2xQ9AXJWL
	i+nibSDD4rQYOI2g==
X-Received: by 2002:a05:6000:611:b0:43e:a81d:c475 with SMTP id ffacd0b85a97d-4493cf2d583mr611329f8f.6.1777504752636;
        Wed, 29 Apr 2026 16:19:12 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm7502180f8f.5.2026.04.29.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:19:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] netfilter: ip6_tables: guard
 ip6t_unregister_table_pre_exit against NULL ops
Date: Wed, 29 Apr 2026 23:19:11 -0000
Message-ID: <177750475157.3021974.6858117535916205046@talencesecurity.com>
In-Reply-To: <177750472539.3004201.15967003942391945312@talencesecurity.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
 <177750472539.3004201.15967003942391945312@talencesecurity.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B1BF649B510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241962-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:mid,talencesecurity.com:email]

Same race as the ipv4 counterpart: ip6t_register_table() adds the
table to the per-netns list before assigning new_table->ops.
cleanup_net can find the table with a NULL ops pointer and crash in
nf_unregister_net_hooks().

Guard against this by checking table->ops before the call.

Fixes: ee177a54413a ("netfilter: ip6_tables: Use xt_register_table()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ipv6/netfilter/ip6_tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index XXXXXXX..XXXXXXX 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1804,7 +1804,7 @@ void ip6t_unregister_table_pre_exit(struct net *net, co=
nst char *name)
 {
 	struct xt_table *table =3D xt_find_table(net, NFPROTO_IPV6, name);

-	if (table)
+	if (table && table->ops)
 		nf_unregister_net_hooks(net, table->ops, hweight32(table->valid_hooks));
 }


