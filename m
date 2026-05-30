Return-Path: <stable+bounces-258577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM2oOSspG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF361157D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70D7B307CDB9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723752F90E0;
	Sat, 30 May 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u4Qe7j8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B301175A6B;
	Sat, 30 May 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164815; cv=none; b=uoH9AvtOGr7I9jFwOB0pl+PPFbSXYHwYcBSmTWjLJj6/lzaB7DihvWRhU8emhNUwWzuUgIwyc/hulUgajIgW60V6xn3dciPJ/4zjngMqbu9cCOg54CVN1dGtqCEUqgMg3Xi+wlzh+5AnAdVtd7q6GbjMm5KrxoLEFCs9lt474XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164815; c=relaxed/simple;
	bh=uUJR8hj0N+Gvko0qh02/XRa8oy4L1IEP78AAfNDH+VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWV2hfYgDWzKu+mdeNu2cJpGGHg8PScKQPfzaFwkFMzlRLtKSiLr33XJ/6Yg6xg6BAYqKAz54C4kAKUx0B0QIQ4i7o8E+ryVdg+9EvyFAKTeSGTfEuy7AwFLfJiVzYPnjRYZRncvXBp0atICzJ9MkQGu73id9La/YqR6QF7bfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4Qe7j8L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDB41F00893;
	Sat, 30 May 2026 18:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164814;
	bh=Q/jpLRUq0Kkxfxqkezf6oq9qgt87FlCGhfWJDoPR6WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u4Qe7j8Lr/cUPmSQadVvsb8ow5zz5+l6oNZNTuQFnSkULqFnzMyM7/t+8ZDDiTXCU
	 +I3Gj8Cy1+xQ/epEuFu/p6cMfRCrvwX+pZkfy3z81xEAgmKE0S+Qw1HRW6MqE8Wtwq
	 u98n3OJuNxh9pNGBwwlmAf/u6+5cxBn539J4YQaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Allison Henderson <achender@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 668/776] net/rds: reset op_nents when zerocopy page pin fails
Date: Sat, 30 May 2026 18:06:22 +0200
Message-ID: <20260530160257.145683446@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258577-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68AF361157D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Allison Henderson <achender@kernel.org>

commit e174929793195e0cd6a4adb0cad731b39f9019b4 upstream.

When iov_iter_get_pages2() fails in rds_message_zcopy_from_user(),
the pinned pages are released with put_page(), and
rm->data.op_mmp_znotifier is cleared.  But we fail to properly
clear rm->data.op_nents.

Later when rds_message_purge() is called from rds_sendmsg() the
cleanup loop iterates over the incorrectly non zero number of
op_nents and frees them again.

Fix this by properly resetting op_nents when it should be in
rds_message_zcopy_from_user().

Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
Signed-off-by: Allison Henderson <achender@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260505234336.2132721-1-achender@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/message.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -409,6 +409,7 @@ static int rds_message_zcopy_from_user(s
 
 			for (i = 0; i < rm->data.op_nents; i++)
 				put_page(sg_page(&rm->data.op_sg[i]));
+			rm->data.op_nents = 0;
 			mmp = &rm->data.op_mmp_znotifier->z_mmp;
 			mm_unaccount_pinned_pages(mmp);
 			ret = -EFAULT;



