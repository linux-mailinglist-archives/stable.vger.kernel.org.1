Return-Path: <stable+bounces-250210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AsGLfHjDWpN4gUAu9opvQ
	(envelope-from <stable+bounces-250210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:40:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045C59232E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B19A30269C0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF3B3F20E3;
	Wed, 20 May 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkWAGOIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2B3EF0A1;
	Wed, 20 May 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294817; cv=none; b=F/ggcMr95VkIGcTn2RzlQjqi7O8LcZc6hSW+YKkGnfdi/+HFQObMgGLeFPJZrwkWPSeJojEygrFCzV/CxtpvHaQC3ywBATLl9ID4EKQIU5XFEoi/yrZNZNYz1QJ6TV95bj8FQmRd0+U/DPEToYPRR2xUkAiK2n9PlYgifcovhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294817; c=relaxed/simple;
	bh=vJ7R4lufKorvsk1jaXn+CPNokhXSkYqXLxFlbjojWcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5v9EtKvybOS+J7+HwReFopspQPrxB7FRQc4GNkXM34BWj4O0YE8+fdX5B5xo+vaf/QHG9UAMT2w4+iOcsQKPbqXXvGeDK0+0TNaQPfIBnmBq/OxistgMg1uyk2FaR935Su5TaW8gEXRsFHe6+X1l0jN0+rQ7o31M+6JjkfDl1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkWAGOIu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9541F00893;
	Wed, 20 May 2026 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294816;
	bh=QJDq0BeMy46B00qBdC4HWcGCjoEYxNdZji06r+MFpgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HkWAGOIuuETOodo6ABqLqSdQ6wUPKvwC6B0Er14VyP/7WCpBBVDKYJeDaQ7SRnQ9B
	 Felppkz3uBy/yZKwpi5YVSu9L884AI71gvkOA2mMC/49LU1hRCgmT8n/ALLR77uaPe
	 JYocSc/A1Y+y6HP3GZwvXk4BMQJaunPY7xk0xvDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0184/1146] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
Date: Wed, 20 May 2026 18:07:14 +0200
Message-ID: <20260520162152.443628926@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-250210-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,ecdb8c9878a81eb21e54];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,mailbox.org:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 2045C59232E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mashiro Chen <mashiro.chen@mailbox.org>

[ Upstream commit bf9a38803b2626b01cc769aaf13485d8650f576f ]

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
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260407173101.107352-1-mashiro.chen@mailbox.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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




