Return-Path: <stable+bounces-265825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KLgZMrCQMWp+mwUAu9opvQ
	(envelope-from <stable+bounces-265825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:06:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D15693CEC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:06:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Vrts3+7Y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265825-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265825-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF9DD30F6CB0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88B3D811A;
	Tue, 16 Jun 2026 18:06:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EE3D810C;
	Tue, 16 Jun 2026 18:06:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633196; cv=none; b=NCvhs4LmYFp6G0LZxAWc4dT9baCDzX7sE8t2O5MSkn7rGUFu73bDw2Vt3F5cZY/hG7DkpA1mhrTMIk6cPBjlBOzL6hRcRWUkFiLc65bKtOYk/OWfVYY7lUUdLiJuu7CLCDtYRTsdJvAzvp4alFgXDN9nDP7QQQnwa9m5i+8ZlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633196; c=relaxed/simple;
	bh=JMlA9M7QDVclwxYc1qKVEBMJ0PKbW7h3InK2WCsKh4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pfejav20NCJl0xF2zLI0PX+l/RFXcZ/0toKFc2PqiowPrfQSzZQltfbIi1+xRCjVP2argr1RGYzCnNCr3CEvLrC00kHvRA+AHi40J1N6AGPTkNAo4+lGAuTRV4EQlmhBgvBwEQhiVrPclUS7xSlstSoc3UUZNwvaBE0JIzmpmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vrts3+7Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3871F000E9;
	Tue, 16 Jun 2026 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633193;
	bh=BsiGnypnl63BjY+yYYKTx1aoPm8jYw5XKCI1YBu+B7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vrts3+7YzV2+UbU4ozg1hOOPwq4ATidhny58BU2pA6MuCdTa32D87B912AVLNhwxP
	 I4m8yt0WiVV3kGv+fO81wwKUn/2qyUhzQ3nqBovbyD2HYidMsnD/HKiHLUUJM99eq0
	 poQ+3ZCQzkxWWnxKb3HRYgMb/y92k3oEuo4okHlY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenghang Xiao <kipreyyy@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 034/411] sctp: fix race between sctp_wait_for_connect and peeloff
Date: Tue, 16 Jun 2026 20:24:32 +0530
Message-ID: <20260616145102.147205777@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265825-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kipreyyy@gmail.com,m:lucien.xin@gmail.com,m:kuba@kernel.org,m:sashal@kernel.org,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21D15693CEC

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenghang Xiao <kipreyyy@gmail.com>

[ Upstream commit f14fe6395a8b3d961a61e138ad7b36ba3626dd4e ]

sctp_wait_for_connect() drops and re-acquires the socket lock while
waiting for the association to reach ESTABLISHED state. During this
window, another thread can peeloff the association to a new socket via
getsockopt(SCTP_SOCKOPT_PEELOFF), changing asoc->base.sk. After
re-acquiring the old socket lock, sctp_wait_for_connect() returns
success without noticing the migration — the caller then accesses
the association under the wrong lock in sctp_datamsg_from_user().

Add the same sk != asoc->base.sk check that sctp_wait_for_sndbuf()
already has, returning an error if the association was migrated while
we slept.

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20260527032411.60959-1-kipreyyy@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 11040232ee937b..136b122d87c5a6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9369,6 +9369,8 @@ static int sctp_wait_for_connect(struct sctp_association *asoc, long *timeo_p)
 		release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		lock_sock(sk);
+		if (sk != asoc->base.sk)
+			goto do_error;
 
 		*timeo_p = current_timeo;
 	}
-- 
2.53.0




