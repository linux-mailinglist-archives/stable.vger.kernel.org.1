Return-Path: <stable+bounces-19488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05542851EFF
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 21:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF07F283BBF
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 20:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2B4A9BF;
	Mon, 12 Feb 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCTwhuFI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF5481B4
	for <stable@vger.kernel.org>; Mon, 12 Feb 2024 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771527; cv=none; b=ROPRsTxcJFoWrC8c7IJq8/Bg3ftrasmKiQNXqcIx3I653MOiSYpKVjaOhCfejBGziokZVjM9gsG0aN+aa5QNOmNCzkLRGLqvXrkgFv204jG2GyZ3BCAy1TnmngyIqlcEu+z/GXnMkI6NYmOFJbaD3pR32Ahgv3kAby+WauF7d9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771527; c=relaxed/simple;
	bh=9aZrduLHPhwchB6kNHNikaEVFm/ONCC/mCvRhMW/vaM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cqYwSXPtccttGbh6cQ0KKk6F42LSKerfJzS5BTi/7XGPOIvWwMO+PoA4HUaIhSCLcrcTrcCCtkhQ9E1nLIYqtBbtuUqc4acFkWoOHhzqjB8yMzfBAjDKY/cAeB+7hwQaQtDx/Vh16gQpP9B/fkSms5vauerQ7mZzk1J+DM4AW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCTwhuFI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60492d6bfc0so47742717b3.2
        for <stable@vger.kernel.org>; Mon, 12 Feb 2024 12:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707771524; x=1708376324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mo8jVM974dvJUVpMsMP++m6OpTvmquf2DlZQ0DJKRH4=;
        b=CCTwhuFIsRZC2cnien2xm5/4SJvG0/5cgpUgMw3bs6Ga+9uwLKxNEr7RsUUYnCYsRU
         opj9c7pYZLEqQIqhFj9WhFnh0DogrVbaN4eeIYC+MaXyHPOtszcttvEdbuZeU737GCut
         ht6A+BqUQ1WggPLGHdldlh29BKdtlY6yo//NdLtT9U+d3uWtLm9R3+6LLabfOPmmh00b
         gzzFY2YdZHVTPVniJkTn3jckqib3tecbqrbao6uSuYHGONQhHdF7DoxXcEs+un1RaVRe
         BYdR3JnOqg/l6OI9q9e01zvwzEjxamta4Lw1lfdiOq3S/5ZgpDabz6inqrHyGH3XXhMv
         f39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707771524; x=1708376324;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mo8jVM974dvJUVpMsMP++m6OpTvmquf2DlZQ0DJKRH4=;
        b=cKOPjGlEY/W4a/dIbCxTeLo+U4UoxaSgMpXrVIdLATUJe5BYzwD5MJ/dedcKitKLNC
         HOFeN4ltgR/MH0OV7FpmF1LjlI+WVIlKxxUr9VJkKLILsOO7GCAe8Roy7c9tCJYXHH9v
         B2SUOlSMCEezLgtpekpTV1nDEyb62aL1tplQv7DttRf8sfmpVNVDzE6raT9/SNFt9S+o
         /8c8BF5zAtUxD7g79oepZVlzYyVtu7GLP0ciyRjuVjC/cU+8LJ+1MJIwSqsIHjjKCzyb
         /9ifA/maJpRmj91BjRpIqj7TOTv0LgNjrdeW9Y8ULurt6OCoscW9NDZqN6FCsMGaRP/S
         JWEA==
X-Gm-Message-State: AOJu0Yyk4QA5QwTA1/IPyCpt3a4ilxg/lR0VqPAsiAwM/975jqoLe3vo
	rfK86Lz12n8hARujGDYf+p3XrqoZQ3GqyctMbIMB65uzzrMDc1gvukEIaRPv6DWtxv1GdgNpti5
	vgX0gCEaYJaD4Gf4oAmN3xgYGL82Fzd6ouzegs5KhQsDKk8PxTxvB71fpns4kSqwMHft6Vvmu3+
	wkvtkOu6fMz6gunzUJAg4gLhn3Wmg=
X-Google-Smtp-Source: AGHT+IGv9SSyAG+JAstgAumoC+5OAlTg6d+vtOJFhsUsLSYLhQ55GHS1u1+jpnI9RFn7y1sqqoE93Ehxqw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a0d:d787:0:b0:5ff:a885:65b with SMTP id
 z129-20020a0dd787000000b005ffa885065bmr1419122ywd.10.1707771524567; Mon, 12
 Feb 2024 12:58:44 -0800 (PST)
Date: Mon, 12 Feb 2024 14:58:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212205824.1015380-2-jrife@google.com>
Subject: [PATCH 6.1.y] fs: dlm: don't put dlm_local_addrs on heap
From: Jordan Rife <jrife@google.com>
To: stable@vger.kernel.org
Cc: ccaulfie@redhat.com, teigland@redhat.com, sashal@kernel.org, 
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com, 
	carnil@debian.org, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexander Aring <aahringo@redhat.com>

commit c51c9cd8addcfbdc097dbefd59f022402183644b upstream

This patch removes to allocate the dlm_local_addr[] pointers on the
heap. Instead we directly store the type of "struct sockaddr_storage".
This removes function deinit_local() because it was freeing memory only.

