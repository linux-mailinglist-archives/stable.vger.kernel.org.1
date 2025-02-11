Return-Path: <stable+bounces-114808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4404A300C9
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A43167034
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363A9262166;
	Tue, 11 Feb 2025 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAiS3P0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CC26215E;
	Tue, 11 Feb 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237542; cv=none; b=OoC9NkRXSaDQCVP8A/TbbUj0rbCTMxYNvpO9fc9noQnGxVCKPs3zwhAtGSsV0g4gymAJUDJWBs/WBdybprTYAntse8WHYoE+3U32pluQqXi/LcOYIDEMOGXJEEs3HSbvVtTEEL/SE10t/F1YUm8Zsj3S9zBeo/W6Tj+DnJIbNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237542; c=relaxed/simple;
	bh=vHmOMGFqOrzYxGFtXOCUBr10fhW5HjBijPMuOMBNbEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W86AnL7FIb/ORZm9C13vAE4mt3HGdf2QKKazbwLsNFFPLSQD0kloZG1w3z+PuxloFYF+AiUthHZpabGHHe/+V7Anu5n2DJauN1+AjNZgbduwM+He+vXs754hJBLkXaejOSnczx9vRc+ZXb+fdEj1S08XPzQYbo7RZ6gHTRUnb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAiS3P0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F78C4CED1;
	Tue, 11 Feb 2025 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237542;
	bh=vHmOMGFqOrzYxGFtXOCUBr10fhW5HjBijPMuOMBNbEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAiS3P0gnWP6GFb45aH+ouEGOIvzZzMohhON5ci/ggH7UsydFewBvSxJNXQaoNZAw
	 hUuVrXAAt3IrCBuurmEgLOkz0PGCgPfdpnUkhpJ58LFDerVeW+aP2deRLoqucTDoF6
	 rDuvfcz9o4Py7Iil/t1vx1DIu5EvzgNfVcCmQgL6xzx7kTPOQ33927NwNLv87RjQ/B
	 4ODSgKkM+elGQCqWfMXLJZvUTVBSauQt2uP7+O7T/Ttx6NXXqqPOZEKLDvIVOgvbiT
	 uPD7A7Vq0px5eojBghvIWhIC/hCQ6k+F/GlDfoSNwrkds2YoYKwUjW8D2DspUVFrAp
	 MQpMvzGNZTRyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 09/11] smb: client: fix noisy when tree connecting to DFS interlink targets
Date: Mon, 10 Feb 2025 20:32:04 -0500
Message-Id: <20250211013206.4098522-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013206.4098522-1-sashal@kernel.org>
References: <20250211013206.4098522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
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
index bfe7b03307d45..1fba7bfdcd58e 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1999,7 +1999,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 
 tcon_error_exit:
 	if (rsp && rsp->hdr.Status == STATUS_BAD_NETWORK_NAME)
-		cifs_tcon_dbg(VFS, "BAD_NETWORK_NAME: %s\n", tree);
+		cifs_dbg(VFS | ONCE, "BAD_NETWORK_NAME: %s\n", tree);
 	goto tcon_exit;
 }
 
-- 
2.39.5


