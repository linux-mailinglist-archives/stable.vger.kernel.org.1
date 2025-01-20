Return-Path: <stable+bounces-109534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BEFA16DE3
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9067A0749
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1801E2849;
	Mon, 20 Jan 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jc25UOym"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F71E2842
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381475; cv=none; b=jiqWTx7FsloF09f4PTJw0XGXoWg+zsflxjQ/VPg61SzjTWX/nGnAJ/n00axO9Dr/d6EvVlcu1RkZk2iE7lirX7VBgZhO2YL2YZ1lrw0es1zH0oHlptsweE9G/1/7cEf0nrsA6uH8TRgLm0T0qKA1ULJs3k3bF5EplrZXFv6MIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381475; c=relaxed/simple;
	bh=ILoJJKk5fnWsNuCCdgJvAfxazEIKOUom/o4MUaR9GUU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e2y33aI0wVhjkDKQqpovNRDM/ny0CUNkRtCIO+UoZo6rgDkivXu/4Ejmy/jiWrF+N0tnetUEz3jOQSyEczKIII2Cl+1RFQuxxNqDmcHyLeY8KrYOEjtOS5EYCRLbD3df6HjFztJ80CR4qVCVf01rhLUP+JtOC8qu9kqdMpRRDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jc25UOym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D714AC4CEDD;
	Mon, 20 Jan 2025 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737381475;
	bh=ILoJJKk5fnWsNuCCdgJvAfxazEIKOUom/o4MUaR9GUU=;
	h=Subject:To:Cc:From:Date:From;
	b=jc25UOym09F3gsBPUzEto+4j9OmdiEgqRNn5BSeQu4lhrmbHIyfyAXld5qED05IqG
	 Y2LbgWXllQ9C7jdXnu8+O7Q+s3mK8AlTZUoAwpaZmmCy4xZTPOQx51imJKCn1E/0Xv
	 jdm9d2njVK6nA2DApaQRSBicU/gEUnwsyggxUFmo=
Subject: FAILED: patch "[PATCH] cifs: support reconnect with alternate password for SMB1" failed to apply to 5.10-stable tree
To: msetiya@microsoft.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:57:32 +0100
Message-ID: <2025012032-goggles-gory-004a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b8ed9da102beb2d0926a1d7a7e652392190151c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012032-goggles-gory-004a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


