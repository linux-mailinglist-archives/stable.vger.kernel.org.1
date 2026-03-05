Return-Path: <stable+bounces-223276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMgSKoP7qWlcJAEAu9opvQ
	(envelope-from <stable+bounces-223276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:54:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8234218B1C
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB8BC300AD6B
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8835F5E8;
	Thu,  5 Mar 2026 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoLsCsNV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE75351C1D
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747646; cv=none; b=Fqy9MyhlvGZ/w/y8Col2vv1s0mHFy+0z88BGXbUSqFUSLRVoR5t2xBiKJ0AR8RvtvRbRb2bosTSIYVgM51ooAzhAks9kZxB9ePQJkyJXyAHpT1gSaYVdGSXBC513eZYWeS4Lunjpix1oxJe0U3soOBv0RUhxCmEYkPel178KkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747646; c=relaxed/simple;
	bh=HJCddEP3HpwEtFqNu8fH3f450OqH/961LoMvQQ4Dmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPp6IZrT5jiYlp6pyTV55o9qz+YGhrZ13aIkhqxEKqLj03D2d4TEiR23qfuBWReqJ8njY3sDD8R4OPKn0Cw4bziBjpNmZfo6ETAuZ7pI6SCfdzexCBxI6NRlPgwSlwVGHStfGLqHhUMnWL+Ca+PZiYjZh+0p59sYUYcQvQbR8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoLsCsNV; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-797ab169454so87705857b3.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 13:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772747644; x=1773352444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDyT5wYyzGLSfGloP9Q597W13aZWnETTygjbppIux2I=;
        b=RoLsCsNVO9/BSuieErIsbnqgIX1c5jJWKoiENzXkBGHT+LDBRxCehHEYRxcpqDhcpI
         R3FnlEvwZ3chRXv7fW/k2gfTSxRahBlg/lcA5NAzcLpJwBosZx1zPQI1OrHqXL64gcdI
         LMV97nbITiWn1X4HTo/uMI4S/W9fySASXcYMsuS2RLe4s2db2GN8HAiHhuD46e8fTP1V
         IzbHIqRnAuYwjQjf6KB3ee5Ev7mnPk2UUHocHGOAqHiQaWpVQVOMNNr0zrJRUyAudquH
         oV83RarCuDgHOAuwYvI66CURrVZQDAAAcrgBK/DyA3HarkjS9cg9BGsAPWILsDQRl4cL
         7BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747644; x=1773352444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDyT5wYyzGLSfGloP9Q597W13aZWnETTygjbppIux2I=;
        b=JC/d9EY/YNWEcQm1e++q8krW4PKJvppu1E1ulUj34pjd4FNqZmCwiHTXxcRm8hyvBJ
         1ygC0ox3UXLBhlDQFI4Lvvu3A5Ek59iQ4PYac9Ip1pIBaNFlJm/5XeEK7NzXb0a4ksIP
         gOTEcs1mIC44tmxZdk8cwEI7f/nvAT1NLETQi5HjLfRFNdLxWNYm0rO9e+8dbZ1Ljn4g
         0IHcSwA5oAFbNKc0LENiHzfmE12teVt0tJBclGgrvvbzgnHTvpv0nHiUZ0CJs1EvlJVa
         cLTCmeUvvu4GbKaE6eiizKaXBzyBMEfm+RoPpuDWsmXuWNZHTGPyEGWxdXNRBjUOorQ4
         t67w==
X-Forwarded-Encrypted: i=1; AJvYcCXiH5NBJ2kF0iqjJrBYDnX3/lPUyTU8E7z8zS0hfeTvggAB2s2nmvzpoHwvsA47zfPe01h/zVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsA4WxRdoqdBF7BJo3uQ1eYUgGUsHLIt4Xpc2qekPkEwJ+GM1a
	futVpvwEcdLJrgWtrNGDRIny923TuzT/OSAN+RE6veiLoq5MjE//RG6I
X-Gm-Gg: ATEYQzyIqHBWcTWikIfifBjiGx6XbOe4OJnBPhBBeARTnsncmsfwhXQHX066mD65QmU
	ex3nctaJJ17ysWIjTlfTcAQdsy4T2kKbh/kBMHxrw0b+XrMgygmrcIXqcwmlCLiZwrseS/79zBG
	B7JBH0Xrkufh9XO7YfrP+RiNCj+JioAMA5sCQc00eW/fiKOWdHMgwhfMGcy+/tT9XYRclgJc9Hd
	4hiTtUcS87Oq/MlLetc7UWXhDY/KIF19mvrUdc2fiNKgb/Jpz04dZ/qVFBVAFQQl+xSIU0G2vER
	51sRZ++ZJlAkTwyau3Hp+9yj9eYJSonXLQz2Gxnpitjo7O6YjXvP1iaLKo1d4U285jObWwqoA6R
	T0T165NE9jeiNgzUAYy3L5hOhNRidc/X5Vrdy2BTKrG/8b1yXTgfC0M+sRUroVfgZDJf77T3hfi
	q71qy+oxYh9M7ixgKp59gxxZXhuNR0C8ps1gssny5Ov1CdxfYVfhxDX3WU
X-Received: by 2002:a05:690c:660c:b0:798:6561:2a7c with SMTP id 00721157ae682-798c6ca2ea1mr59720497b3.41.1772747644186;
        Thu, 05 Mar 2026 13:54:04 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ca7354sm90121677b3.52.2026.03.05.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:54:03 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH] tipc: validate conn_timeout to prevent divide-by-zero
Date: Thu,  5 Mar 2026 16:53:36 -0500
Message-ID: <20260305215336.645186-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8234218B1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.sourceforge.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223276-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

A user can set conn_timeout to any value via
setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
tipc_sk_filter_connect() executes:

    delay %= (tsk->conn_timeout / 4);

If conn_timeout is in the range [0, 3], the integer division yields 0,
and the modulo operation triggers a divide-by-zero exception, causing a
kernel oops/panic.

Fix this by rejecting conn_timeout values less than 4 in
tipc_setsockopt() with -EINVAL.  Values below 4ms are not meaningful as
a connection timeout anyway.

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
RIP: 0010:tipc_sk_filter_rcv+0x1b99/0x3040
Call Trace:
 tipc_sk_backlog_rcv+0xe4/0x1d0
 __release_sock+0x1ef/0x2a0
 release_sock+0x55/0x190
 tipc_connect+0x140/0x510
 __sys_connect+0x1bb/0x2e0

Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 net/tipc/socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 4c618c2b871d..85c07b0ba0ec 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3184,6 +3184,10 @@ static int tipc_setsockopt(struct socket *sock, int lvl, int opt,
 		tsk_set_unreturnable(tsk, value);
 		break;
 	case TIPC_CONN_TIMEOUT:
+		if (value < 4) {
+			res = -EINVAL;
+			break;
+		}
 		tipc_sk(sk)->conn_timeout = value;
 		break;
 	case TIPC_MCAST_BROADCAST:
--
2.48.1

