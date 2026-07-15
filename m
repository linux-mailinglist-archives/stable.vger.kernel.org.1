Return-Path: <stable+bounces-274912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E3ScKbRxV2p/OAEAu9opvQ
	(envelope-from <stable+bounces-274912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:40:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23E75DA0E
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZaiOJJpz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274912-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274912-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5235130080AB
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B23B27F4;
	Wed, 15 Jul 2026 11:40:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547DD43303A
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115627; cv=none; b=Z4MhEiITbTpCVu8bJgRaW9hje8uYXFgvYgqV00sPLcqhwK3spDmK2GlMJ/XQpMtV4ECR6diyRvS3ry/4NAMz6EOH6xXGhECgRyxjTbHQxb2oB7Jx7c+qGTTiAXl/WndaS45uJwIH9Z9WQwAjEpITlhoQGGpjXynFuCLWLpqgIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115627; c=relaxed/simple;
	bh=sIxXvNI9OBBFOr+5tk8wIXJAmXmqGlX6vGJgXDsYjlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYqOGdmy8GWtN/ruXARn8jOiL37SI6FxJxnbDqlpynB110fHHikG7/nmNV/wJvT+Mh+Bnz/NinZbAAgF/KveM7agL3sKncBwX3VLxFqmoYmlBQNaWLxlbJPs3M9tJ3+cJDRkyoTNshtWciGqnB4N2tBYhOdmyyIV0pC1pcjq53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaiOJJpz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D60B1F00A3D;
	Wed, 15 Jul 2026 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115626;
	bh=7foHQ87lxEB1eudb38AO7hm9RxFZSdtOLpakl49oElY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaiOJJpz7DsXnxeCr47wZJJLGOxE4sxL0jdSOmM9ZXovBGlh9vxTtlWreBzy1aiwJ
	 o9N/ukfxGuCpnT8ZJ9763pGqvcQr60RnFhELkwlykV9iJhdtJQLHu5LJJiRliLPMqB
	 4Gv6slebRQYmVE+XpPF2qFdf2NkwQkBWOUqVh/eDNtA+mCJXz3PN5zwvGwTTenHcfK
	 yWcLWxkN7X1hOWYuNGFGC++ymoTYicD8EYn+c24DWUhk/dprg4s5yNcPUk8jSBeELm
	 b2I6UF585p83w9qAh+Nom+W5b/aVJkqWoEZaz/VHiEd12AxkGMG5hFow5cTU3IPwml
	 zSjqcPL/hmvHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Wigham <michael@wigham.net>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] io_uring/rw: preserve partial result for iopoll
Date: Wed, 15 Jul 2026 07:40:18 -0400
Message-ID: <20260715114018.726395-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715114018.726395-1-sashal@kernel.org>
References: <2026071357-gout-canyon-b50f@gregkh>
 <20260715114018.726395-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:michael@wigham.net,m:axboe@kernel.dk,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274912-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A23E75DA0E

From: Michael Wigham <michael@wigham.net>

[ Upstream commit c554246ff4c68abf71b61a89c6e39d3cf94f523e ]

A partial read will store the completed byte count in io->bytes_done.
The regular completion path applies io_fixup_rw_res() so that, when the
following operation reaches EOF, the number of bytes already read is
returned.

The iopoll completion path does not apply this fixup to the return value
and can return zero instead.

Use the fixup result when updating the CQE, and the raw result for the
reissue check.

Cc: stable@vger.kernel.org
Fixes: 4d9cb92ca41d ("io_uring/rw: fix short rw error handling")
Signed-off-by: Michael Wigham <michael@wigham.net>
Link: https://patch.msgid.link/20260613225240.34032-1-michael@wigham.net
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/rw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0afbb1ae76618f..a744cb5d235a6a 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -546,15 +546,15 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 {
 	struct io_rw *rw = container_of(kiocb, struct io_rw, kiocb);
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
+	int final_res = io_fixup_rw_res(req, res);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
-	if (unlikely(res != req->cqe.res)) {
-		if (res == -EAGAIN && io_rw_should_reissue(req))
-			req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
-		else
-			req->cqe.res = res;
-	}
+
+	if (res == -EAGAIN && io_rw_should_reissue(req))
+		req->flags |= REQ_F_REISSUE | REQ_F_BL_NO_RECYCLE;
+	else if (unlikely(final_res != req->cqe.res))
+		req->cqe.res = final_res;
 
 	/* order with io_iopoll_complete() checking ->iopoll_completed */
 	smp_store_release(&req->iopoll_completed, 1);
-- 
2.53.0


