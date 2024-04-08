Return-Path: <stable+bounces-36360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AA89BCEF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7431BB21D5B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC08952F87;
	Mon,  8 Apr 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BsjODCxl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CF52F82
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571813; cv=none; b=Jdqtf5aLYgPnQuQ5Rc2Hj7A2a3ZmOhxpNAB1APAnCWEgdST3GHhF1Oqovgw9VOEktXP/ivfO9P38vHuHE/BEB6R1J+oRUHMqQYvnMiDWriMIf3lkuTuMXkzHNMWRKoGb1apsaEQgU1n81w2jBeVJqTLFtfNC25rG3BjOywjzw3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571813; c=relaxed/simple;
	bh=Ar8B5ippTOMNQj5UD2uqtCjRtRxHKBvvSGrjNAXzUeg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eeq7xbLC0bMVkTt6YEf1NkCt97Q5odYXngZX13CfgVcuqPyjqWT//GqfguBhgLhwp4es/4oG9Oo5jnGs7czlKa0hb1xt4myPAVSMQ2s4JvGcydinzriHL8SKgykx1lvWn7bGhjdbOV54oY6hiraS+jc6x5jrkK+TXIWPi+Hg9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BsjODCxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36335C433C7;
	Mon,  8 Apr 2024 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571812;
	bh=Ar8B5ippTOMNQj5UD2uqtCjRtRxHKBvvSGrjNAXzUeg=;
	h=Subject:To:Cc:From:Date:From;
	b=BsjODCxldqXnk6J+2mRq2zcCA6TB8fmwR4Snsm5NPG/gko0loALfi9euD7v9C7aW/
	 HoxPxuDjerUWsxVVKepSmsblKAMM/fDv9YE2c+lXHPZ5pK6dc7UpeagfvUS1ewaTs1
	 JjjbMtaX9b7M4gP+O1WrbUd90np09hH9v6NGeMlA=
Subject: FAILED: patch "[PATCH] smb: client: fix potential UAF in cifs_dump_full_key()" failed to apply to 6.1-stable tree
To: pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:23:29 +0200
Message-ID: <2024040829-upcoming-gnat-69ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 58acd1f497162e7d282077f816faa519487be045
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040829-upcoming-gnat-69ec@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

58acd1f49716 ("smb: client: fix potential UAF in cifs_dump_full_key()")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
8e3554150d6c ("cifs: fix sharing of DFS connections")
2f4e429c8469 ("cifs: lock chan_lock outside match_session")
396935de1455 ("cifs: fix use-after-free bug in refresh_cache_worker()")
b56bce502f55 ("cifs: set DFS root session in cifs_get_smb_ses()")
b9ee2e307c6b ("cifs: improve checking of DFS links over STATUS_OBJECT_NAME_INVALID")
7ad54b98fc1f ("cifs: use origin fullpath for automounts")
466611e4af82 ("cifs: fix source pathname comparison of dfs supers")
6916881f443f ("cifs: fix refresh of cached referrals")
cb3f6d876452 ("cifs: don't refresh cached referrals from unactive mounts")
a1c0d00572fc ("cifs: share dfs connections and supers")
a73a26d97eca ("cifs: split out ses and tcon retrieval from mount_get_conns()")
2301bc103ac4 ("cifs: remove unused smb3_fs_context::mount_options")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
c877ce47e137 ("cifs: reduce roundtrips on create/qinfo requests")
83fb8abec293 ("cifs: Add "extbuf" and "extbuflen" args to smb2_compound_op()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58acd1f497162e7d282077f816faa519487be045 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Tue, 2 Apr 2024 16:33:54 -0300
Subject: [PATCH] smb: client: fix potential UAF in cifs_dump_full_key()

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index c012dfdba80d..855ac5a62edf 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -247,7 +247,9 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 		spin_lock(&cifs_tcp_ses_lock);
 		list_for_each_entry(server_it, &cifs_tcp_ses_list, tcp_ses_list) {
 			list_for_each_entry(ses_it, &server_it->smb_ses_list, smb_ses_list) {
-				if (ses_it->Suid == out.session_id) {
+				spin_lock(&ses_it->ses_lock);
+				if (ses_it->ses_status != SES_EXITING &&
+				    ses_it->Suid == out.session_id) {
 					ses = ses_it;
 					/*
 					 * since we are using the session outside the crit
@@ -255,9 +257,11 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 					 * so increment its refcount
 					 */
 					cifs_smb_ses_inc_refcount(ses);
+					spin_unlock(&ses_it->ses_lock);
 					found = true;
 					goto search_end;
 				}
+				spin_unlock(&ses_it->ses_lock);
 			}
 		}
 search_end:


