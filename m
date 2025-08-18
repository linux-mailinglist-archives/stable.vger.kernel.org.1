Return-Path: <stable+bounces-171637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C617DB2B0A6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 20:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085741B61D80
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A60263F43;
	Mon, 18 Aug 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+rxI3Vy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34249620
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542438; cv=none; b=MPVWx7jM0r8DXT6rjwaek6Cf29nlDIRHd/tcIgPbK+3klf0dv7WeV7DCsoxuxzgJfdCX1hVcJbFN1E14ObPt4eItelNpXmhkJVEDAIZaRqySySOJGjxz60LCkTphW5GGO2gBDR9LD6CMa6d+m9vklAMecHhXuavV43d7Zm/DZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542438; c=relaxed/simple;
	bh=GKlwNvRTJHOws+zj9wN/thWNCL2UftL8KAjOBCLJm5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7LRGEwBq6Easmw6ypeYZoQfoQjqt0lTqD9DKlBrgbtMr3zFFNMfjGvswVGZvXnUIuhE+oqfVPWx3a5dqMpkuFN2uM6B3H/6QAfjfwyCesgSxA5/9exxvf3qus0/u1v2I4oLforSXwQRbefiZAmIpA5r93qKP9sX/8LhEMr6iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+rxI3Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE636C4CEEB;
	Mon, 18 Aug 2025 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755542436;
	bh=GKlwNvRTJHOws+zj9wN/thWNCL2UftL8KAjOBCLJm5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+rxI3VyU7SfuL1NTGUKnWCsj3uCquMlAfiwW01R/fXopEIpvXCpS/vBfr+M9OF8u
	 NBl2ogEj8ZSruLPf4Fc8Fh6E2IIICYWUeLqpe6UC8Jpc04qA+MQ474Zuy686RrOSQ0
	 83vEIR8V5qgEKlrMYoOp89TNVzLWpBbhNgWraf+MlKBe6PRAogHHeEdnxaxNr8abaF
	 Z7rgdyd8O7+0HNZClgeacMSQ4odJjW8iV1/F/zqRgDa7AWztA2XjUyrEZKgO9Jw3Lh
	 ZOk7ayaSiwop6cAowi/a9rexRTgweLu8IJL9/WP9pbagVfNH8nHK0/gEeMJb/NF3vp
	 PhGw7hP8CjqNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cifs: reset iface weights when we cannot find a candidate
Date: Mon, 18 Aug 2025 14:40:33 -0400
Message-ID: <20250818184033.23573-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081845-cork-enable-a1e8@gregkh>
References: <2025081845-cork-enable-a1e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 9d5eff7821f6d70f7d1b4d8a60680fba4de868a7 ]

We now do a weighted selection of server interfaces when allocating
new channels. The weights are decided based on the speed advertised.
The fulfilled weight for an interface is a counter that is used to
track the interface selection. It should be reset back to zero once
all interfaces fulfilling their weight.

In cifs_chan_update_iface, this reset logic was missing. As a result
when the server interface list changes, the client may not be able
to find a new candidate for other channels after all interfaces have
been fulfilled.

Fixes: a6d8fb54a515 ("cifs: distribute channels across interfaces based on speed")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Kept both int rc and int retry variables ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 883d1cb1fc8b..6764d72ab5a5 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -292,6 +292,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	struct cifs_server_iface *last_iface = NULL;
 	struct sockaddr_storage ss;
 	int rc = 0;
+	int retry = 0;
 
 	spin_lock(&ses->chan_lock);
 	chan_index = cifs_ses_get_chan_index(ses, server);
@@ -320,6 +321,7 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		return 0;
 	}
 
+try_again:
 	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
 				     iface_head);
 	iface_min_speed = last_iface->speed;
@@ -358,6 +360,13 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 
 	if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
 		rc = 1;
+		list_for_each_entry(iface, &ses->iface_list, iface_head)
+			iface->weight_fulfilled = 0;
+
+		/* see if it can be satisfied in second attempt */
+		if (!retry++)
+			goto try_again;
+
 		iface = NULL;
 		cifs_dbg(FYI, "unable to find a suitable iface\n");
 	}
-- 
2.50.1


