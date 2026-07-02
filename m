Return-Path: <stable+bounces-270435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sKwjE/5iRmq+SQsAu9opvQ
	(envelope-from <stable+bounces-270435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:09:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395646F826E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:09:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=wcpegwwi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270435-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270435-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F753300443A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA50B481673;
	Thu,  2 Jul 2026 12:52:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45F47ECFB
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:52:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996722; cv=none; b=r2RWTB6UhZBurbqTMwQ8gc9LwrCNtwfakfBA8v3f0yUpFgrbOxWFm/H9KM7AlApi6N5p/hAEG2TkNMzIylgtcRlBXyokP62Gf1z+9oec8talE/xfk/6y6MTvBMmwjk1Ui3NVraIQEAx/UUN7xxfjhhUk+6Vy3SdQ6AfPOKZk6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996722; c=relaxed/simple;
	bh=lUUQi7zLZpwZMeMXNXzLQfFO/QBsODxvEfMpkhoXlUw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QjyA9HVLiJWXzX8AXN3A+XBg9Rg2Y+YR69ovUdixSHW+Fu3jFosDD5EnHog2OiwgRQeFbzHvwmDgXiWki4hTFOk/1Lc88amK5G/wIbYQIxybzlSJ3gy2wB2KgUIS3/waSArzkJ6aO5ynlYIRzPtv3GGc9QYi2o7kmCl3Ob3vIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wcpegwwi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22131F000E9;
	Thu,  2 Jul 2026 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782996721;
	bh=jpganlBFV8EhP3D8mEIfy6lJSb0uhpZ78QHSAci9teM=;
	h=Subject:To:Cc:From:Date;
	b=wcpegwwiJ4Dt0uhQNW3EJoeAfHAKTYczuRdGW3gyCi5423rVaU0N3NcNweakdDkyt
	 /6xGcc8M1pY71ADzPY+OOK4jpm8RrJt1stAzgEyeHtVJDmoo+JedwhmqZI6TlIuccD
	 bakjgy4EnhVnuRiPqH4gDH3jg3GYiIRqxZvW5PDo=
Subject: FAILED: patch "[PATCH] userfaultfd: ensure mremap_userfaultfd_fail() releases" failed to apply to 6.12-stable tree
To: rppt@kernel.org,akpm@linux-foundation.org,brauner@kernel.org,david@kernel.org,jack@suse.cz,peterx@redhat.com,stable@vger.kernel.org,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 14:52:11 +0200
Message-ID: <2026070211-nappy-catalyst-f7c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270435-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:akpm@linux-foundation.org,m:brauner@kernel.org,m:david@kernel.org,m:jack@suse.cz,m:peterx@redhat.com,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,gregkh:mid,linux.org.uk:email,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linux-foundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.cz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 395646F826E


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0496a59745b0723ea74274db16fd5c8b1379b9a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070211-nappy-catalyst-f7c9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0496a59745b0723ea74274db16fd5c8b1379b9a9 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 13 May 2026 11:14:16 +0300
Subject: [PATCH] userfaultfd: ensure mremap_userfaultfd_fail() releases
 mmap_changing

Sashiko says:

  mremap_userfaultfd_prep() increments ctx->mmap_changing to stall
  concurrent operations, but mremap_userfaultfd_fail() does not
  decrement it before dropping the context reference.

If an mremap operation fails, ctx->mmap_changing remains elevated. This
will causes subsequent userfaultfd operations like a UFFDIO_COPY to fail
with -EAGAIN.

Decrement ctx->mmap_changing in mremap_userfaultfd_fail().

Link: https://sashiko.dev/#/patchset/20260430113512.115938-1-rppt@kernel.org
Link: https://lore.kernel.org/20260513081416.495963-1-rppt@kernel.org
Fixes: df2cc96e7701 ("userfaultfd: prevent non-cooperative events vs mcopy_atomic races")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4b53dc4a3266..390e4b7d9cb9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -786,6 +786,8 @@ void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
 	if (!ctx)
 		return;
 
+	atomic_dec(&ctx->mmap_changing);
+	VM_WARN_ON_ONCE(atomic_read(&ctx->mmap_changing) < 0);
 	userfaultfd_ctx_put(ctx);
 }
 


