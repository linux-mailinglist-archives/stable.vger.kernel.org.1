Return-Path: <stable+bounces-264607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J3xFMqB6MWqXkQUAu9opvQ
	(envelope-from <stable+bounces-264607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:32:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E06922E6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:32:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hwTFF+ZM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264607-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264607-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD2F31D97B9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ECB466B65;
	Tue, 16 Jun 2026 16:19:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E643E4BA;
	Tue, 16 Jun 2026 16:19:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626795; cv=none; b=N3ZxTugxwFaK/Y74/E2bR8r2VzPN2r6URqYKFCxWxWNUfyORJEJZ4sZFdBYHnWgmqM/lfjRa4sDwEzU+E0WcDxot+f3ErUgzxanf+q5IDGrySYg9tu0fjpyRocDdEx8YklonIflv6oCCbmH3yQcuH9dKPeSoT0MaxBxNhR1uXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626795; c=relaxed/simple;
	bh=EMzmFwlEatsdNQtHPju00w5+P6zD6Fk67w+JefGG2zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AylYycw9enJ7b1TZvRLMgGsNLff1UCa+UE61KB/bhVcC52ETCaslnlvKQJeW1RpTBj0jmnOUTjJ5oftw4qob93iiI0WHAqTo9gQ3nU7NMr8F0/DzX5Qncp57wwBFmc1BZ2XcAjx/DqwSlv2K3x6Ym9aByA9Ek1OWFA+y0n9dGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwTFF+ZM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBDC1F000E9;
	Tue, 16 Jun 2026 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626794;
	bh=w1UwNAnHfdAMGvcsRnIQ4Z6CjaMzFota2oDKU2RtXPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwTFF+ZMZk4ZNaTcrGBo7zd5EyUkKxplg//DOacfW4z8bv06npLALQliEw36qCUu+
	 Qwc/0XyBcRxdvOybus7lJboEUEQrKC1pktIfo2cBiQj1ImVfXHhmGxou53Ea0NzOV1
	 eyd7seCqYQCSpS7hs9Qut91BYo1uNTf/Woz4Y9sc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Brian Foster <bfoster@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 072/261] iomap: dont revert iov_iter on partially completed buffered writes
Date: Tue, 16 Jun 2026 20:28:30 +0530
Message-ID: <20260616145048.451227868@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264607-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:gleventhal@janestreet.com,m:ehagberg@janestreet.com,m:bfoster@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D5E06922E6

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Foster <bfoster@redhat.com>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0178292c186485..5f885286b2f4a0 100644
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
2.53.0




