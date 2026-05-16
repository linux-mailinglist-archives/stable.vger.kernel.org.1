Return-Path: <stable+bounces-249024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGP/BC6+CGql3QMAu9opvQ
	(envelope-from <stable+bounces-249024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:57:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7442655D696
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 20:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E995301E96F
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A64346FC8;
	Sat, 16 May 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="C3iSBj+3"
X-Original-To: stable@vger.kernel.org
Received: from cvsmtppost31.nm.naver.com (cvsmtppost31.nm.naver.com [114.111.35.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE54346791
	for <stable@vger.kernel.org>; Sat, 16 May 2026 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778957840; cv=none; b=FpXf1sa4XmAPbh41n2L2IKc9jQM/bhGcLM0XyAkIuaHBveF1YGZRZpN+MpAXmWXk4+ag7JLnmADwSiMiu/n9inVEBZTbpr/fOx2Bpcup3oVOaJ7FRWXeTitgnkPP79DdDphq6c/DOSow0JKdPs9Yt4SwnqsC/t29FhBnCxqI38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778957840; c=relaxed/simple;
	bh=BI0vBVl9tWNuZwGpeDers6tiRT/vw15LujgyQ7mMs3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bq6PNcYTWhQntWuDKxfl9MdlByDSw2nZ+VDYqrenW08BUinuKRGz8n4VkZUGzXMYbJQRWoGsk8hMJmvSz+8SHAWi+8io+JQCcccVFyJ3BKyor71JAuHT5BX9uYTu84PGEjM5O+7kKEALlXzbfAWV+/VQH41bp4UEX5A8BJUYOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=C3iSBj+3; arc=none smtp.client-ip=114.111.35.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Received: from cvsendbo029.nm ([10.112.18.60])
  by cvsmtppost31.nm.naver.com with ESMTP id 5GNA9f10TKu8P+yFB7Zu3w
  for <stable@vger.kernel.org>;
  Sat, 16 May 2026 18:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1778957230; bh=BI0vBVl9tWNuZwGpeDers6tiRT/vw15LujgyQ7mMs3o=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=C3iSBj+3YXmq9/wrZGIjiO29whXa/857WcQHyjCmS9g89JrkQ2ahi6hL8QbGgNi13
	 P+8WIzRO67bRiv0BFWT3Jf7tkpQONZVWQeMOv9koumZmugEAZgFIr728qHcUf4qeyN
	 reRTf6Elw9osvGN732qDJyC/hDDkBjr9vNx53yqFgsfNP23p0SIqFufFU6X1cHBmED
	 nsmbFdVTn0LboJB1L2LmkxwUeXz9ZN2hOiCBJ9Cv9HzWfGA97kQvCWL8wsGYJpkSPQ
	 DY1x80znzzGJIAu7JtdLn5IzJlMh7Si0/X0E6BAGnVfFR6a7pDif+iBWhER5pK46Hh
	 eG9zIoo3EY7+g==
X-Session-ID: bcA97ukCQW2KMl3kdGiLdA
X-Works-Send-Opt: kQbdjAJYjHmdKoUqFxJYaAU/aHwtxBmwjAg=
X-Works-Smtp-Source: VZYZax2XFqJZ+HmmKq2d+6E=
Received: from DESKTOP-PE9G5L9.localdomain ([1.219.165.140])
  by cvnsmtp004.nm.naver.com with ESMTP id bcA97ukCQW2KMl3kdGiLdA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 16 May 2026 18:47:10 -0000
From: Heechan Kang <gganji11@naver.com>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	Heechan Kang <gganji11@naver.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] io_uring/waitid: clear waitid info before copying it to userspace
Date: Sun, 17 May 2026 03:47:09 +0900
Message-Id: <20260516184709.852814-1-gganji11@naver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7442655D696
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[naver.com,none];
	R_DKIM_ALLOW(-0.20)[naver.com:s=s20171208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249024-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,naver.com];
	FREEMAIL_FROM(0.00)[naver.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gganji11@naver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[naver.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,naver.com:email,naver.com:mid,naver.com:dkim]
X-Rspamd-Action: no action

IORING_OP_WAITID stores its result fields in struct io_waitid::info and
later copies them to userspace siginfo. The prep path initializes the
request arguments, but it does not initialize info itself.

If the wait operation completes without reporting a child event, the common
wait code can return without writing wo_info. In that case io_waitid_finish()
still copies iw->info to userspace, exposing stale bytes from the reused
io_kiocb command storage.

Clear the result storage during prep so the io_uring path matches the
regular waitid syscall, which uses a zero-initialized struct waitid_info.

Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Heechan Kang <gganji11@naver.com>
---
v2:
- Resend as plain text; no code changes.

 io_uring/waitid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index d25d60aed6a..32f68fd7fcd 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -275,6 +275,7 @@ int io_waitid_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	iw->options = READ_ONCE(sqe->file_index);
 	iw->head = NULL;
 	iw->infop = u64_to_user_ptr(READ_ONCE(sqe->addr2));
+	memset(&iw->info, 0, sizeof(iw->info));
 	return 0;
 }
 
-- 
2.43.0

