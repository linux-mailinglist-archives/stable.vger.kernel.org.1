Return-Path: <stable+bounces-270520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uxO9LeBtRmqPUgsAu9opvQ
	(envelope-from <stable+bounces-270520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:55:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 281796F8988
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 15:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=z64TyLW1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270520-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270520-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3448B301F788
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2F496919;
	Thu,  2 Jul 2026 13:55:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556BB420E84
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:55:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000542; cv=none; b=So2afZIl5yZZjQUWJ8hC1QdlM78R9/B9Aut4+6pIJwvpxhR1iO2gDuOxDf3BhytlA+SoHASrDfm1JL93tgHEBnnngfytaiHTbN+ZurVTjcxurtBNqlrq2aYgcWyBuz82/k+Ack6jGjta9vPy+sCD5KBKJWjER8UnygUSz83ZLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000542; c=relaxed/simple;
	bh=dmLIL06eehuFKpDHncr1cjT+vg6J53ZSggfo+uEfGh8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iLsk2rRMmechOiXw+YDiXlFrpVrum19zcwDTPtzq2nfrTSRa/sO5sXdjL7BlAXtbSWtfd5m3VGb9vt9kXPP2es2QFB2Q+Q82+bDBO0BLGhPFwU4UqWySsF18uzhGArg0ACsYFzRmISRLcSUOU7r1xQkLhJ49GNio0kweO5Iwj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z64TyLW1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710D71F000E9;
	Thu,  2 Jul 2026 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000541;
	bh=ACMzVIsD/9Lx6Ji3eJPxAG5tvOA5HSwZ1LOIJmZvZR4=;
	h=Subject:To:Cc:From:Date;
	b=z64TyLW13MkLFpmEuownP7otBOTgvFFUt+26Po80kQxQYRprZptrjTnwQMuQJtYL5
	 TjPxI+zJjDaNAf5r0HkCSNJ082qzXh3ZMlojcbeRBdOywGDOw2OfJ1wAqqIKnRHG99
	 i+NLI4Y0ehsHzcUmrjdJQA6P14Si6nEFan/3+JWs=
Subject: FAILED: patch "[PATCH] NFSv4/flexfiles: reject zero filehandle version count" failed to apply to 6.1-stable tree
To: michael.bommarito@gmail.com,anna.schumaker@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:55:43 +0200
Message-ID: <2026070243-unafraid-spooky-0873@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270520-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:anna.schumaker@hammerspace.com,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,hammerspace.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 281796F8988


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070243-unafraid-spooky-0873@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 13 May 2026 12:26:56 -0400
Subject: [PATCH] NFSv4/flexfiles: reject zero filehandle version count

ff_layout_alloc_lseg() decodes the filehandle-version array count
from the flexfiles layout body. The value is used as the count for
kzalloc_objs(), and the current code only rejects NULL.

A zero count yields ZERO_SIZE_PTR, which can be stored in
dss_info->fh_versions even though later flexfiles paths assume that at
least one filehandle version exists.

Reject fh_count == 0 before the allocation, matching the existing zero
version_count validation in the flexfiles GETDEVICEINFO parser.

A QEMU/KASAN run with a malformed flexfiles layout hit:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:ff_layout_encode_ff_layoutupdate.isra.0+0x15f/0x750
  ff_layout_encode_layoutreturn+0x683/0x970
  nfs4_xdr_enc_layoutreturn+0x278/0x3a0
  Kernel panic - not syncing: Fatal exception

The patched kernel rejects the malformed layout without KASAN/oops/panic,
and a valid fh_count=1 regression still opens, reads, and unmounts cleanly.

Cc: stable@vger.kernel.org
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 6a84d85e0651..99caa8d28c25 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -551,6 +551,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 			if (!p)
 				goto out_err_free;
 			fh_count = be32_to_cpup(p);
+			if (fh_count == 0) {
+				rc = -EINVAL;
+				goto out_err_free;
+			}
 
 			dss_info->fh_versions =
 			    kzalloc_objs(struct nfs_fh, fh_count, gfp_flags);


