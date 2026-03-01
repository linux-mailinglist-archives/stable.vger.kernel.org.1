Return-Path: <stable+bounces-221962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMpdHXybo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F851CBF9F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DE25302A9F6
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B72E8E09;
	Sun,  1 Mar 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0SIvYga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529722AE65;
	Sun,  1 Mar 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329565; cv=none; b=eWtw+OZgxpUVeVmjJ7oDjkZVLmieDS8CocH+dDQFga4wW2GM8MfC5j6M3zyAAC0fA0DJwpWfeVKCp5OG1TcWS/jZiwBXNwSnGKjBmHyLW4MXecIIkwqFc7k3RiCy7f5ORK/2LnO7iGYS2r/iJZdSMFgIe+2Xrsmz9UE39irdgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329565; c=relaxed/simple;
	bh=g1M78NHjtjFZsCMLehCmb7hmblwsQqfdt6ifC6acrpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9JcDv16/QE+VIW3oIpMDB/iS81nborhnRopjf0hV2RoBKJgC5K/8I2+i8XQAoRCIIX5RGijSe9zbORepET4nHy+ag2N3fmuxiN1wYZvsKiJMasTQIlyK4RJg/91D+c+IzdMXFdbZ4R1TQRvsVAzwfmjVqGLSMRenguku+UkjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0SIvYga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B10C19424;
	Sun,  1 Mar 2026 01:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329565;
	bh=g1M78NHjtjFZsCMLehCmb7hmblwsQqfdt6ifC6acrpc=;
	h=From:To:Cc:Subject:Date:From;
	b=J0SIvYgaiKz41mhvM4gM33tOy0cs7VkYpofGu+a4ovczpQB9jWdly/HiLq6SZCWxb
	 xDLe8F8ySdhcg91q/tWuGa1aelLZXsLLsYhdf3MeE6n8By6cZiaBzEH8G5++wmFirq
	 Wu409g/TANpXTO10Qq+prxEFaB9xLOB0XQd/cuZa66lEeWYfIji8DCxoiyvnWHe9Lh
	 jwh6fqJcsAzp0zWQpkISNJNQQ/akzEZhxbKHOA50qmIQosBFtwvrj7/rDNhYh1UvPL
	 zpX673IUia0zhippFgKLFvAyWBBoDXvvi7YqwKzr43Jy2EWJ5gG8ogXplP8yaQ5s/s
	 TcT8Ii9vBsaig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	metze@samba.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Steve French <stfrench@microsoft.com>
Subject: FAILED: Patch "smb: server: let send_done handle a completion without IB_SEND_SIGNALED" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:46:02 -0500
Message-ID: <20260301014603.1708893-1-sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,talpey.com,vger.kernel.org,lists.samba.org,microsoft.com];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-221962-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.456];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talpey.com:email,samba.org:email]
X-Rspamd-Queue-Id: 15F851CBF9F
X-Rspamd-Action: add header
X-Spam: Yes

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9da82dc73cb03e85d716a2609364572367a5ff47 Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Thu, 22 Jan 2026 18:16:47 +0100
Subject: [PATCH] smb: server: let send_done handle a completion without
 IB_SEND_SIGNALED

With smbdirect_send_batch processing we likely have requests without
IB_SEND_SIGNALED, which will be destroyed in the final request
that has IB_SEND_SIGNALED set.

If the connection is broken all requests are signaled
even without explicit IB_SEND_SIGNALED.

Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/transport_rdma.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 5c0cc5064e8c0..c94068b78a1d2 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1059,6 +1059,31 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 		    ib_wc_status_msg(wc->status), wc->status,
 		    wc->opcode);
 
+	if (unlikely(!(sendmsg->wr.send_flags & IB_SEND_SIGNALED))) {
+		/*
+		 * This happens when smbdirect_send_io is a sibling
+		 * before the final message, it is signaled on
+		 * error anyway, so we need to skip
+		 * smbdirect_connection_free_send_io here,
+		 * otherwise is will destroy the memory
+		 * of the siblings too, which will cause
+		 * use after free problems for the others
+		 * triggered from ib_drain_qp().
+		 */
+		if (wc->status != IB_WC_SUCCESS)
+			goto skip_free;
+
+		/*
+		 * This should not happen!
+		 * But we better just close the
+		 * connection...
+		 */
+		pr_err("unexpected send completion wc->status=%s (%d) wc->opcode=%d\n",
+		       ib_wc_status_msg(wc->status), wc->status, wc->opcode);
+		smb_direct_disconnect_rdma_connection(sc);
+		return;
+	}
+
 	/*
 	 * Free possible siblings and then the main send_io
 	 */
@@ -1072,6 +1097,7 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	lcredits += 1;
 
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
+skip_free:
 		pr_err("Send error. status='%s (%d)', opcode=%d\n",
 		       ib_wc_status_msg(wc->status), wc->status,
 		       wc->opcode);
-- 
2.51.0





