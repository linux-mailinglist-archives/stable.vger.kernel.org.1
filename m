Return-Path: <stable+bounces-247621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLToLNXiBmrVogIAu9opvQ
	(envelope-from <stable+bounces-247621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:09:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3154C0E5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48D993073E38
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338D421883;
	Fri, 15 May 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0TJNFgVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008C41C2FB
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835239; cv=none; b=pzmwgxE+xCgNZPVpOLF4dcQKrgf1vA7x93HIgMngcZhSivS1oimmpzB8aIPTMbh2Bn/FXovyQwgGADoucvCjq65+KEgXyG2qUDWba1SOKaZZsr/ojyTW+Q4SML4dxnTE36Mej1ZzRjsp1nVq25RvZWZ9KWHBgLLhm5YBc/LZlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835239; c=relaxed/simple;
	bh=R/FUJl6gJSAEytKjaQyda63ujOW2pU1u+cZoLlfVahw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cVA8t4lz6J1yShT0g1z2fDZTCgnnJn0bcwKjWlsygCbjxKkXRnTkoytSfda8x3oqWkeELB/LxdshNoqaH7VqtmQ0ygdEcGe37mpc+lEBqZx3oD25OXRBP4KwrToI8KTHRMMVfdnUEheI+EkuGt78r0PGELKMLnZGt/IYbhWdtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0TJNFgVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF82C2BCB0;
	Fri, 15 May 2026 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778835238;
	bh=R/FUJl6gJSAEytKjaQyda63ujOW2pU1u+cZoLlfVahw=;
	h=Subject:To:Cc:From:Date:From;
	b=0TJNFgVNu4mxnSo+ZiCfGvHyhFVWYztqmalnDAI4Y6G1bOCRa+bVkcdbAEEN4jgCb
	 SWAURIDPBzeK+XlmF/lAytzMrCwA6cnibfXf/2QZQUocRjx2k2QmGOjjVWTtb8xiPN
	 FPwLYgO1VLKQHdf1oxzTN6wgyNCGryd6nR416m18=
Subject: FAILED: patch "[PATCH] drm/v3d: Reject empty multisync extension to prevent infinite" failed to apply to 6.12-stable tree
To: ashutoshdesai993@gmail.com,mcanal@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:51:41 +0200
Message-ID: <2026051541-platter-sugar-75ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7E3154C0E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247621-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,igalia.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fb44d589bf3148e13452185a6e772a7efbf2d684
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051541-platter-sugar-75ec@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb44d589bf3148e13452185a6e772a7efbf2d684 Mon Sep 17 00:00:00 2001
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
Date: Wed, 15 Apr 2026 05:00:00 +0000
Subject: [PATCH] drm/v3d: Reject empty multisync extension to prevent infinite
 loop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3d_get_extensions() walks a userspace-provided singly-linked list of
ioctl extensions without any bound on the chain length. A local user
can craft a self-referential extension (ext->next == &ext) with zero
in_sync_count and out_sync_count, which bypasses the existing duplicate-
extension guard:

    if (se->in_sync_count || se->out_sync_count)
            return -EINVAL;

The guard never fires because v3d_get_multisync_post_deps() returns
immediately when count is zero, leaving both fields at zero on every
iteration. The result is an infinite loop in kernel context, blocking
the calling thread and pegging a CPU core indefinitely.

Fix this by rejecting a multisync extension where both in_sync_count
and out_sync_count are zero in v3d_get_multisync_submit_deps(). An
empty multisync carries no synchronization information and serves no
useful purpose, so returning -EINVAL for such an extension is the
correct defense against this attack vector.

Fixes: e4165ae8304e ("drm/v3d: add multiple syncobjs support")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Link: https://patch.msgid.link/20260415050000.3816128-1-ashutoshdesai993@gmail.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe89f..fc74351efad5 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -393,6 +393,11 @@ v3d_get_multisync_submit_deps(struct drm_file *file_priv,
 	if (multisync.pad)
 		return -EINVAL;
 
+	if (!multisync.in_sync_count && !multisync.out_sync_count) {
+		drm_dbg(&v3d->drm, "Empty multisync extension\n");
+		return -EINVAL;
+	}
+
 	ret = v3d_get_multisync_post_deps(file_priv, se, multisync.out_sync_count,
 					  multisync.out_syncs);
 	if (ret)


