Return-Path: <stable+bounces-109532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E09A16DE0
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458EB3A10C3
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379851E2842;
	Mon, 20 Jan 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NrkP/ur2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECF1E2844
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381465; cv=none; b=Hb2Y8DaDrFQMISpfgR5SoNBAKEbfrdCj9fjdsvXnCYCm6URjYTH7Skx6mXKznSvZmVD7EjhmGf0Uch3hZEfg2dNdoWvQvXyuQLjk1Lj3NZWjFOkql1dQMPzD1t/Qgl6RyszLpBdRoz/RVGPxMofizK0XUOX7bmhlfEUMJyUmmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381465; c=relaxed/simple;
	bh=dcWJhwyW1fMPEwlwwS+bZUcNdG814NMhv1sUcS0xD+M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=stgPyEwYhI883PkE0O78MWo01TJ65dkE+2auMnl5GWUR+qxIyVL331e8H2Q86vMFv+4g+PlF5vdIZaruzdnkxzb/K+e9Ul0PJb0eeLdSCHHFHSIvlnByzBvHNxil7HlEyqifxj8VAFCmB8JuBmSSseWf58O7YiJGZR0XEItIpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NrkP/ur2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1742CC4CEDD;
	Mon, 20 Jan 2025 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737381464;
	bh=dcWJhwyW1fMPEwlwwS+bZUcNdG814NMhv1sUcS0xD+M=;
	h=Subject:To:Cc:From:Date:From;
	b=NrkP/ur2/rErWZIGJCNLR//5nDxfpZ07l03S8rZ547x2yOrbmhjVW+dseXRSg33Jz
	 9unC/0ExRLtHHHpYoHlfH4oByVvIi0mHRteH2Dv65ALJise4L04CvMRvlvDIG48kIC
	 G07MUZujjoQhpaL3VXA25S3bPJ+iWja2B8IQZh0E=
Subject: FAILED: patch "[PATCH] cifs: support reconnect with alternate password for SMB1" failed to apply to 5.15-stable tree
To: msetiya@microsoft.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:57:31 +0100
Message-ID: <2025012031-dealer-graded-ea0e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b8ed9da102beb2d0926a1d7a7e652392190151c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012031-dealer-graded-ea0e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


