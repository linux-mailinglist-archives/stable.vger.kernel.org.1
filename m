Return-Path: <stable+bounces-249968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCCgErjIDWr93AUAu9opvQ
	(envelope-from <stable+bounces-249968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F958FE86
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEAAF300382A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70A3EA94E;
	Wed, 20 May 2026 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jrYlt2ss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E223392C
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288078; cv=none; b=krw5y+fC1lmtoEW5j03XGomDYIz0R7drd1QHt0q35h8N6AMDEaNOp2zjyg76dJY4XtpZ/bo/HrThXtfsvQzGT8C4TysAgBoTb+a/0jakX8RJwhlfv03orZ5hmSCAKCFd0ddIhM7S42P/RvGsWQ/jLKve7moJ36QtwApo1z4WH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288078; c=relaxed/simple;
	bh=yYkWKf3SToW66aR/q98Bd+j8WfjRvYPvkyRrPvfjZSc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=otugNu6Yim/WLJqF8xo7MfGVlhPxwQK+eTOFFQSbL90XgAVA8qm9vEkC9tNMI8wXh2iEEJtmTHQXuQyTGLslZN58n1njNi8VpJ6podI6a27a2AqYOrjCztWTYLSaSskgfXAP58SMOmaAXn7jfvadmrHf8bm/eFTfSbhmzrpO3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jrYlt2ss; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2BC1F000E9;
	Wed, 20 May 2026 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288077;
	bh=jIgC8a+sEsUDe34ccPkmZIuRMxnE7xFKH257gHm2G0c=;
	h=Subject:To:Cc:From:Date;
	b=jrYlt2ssqJUw6IQD+/tavh3vAm1VA20bskG2N67vV6VKkXutQxPa+1/CFJeMpPEfL
	 B+CJT6zIo8xJx20dEjP93tKlznM3wKgicRXepDkBK1dRsTEOXV/PZNJ6df2DDzuJNP
	 uIA5feBFHGmKJTQEyknWU1gXwuMdS6+7N+LtM5Q8=
Subject: FAILED: patch "[PATCH] fuse: fix writeback array overflow when max_pages is one" failed to apply to 7.0-stable tree
To: qjx1298677004@gmail.com,brauner@kernel.org,joannelkoong@gmail.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:41:20 +0200
Message-ID: <2026052020-doing-champion-3502@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249968-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:email]
X-Rspamd-Queue-Id: DC7F958FE86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x c3880a7b10e487e033dc6f388bda118436566f7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052020-doing-champion-3502@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c3880a7b10e487e033dc6f388bda118436566f7a Mon Sep 17 00:00:00 2001
From: Junxi Qian <qjx1298677004@gmail.com>
Date: Wed, 6 May 2026 20:24:15 +0800
Subject: [PATCH] fuse: fix writeback array overflow when max_pages is one

fuse_iomap_writeback_range() appends one folio pointer and one
fuse_folio_desc for every dirty range that is merged into the current
writeback request.  The merge decision checks the byte budget against
fc->max_pages and fc->max_write, but it does not check whether the folio
and descriptor arrays still have another free slot.

This is not sufficient for fuseblk, where the filesystem block size can
be smaller than PAGE_SIZE.  With writeback cache enabled and max_pages
negotiated as one, contiguous sub-page dirty ranges can fit within the
byte budget while spanning more than one folio.  The next append can then
write past the one-slot folios and descs arrays.

Split the request when the number of already attached folios has reached
fc->max_pages.  This keeps the folio/descriptor slot accounting in sync
with the send decision.

Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Link: https://patch.msgid.link/20260506122415.205340-1-qjx1298677004@gmail.com
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60b8d..f94f3dc082c6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2176,7 +2176,10 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
 
 	WARN_ON(!ap->num_folios);
 
-	/* Reached max pages */
+	/* Reached max pages or max folio slots */
+	if (ap->num_folios >= fc->max_pages)
+		return true;
+
 	if (DIV_ROUND_UP(bytes, PAGE_SIZE) > fc->max_pages)
 		return true;
 


