Return-Path: <stable+bounces-216039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGMdM070jmnDGAEAu9opvQ
	(envelope-from <stable+bounces-216039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:52:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E9F134B43
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82C56300B53F
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80C34F247;
	Fri, 13 Feb 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0ekavfP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8A34EF1E
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976330; cv=none; b=Q7LsMe0ZqZZVfK91oqv2TpYDaKSBdstJaKsPv7oO0sW3OMADJOF6HdTwp2TDjpSGXG43SjzFRjP+4A2oPHaON0fRlqf3YV36Q/rqIF+NMAlfKzMmT6ObwlVSIEkD3s1iu+HTjxiZVjtnzF++4gjrE/4uoG/Q59U5BTAEAcZFQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976330; c=relaxed/simple;
	bh=/KT7vW/QpVQd8kmz2RFIOXxCM34ny70kFm5PRTQkYbM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZBx9sn4E+Mro64ofGDruY9SjRVYxJDKCA9IqMesJqeainQEEYT/oBX3JTbhqePdXcw7JniMUUavt+zZBCX/ulV0OKw5hxXwvqKx86urugALGpNgv/qWT+mCatbSjKGIGFiSkEYq2GrcCpa45KlE/h9bYofAVwbsEXrG5Sq2uId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0ekavfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDADC116C6;
	Fri, 13 Feb 2026 09:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770976329;
	bh=/KT7vW/QpVQd8kmz2RFIOXxCM34ny70kFm5PRTQkYbM=;
	h=Subject:To:Cc:From:Date:From;
	b=k0ekavfPK9v1HEQGvcvcwYIjcU/HomoSDHvr8NiNpUVhRW+T5ORLFKrgWgoB9gHCk
	 c25kIyXonYtN7rP+6NSPxxQKQd1aPFhvHE+yQKLtHYGwkESkTQh/KmjqtgOg85Az8t
	 KLnXp5xPcqhkrhCgsBUP7mZvu2lIJGoIPDPMKVhw=
Subject: FAILED: patch "[PATCH] smb: server: fix leak of active_num_conn in" failed to apply to 5.15-stable tree
To: henrique.carvalho@suse.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Feb 2026 10:52:06 +0100
Message-ID: <2026021306-laurel-scariness-bfee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216039-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: F2E9F134B43
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 77ffbcac4e569566d0092d5f22627dfc0896b553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021306-laurel-scariness-bfee@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77ffbcac4e569566d0092d5f22627dfc0896b553 Mon Sep 17 00:00:00 2001
From: Henrique Carvalho <henrique.carvalho@suse.com>
Date: Wed, 4 Feb 2026 20:06:43 -0300
Subject: [PATCH] smb: server: fix leak of active_num_conn in
 ksmbd_tcp_new_connection()

On kthread_run() failure in ksmbd_tcp_new_connection(), the transport is
freed via free_transport(), which does not decrement active_num_conn,
leaking this counter.

Replace free_transport() with ksmbd_tcp_disconnect().

Fixes: 0d0d4680db22e ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 4bb07937d7ef..2436dabada95 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -40,6 +40,7 @@ static const struct ksmbd_transport_ops ksmbd_tcp_transport_ops;
 
 static void tcp_stop_kthread(struct task_struct *kthread);
 static struct interface *alloc_iface(char *ifname);
+static void ksmbd_tcp_disconnect(struct ksmbd_transport *t);
 
 #define KSMBD_TRANS(t)	(&(t)->transport)
 #define TCP_TRANS(t)	((struct tcp_transport *)container_of(t, \
@@ -202,7 +203,7 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	if (IS_ERR(handler)) {
 		pr_err("cannot start conn thread\n");
 		rc = PTR_ERR(handler);
-		free_transport(t);
+		ksmbd_tcp_disconnect(KSMBD_TRANS(t));
 	}
 	return rc;
 }


