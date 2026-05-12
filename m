Return-Path: <stable+bounces-245491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAxjMsEjA2oF1AEAu9opvQ
	(envelope-from <stable+bounces-245491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:57:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E4520874
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB4D2301DDAD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35133998AD;
	Tue, 12 May 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qRJO5qvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49B3AFAF2
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589921; cv=none; b=a3i6KWd6ATLzJlwJDNnOivSWieM+8tdy5HYSytdHQ+jI9y/f+pHVIsFUc8VI5ywVMXSaItvUb29ZB1rM8vXvus6GvlrrQ8C4BoiR1EjxeMmJrCGABRMUqDsgLo2GrksG1InSGlM3dM2XcdpreQOdcfGmcKowbp0pOqozH+ZIGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589921; c=relaxed/simple;
	bh=MOQxBEwNfC5m0yi5lnvUA/eVyMzXvgkCsHC0T0Yp5jc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UHB4knIQ2MTcpAg2SgWqU8MzayQTWJEWRuVZxVoUokPnYJkJgnU9AVEIO5/4XS7HttVXSJLftcYb1OUdvI9tyaJm5ZZeZ6Dlx0Z2plpF/f4SLzQ6u8zkxUjKhPLkMSkDGhlaSGS4Aqq+zW4+E9p0xTCY8i9JBalvbgrW0q6ONv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qRJO5qvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136ABC2BCB0;
	Tue, 12 May 2026 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778589921;
	bh=MOQxBEwNfC5m0yi5lnvUA/eVyMzXvgkCsHC0T0Yp5jc=;
	h=Subject:To:Cc:From:Date:From;
	b=qRJO5qvcB+kjNwJAjHJEd1Qdogc8tXbXy9B+TYcVFWKjPa9/BasNLGP64CNj7oEUk
	 GUqKIClDspCUzu9/yzaDw301u+qduj7pprrEv+u9BJmngND8xkpxXf2oLOzJTnZ1bk
	 mZJKWYorindlziDPQ1U6/kX1pHL9DcttUpky3T30=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: support min length left for incremental" failed to apply to 6.18-stable tree
To: code@mgjm.de,axboe@kernel.dk,krisman@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:41:32 +0200
Message-ID: <2026051232-kindred-spooky-37ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 421E4520874
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245491-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,suse.de:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7deba791ad495ce1d7921683f4f7d1190fa210d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051232-kindred-spooky-37ac@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7deba791ad495ce1d7921683f4f7d1190fa210d1 Mon Sep 17 00:00:00 2001
From: Martin Michaelis <code@mgjm.de>
Date: Thu, 23 Apr 2026 15:54:11 -0600
Subject: [PATCH] io_uring/kbuf: support min length left for incremental
 buffers

Incrementally consumed buffer rings are generally fully consumed, but
it's quite possible that the application has a minimum size it needs to
meet to avoid truncation. Currently that minimum limit is 1 byte, but
this should be a setting that is the hands of the application. For
recvmsg multishot, a prime use case for incrementally consumed buffers,
the application may get spurious -EFAULT returned at the end of an
incrementally consumed buffer, as less space is available than the
headers need.

Grab a u32 field in struct io_uring_buf_reg, which the application can
use to inform the kernel of the minimum size that should be available
in an incrementally consumed buffer. If less than that is available,
the current buffer is fully processed and the next one will be picked.

Cc: stable@vger.kernel.org
Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
Link: https://github.com/axboe/liburing/issues/1433
Signed-off-by: Martin Michaelis <code@mgjm.de>
[axboe: write commit message, change io_buffer_list member name]
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 17ac1b785440..909fb7aea638 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -905,7 +905,8 @@ struct io_uring_buf_reg {
 	__u32	ring_entries;
 	__u16	bgid;
 	__u16	flags;
-	__u64	resv[3];
+	__u32	min_left;
+	__u32	resv[5];
 };
 
 /* argument for IORING_REGISTER_PBUF_STATUS */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 43e4f8615fe8..63061aa1cab9 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -47,7 +47,7 @@ static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
 		this_len = min_t(u32, len, buf_len);
 		buf_len -= this_len;
 		/* Stop looping for invalid buffer length of 0 */
-		if (buf_len || !this_len) {
+		if (buf_len > bl->min_left_sub_one || !this_len) {
 			WRITE_ONCE(buf->addr, READ_ONCE(buf->addr) + this_len);
 			WRITE_ONCE(buf->len, buf_len);
 			return false;
@@ -637,6 +637,10 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	if (reg.ring_entries >= 65536)
 		return -EINVAL;
 
+	/* minimum left byte count is a property of incremental buffers */
+	if (!(reg.flags & IOU_PBUF_RING_INC) && reg.min_left)
+		return -EINVAL;
+
 	bl = io_buffer_get_list(ctx, reg.bgid);
 	if (bl) {
 		/* if mapped buffer ring OR classic exists, don't allow */
@@ -683,6 +687,8 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	bl->mask = reg.ring_entries - 1;
 	bl->flags |= IOBL_BUF_RING;
 	bl->buf_ring = br;
+	if (reg.min_left)
+		bl->min_left_sub_one = reg.min_left - 1;
 	if (reg.flags & IOU_PBUF_RING_INC)
 		bl->flags |= IOBL_INC;
 	ret = io_buffer_add_list(ctx, bl, reg.bgid);
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index abf7052b556e..401773e1ef80 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -32,6 +32,13 @@ struct io_buffer_list {
 
 	__u16 flags;
 
+	/*
+	 * minimum required amount to be left to reuse an incrementally
+	 * consumed buffer. If less than this is left at consumption time,
+	 * buffer is done and head is incremented to the next buffer.
+	 */
+	__u32 min_left_sub_one;
+
 	struct io_mapped_region region;
 };
 


