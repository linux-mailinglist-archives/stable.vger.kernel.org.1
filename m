Return-Path: <stable+bounces-114781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6BA30080
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF951887C0C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8C1F2C28;
	Tue, 11 Feb 2025 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XutgXRV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5601F2BB7;
	Tue, 11 Feb 2025 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237485; cv=none; b=RFj4ayi/v4UP9kdxIfNiqhsQEcVQGqVxTBDmE2w+mG86IYiLjFaZU5IrG5ZFry3SOa2X1NyX5U9bQ5LCDpHkWn7mJyaiHdWwa0DIXnRr9VIVoL3xzTSBEW4isY+cbia+kbBHZuFIxuXSdQwocdXSIpAvjqJUkLAJCYIEeCetovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237485; c=relaxed/simple;
	bh=Sf5wf3nrMe44/8779lMbahSKanPXfB9Q29I0zhUYPsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6mCH+M4H41jYLFpkFtBs/K+uZ2VvX4pJCea0D5Ocsf1/ZOxC/OgmLoBE6HWdkJigusFuHvbqz2CuwK7gSXxJjDUIYFVf7xQgfvf+M8Rj6lHk/5npcosQWqXtDM9h49Y3FAAV53nQ7n7JA/E63Yu2qgLVGT4wjxZzSzVHXn6k/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XutgXRV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA15C4CED1;
	Tue, 11 Feb 2025 01:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237485;
	bh=Sf5wf3nrMe44/8779lMbahSKanPXfB9Q29I0zhUYPsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XutgXRV1EF+lmd6nPnSQf3R9Gf7zj89x/LH183BTUg/Mw+/rEMn6FftR2lntof6m5
	 j1pRJTG9+TM4UPvG5c83dq8a/MeulmbGu0IYaONWOyEU3KbH2QoqE29u5s6XCoMrc4
	 LkiHVXpd0JX2/vNktRPSPvAERz+Sk5SL8kb+BjsvqOfrkF3IS78Y9rRmWOs57mWtVy
	 WPNXn9dOtbxDiEpL2cscWJV8SLOnsp+FRohld3EFqAxP/D4DynGZVfnOn+TgPWCd9l
	 T/UkbEwGA5NWwV/fn8hLUCRcqEKU0dKpSTp9ovyScmNJnHisHm25+/wG1X7jryxD2W
	 iHU9hqzCNDOEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.12 16/19] smb: client: fix noisy when tree connecting to DFS interlink targets
Date: Mon, 10 Feb 2025 20:30:44 -0500
Message-Id: <20250211013047.4096767-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013047.4096767-1-sashal@kernel.org>
References: <20250211013047.4096767-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.13
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 773dc23ff81838b6f74d7fabba5a441cc6a93982 ]

When the client attempts to tree connect to a domain-based DFS
namespace from a DFS interlink target, the server will return
STATUS_BAD_NETWORK_NAME and the following will appear on dmesg:

	CIFS: VFS:  BAD_NETWORK_NAME: \\dom\dfs

Since a DFS share might contain several DFS interlinks and they expire
after 10 minutes, the above message might end up being flooded on
dmesg when mounting or accessing them.

Print this only once per share.

Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4750505465ae6..80d5705649f36 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2175,7 +2175,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 
 tcon_error_exit:
 	if (rsp && rsp->hdr.Status == STATUS_BAD_NETWORK_NAME)
-		cifs_tcon_dbg(VFS, "BAD_NETWORK_NAME: %s\n", tree);
+		cifs_dbg(VFS | ONCE, "BAD_NETWORK_NAME: %s\n", tree);
 	goto tcon_exit;
 }
 
-- 
2.39.5


