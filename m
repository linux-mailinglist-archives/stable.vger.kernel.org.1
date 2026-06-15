Return-Path: <stable+bounces-263411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CO5pF8YzMGpxPwUAu9opvQ
	(envelope-from <stable+bounces-263411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:17:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA12F688C5E
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 19:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ecwz1iP3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263411-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263411-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9153E3043387
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0917413D8C;
	Mon, 15 Jun 2026 17:17:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C823FCB13
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 17:17:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543865; cv=none; b=to9XNFfvO+/CzNDaKQ3U7KMrPTSj6iNWVlVdef7/1o+sUkh3HbvLJZCZ/nNBxMSHeYqRhu7qIcIT/k57AE6ips4YMTts7lyVBD7CJeTEQohXiLa4hh80vW0eWxEIp5DVYRYe5rwrWSu5alc4Fy0ANE1u7o2BMA+bjyWAhlNfE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543865; c=relaxed/simple;
	bh=ZiITZBLsFI77xgWobj+9RMtVotjFNXhJMhjFKXjJxU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u9uc0pTHJIiE3pIoMNO5gL+xuYIHdT+92N1sAG7bQMv36WtkU7ybenGRgCd5U8ZVlNCw8PjP67hwZnr+WtBaLpAepw4y1Geoy/A9YgAByWDbhvlvYvzMqYmC9QaVwiVti1qcwcO/hUg93owNC8FQwu9d7DbGpkBPle9UikYkXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecwz1iP3; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c379e8ffso24382495ad.3
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781543863; x=1782148663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrG0dsMXcYLWhA7XdfHD4yvwbct/DS6UU+B83YUIjw4=;
        b=ecwz1iP3kH1MZD2f7XnSYpG1xMUaghnOXCMxyLdMt9pToY9/7P/tqLFDJ0hyJwyrbK
         L43+5SL0RDjwhtokHn/NwEf+ahwp5ZZdwePxwLfzZKZ8pbppQ8U47H4PIbsN5NUbq4n6
         +QTvcrscWSLLHLKUdMNsC03AUa/tLXqACVj/92+W8/6wK7bUkE3SrLOMdf5G+yuXyKHm
         XoJl48vyk3kGrRiLPalWfNx/KMCPjm3OxJ9h1sypJQ67yNNR1KGeipaMbxQDu3AabTZl
         EHL+XEbSCRnXPhzsmkZ9K5R3GSKrRIVIBMRkVhdbttHjZQlVrqMT80pFzt8HqW8o2OSN
         OAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543863; x=1782148663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrG0dsMXcYLWhA7XdfHD4yvwbct/DS6UU+B83YUIjw4=;
        b=Ryyw97mU5J/eAS08pX77kww+37Dt0EqMn+kuS0mCJwZ9V3rGyqrhslJbvnlsEJ3+IR
         A0Aw+IwUQQrtCGpazHBzWGuZ+0UbyFMsXuW74snAaAJ+pD1K9/heo1t1ImUDImTvVjxa
         P1Y4TM0Ls1CVHhHY66q+aW71gsA8xEn4VctfA/9Ypo90n2UOrQSC1f3HzG6z5VJ/XJOJ
         4ePuRN7r3qg2UmVWweWfcy85dusTbBn98hAerjSTbeaBY5kPlgKJHb8cF/ViL38G68lg
         RrC0z7+AmkD3zizHj71fiUkzqnA9wBNMi0wzl4ZAAwDozmQ7bIpHK6OETDtvHEAHVDSW
         kWeg==
X-Forwarded-Encrypted: i=1; AFNElJ8ffeX1BL4pzyuV3fgR+w1Yht73s0Bq0u9jmE6BKdaXKayoV6tpWMKWaZCYnYYf9/vHnWN7fa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK83Qp5821D9miXKD3rphrbXvNKArF3sQfoFe4JpHD5UrYpqf+
	fzlhH0pyGcYkBokqG5iQJ0N8po7blMWw0EuToHRPYMwcbzZx7AkAr035
X-Gm-Gg: Acq92OHDI0w7QaFREOxtqyAp0dslhboMG5WtEbS6j1wOsPolXhhDuszbl8alhSaWl4x
	ZUfD/6wiK61mJfSM1ZY4bRg14CAEfEPwEiN4ZVGkBsNsYslnITHtGUuIlJWOdXSSxbft91QXPhU
	dcqXRU7RowiGVOBnNXiqs/Gu+z2wTFJ/r7S7YdiYkqIiYghSqQ92t4D8nL7BSO+oBBCPAGwjudS
	4DMBdzGYq5wH5iCh51eIrpFq5I43pLvdxVEEmwcqgKKDAwXPS6MdmNaLjnJ9S2ZPfTlU5RJmNlh
	EFXk3qKFUb0okWyBOAdtOQ9LQDJrC5U1/lvaeteGEZSrtQ9XH42kUctivz8acvDHJAIMfWB7IMr
	sWa8nepU1qJg1nj1I4U6Sl6TgdNDM1xhPK1J8BKJrmH4xm8M2O3nIio/FXBonoQELScLEgrtLeA
	lQ6UbUtWAX91u0mWqPbE9lQEGGzQycqKwQ8yFlP78/KSW4Vq/3
X-Received: by 2002:a17:903:1207:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c6641e180cmr125176215ad.17.1781543863267;
        Mon, 15 Jun 2026 10:17:43 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433558365sm106538685ad.77.2026.06.15.10.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:17:42 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] netdev-genl: report NAPI thread PID in the caller's pid namespace
Date: Tue, 16 Jun 2026 01:17:36 +0800
Message-Id: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:daniel@iogearbox.net,m:razor@blackwall.org,m:dw@davidwei.uk,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:skhawaja@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263411-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA12F688C5E

netdev_nl_napi_fill_one() reports the NAPI kthread PID in NETDEV_A_NAPI_PID
using task_pid_nr(), which returns the PID in the initial pid namespace.

NETDEV_CMD_NAPI_GET does not have GENL_ADMIN_PERM and the netdev genl family
is netnsok, so a caller in a child pid namespace can issue it. That caller
then sees the kthread's global PID, even though the kthread is not visible
in its pid namespace, where the value should be 0.

Translate the PID through the caller's pid namespace, the same way commit
3799c2570982 ("io_uring/fdinfo: translate SqThread PID through caller's
pid_ns") did for the io_uring SQPOLL thread. The doit and dumpit paths both
run synchronously in the caller's context, so task_active_pid_ns(current) is
the caller's pid namespace.

Fixes: db4704f4e4df ("netdev-genl: Add PID for the NAPI thread")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/core/netdev-genl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b8f6076d8007..4c23e985cc01 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -2,6 +2,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/notifier.h>
+#include <linux/pid_namespace.h>
 #include <linux/rtnetlink.h>
 #include <net/busy_poll.h>
 #include <net/net_namespace.h>
@@ -189,7 +190,8 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 		goto nla_put_failure;
 
 	if (napi->thread) {
-		pid = task_pid_nr(napi->thread);
+		pid = task_pid_nr_ns(napi->thread,
+				     task_active_pid_ns(current));
 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
 			goto nla_put_failure;
 	}
--
2.43.0

