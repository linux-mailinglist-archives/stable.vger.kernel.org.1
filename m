Return-Path: <stable+bounces-220533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLF3Fmc8o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD78C1C695D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C56325606D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA253CFCF4;
	Sat, 28 Feb 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6j1we1l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0153CFCEB;
	Sat, 28 Feb 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300416; cv=none; b=YdDU/E3CNi/qp5tB7Q12c28JmD4E7fS0z9V6GeleBrnFeeWNi+6YN6L1E7ImFFeH/Y5XTQ6coZlHAc3FnEmKar7fkYRI0FWGuMQgJVBkwJ2OAjurvUU2+gtDk5O5yrfK/+GcUafz6Q8l21r4mDBvsYcCrE29Q0sZclitNeXkdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300416; c=relaxed/simple;
	bh=dH/i1FBsguOEmUILzyVjTdcuHv2E7eXf4aeX/spdWmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m57M92kHJPWk5H0GeafvyIr8Lojr0kz+gwOGRkWB9subFx+BtHSL2B3TpNqntLDXs9mqb3No6zYyGpGKqk8kOcj3gB/XTUB6pztbYvjbMepS7PPcwil6gX+6Ypp6Popkf3QQ4XzS6M27BZS5CHEmAp0CMPz+L9tGXkL5IkZfQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6j1we1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45DDC116D0;
	Sat, 28 Feb 2026 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300416;
	bh=dH/i1FBsguOEmUILzyVjTdcuHv2E7eXf4aeX/spdWmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6j1we1l3Yhp/wKBsoYQjfTTHs06Q+FILcL0Tb/X2nsAs9iWFZ7WAvDUaMJ3Pso5j
	 PWibYPGCCKZ9FiHqq8kbDSFliLK1rXnCxzsZFY5b2Q+ko3YgEUE89gN2xs0mcbWsjT
	 U7Q09Ugf3GqmRgQk56+eBekvMdPTkgMvmtdSSTUKgPqP/Q8HKhflVUgxMGGv63FCx6
	 glEFMtutZMAd9jkfdYJkGKlwv7SVer/vKrQecDwKrgbZFOUhtsdrtG1c4QYGmQ4Elm
	 uCzuRvJVQfpsFIxclP/jUGEL4WABvId4wu1vYRQjHKJGE0Sx3FgYwqSvc+BuK5OQ4k
	 pdjFfBk9XhgPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 454/844] espintcp: Fix race condition in espintcp_close()
Date: Sat, 28 Feb 2026 12:26:07 -0500
Message-ID: <20260228173244.1509663-455-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220533-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: AD78C1C695D
X-Rspamd-Action: no action

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit e1512c1db9e8794d8d130addd2615ec27231d994 ]

This issue was discovered during a code audit.

After cancel_work_sync() is called from espintcp_close(),
espintcp_tx_work() can still be scheduled from paths such as
the Delayed ACK handler or ksoftirqd.
As a result, the espintcp_tx_work() worker may dereference a
freed espintcp ctx or sk.

The following is a simple race scenario:

           cpu0                             cpu1

  espintcp_close()
    cancel_work_sync(&ctx->work);
                                     espintcp_write_space()
                                       schedule_work(&ctx->work);

To prevent this race condition, cancel_work_sync() is
replaced with disable_work_sync().

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/aZSie7rEdh9Nu0eM@v4bel
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/espintcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index bf744ac9d5a73..8709df716e98e 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -536,7 +536,7 @@ static void espintcp_close(struct sock *sk, long timeout)
 	sk->sk_prot = &tcp_prot;
 	barrier();
 
-	cancel_work_sync(&ctx->work);
+	disable_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
 
 	skb_queue_purge(&ctx->out_queue);
-- 
2.51.0


