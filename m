Return-Path: <stable+bounces-188472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3FBF85D3
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E66C19C37D9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984EC273D9F;
	Tue, 21 Oct 2025 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zstFfbZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54943272E7C;
	Tue, 21 Oct 2025 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076515; cv=none; b=BCcjknMMc89NrGWFXfWPi4dM1MclS447yz+JMV3TcCCY/Ox6a1NPgmBLSfI8huybCLwctt7ji6ZDmLBf+7bI5vcwl9Ep0+yHgKN6xnkIj3ZIf+tKTp0LfjQBhTx3EtSG/lp8kCkmkN7JthSQVOdxbLFFT0tyso7yBmgj9olOw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076515; c=relaxed/simple;
	bh=0qJ/q5CD8a3mXPcGrOZLu/P93tAVKVdrJsbr4UEfoRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE8qcJlxTyT9vvyuAbr3OBYePcpLjBu+E4mvXoXSEXuSQcw9xA2bBd4I81o4kuWQBIuodgP9X9FC5K3sw88dA8X8r7VFc8k7EFggwdswnP6vBHh8TO4EpNn/JVKmegQIlQLWKArwcSKty5WU13y+b2+Dwr/6tgxhYI4vNCCiXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zstFfbZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7570C4CEF5;
	Tue, 21 Oct 2025 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076515;
	bh=0qJ/q5CD8a3mXPcGrOZLu/P93tAVKVdrJsbr4UEfoRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zstFfbZv0Xj81difs2GQ9Jh5ltpuie4s5S6zucdT+gV5hCfeQEQ+5EuUMvgF9oIId
	 hZpPgv2wGPhnXigzS5gfz69tQVMIGNxXztungnVNvMFGLILNdU+cBEaGGRzTMEHRE+
	 mG/RRFzCCrypK9nSgNZVPn+9yv9eiUUUntkP/44E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eugene Korenevsky <ekorenevsky@aliyun.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 013/105] cifs: parse_dfs_referrals: prevent oob on malformed input
Date: Tue, 21 Oct 2025 21:50:22 +0200
Message-ID: <20251021195021.805581253@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Eugene Korenevsky <ekorenevsky@aliyun.com>

commit 6447b0e355562a1ff748c4a2ffb89aae7e84d2c9 upstream.

Malicious SMB server can send invalid reply to FSCTL_DFS_GET_REFERRALS

- reply smaller than sizeof(struct get_dfs_referral_rsp)
- reply with number of referrals smaller than NumberOfReferrals in the
header

Processing of such replies will cause oob.

Return -EINVAL error on such replies to prevent oob-s.

Signed-off-by: Eugene Korenevsky <ekorenevsky@aliyun.com>
Cc: stable@vger.kernel.org
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/misc.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -922,6 +922,14 @@ parse_dfs_referrals(struct get_dfs_refer
 	char *data_end;
 	struct dfs_referral_level_3 *ref;
 
+	if (rsp_size < sizeof(*rsp)) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: header is malformed (size is %u, must be %zu)\n",
+			 __func__, rsp_size, sizeof(*rsp));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
+
 	*num_of_nodes = le16_to_cpu(rsp->NumberOfReferrals);
 
 	if (*num_of_nodes < 1) {
@@ -930,6 +938,15 @@ parse_dfs_referrals(struct get_dfs_refer
 		rc = -EINVAL;
 		goto parse_DFS_referrals_exit;
 	}
+
+	if (sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3) > rsp_size) {
+		cifs_dbg(VFS | ONCE,
+			 "%s: malformed buffer (size is %u, must be at least %zu)\n",
+			 __func__, rsp_size,
+			 sizeof(*rsp) + *num_of_nodes * sizeof(REFERRAL3));
+		rc = -EINVAL;
+		goto parse_DFS_referrals_exit;
+	}
 
 	ref = (struct dfs_referral_level_3 *) &(rsp->referrals);
 	if (ref->VersionNumber != cpu_to_le16(3)) {



