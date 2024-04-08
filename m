Return-Path: <stable+bounces-37283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F177F89C432
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C2D1F2266E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A858594B;
	Mon,  8 Apr 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UedhKBge"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951337E118;
	Mon,  8 Apr 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583783; cv=none; b=Z6P4tCfF0LNcIRObNGZpze/Q4d8LQ5RaZnZc5DjFbUJyxeHDl8LvaQrG842V+W154AgmH39SVeLl0t06tYyeeCwn5puKoZQcaeMgoABskcibSr1x65U5T5ARR1w85iP9DG6aN6c9XJH7ZuBZd8xI20rVnHtFcg6EO7fkC6quUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583783; c=relaxed/simple;
	bh=a3SYhrZOl3InBLw9VupUxjs1dUj1wik/XdM5pmQNWW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HttwGz80ORauo1WjoZNvWRiPgiAVkawKRtNUSSj5LdtE3uhFJLJ8IqCMbU5ML9KJrAEmS5g13126RErZvV7YvehPAPyJDMaL+++7ms7ehIfm7FIHl1T/fg2T0uvtjEMQYZyfS/gZR6FViDWyVQogVu+dXJlboRHS0OyHBYgwN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UedhKBge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACE7C433C7;
	Mon,  8 Apr 2024 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583783;
	bh=a3SYhrZOl3InBLw9VupUxjs1dUj1wik/XdM5pmQNWW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UedhKBge97VhnLTWzbCaXX7rjwRNeX4SwY9anUIB1yVgE/UIrPFAxKJ4WChKa1zWU
	 3DoFcdE8FYaMkYa5SW0EXs/Lh/7wRAOqJJ1bPaOioldNtPjJcqDh9BZ0bVqCAIgmNp
	 8IDNmF3yoqZw1aHKfxQYKrCfgOi+P7fEEMGYym+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 233/252] smb: client: fix potential UAF in smb2_is_valid_oplock_break()
Date: Mon,  8 Apr 2024 14:58:52 +0200
Message-ID: <20240408125313.886595527@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

commit 22863485a4626ec6ecf297f4cc0aef709bc862e4 upstream.

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2misc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -697,6 +697,8 @@ smb2_is_valid_oplock_break(char *buffer,
 	/* look up tcon based on tid & uid */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 
 			spin_lock(&tcon->open_file_lock);



