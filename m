Return-Path: <stable+bounces-226337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFoQIvWIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:01:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E62AED01
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41724313D5C1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8993F23AA;
	Tue, 17 Mar 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fxfwcyS8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7F2E62B7;
	Tue, 17 Mar 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766267; cv=none; b=ug3iK0mamUVmoLjPEvADkSKSOSXFXqp4lbvApSWXVXd7xdAv04rWyxmsDgRcvfIBrLLCQeH3sA6nAY+/SbJKh7CWL98ELKvMUq32AXrBH+/oug5XzDZJZ2hSC6WkEo1+xU4+06SxGip3ARM3BI1oCT9hxu4Ar345l6Z55kKgOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766267; c=relaxed/simple;
	bh=+8nuGWxF8LWbb6dPpAEAwIv5AoC0WN5fLgUKRPDbiRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjtOCjUErQm6z69h1rZ0WVqK3Vk4WsCTexIv2jxcvqcl6OKXMXdMQq5/lso+mXpVBe/p+nUViWvegxVmtLK8e2COIdZmztTwGLasy6EAytJJCdcnUNEgtUHsWzo89R751RMQ3PKAnNKuTJdXLBcP7QA5GdoSk46gI20ZTpJoqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fxfwcyS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EB1C4CEF7;
	Tue, 17 Mar 2026 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766267;
	bh=+8nuGWxF8LWbb6dPpAEAwIv5AoC0WN5fLgUKRPDbiRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxfwcyS8OSBSX/IHDQtMzxvigHKiDWTgrYQlGuB+qTyFUdnn+NyqeYVMItEgAmX26
	 uqoy4VaYhSUIPCgu7JgzGaX6ikGZsw3Zxi2Li+M4TfD2tDzixwZYvou//6hsqh9VtO
	 v+SlWWwy7uKvU9Z+Ma6CMeWNiJYxDpZQBKNwRQ+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH 6.19 207/378] libceph: prevent potential out-of-bounds reads in process_message_header()
Date: Tue, 17 Mar 2026 17:32:44 +0100
Message-ID: <20260317163014.625514968@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tu-ilmenau.de,gmail.com,redhat.com,ibm.com];
	TAGGED_FROM(0.00)[bounces-226337-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tu-ilmenau.de:email]
X-Rspamd-Queue-Id: 870E62AED01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 69fb5d91bba44ecf7eb80530b85fa4fb028921d5 upstream.

If the message frame is (maliciously) corrupted in a way that the
length of the control segment ends up being less than the size of the
message header or a different frame is made to look like a message
frame, out-of-bounds reads may ensue in process_message_header().

Perform an explicit bounds check before decoding the message header.

Cc: stable@vger.kernel.org
Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger_v2.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2832,12 +2832,15 @@ static int process_message_header(struct
 				  void *p, void *end)
 {
 	struct ceph_frame_desc *desc = &con->v2.in_desc;
-	struct ceph_msg_header2 *hdr2 = p;
+	struct ceph_msg_header2 *hdr2;
 	struct ceph_msg_header hdr;
 	int skip;
 	int ret;
 	u64 seq;
 
+	ceph_decode_need(&p, end, sizeof(*hdr2), bad);
+	hdr2 = p;
+
 	/* verify seq# */
 	seq = le64_to_cpu(hdr2->seq);
 	if ((s64)seq - (s64)con->in_seq < 1) {
@@ -2868,6 +2871,10 @@ static int process_message_header(struct
 	WARN_ON(!con->in_msg);
 	WARN_ON(con->in_msg->con != con);
 	return 1;
+
+bad:
+	pr_err("failed to decode message header\n");
+	return -EINVAL;
 }
 
 static int process_message(struct ceph_connection *con)



