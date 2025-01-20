Return-Path: <stable+bounces-109530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36392A16DDE
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D718820CA
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F061E32CA;
	Mon, 20 Jan 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CVtE2Lni"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE91E32BE
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381453; cv=none; b=I22u6hQSZBXfG1LQjiFmjLn46F3rO35/yurW8KmpiXYQsQqzxvMDPxZ6MCErSFj4UOhzGkRb2bWqpwQgfeV1zmlterzFjg9dxcU4QHEF5+1hfqdfPJidjs7SRVdpnfEBXskphqIW0yjjPlyFBuIWGJOgu312nVxPFjh4+6ZOBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381453; c=relaxed/simple;
	bh=0+irMF80gY0jNHbrIMFFSIlxw0mkCVwCLoFVhFqgvoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AI+yGtEcqE9ajZM7hlEaB70aSCXW3gRgA3XDMmeGzKh8MvUvFcE7sa2OluvlhEGWh0garrgkWCGYljA/NKyjYluiO8p/3uNPcmzdDKOFHgECopWW8GxMfR0TdQZNsPKSxpf1U8vvmwC1MkezziyGpbvqRgLhUTdOF1gLrd7y7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CVtE2Lni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92084C4CEDD;
	Mon, 20 Jan 2025 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737381452;
	bh=0+irMF80gY0jNHbrIMFFSIlxw0mkCVwCLoFVhFqgvoM=;
	h=Subject:To:Cc:From:Date:From;
	b=CVtE2Lnic1lSKpuhPH1IlUBMZ0VLsCbbqZdBD0JPV1GyoZ0L8sr0NTCMW2wm15tDb
	 pNUoOcuuz8LOWAU12t9HpH3S0Ww490qlt3Z7Awwd7Zsb7j4myNgq5Q1ow1ctSJpw5k
	 m6GyNwoQTtzfGuxz+DeqMvfxIZKkeYPMQ1UFhWrE=
Subject: FAILED: patch "[PATCH] cifs: support reconnect with alternate password for SMB1" failed to apply to 6.12-stable tree
To: msetiya@microsoft.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:57:30 +0100
Message-ID: <2025012030-print-avert-f15d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b8ed9da102beb2d0926a1d7a7e652392190151c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012030-print-avert-f15d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8ed9da102beb2d0926a1d7a7e652392190151c0 Mon Sep 17 00:00:00 2001
From: Meetakshi Setiya <msetiya@microsoft.com>
Date: Fri, 10 Jan 2025 07:10:27 -0500
Subject: [PATCH] cifs: support reconnect with alternate password for SMB1

SMB1 shares the mount and remount code paths with SMB2/3 and already
supports password rotation in some scenarios. This patch extends the
password rotation support to SMB1 reconnects as well.

Cc: stable@vger.kernel.org
Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6cb1e81993f8..ab0b949924d7 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -152,8 +152,17 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	spin_unlock(&ses->ses_lock);
 
 	rc = cifs_negotiate_protocol(0, ses, server);
-	if (!rc)
+	if (!rc) {
 		rc = cifs_setup_session(0, ses, server, ses->local_nls);
+		if ((rc == -EACCES) || (rc == -EHOSTDOWN) || (rc == -EKEYREVOKED)) {
+			/*
+			 * Try alternate password for next reconnect if an alternate
+			 * password is available.
+			 */
+			if (ses->password2)
+				swap(ses->password2, ses->password);
+		}
+	}
 
 	/* do we need to reconnect tcon? */
 	if (rc || !tcon->need_reconnect) {


