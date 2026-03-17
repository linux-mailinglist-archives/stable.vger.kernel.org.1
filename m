Return-Path: <stable+bounces-226693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EoWDtmMuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:18:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A442AF498
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E2A5304D1C0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933D2EF67A;
	Tue, 17 Mar 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/Ectbkj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E7225A38;
	Tue, 17 Mar 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767845; cv=none; b=WY+Mx2yK6p51qGjlRXgbFHin770Z+e4Ywfd9TbKpZ43sd0FFgGncDqjT3047uGqGTZOn3yBGEwUhbPyUXdKLwVi08/1Q0cOkEZLgcPrrBn5gk2J5t17UjzZPTPupdlNKLKh60ZhKofJVX+a3OKwqb6eiMFzBV2mZwK+T1MjmV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767845; c=relaxed/simple;
	bh=pUuM+usgE8KjqBx3xSArxwS54x1LcX6Hih8pIiKosMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjj50NlwxqRt8a6dc2U7DmVR4eiCYFznunQKZC+Lx25g80ADoRjVZq50dqYXGPFey9OtkE1om7OrM76DMKn5O7hRxr3QsOoe5cAOZvsjAghFLW0+hxSVUkhq6bpng2ty+Qw5/EiIuLGQb1jutZK4VQw5QPe/WeZxVkXSTsuzn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/Ectbkj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E2FC4CEF7;
	Tue, 17 Mar 2026 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767844;
	bh=pUuM+usgE8KjqBx3xSArxwS54x1LcX6Hih8pIiKosMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/EctbkjLO5WjumfdvTeGFYdkcyeOm4h7GRBVMrnihRcjqOg2DZS0ccwLMU3MXbAS
	 75MMoz29EJIswJfG7bFJcmSMWZFQ+bz3XIqf01gVKJGOz5XI62CNXkm4CHesPY4EAI
	 q4cKkE1A3iqzmFn7TSKkLR772s6T7bMGppd1UJO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH 6.18 169/333] libceph: admit message frames only in CEPH_CON_S_OPEN state
Date: Tue, 17 Mar 2026 17:33:18 +0100
Message-ID: <20260317163005.627270442@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226693-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,ibm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8A442AF498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit a5a373705081d7cc6363e16990e2361b0b362314 upstream.

Similar checks are performed for all control frames, but an early check
for message frames was missing.  process_message() is already set up to
terminate the loop in case the state changes while con->ops->dispatch()
handler is being executed.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger_v2.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2906,6 +2906,11 @@ static int __handle_control(struct ceph_
 	if (con->v2.in_desc.fd_tag != FRAME_TAG_MESSAGE)
 		return process_control(con, p, end);
 
+	if (con->state != CEPH_CON_S_OPEN) {
+		con->error_msg = "protocol error, unexpected message";
+		return -EINVAL;
+	}
+
 	ret = process_message_header(con, p, end);
 	if (ret < 0)
 		return ret;