Backport e11dea8 ("dlm: use kernel_connect() and kernel_bind()") to
Linux stable 6.1 caused a regression. The original patch expected
dlm_local_addrs[0] to be of type sockaddr_storage, because c51c9cd ("fs:
dlm: don't put dlm_local_addrs on heap") changed its type from
sockaddr_storage* to sockaddr_storage in Linux 6.5+ while in older Linux
versions this is still the original sockaddr_storage*.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Jordan Rife <jrife@google.com>
Tested-by: Valentin Kleibel <valentin@vrvis.at>
Fixes: e11dea8f5033 ("dlm: use kernel_connect() and kernel_bind()")
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1063338
Link: https://lore.kernel.org/stable/20240209162658.70763-2-jrife@google.com/T/#u
Cc: <stable@vger.kernel.org> # 6.1.x
---
 fs/dlm/lowcomms.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 72f34f96d0155..e26af8c23aa80 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -174,7 +174,7 @@ static LIST_HEAD(dlm_node_addrs);
 static DEFINE_SPINLOCK(dlm_node_addrs_spin);
 
 static struct listen_connection listen_con;
-static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
+static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
 static int dlm_local_count;
 int dlm_allow_conn;
 
@@ -398,7 +398,7 @@ static int nodeid_to_addr(int nodeid, struct sockaddr_storage *sas_out,
 	if (!sa_out)
 		return 0;
 
-	if (dlm_local_addr[0]->ss_family == AF_INET) {
+	if (dlm_local_addr[0].ss_family == AF_INET) {
 		struct sockaddr_in *in4  = (struct sockaddr_in *) &sas;
 		struct sockaddr_in *ret4 = (struct sockaddr_in *) sa_out;
 		ret4->sin_addr.s_addr = in4->sin_addr.s_addr;
@@ -727,7 +727,7 @@ static void add_sock(struct socket *sock, struct connection *con)
 static void make_sockaddr(struct sockaddr_storage *saddr, uint16_t port,
 			  int *addr_len)
 {
-	saddr->ss_family =  dlm_local_addr[0]->ss_family;
+	saddr->ss_family =  dlm_local_addr[0].ss_family;
 	if (saddr->ss_family == AF_INET) {
 		struct sockaddr_in *in4_addr = (struct sockaddr_in *)saddr;
 		in4_addr->sin_port = cpu_to_be16(port);
@@ -1167,7 +1167,7 @@ static int sctp_bind_addrs(struct socket *sock, uint16_t port)
 	int i, addr_len, result = 0;
 
 	for (i = 0; i < dlm_local_count; i++) {
-		memcpy(&localaddr, dlm_local_addr[i], sizeof(localaddr));
+		memcpy(&localaddr, &dlm_local_addr[i], sizeof(localaddr));
 		make_sockaddr(&localaddr, port, &addr_len);
 
 		if (!i)
@@ -1187,7 +1187,7 @@ static int sctp_bind_addrs(struct socket *sock, uint16_t port)
 /* Get local addresses */
 static void init_local(void)
 {
-	struct sockaddr_storage sas, *addr;
+	struct sockaddr_storage sas;
 	int i;
 
 	dlm_local_count = 0;
@@ -1195,21 +1195,10 @@ static void init_local(void)
 		if (dlm_our_addr(&sas, i))
 			break;
 
-		addr = kmemdup(&sas, sizeof(*addr), GFP_NOFS);
-		if (!addr)
-			break;
-		dlm_local_addr[dlm_local_count++] = addr;
+		memcpy(&dlm_local_addr[dlm_local_count++], &sas, sizeof(sas));
 	}
 }
 
-static void deinit_local(void)
-{
-	int i;
-
-	for (i = 0; i < dlm_local_count; i++)
-		kfree(dlm_local_addr[i]);
-}
-
 static struct writequeue_entry *new_writequeue_entry(struct connection *con)
 {
 	struct writequeue_entry *entry;
@@ -1575,7 +1564,7 @@ static void dlm_connect(struct connection *con)
 	}
 
 	/* Create a socket to communicate with */
-	result = sock_create_kern(&init_net, dlm_local_addr[0]->ss_family,
+	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
 				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
 	if (result < 0)
 		goto socket_err;
@@ -1786,7 +1775,6 @@ void dlm_lowcomms_stop(void)
 	foreach_conn(free_conn);
 	srcu_read_unlock(&connections_srcu, idx);
 	work_stop();
-	deinit_local();
 
 	dlm_proto_ops = NULL;
 }
@@ -1803,7 +1791,7 @@ static int dlm_listen_for_all(void)
 	if (result < 0)
 		return result;
 
-	result = sock_create_kern(&init_net, dlm_local_addr[0]->ss_family,
+	result = sock_create_kern(&init_net, dlm_local_addr[0].ss_family,
 				  SOCK_STREAM, dlm_proto_ops->proto, &sock);
 	if (result < 0) {
 		log_print("Can't create comms socket: %d", result);
@@ -1842,7 +1830,7 @@ static int dlm_tcp_bind(struct socket *sock)
 	/* Bind to our cluster-known address connecting to avoid
 	 * routing problems.
 	 */
-	memcpy(&src_addr, dlm_local_addr[0], sizeof(src_addr));
+	memcpy(&src_addr, &dlm_local_addr[0], sizeof(src_addr));
 	make_sockaddr(&src_addr, 0, &addr_len);
 
 	result = kernel_bind(sock, (struct sockaddr *)&src_addr,
@@ -1899,7 +1887,7 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 	int addr_len;
 
 	/* Bind to our port */
-	make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
+	make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
 	return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
 			   addr_len);
 }
@@ -1992,7 +1980,7 @@ int dlm_lowcomms_start(void)
 
 	error = work_start();
 	if (error)
-		goto fail_local;
+		goto fail;
 
 	dlm_allow_conn = 1;
 
@@ -2022,8 +2010,6 @@ int dlm_lowcomms_start(void)
 fail_proto_ops:
 	dlm_allow_conn = 0;
 	work_stop();
-fail_local:
-	deinit_local();
 fail:
 	return error;
 }
-- 
2.43.0.687.g38aa6559b0-goog


