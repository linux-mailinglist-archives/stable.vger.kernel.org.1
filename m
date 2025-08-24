Return-Path: <stable+bounces-172711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B2B32E9B
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7193817D9AE
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C377258CDA;
	Sun, 24 Aug 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D1FlSExD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0720322
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026478; cv=none; b=NJA88Pby6vAxqNwPddLxMVmBuG1kEoPOD8s32GxGG5lEawYJ/TT6HBA41VQag3omueICGiSAm4bGJqDVmELisG9vmA68cnEmxbtNxeMYkVbK4M3Y+TDqIpYiGvW+a5Xl2FJ2x+PBjjBu8DnymKRF5qbjjDDhfJ1sK3n8Hein8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026478; c=relaxed/simple;
	bh=mPE92K+GH3GPRbFos/oaR0i4QPQXZ3X1d3m1fOTf1J4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LiTps/CQ08xrFxCmg5NwJaHULXAI33WFgcxUn/gZv4HADKcHeX+qtbh5mXUp2zWyRgysCm7MfxuIkPFoUfe96yUKvW7EfD0ZO2NjPQ9Ag8AAnayLJpnBhq7lFsO4YTx7YxNH9mAsT8Jn5AADFZcQcn+MpI+5esuj2mnaNhnsG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D1FlSExD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2F0C4CEEB;
	Sun, 24 Aug 2025 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756026477;
	bh=mPE92K+GH3GPRbFos/oaR0i4QPQXZ3X1d3m1fOTf1J4=;
	h=Subject:To:Cc:From:Date:From;
	b=D1FlSExDVD5wPcUT4+uVy9ANsSFmUkzmOPJ0uhlc+OWE78j62VsVcMN8uuzMvjyXk
	 vMxlBcf8qxENwINxuUl5vwaQ32cp6eojJDHrt836pB/MukFpgLq4R3W6FBXq/De6vL
	 aDbzXjHYKkjFe9npyN/CtBYXxO9y4tMhQjqK4xkk=
Subject: FAILED: patch "[PATCH] tls: fix handling of zero-length records on the rx_list" failed to apply to 5.4-stable tree
To: kuba@kernel.org,billy@starlabs.sg,ramdhan@starlabs.sg,sd@queasysnail.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 24 Aug 2025 11:07:44 +0200
Message-ID: <2025082444-reload-culinary-df2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 62708b9452f8eb77513115b17c4f8d1a22ebf843
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082444-reload-culinary-df2b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62708b9452f8eb77513115b17c4f8d1a22ebf843 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Aug 2025 19:19:51 -0700
Subject: [PATCH] tls: fix handling of zero-length records on the rx_list

Each recvmsg() call must process either
 - only contiguous DATA records (any number of them)
 - one non-DATA record

If the next record has different type than what has already been
processed we break out of the main processing loop. If the record
has already been decrypted (which may be the case for TLS 1.3 where
we don't know type until decryption) we queue the pending record
to the rx_list. Next recvmsg() will pick it up from there.

Queuing the skb to rx_list after zero-copy decrypt is not possible,
since in that case we decrypted directly to the user space buffer,
and we don't have an skb to queue (darg.skb points to the ciphertext
skb for access to metadata like length).

Only data records are allowed zero-copy, and we break the processing
loop after each non-data record. So we should never zero-copy and
then find out that the record type has changed. The corner case
we missed is when the initial record comes from rx_list, and it's
zero length.

Reported-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Reported-by: Billy Jheng Bing-Jhong <billy@starlabs.sg>
Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250820021952.143068-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 51c98a007dda..bac65d0d4e3e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1808,6 +1808,9 @@ int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
 	return tls_decrypt_sg(sk, NULL, sgout, &darg);
 }
 
+/* All records returned from a recvmsg() call must have the same type.
+ * 0 is not a valid content type. Use it as "no type reported, yet".
+ */
 static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 				   u8 *control)
 {
@@ -2051,8 +2054,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (err < 0)
 		goto end;
 
+	/* process_rx_list() will set @control if it processed any records */
 	copied = err;
-	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA) || rx_more)
+	if (len <= copied || rx_more ||
+	    (control && control != TLS_RECORD_TYPE_DATA))
 		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);


