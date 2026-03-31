Return-Path: <stable+bounces-232486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK64MlMIzGlaNgYAu9opvQ
	(envelope-from <stable+bounces-232486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:45:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51736F47C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2807C30DF0A0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08630AD00;
	Tue, 31 Mar 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgL5zowl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4F22578D;
	Tue, 31 Mar 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976872; cv=none; b=Pq1RIi4Rmm8KtjUTnO4ZGfJbYj/I1fMzRIfGI/ln+GhpMZsAcvSrEzP1DyWBs/KMqoVuRvnT3cjtgDto3unRUIOMuCF3rOfIYuA24Buen5s7ukb/hFuDMt270oeiJaT0aIQT3dehjORE8Drlh5Bl57jnF+gOkaKOwQ9llC9aJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976872; c=relaxed/simple;
	bh=EOhfmEE5ERDycH/BjcYqIIo6FBoAVsdga014gpecpGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlssNM9TWZ8qpLCKO9hgcOk/6bXQAbyeF1REFBZqPKIGjjZ18QaH+5Ik9MLHxXxRYavOCGK78YM/34ieiwLiY97zrHhPNgcU2KRjvwaQXtK/a8+YNY5SFHsQE/eL9iA3h1e/DpR2yWiRgMDuzeG1Mt+zOjYxWXkMcwaxKxnOJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgL5zowl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABE3C19423;
	Tue, 31 Mar 2026 17:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976872;
	bh=EOhfmEE5ERDycH/BjcYqIIo6FBoAVsdga014gpecpGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgL5zowlmUw0oAghIWgrb2dwjzm3IelSiEtyQ5KmMyrp8j7MqQXOjwzFv0QdGBA9L
	 JAL6KPbY60U09op/KtlmhHoeE74q3yULxsXdzsAMxfJhXMNwRAi3PVDs5wbSI3TL80
	 Jo78L/+u3koQcS527Hmn9otWlKpInS89qIz7zpFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuto Ohnuki <ytohnuki@amazon.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.18 260/309] ext4: replace BUG_ON with proper error handling in ext4_read_inline_folio
Date: Tue, 31 Mar 2026 18:22:43 +0200
Message-ID: <20260331161803.138466380@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232486-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,iloc.bh:url]
X-Rspamd-Queue-Id: 3F51736F47C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuto Ohnuki <ytohnuki@amazon.com>

commit 356227096eb66e41b23caf7045e6304877322edf upstream.

Replace BUG_ON() with proper error handling when inline data size
exceeds PAGE_SIZE. This prevents kernel panic and allows the system to
continue running while properly reporting the filesystem corruption.

The error is logged via ext4_error_inode(), the buffer head is released
to prevent memory leak, and -EFSCORRUPTED is returned to indicate
filesystem corruption.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
Link: https://patch.msgid.link/20260223123345.14838-2-ytohnuki@amazon.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inline.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -522,7 +522,15 @@ static int ext4_read_inline_folio(struct
 		goto out;
 
 	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
-	BUG_ON(len > PAGE_SIZE);
+
+	if (len > PAGE_SIZE) {
+		ext4_error_inode(inode, __func__, __LINE__, 0,
+				 "inline size %zu exceeds PAGE_SIZE", len);
+		ret = -EFSCORRUPTED;
+		brelse(iloc.bh);
+		goto out;
+	}
+
 	kaddr = kmap_local_folio(folio, 0);
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
 	kaddr = folio_zero_tail(folio, len, kaddr + len);



