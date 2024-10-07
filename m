Return-Path: <stable+bounces-81351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5999317C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB421F23946
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B51D90D1;
	Mon,  7 Oct 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ike7JaG4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7C1D86DC
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315521; cv=none; b=U2wbUZV2dkXkKeHpLPmhszNWuKE+bUV0mkegaTggicuJN+kHg6NRAq5ssUqyalo6vtXj5JBnOt6saD3qNeAw7uHR4u+tOgQY1e9q0JFxg+o006rrp4Md5TU+RHhWOYFz34f6Qhq+LWc+o/PKTsfvzfNN2mCLUEptOo7Pf/Zihag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315521; c=relaxed/simple;
	bh=ywggsBuunlnfU9YeLcFECSC7glmbki6mcUzvf3IrII4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=omrmOuUK2t674u62ggy4hOMhhf/bHgujmzpkpd86AcYEencY0AQcRaPkGNyVrEUpcLAz1vwvmAuvR7yEweJhC/wcmku/qzfqusM61cXtLBE702I065WQOdi91Qromb2e1uLyZZ3D0qZ1x37mwlN6LmcukhVsh+3SpYAg8jXCjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ike7JaG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08DDC4CEC6;
	Mon,  7 Oct 2024 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315521;
	bh=ywggsBuunlnfU9YeLcFECSC7glmbki6mcUzvf3IrII4=;
	h=Subject:To:Cc:From:Date:From;
	b=ike7JaG4oWb2xeuGOzdG+1RzaB/ZMQdESegOyBgQ6MbVXmDMV1kvbPZT9YBUtmSoF
	 0Ikh15yXTpSPOeTZw2oXAGFr+2ENzaTY6NxrFoW8uCb3pioYUOet67EkWauQjglW74
	 5JpTfDxohwQkQkk/VL9qBiAwFWCp/NMy1VbHaqcA=
Subject: FAILED: patch "[PATCH] nfsd: fix delegation_blocked() to block correctly for at" failed to apply to 4.19-stable tree
To: neilb@suse.de,bcodding@redhat.com,chuck.lever@oracle.com,jlayton@kernel.org,okorniev@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:38:29 +0200
Message-ID: <2024100729-trident-control-06ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 45bb63ed20e02ae146336412889fe5450316a84f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100729-trident-control-06ad@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

45bb63ed20e0 ("nfsd: fix delegation_blocked() to block correctly for at least 30 seconds")
b3f255ef6bff ("nfsd: use ktime_get_seconds() for timestamps")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45bb63ed20e02ae146336412889fe5450316a84f Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Mon, 9 Sep 2024 15:06:36 +1000
Subject: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds

The pair of bloom filtered used by delegation_blocked() was intended to
block delegations on given filehandles for between 30 and 60 seconds.  A
new filehandle would be recorded in the "new" bit set.  That would then
be switch to the "old" bit set between 0 and 30 seconds later, and it
would remain as the "old" bit set for 30 seconds.

Unfortunately the code intended to clear the old bit set once it reached
30 seconds old, preparing it to be the next new bit set, instead cleared
the *new* bit set before switching it to be the old bit set.  This means
that the "old" bit set is always empty and delegations are blocked
between 0 and 30 seconds.

This patch updates bd->new before clearing the set with that index,
instead of afterwards.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 6282cd565553 ("NFSD: Don't hand out delegations for 30 seconds after recalling them.")
Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cb5a9ab451c5..ac1859c7cc9d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1078,7 +1078,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
  * When a delegation is recalled, the filehandle is stored in the "new"
  * filter.
  * Every 30 seconds we swap the filters and clear the "new" one,
- * unless both are empty of course.
+ * unless both are empty of course.  This results in delegations for a
+ * given filehandle being blocked for between 30 and 60 seconds.
  *
  * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
  * low 3 bytes as hash-table indices.
@@ -1107,9 +1108,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
 		if (ktime_get_seconds() - bd->swap_time > 30) {
 			bd->entries -= bd->old_entries;
 			bd->old_entries = bd->entries;
+			bd->new = 1-bd->new;
 			memset(bd->set[bd->new], 0,
 			       sizeof(bd->set[0]));
-			bd->new = 1-bd->new;
 			bd->swap_time = ktime_get_seconds();
 		}
 		spin_unlock(&blocked_delegations_lock);


