Return-Path: <stable+bounces-233704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLwIOiZA1Wk73gcAu9opvQ
	(envelope-from <stable+bounces-233704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:34:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B83B266F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD1430C3E8A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330734252B;
	Tue,  7 Apr 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Qt5VoshN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pg/wNs+C"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A432342CB4;
	Tue,  7 Apr 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583079; cv=none; b=MpG46yYAip11Gx9WlZufF4SmPNOKFcABYp9lkdYMyQFx3dQUIB4qDaRcOdByeh/4Lo/+nAiGN7lK5nReLXy72yFk1z37YRSyE4wjB69Oj/AIztCPwNp4bAIpwBzRLmlTZGOSDtHeNefCnhZFF38rzOMNBDxFke98kUcqVOnpyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583079; c=relaxed/simple;
	bh=tlECP4uTLaQqF5M9Il3Phq0WryFOhdvy7fqtkbVffuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFif9iFd3dvYUFbGqcLZvCf5H6w4ffQLowI0iWlhHVZDz+H06ovTlx34jpHVmsfmavkLtuNNuJnFENXY1Rd/tXAHMk0hIhClw1cBUVAYWuWXzrnuQGpeOQBaDIspz7mzXtfB083agSQyVxQXXC35foiJd8ZBfsfTHM8BJwN3Qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Qt5VoshN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pg/wNs+C; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fqtXM3bP8z9ySW;
	Tue,  7 Apr 2026 19:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775583075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIg2qhrKVQQuHdMcVdIxvMpdtcCA2y5ngwd5rH7xFHE=;
	b=Qt5VoshNB9EznJ7DNd9isUBAQR+2o9cswtWIELjvRqwyuUTULsxsoBv1AF4MT/EgC1APuB
	Um0NsaZyjLthSVGnHPs0a9nE2Ke4n53eWuwJk0MQ+/nHP7XDQJNzcSdfnm7rOJB0n3WTnb
	W/SJSzwtLvgW4C73L8PlzQVSs3iTkpEngCaPPZ763YPICm/4XhRWaNHl9biB/AtEbGovJf
	bcXq7jfSCAxe1xTKM1UYXvdVo7CEa3TdcgBjDfspoYeo6wz1vbd6EQhXHc24ghZLl967Y2
	uedXzOhml7EWHd64fVuC4CNKLONbUjZwO75Qb1bBdRAGvlIAhc9C8DcXHdTaxg==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775583073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIg2qhrKVQQuHdMcVdIxvMpdtcCA2y5ngwd5rH7xFHE=;
	b=pg/wNs+CAjbAtJTlPpFP258sYpX5AosAsh38/Hy7+YvcDXQS2vOs1HQMipmBFBDPjCnJEJ
	ofjg2j7JOFVZMGsWidBUnwcMxmVRWiGubEGUpCQbLxFcuBEEN6Zdbb7C8M/+VioizVHSIE
	OS2EupEx8W0x4hhsPAAbq4JGf5CkyyTTdndBb+Pu6g12zA99fmu/Mybfern+NSR6XCqrx4
	fDAdAk8mfrvuB83agH+0pes4vWXCEHIyDu2PInCmT04XvekSxZBWuB0IaK38mJLtQLA/8K
	lv1ciRgXMldgt2nZ8UMlItvwxGl+rdsBs4DozdurSBD7BcuNG3LdDMCXdWh51w==
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hams@vger.kernel.org,
	stable@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Subject: [PATCH v2] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
Date: Wed,  8 Apr 2026 01:31:01 +0800
Message-ID: <20260407173101.107352-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260407165007.GB469338@kernel.org>
References: <20260407165007.GB469338@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rmpiu6ikw5xibeb9ef3raowfg7e9ej14
X-MBO-RS-ID: 803d5a9751816110560
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233704-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,ecdb8c9878a81eb21e54];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid]
X-Rspamd-Queue-Id: 949B83B266F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sixpack_receive_buf() does not properly skip bytes with TTY error flags.
The while loop iterates through the flags buffer but never advances the
data pointer (cp), and passes the original count (including error bytes)
to sixpack_decode(). This causes sixpack_decode() to process bytes that
should have been skipped due to TTY errors.  The TTY layer does not
guarantee that cp[i] holds a meaningful value when fp[i] is set, so
passing those positions to sixpack_decode() results in KMSAN reporting
an uninit-value read.

Fix this by processing bytes one at a time, advancing cp on each
iteration, and only passing valid (non-error) bytes to sixpack_decode().
This matches the pattern used by slip_receive_buf() and
mkiss_receive_buf() for the same purpose.

Reported-by: syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/6pack.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 885992951e8a6..c8b2dc5c1becc 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -391,7 +391,6 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 				const u8 *fp, size_t count)
 {
 	struct sixpack *sp;
-	size_t count1;
 
 	if (!count)
 		return;
@@ -401,16 +400,16 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 		return;
 
 	/* Read the characters out of the buffer */
-	count1 = count;
-	while (count) {
-		count--;
+	while (count--) {
 		if (fp && *fp++) {
 			if (!test_and_set_bit(SIXPF_ERROR, &sp->flags))
 				sp->dev->stats.rx_errors++;
+			cp++;
 			continue;
 		}
+		sixpack_decode(sp, cp, 1);
+		cp++;
 	}
-	sixpack_decode(sp, cp, count1);
 
 	tty_unthrottle(tty);
 }
-- 
2.53.0


