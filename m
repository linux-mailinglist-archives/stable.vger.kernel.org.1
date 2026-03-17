Return-Path: <stable+bounces-226406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCYxEoyKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C43AF2AF028
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E7633182D11
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DD33F23DD;
	Tue, 17 Mar 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HP+urtQE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A33C6612;
	Tue, 17 Mar 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766566; cv=none; b=ahjt3XwVTFBpWOR8zulF5WlUpVoxLQDP/Q8Od0pBiNIXSB1aN4Sa6PupiCfTdPW4lGw3kNehVds1aDXOfDp6ZYV24i8LiRybQWGpKktbhDWU1Vq9NFTPJVL0GwV68EcvfpjoOba6v7l9G4jdJTQTMVSeHVV6xgSseuY1dZJtwEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766566; c=relaxed/simple;
	bh=GMM9GrWT2Ij+jwhabLf+uQyeWOfxgjONmn3dYGd/G0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVfCPniT332Hc3kxS6EmT4BeIlPsXwvkAMziviocNWFeCSyUT65yU3rTh+5mIuiCSpjKWzddPQ/Ovoz3q1EQqKprzlbgbW+/QyqKPpUopQptbQXs//OQzZhl/t3Pr4SKpE0tohHxjiR0Qeva5H7vdA8OyAG0KAidT+5K1c6840A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HP+urtQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6D1C4CEF7;
	Tue, 17 Mar 2026 16:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766566;
	bh=GMM9GrWT2Ij+jwhabLf+uQyeWOfxgjONmn3dYGd/G0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HP+urtQEWOqAjxPfW5ravmZzNSi8d7ofwSY5x/jW1ochIVk96eFtyYOzYVoyy2icB
	 HdTQBGdrYkKeY7/H77n3uBjLz2SQeam0uOi0i9i0X7YIn+lKILyP/ImKSfPmW5+Zmu
	 ZzSwmVGP2+bgC53+mvmxtYoUnHI73s6yVGc7/Xpo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Gao <wegao@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.19 241/378] iomap: dont mark folio uptodate if read IO has bytes pending
Date: Tue, 17 Mar 2026 17:33:18 +0100
Message-ID: <20260317163015.882463050@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-226406-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,msgid.link:url]
X-Rspamd-Queue-Id: C43AF2AF028
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joanne Koong <joannelkoong@gmail.com>

commit debc1a492b2695d05973994fb0f796dbd9ceaae6 upstream.

If a folio has ifs metadata attached to it and the folio is partially
read in through an async IO helper with the rest of it then being read
in through post-EOF zeroing or as inline data, and the helper
successfully finishes the read first, then post-EOF zeroing / reading
inline will mark the folio as uptodate in iomap_set_range_uptodate().

This is a problem because when the read completion path later calls
iomap_read_end(), it will call folio_end_read(), which sets the uptodate
bit using XOR semantics. Calling folio_end_read() on a folio that was
already marked uptodate clears the uptodate bit.

Fix this by not marking the folio as uptodate if the read IO has bytes
pending. The folio uptodate state will be set in the read completion
path through iomap_end_read() -> folio_end_read().

Reported-by: Wei Gao <wegao@suse.com>
Suggested-by: Sasha Levin <sashal@kernel.org>
Tested-by: Wei Gao <wegao@suse.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Cc: stable@vger.kernel.org # v6.19
Link: https://lore.kernel.org/linux-fsdevel/aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org/
Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Link: https://patch.msgid.link/20260303233420.874231-2-joannelkoong@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/iomap/buffered-io.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -79,18 +79,27 @@ static void iomap_set_range_uptodate(str
 {
 	struct iomap_folio_state *ifs = folio->private;
 	unsigned long flags;
-	bool uptodate = true;
+	bool mark_uptodate = true;
 
 	if (folio_test_uptodate(folio))
 		return;
 
 	if (ifs) {
 		spin_lock_irqsave(&ifs->state_lock, flags);
-		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		/*
+		 * If a read with bytes pending is in progress, we must not call
+		 * folio_mark_uptodate(). The read completion path
+		 * (iomap_read_end()) will call folio_end_read(), which uses XOR
+		 * semantics to set the uptodate bit. If we set it here, the XOR
+		 * in folio_end_read() will clear it, leaving the folio not
+		 * uptodate.
+		 */
+		mark_uptodate = ifs_set_range_uptodate(folio, ifs, off, len) &&
+				!ifs->read_bytes_pending;
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (uptodate)
+	if (mark_uptodate)
 		folio_mark_uptodate(folio);
 }
 



