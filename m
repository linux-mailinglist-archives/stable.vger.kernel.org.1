Return-Path: <stable+bounces-221493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KmAEpylo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:34:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD681CDAD3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12255317B4FE
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC92848AA;
	Sun,  1 Mar 2026 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Wlf+vS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA081F9F70;
	Sun,  1 Mar 2026 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328402; cv=none; b=AMeCXmbIOYnfe7ehQvMFjY2IhKrB8WdZko6nwQrJG6jL18JobRjcr9+ftEbHeh2sgRC7T6WXfAt0n101GW7oTtLenwADG9LkpfW0THzMEvCIk751d5VMW9J/kZT8ALpDN/ugJ//K4EgOTvo+oZN8EVi6iD0HvR8BuyQfyliEf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328402; c=relaxed/simple;
	bh=GDEn7hbfNX5yUE4a9iR1TnibA5IQ8pomPNgb6nU6m8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjWa7M03Ak0AfsEpRkoqRoKB757yM88CIlL7kGF5sJ3NhDJm/VmUSXeIPBB3uA3zmZZdePDZgli6ds8eAsS0DQ+OZVLO5G8/Rc5UpFx82ot6oxHjrfJGPk8g+5bqSvdQtoGQBgksNKRw5p+IBW+SN2sDIAOeaEsuJZRVnBUAtSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Wlf+vS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DC4C19421;
	Sun,  1 Mar 2026 01:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328402;
	bh=GDEn7hbfNX5yUE4a9iR1TnibA5IQ8pomPNgb6nU6m8U=;
	h=From:To:Cc:Subject:Date:From;
	b=c+Wlf+vSrA+TCkki1aFksv3gGy30O97Rd+qJNFJJUpfJjq1R0OXRTEj0Sa+Ywwxgr
	 Q0gFAC7EFeACGXdAKCiQrGBPksGAtUpTfLEjr9Mj6KlG7lr1Y3zjLPvhWWMxjrgy+r
	 Ts/pvnxmkKrWobhtFI/N0d6+j9UwCYOHvvqce7sQ7Cb91ItHD3xVX9FbZNq0szKIiC
	 ovkRCsnMWrGN5ljuZ17REqkjhfuU7oySULHbz5n9w/h8/8i2bmOpdAVxI7QqgcPyOX
	 IB9s4crRLGtY7eI8a1TgkwTcU8GjDDrpYBEHN1WPIWJOqHSyiyqpUKC3zLmdOXFv2P
	 kNo3U75rKsOVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	metze@samba.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Steve French <stfrench@microsoft.com>
Subject: FAILED: Patch "smb: server: let send_done handle a completion without IB_SEND_SIGNALED" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:39 -0500
Message-ID: <20260301012640.1684085-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221493-lists,stable=lfdr.de];
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
	NEURAL_SPAM(0.00)[0.335];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,talpey.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAD681CDAD3
X-Rspamd-Action: add header
X-Spam: Yes

The patch below does not apply to the 6.12-stable tree.
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





