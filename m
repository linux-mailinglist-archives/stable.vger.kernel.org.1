Return-Path: <stable+bounces-262915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W2g3AHP4K2onIwQAu9opvQ
	(envelope-from <stable+bounces-262915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 14:15:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 513496794AD
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 14:15:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BJFWQyuY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262915-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262915-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E747B305A5CA
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B637CD4E;
	Fri, 12 Jun 2026 12:10:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8437312831
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 12:10:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266254; cv=none; b=mxxFmVDXeScPj90AMOdUXraZuF9w6YB4nL2Zbe7JjpJ4Yfy/nTciztnXXEezeOzq0BpAajVJ/T1/UgJ/BYSt1+J67m8UubZGnWsQZmAZCwFiog3rHJweXBx8iLJhKeEf7qFx6hkhGWjuu26hE7m9OeRFyH09+LBueeWPik0cKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266254; c=relaxed/simple;
	bh=HZ9Ks0XPk0YTR1RMBY9S7/jI8tTrBBoWbjsfOfflUkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcMAMG8pYO/gIJu+MWOwV3TF45+OsbmzxWeYGBF1XVrUG2txJy4CqplcySjES1NXxZpJvjH0fpAhSjfSI1/78zROyjmDDWXyHgYpQvUzX+nam+baueVBHWK9oymLAqQjY6hOzn98/CW3lbp0LRTMPBJJgIS22cuL8XhmtY/Jpgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJFWQyuY; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781266251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAG/aaleL+KGNyeyu+ILijGdPmXoI66HYof8HAvsvrY=;
	b=BJFWQyuYVpBx0tN6I6MqUehlsSHc7TBx/jLjtywXvtfaBAKwnqZCivghnO+t6c0mKSbqVe
	8xGlcNjjUtrNZeFSHiqI4FcDDZrP/UEmxSmKqg8xalaSZedQ/vrViu2l7UENWSyHrB0/en
	//FchL4uBsTF8/9rMmhVxHYxtscY4CM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-3v5IX6EUPKqTgzN8ju9jJw-1; Fri,
 12 Jun 2026 08:10:50 -0400
X-MC-Unique: 3v5IX6EUPKqTgzN8ju9jJw-1
X-Mimecast-MFC-AGG-ID: 3v5IX6EUPKqTgzN8ju9jJw_1781266249
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CFA21800A7B;
	Fri, 12 Jun 2026 12:10:49 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.93])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E1E33008B34;
	Fri, 12 Jun 2026 12:10:48 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH 6.12.y] iomap: don't revert iov_iter on partially completed buffered writes
Date: Fri, 12 Jun 2026 08:10:47 -0400
Message-ID: <20260612121047.397754-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262915-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:gleventhal@janestreet.com,m:ehagberg@janestreet.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bfoster@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 513496794AD

Gregg reports that the iomap retry behavior for nonblocking (nowait)
append writes is broken. The problem occurs when an append write is
first submitted in non-blocking mode (i.e. via io_uring), partially
completes before hitting -EAGAIN, and then is resubmitted from
blocking context.

The specific problem is that at least one iteration of the loop in
iomap_write_iter() completes in non-blocking context and thus has
bumped i_size. The next iteration hits -EAGAIN, reverts the iov_iter
and returns. io_uring retries the entire append write from blocking
context, but since i_size has already been increased, the data that
was partially written on the first attempt is rewritten at the new
i_size. This is essentially an intra-write data corruption since the
data written to the file does not reflect the write from userspace.

This problem is already fixed on master as of commit 1a1a3b574b97
("iomap: advance the iter directly on buffered writes"). That commit
was primarily intended to clean up iomap iter state tracking, but it
also happened to remove the iov_iter revert and thus accidentally
fix this problem as well. Without the revert, iomap will commit
partial progress internally and loop once more before it more than
likely hits -EAGAIN and returns partial progress consistent with the
inode updates. This means the blocking retry from io_uring will pick
up where the first attempt left off at the current i_size and
perform the remainder of the write correctly.

Cc: <stable@vger.kernel.org>
Fixes: 18e419f6e80a ("iomap: Return -EAGAIN from iomap_write_iter()")
Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
Reported-by: Eric Hagberg <ehagberg@janestreet.com>
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

This relates to the discussion here[1]. Refer to the link for further
details and the custom reproducer. Since this is a stable-only patch,
I'd like to see at least one ack if possible from an iomap developer.

Note that this patch introduces an extra iomap iteration in the write
iter path before an -EAGAIN will return, but I went this route because
this is current upstream behavior and I didn't want to introduce novel
behavior in -stable, as trivial as it might be. This was initially
developed as a custom/selective backport of 1a1a3b574b97, but as it
turns out this is also effectively a revert of commit 18e419f6e80a. So
FWIW, this is somewhat historical behavior as well.

I plan to float a patch upstream to fix that loop wart soon. That would
seem overkill to fix in stable to me, but if it does prove necessary we
can revisit something like the custom version posted in [1] as a
stable-worthy variant. I'd just prefer to only do that if/after that
change proves acceptable upstream.

Finally, note that I'm not intimately familiar with -stable process so
I'm just sending a 6.12.y version here. Earlier branches can either also
include this, revert 18e419f6e80a directly, or I can post targeted
patches if needed. Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-fsdevel/CAFN_u7FrgM4Dzie2jjkLwWV8P0dvUG_Wwy3Q9B3-2HnnWiDu8w@mail.gmail.com/

 fs/iomap/buffered-io.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0178292c1864..5f885286b2f4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1037,10 +1037,6 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		}
 	} while (iov_iter_count(i) && length);
 
-	if (status == -EAGAIN) {
-		iov_iter_revert(i, total_written);
-		return -EAGAIN;
-	}
 	return total_written ? total_written : status;
 }
 
-- 
2.54.0


