Return-Path: <stable+bounces-266433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RRYDBzOdMWoWoQUAu9opvQ
	(envelope-from <stable+bounces-266433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:00:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F51694A59
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:00:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=kS1IVsva;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266433-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266433-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F4273045B31
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29647CC96;
	Tue, 16 Jun 2026 18:59:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FCB472798;
	Tue, 16 Jun 2026 18:59:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636398; cv=none; b=ifIjP3Y/V9DWhhy/NMQDtNybumEp0pZJgi4Nn/r2ZfqSNblRPiQl2j4poSGRsdCrm4KWN2J76ifefF59S4qc5sJGTTokc3k2Qu4Fx4RPRnlh+Rg5EaRPkEoRS26Dv7rVzT/O8F7REcqOPsBB1xQvLxVeQtxDcP7n2yAAgPiDwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636398; c=relaxed/simple;
	bh=UACtSUDjlrYbM2OsKpTx/C30KQ6X2W0ULdkBPOMfxTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odhAF37WU1ES5Uzu/B5ZEsQQJ6788Juelze5e/PldaOlT6G+jydNp9bvicWYeRwwlDi/vyWf1PkWZ2+dnHeLe5lPQFH2ar+nrFTSTamUPG7aqM6EBGC5O+eP7vU/rmft2eZ5WTcvrm9JFPXKhcxDGy2yMnUG3Fsd7MXBOROpG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kS1IVsva; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D3B1F000E9;
	Tue, 16 Jun 2026 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636397;
	bh=PTQoYmxuADBnPi0ukGnrtDobUwlKsm8/DzoWH4FYV1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kS1IVsvaUF1dMcKz7bm/V5rT9+yyOHBJnh9lo/77qLIF4BqX4h9dFtfCSujPVMJZw
	 vOwtxmA0kwtVcQMl/vdToQf0OG+2k9wRRG7SWgFUtWCuePI8R7sKtElpEz2qpFNFbi
	 sxlorxJsUeDYQYYZKMkDdmSXXwKHzBoiS/Rzq83M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Longxuan Yu <ylong030@ucr.edu>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.10 214/342] io_uring/poll: fix signed comparison in io_poll_get_ownership()
Date: Tue, 16 Jun 2026 20:28:30 +0530
Message-ID: <20260616145058.149589321@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266433-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:zcliangcn@gmail.com,m:ylong030@ucr.edu,m:n05ec@lzu.edu.cn,m:asml.silence@gmail.com,m:axboe@kernel.dk,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,ucr.edu,kernel.dk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,lzu.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,ucr.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63F51694A59

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Longxuan Yu <ylong030@ucr.edu>

Commit 326941b22806cbf2df1fbfe902b7908b368cce42 usptream.

io_poll_get_ownership() uses a signed comparison to check whether
poll_refs has reached the threshold for the slowpath:

    if (unlikely(atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))

atomic_read() returns int (signed). When IO_POLL_CANCEL_FLAG
(BIT(31)) is set in poll_refs, the value becomes negative in
signed arithmetic, so the >= 128 comparison always evaluates to
false and the slowpath is never taken.

Fix this by casting the atomic_read() result to unsigned int
before the comparison, so that the cancel flag is treated as a
large positive value and correctly triggers the slowpath.

Fixes: a26a35e9019f ("io_uring: make poll refs more robust")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Longxuan Yu <ylong030@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://patch.msgid.link/3a3508b08bcd7f1bc3beff848ae6e1d73d355043.1775965597.git.ylong030@ucr.edu
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -5378,7 +5378,7 @@ static bool io_poll_get_ownership_slowpa
  */
 static inline bool io_poll_get_ownership(struct io_kiocb *req)
 {
-	if (unlikely(atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
+	if (unlikely((unsigned int)atomic_read(&req->poll_refs) >= IO_POLL_REF_BIAS))
 		return io_poll_get_ownership_slowpath(req);
 	return !(atomic_fetch_inc(&req->poll_refs) & IO_POLL_REF_MASK);
 }



