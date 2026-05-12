Return-Path: <stable+bounces-245659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOF/OZI7A2oL2AEAu9opvQ
	(envelope-from <stable+bounces-245659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:39:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA85522B80
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 637953064725
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09963A4256;
	Tue, 12 May 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tvMaF+jb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465C3A7195
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594565; cv=none; b=KpNOLVGdSnxZfyMT0NQ+k/v1IsCFvOdFldb2F6SEfDSsTV+rjfwG49pQ5+2z38O/VYIWUSk0ndXGk4I8wvc3ptSAaRv0c6/mmawzCXnh2Uy36f+WN1LUE+pI/G3AvVQHmFicSiNfnqn9LT2d1HKfimG9DJKoN4gkP99PznBpbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594565; c=relaxed/simple;
	bh=BEuD8SC8z52a8XzClbjEgN3V5AhEHNizOVBASDwSxxE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lb/IHmclYf9Y2lYi4Dr+qoz32bDeeFJ4b1u6XpnWWxyoMVv0YSZSz6QcRkJr9WJ4tfADq3Nc9SlPaTTfmfZIefTOof2sJ40JXy0Oo8VUMTRnOsIeqMAqCecDWsBbA9McNlj1DfVWE5x0k+FZJAZk3OlnQJNsvGXnGHUorGiW6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tvMaF+jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAD1C2BCB0;
	Tue, 12 May 2026 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594565;
	bh=BEuD8SC8z52a8XzClbjEgN3V5AhEHNizOVBASDwSxxE=;
	h=Subject:To:Cc:From:Date:From;
	b=tvMaF+jbsuOHVznMSJCfhNqBJQO+yQryoM6g1YDf/MKUglmNXisZHDtPQnY7W67Lg
	 wSwv+TtPK2e7dhhvkSRDyO4qtvR3zDxKS2ASbXoE6AAHLqV+nHBQB+rXQgy2gFoOo5
	 eewKsrU2CCux+97dS4Df1oxkqyv804uWX3MWzdIY=
Subject: FAILED: patch "[PATCH] dm-verity-fec: fix the size of dm_verity_fec_io::erasures" failed to apply to 5.15-stable tree
To: ebiggers@kernel.org,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:00:14 +0200
Message-ID: <2026051214-undying-maybe-3c0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EEA85522B80
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
	TAGGED_FROM(0.00)[bounces-245659-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a7fca324d7d90f7b139d4d32747c83a629fdb446
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051214-undying-maybe-3c0e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7fca324d7d90f7b139d4d32747c83a629fdb446 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 5 Feb 2026 20:59:23 -0800
Subject: [PATCH] dm-verity-fec: fix the size of dm_verity_fec_io::erasures

At most 25 entries in dm_verity_fec_io::erasures are used: the maximum
number of FEC roots plus one.  Therefore, set the array size
accordingly.  This reduces the size of dm_verity_fec_io by 912 bytes.

Note: a later commit introduces a constant DM_VERITY_FEC_MAX_ROOTS,
which allows the size to be more clearly expressed as
DM_VERITY_FEC_MAX_ROOTS + 1.  This commit just fixes the size first.

Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index 35d28d9f8a9b..32ca2bfee1db 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -47,7 +47,8 @@ struct dm_verity_fec {
 /* per-bio data */
 struct dm_verity_fec_io {
 	struct rs_control *rs;	/* Reed-Solomon state */
-	int erasures[DM_VERITY_FEC_MAX_RSN];	/* erasures for decode_rs8 */
+	/* erasures for decode_rs8 */
+	int erasures[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN + 1];
 	u8 *output;		/* buffer for corrected output */
 	unsigned int level;		/* recursion level */
 	unsigned int nbufs;		/* number of buffers allocated */


