Return-Path: <stable+bounces-264726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1jgcIjd8MWo8kgUAu9opvQ
	(envelope-from <stable+bounces-264726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:39:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FC6924D6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=R4xIzDPO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264726-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264726-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6691F30C4F39
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590EF477988;
	Tue, 16 Jun 2026 16:32:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3A472786;
	Tue, 16 Jun 2026 16:32:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627538; cv=none; b=jshBSLRDREGKoKEJNSIOyQUo56P2wy1wNHNDTM3QkREZ9qk2v7dKA2lKC9yiYWEF/Lq4xPHHwGfJamnkUs0UEARtd1Vw25FnWrWG7MafhxWAAmxuwJFFzrn/2UAle0yo/8nu3UCbZw4Km+U/VMsFIj1e5Ps1J4pvTX2WROFsqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627538; c=relaxed/simple;
	bh=Pe3spdqEVjRBpuliCwnbcBX9g3+/DTS7nJLuUEESFbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDhlLcbwU5pPTiSsb0F7gTzgDudlZTq3cDYOs3LH+KEg9q0Nt98olitUOx48mZqy0f/sdM9dkV6cB7FV9PbN0T5TJuZI26fwtGqJR95ppL7JPEwR9q9cvWkSlBA+7zrp9kJL41gPqQnOjfTo61qlR64K4QdPEQGxUKLEASJINus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R4xIzDPO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416EC1F000E9;
	Tue, 16 Jun 2026 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627537;
	bh=u47PoEXhLVMB0BRONPeVdkJz5PY34/QjUCwYCuHKf2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4xIzDPOBvTvLl9c9ZWxCQ7JVCqdX1RqsIK9jUTm0LAiXgbrSJ6eoLPpzTly89HQL
	 pqgZKT8X1twBBQWjnomuaxnk75jqL3hH9RHwD6oaxSAwNM6DnXU5g5nhbKwAgFmpLa
	 p/X8UidDUf9F1g+DtCRvfFOhFDDnkbQpJFwnDUqw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tip ten Brink <tip@tenbrinkmeijs.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 190/261] io_uring/wait: fix min_timeout behavior
Date: Tue, 16 Jun 2026 20:30:28 +0530
Message-ID: <20260616145053.868804962@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264726-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:tip@tenbrinkmeijs.com,m:lk@c--e.de,m:axboe@kernel.dk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,c--e.de:email,kernel.dk:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tenbrinkmeijs.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E19FC6924D6

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Christian A. Ehrhardt" <lk@c--e.de>

Commit 29fe1bd01b99714f3136f922230a643c2742cda9 upstream.

The wakeup condition if a min timeout is present and has expired is that
at least _one_ CQE was posted. Thus set the cq_tail target to
->cq_min_tail + 1. Without this commit a spurious wakeup can result in a
premature wakeup because io_should_wake() will return true even if _no_
CQE was posted at all.

Cc: Tip ten Brink <tip@tenbrinkmeijs.com>
Fixes: e15cb2200b93 ("io_uring: fix min_wait wakeups for SQPOLL")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Link: https://patch.msgid.link/20260606201120.1441447-1-lk@c--e.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2414,7 +2414,7 @@ static enum hrtimer_restart io_cqring_mi
 	}
 
 	/* any generated CQE posted past this time should wake us up */
-	iowq->cq_tail = iowq->cq_min_tail;
+	iowq->cq_tail = iowq->cq_min_tail + 1;
 
 	iowq->t.function = io_cqring_timer_wakeup;
 	hrtimer_set_expires(timer, iowq->timeout);



