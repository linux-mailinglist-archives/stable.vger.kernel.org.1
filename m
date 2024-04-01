Return-Path: <stable+bounces-34527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30A893FB8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD00D2851A3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750A45BE4;
	Mon,  1 Apr 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="St95iTEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B861CA8F;
	Mon,  1 Apr 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988421; cv=none; b=n+mudga4lrc3mTUtCw1NtfaX0HgHogiyqeaYRho+fNO71znFo2DUm5E+1x76qpMxS5WrH1O8q6Qrb4TkJ7fShp0shKTFs+CvtXcd1BbWppY51BM535O1rt92pr9oknpnpH33zpTfPVEDqSuDcidZbdlxvbzSOVUkD8c7rj9k6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988421; c=relaxed/simple;
	bh=D14wbWyed/RBo3U8Ig56T8NeU7OQZL2ycE3XEaKxPN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYLevv29LOJ2wPV3r4EZTuF/CjrAB8MW83zJn/IUUGF+0A5QDBtCUaBJDsD3vBhVO6hKP//138B/1bJ4Hc4N5HJd22RzlINo7ZjDNwZqyTxbzp4xgrWfiY7z6Pg2lvxbv+hO+uJVOo81WRmFRsezCMPVwfJvupC05uYManif4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=St95iTEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76750C433F1;
	Mon,  1 Apr 2024 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988420;
	bh=D14wbWyed/RBo3U8Ig56T8NeU7OQZL2ycE3XEaKxPN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=St95iTEjRDurOFp/oqiTa5pvcQtucS142NeZRwccjJPfNfUDiVzTbEi2oM9eRWtSj
	 QRz++VDt6Agdc34OZCTHmhCV6FnS6zLDA8Dkf+/fepDL4AFv8dxWY2qlBvyPefJDYy
	 mjG/G5BLwkaSKw34XQW7Nhe4ZZUCmN4qe/rSEPHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 180/432] cifs: reduce warning log level for server not advertising interfaces
Date: Mon,  1 Apr 2024 17:42:47 +0200
Message-ID: <20240401152558.513626053@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 16a57d7681110b25708c7042688412238e6f73a9 ]

Several users have reported this log getting dumped too regularly to
kernel log. The likely root cause has been identified, and it suggests
that this situation is expected for some configurations
(for example SMB2.1).

Since the function returns appropriately even for such cases, it is
fairly harmless to make this a debug log. When needed, the verbosity
can be increased to capture this log.

Cc: stable@vger.kernel.org
Reported-by: Jan Čermák <sairon@sairon.cz>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index f8f4e7fc05dae..5de32640f0265 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -230,7 +230,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		spin_lock(&ses->iface_lock);
 		if (!ses->iface_count) {
 			spin_unlock(&ses->iface_lock);
-			cifs_dbg(VFS, "server %s does not advertise interfaces\n",
+			cifs_dbg(ONCE, "server %s does not advertise interfaces\n",
 				      ses->server->hostname);
 			break;
 		}
@@ -396,7 +396,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	spin_lock(&ses->iface_lock);
 	if (!ses->iface_count) {
 		spin_unlock(&ses->iface_lock);
-		cifs_dbg(VFS, "server %s does not advertise interfaces\n", ses->server->hostname);
+		cifs_dbg(ONCE, "server %s does not advertise interfaces\n", ses->server->hostname);
 		return;
 	}
 
-- 
2.43.0




