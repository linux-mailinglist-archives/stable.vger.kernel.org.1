Return-Path: <stable+bounces-172709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE8DB32E98
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 11:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EB4445328
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D724DCE3;
	Sun, 24 Aug 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wc9pI0K8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1754EB38
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026475; cv=none; b=r9go+67FZZAsuFCfPKmCuCoaBTUGkYu+ji3c3G6HqnE+Wf+KoDbL1pBPh/0Iu3obP68RPK7qPcBOvJ8xWEsf7JV9tFllR3OrML2cX3Vr5jBJzfsTw3eKqWrvFhNsHKqZub8kKzc7IGDBwk2dHBbKhSriHJs5HiGF9b0focf1WPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026475; c=relaxed/simple;
	bh=PGud2EkITDPAFLZ1/2NhAsH8NTTqGP22a91j6RoQo1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f/hJRP31VT3TIiufw4yFKVTGbH3PYNb8Yq2cD+WQEWkVMmr5iLKQFm5L3BoRU+AuHLj9stll8XN+8f2RN5KXhUrAk6yfqq9MsGNVS1G168/VxQrnkpNk1ZOBMqUY7qp1zXZwaB4FSemfwO8dgsNdIeGcOTdWDoTWJfW6Gg3cYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wc9pI0K8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22005C116D0;
	Sun, 24 Aug 2025 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756026474;
	bh=PGud2EkITDPAFLZ1/2NhAsH8NTTqGP22a91j6RoQo1Y=;
	h=Subject:To:Cc:From:Date:From;
	b=Wc9pI0K8v80nMT9t7mnaYD3tIAAU/CYbvOPxeH9uM3Su/wYjyuXw8Uz3uTMqU4lJs
	 wGN3JmtvMyaaFDo8NNrIWTnjDy/WrupWw08/AkiwBtUWB7I4ZGkMBVi6Rw9nAgdTzA
	 JdMzQV14b/Cjo7Crb7O/056ZBdlfWJjmoVys8FHs=
Subject: FAILED: patch "[PATCH] tls: fix handling of zero-length records on the rx_list" failed to apply to 5.10-stable tree
To: kuba@kernel.org,billy@starlabs.sg,ramdhan@starlabs.sg,sd@queasysnail.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 24 Aug 2025 11:07:43 +0200
Message-ID: <2025082443-overplant-target-cc18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 62708b9452f8eb77513115b17c4f8d1a22ebf843
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082443-overplant-target-cc18@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


