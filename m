Return-Path: <stable+bounces-249969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMONAo3NDWrh3QUAu9opvQ
	(envelope-from <stable+bounces-249969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA6590741
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D222C3020AAC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1863E95B3;
	Wed, 20 May 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAnmm6ND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A623D9DA4
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288087; cv=none; b=Z38fz9sgEM+haaH/GwrTuEMfgHhycv+DZ2UWP7KsGif3ydL7ifANEB8IEUZ9K0Ms8BPEZ1gfBxoscWAL49JZ8KZJAebe2totSdN8QR+wJwVQMR9rWWFE/wiKSHntxSIS/4eAPYtCXHhiDPdvOHyfvJC7dKvlj9cuJh6kHrw0xP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288087; c=relaxed/simple;
	bh=DSknGwmYznsPB1tbNpeRNTHbO4yoaueY4dtxkQdt4/Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e4RbNeZ921pPOM98/Qil+6dv5eFexi8Af2hvI9JdlOf2aO6KkNa0s2A4iMLilq6EO8LJFG3y/gdb3QuWDamjDIkT8QC9QWA1S9Qudqu9XWyr78oMCCQg+vSg27+wqcv2KlzxpPoztUe89DMTq2ou4Dz4b9O6OuuyEYvZi54Q8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAnmm6ND; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA2B1F000E9;
	Wed, 20 May 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288086;
	bh=StxoljcKAhorWp/VTyClKTJq4WTYSm93YLZ8PoJmz/U=;
	h=Subject:To:Cc:From:Date;
	b=OAnmm6NDnNT5K1gYwmcWnEaizGziSkFYlv/eBtWFP96dBgs+Ptk3CykUMgTDMPUy6
	 PRr6VzIXvKBLi0+7FjXWulMIzD6bbJsU5xejp0QTxbFkT84pEalnKlBeLUqnmb8FvJ
	 dEvwBQ6HZfBWsBSLsxlGL6M3e9x1WwsVOdE2ku9g=
Subject: FAILED: patch "[PATCH] fuse: fix writeback array overflow when max_pages is one" failed to apply to 6.18-stable tree
To: qjx1298677004@gmail.com,brauner@kernel.org,joannelkoong@gmail.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:41:21 +0200
Message-ID: <2026052021-bless-hazy-b0ae@gregkh>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249969-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: 46DA6590741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c3880a7b10e487e033dc6f388bda118436566f7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052021-bless-hazy-b0ae@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

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
 


