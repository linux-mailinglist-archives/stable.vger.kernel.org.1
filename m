Return-Path: <stable+bounces-36926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD689C262
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48B9282DF2
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE70F7BB0F;
	Mon,  8 Apr 2024 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7fRikwR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7B7BB06;
	Mon,  8 Apr 2024 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582746; cv=none; b=tLGgVYMB7z1UDWAGRnQHV7xOgeslsKi+ZHNu1fn9ECWOJACi6MCo3ulyAVpueM8k3fNG32yfUrqRp1Te+c0DJpb0mlYYqIuBoF4m5BM54UBow9JLAQcnPJ+eADVnF4CslVrxy+xPzURKgUaJ9smerK2S589Ba/aCfeDmWR2neIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582746; c=relaxed/simple;
	bh=AlkSEPzBMtIMB4ugCT0K25m6dYWSJyEm/6G5nL0wYOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGbkps5O4AYU6XDmpxRfwbuXvick8DDfHsAEHkOiWKcUfbxrywx7rI3voWNU3Y8gT5jaZbg7PPzaw++ztZvemjfqRUg7ul7YoZYy7t8A1nA6NaQSGpceEc8p78l5PBQbgY2EHe4JDpMviFoQ2uN4JugoR97IjXB1007ECLm4baM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7fRikwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9688C43399;
	Mon,  8 Apr 2024 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582746;
	bh=AlkSEPzBMtIMB4ugCT0K25m6dYWSJyEm/6G5nL0wYOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w7fRikwRKxDrRs/zQQefiyGuUKwiFr2c+NhOrVqaxzMzHkkvcZ5VshSZTSHOA32B9
	 ARS8tGBNFUQN+/XObBv41amOXlPTgCFxjZj+/8o+Cq61CLxZRcZkCfPz6D2V6cVkxC
	 j3bUseKrxsNv20vmwSkBSCWNYX0N5e9viJkUwRhY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 130/138] smb: client: fix potential UAF in smb2_is_valid_lease_break()
Date: Mon,  8 Apr 2024 14:59:04 +0200
Message-ID: <20240408125300.274625874@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

commit 705c76fbf726c7a2f6ff9143d4013b18daaaebf1 upstream.

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
@@ -622,6 +622,8 @@ smb2_is_valid_lease_break(char *buffer,
 	/* look up tcon based on tid & uid */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			spin_lock(&tcon->open_file_lock);
 			cifs_stats_inc(



