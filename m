Return-Path: <stable+bounces-222161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKAYL/Gdo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DFE1CC9FE
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D4FC31062CB
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055130C356;
	Sun,  1 Mar 2026 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3jlE7mq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139D1DF271;
	Sun,  1 Mar 2026 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330052; cv=none; b=hIKd+CUd2EWryBsEavxNT1x020kOGT1Y+USYZVqocsEp6gdNLVumZQjIUFlgdLPLvJG+7Z4a9YZcijfC/QmV6I8M/g4u7at7IT+ZX45crELM/Wb2sjWWuVvYHHnAjc7xLIoKlAcK8zZwDx1bheHtJ/yRo/6QIzE/pHwayTbXEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330052; c=relaxed/simple;
	bh=JTnHmj/PD4g00NFdG7rv5A+LgfhAacl+Z0Uw8r653hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNmJn02vZEcNQx0ZNwZ/2/xf1jzlEi31ydeO1JvKyZIjI8F7Iqlpyr9U92i7AOFBWZ8Gkh/crSCoTHqpDlhwA7y0iExb2QcAOEqkBf4b16H6V9YjONRuxmW3rH1nvCahPwFY0vQy90YfChdzqfve0BSJkqXtROG8ULkiKqWQYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3jlE7mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FE0C19421;
	Sun,  1 Mar 2026 01:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330052;
	bh=JTnHmj/PD4g00NFdG7rv5A+LgfhAacl+Z0Uw8r653hg=;
	h=From:To:Cc:Subject:Date:From;
	b=k3jlE7mqZyMFex2/m3IqRyjfvu4TT8LAajuhNoabART9uD1uw5YC7l0YyZBBGpiXq
	 dBGXrmeZv0WuCMCM9B/tMdv/sDi9WySqJDvBkkbJL9NH5FaHRn8XR1ffIUyo21DUlV
	 sSdWu9/T2qfIWWwdhGu4YyMye2PMuE70OMZcAhz5R7YlTY5QDCe6SYwJzW8Zwf27I4
	 veKRe4GiGKx4lvrK8/tPXY0K2Gf/5hfL0zYnrC5BN9TN34YEG5ONhF6M6cZVzy0Mff
	 fRskSnp8mNu4R5da2/fUWuLwnAiymH+voDK01De3ey3TVZgRMq9igFxV+u3NJbBsQ7
	 /pGdLBh3u6VRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	metze@samba.org
Cc: Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Steve French <stfrench@microsoft.com>
Subject: FAILED: Patch "smb: smbdirect: introduce smbdirect_socket.send_io.bcredits.*" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:54:09 -0500
Message-ID: <20260301015409.1721101-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-222161-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.411];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,samba.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50DFE1CC9FE
X-Rspamd-Action: add header
X-Spam: Yes

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8e94268b21c8235d430ce1aa6dc0b15952744b9b Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Thu, 22 Jan 2026 18:16:42 +0100
Subject: [PATCH] smb: smbdirect: introduce smbdirect_socket.send_io.bcredits.*

It turns out that our code will corrupt the stream of
reassabled data transfer messages when we trigger an
immendiate (empty) send.

In order to fix this we'll have a single 'batch' credit per
connection. And code getting that credit is free to use
as much messages until remaining_length reaches 0, then
the batch credit it given back and the next logical send can
happen.

Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/common/smbdirect/smbdirect_socket.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/smb/common/smbdirect/smbdirect_socket.h b/fs/smb/common/smbdirect/smbdirect_socket.h
index 403a8b2cd30e4..95265192bb01b 100644
--- a/fs/smb/common/smbdirect/smbdirect_socket.h
+++ b/fs/smb/common/smbdirect/smbdirect_socket.h
@@ -162,6 +162,17 @@ struct smbdirect_socket {
 			mempool_t		*pool;
 		} mem;
 
+		/*
+		 * This is a coordination for smbdirect_send_batch.
+		 *
+		 * There's only one possible credit, which means
+		 * only one instance is running at a time.
+		 */
+		struct {
+			atomic_t count;
+			wait_queue_head_t wait_queue;
+		} bcredits;
+
 		/*
 		 * The local credit state for ib_post_send()
 		 */
@@ -371,6 +382,9 @@ static __always_inline void smbdirect_socket_init(struct smbdirect_socket *sc)
 	INIT_DELAYED_WORK(&sc->idle.timer_work, __smbdirect_socket_disabled_work);
 	disable_delayed_work_sync(&sc->idle.timer_work);
 
+	atomic_set(&sc->send_io.bcredits.count, 0);
+	init_waitqueue_head(&sc->send_io.bcredits.wait_queue);
+
 	atomic_set(&sc->send_io.lcredits.count, 0);
 	init_waitqueue_head(&sc->send_io.lcredits.wait_queue);
 
@@ -485,6 +499,8 @@ struct smbdirect_send_batch {
 	 */
 	bool need_invalidate_rkey;
 	u32 remote_key;
+
+	int credit;
 };
 
 struct smbdirect_recv_io {
-- 
2.51.0





