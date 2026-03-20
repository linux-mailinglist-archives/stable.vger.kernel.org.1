Return-Path: <stable+bounces-227595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIhNIBCHvWnQ+gIAu9opvQ
	(envelope-from <stable+bounces-227595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:42:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA02DED72
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D8A130ADD65
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B94F3D1715;
	Fri, 20 Mar 2026 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U3tgnEDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1073CE4B6
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028057; cv=none; b=ASpvUn4204oE2/nhacWJr0Fo3ZkRXg69Sqlb1QFmLN26JdaxfrqMFf/YTwXVkDLfX0z2A1vAOQY3DZAKgexis/LeFmHEI+Ap5WhjPigZVm/ZVeOp8d0ciuJNJlSicZgyRL5p3+ACQMc0TR6KRN71hLBNgNR0eZLfeUfZn/ojYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028057; c=relaxed/simple;
	bh=v5Yw6AH2ykHWEZ+AX512lDNmY1k5gMtGURE1OE4abLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RjVFs+cO7z9V5ECWDsiO/x3vKPDXc89Dr44bS0iQvDe9QTqktfAeGBTpsBGEvLisqlzT+YKWemb+3FVguyhbNdOMHZGdTK7b3scQSnAWcA6aamA41iG1KfB4lpw+tDpKQBAhU/9VaJ+asgHl3rBqxHdpMT3iwl0yhxywH0AOybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U3tgnEDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CEAC4CEF7;
	Fri, 20 Mar 2026 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774028056;
	bh=v5Yw6AH2ykHWEZ+AX512lDNmY1k5gMtGURE1OE4abLY=;
	h=Subject:To:Cc:From:Date:From;
	b=U3tgnEDr8v4B+AgFU95D1QbMxDMNQb4Yd+9vtW6CWhMdA2lIyiXPiVB6GjOch/lGh
	 WMkDxAnXYVBkzGz+/ynL63Ms2XUpQ7d1g/cVXZPDRMZ9JqBZGiHRKZ38aNjmLAUxYf
	 ekdnUGQPS58lsIePeJG04dnzHE7mRCcoEoUDhNZs=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: fix missing BUF_MORE for incremental buffers" failed to apply to 6.12-stable tree
To: axboe@kernel.dk,code@mgjm.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 18:34:08 +0100
Message-ID: <2026032008-prologue-sarcastic-de41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227595-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.914];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,gregkh:email,linuxfoundation.org:dkim,mgjm.de:email]
X-Rspamd-Queue-Id: 00BA02DED72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3ecd3e03144b38a21a3b70254f1b9d2e16629b09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032008-prologue-sarcastic-de41@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ecd3e03144b38a21a3b70254f1b9d2e16629b09 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 19 Mar 2026 14:29:09 -0600
Subject: [PATCH] io_uring/kbuf: fix missing BUF_MORE for incremental buffers
 at EOF

For a zero length transfer, io_kbuf_inc_commit() is called with !len.
Since we never enter the while loop to consume the buffers,
io_kbuf_inc_commit() ends up returning true, consuming the buffer. But
if no data was consumed, by definition it cannot have consumed the
buffer. Return false for that case.

Reported-by: Martin Michaelis <code@mgjm.de>
Cc: stable@vger.kernel.org
Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
Link: https://github.com/axboe/liburing/issues/1553
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index e7f444953dfb..a4cb6752b7aa 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -34,6 +34,10 @@ struct io_provide_buf {
 
 static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
 {
+	/* No data consumed, return false early to avoid consuming the buffer */
+	if (!len)
+		return false;
+
 	while (len) {
 		struct io_uring_buf *buf;
 		u32 buf_len, this_len;


