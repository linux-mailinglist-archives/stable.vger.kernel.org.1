Return-Path: <stable+bounces-264725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mQWgDsJ6MWqkkQUAu9opvQ
	(envelope-from <stable+bounces-264725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C6B69231E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:33:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rDNAmjzr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264725-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264725-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FC9A304A4CC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F975477E33;
	Tue, 16 Jun 2026 16:32:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186F4508F2;
	Tue, 16 Jun 2026 16:32:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627533; cv=none; b=j79rmEHJ89fbvmzf1fmFuk9yfkafpXFlgJ3PB8t4YNzu3uoyInL6tlatRoNXpVOzG9WB6qyougN0NSjgRJrQTmazl+RLotROVZK9Vjjy2l5+oUxvChacXeUwCrp3zx44c2Yc4S6kCk1bGF28HPFVLrA944gZtW7lkH4T2MJt5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627533; c=relaxed/simple;
	bh=Jyb9muVDZJh/85r6QgtsoAhQwpCl0vQlbq1q3+3sp88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tftznf/LoNxdyrCM1Cv56hcgUmgMCCbDklEcIPhppxjRU/B1GQTuhKffniZKq8GTOXeZxpRkVH9sCW0BTTmFoEI71FUvU+YUMXQou9LusnV5VzUe+l0QrH81FELu/WVBSgwjQexHBR1VZan3fVzdqcPmvS6VBV9J/R1IHBGS08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rDNAmjzr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A921F000E9;
	Tue, 16 Jun 2026 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627531;
	bh=6tLH3RI7H0vb0FLEtmuHLomYoIF6weWPoMVd68bXzlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rDNAmjzr9OquNgf8JxRI3InrawvzdLzX6/0R9W796YzU87OJ80Mpqs7AB9o2dfctF
	 0UApFjlLZJuuYngTKHks8ToPweZnr8zkEZqxzxFzMSkR0pCb0dMk2KwQkyiSx2IuTn
	 1l3ZbmicwSDF5oy/+TihBuyUJKNojllWf6IsoEwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Federico Brasili <federico.brasili@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 189/261] io_uring/kbuf: dont truncate end buffer for bundles
Date: Tue, 16 Jun 2026 20:30:27 +0530
Message-ID: <20260616145053.821640587@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264725-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:federico.brasili@gmail.com,m:axboe@kernel.dk,m:federicobrasili@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kernel.dk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5C6B69231E

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 70f4886bcbb929e88038c8807f1daf7fc587ae7c upstream.

If buffers have been peeked for a bundle receive, the kernel will
truncate the end buffer, if the available length is shorter than the
buffer itself. This is unnecessary, as applications iterating bundle
receives must always use the minimum size of the buffer length and the
remaining number of bytes in the bundle. The examples in liburing do
that as well, eg examples/proxy.c.

If the kernel does truncate this buffer AND the current transfer fails,
then the buffer will be left with a smaller size than what is otherwise
available.

Just remove the buffer truncation, as it's not necessary in the first
place.

Link: https://lore.kernel.org/io-uring/CAAEr8jbY60noGj1fw_k91UJRBkyiRVoS6=nLhZ7Svwidjn4CAA@mail.gmail.com/
Reported-by: Federico Brasili <federico.brasili@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 35c8711c8fc4 ("io_uring/kbuf: add helpers for getting/peeking multiple buffers")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/kbuf.c |    1 -
 1 file changed, 1 deletion(-)

--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -293,7 +293,6 @@ static int io_ring_buffers_peek(struct i
 				arg->partial_map = 1;
 				if (iov != arg->iovs)
 					break;
-				WRITE_ONCE(buf->len, len);
 			}
 		}
 



