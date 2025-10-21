Return-Path: <stable+bounces-188537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72446BF86D6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2894850A6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B8274B30;
	Tue, 21 Oct 2025 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ik1awKbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF98246798;
	Tue, 21 Oct 2025 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076722; cv=none; b=kuSZcQZduPi+XGqaej7wBshKKC/MYP1uAmsqdOHbqCEHE4i8O9F/XWb+UKtTwR41IkC5iofuMMmsMARoDaep3Kjmm194NY1XKQ6uA+5+8Dd60KINXltcFwIHEanOq1dbkK7i0gTzsgib8DNcbRd0THLiF/rc9ZWPVZ8g7Bjopvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076722; c=relaxed/simple;
	bh=W4iJNIzwg2zailRI9LlwlYvc4v/qpI4O3ML2UG28XWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/RfT0LIoZ36JniHLcgceLRLWCfW6wBYiiPh4QZs7+O1d2g5Ry5BTKJgNtZFMxZIVsPoH+T9mKxM04BZ8wAkFUChY5yAkkpmmi1kokT8Ul2Jg8Z7Zvw3p/mcF56LM8KVTc4RF3ecMuHCTciGbbLGgRQVuWMij5tDtwuI+zXNXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ik1awKbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FBC4CEF1;
	Tue, 21 Oct 2025 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076721;
	bh=W4iJNIzwg2zailRI9LlwlYvc4v/qpI4O3ML2UG28XWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ik1awKbVc+HMKnXaPNSpr4ljhG50yG6cVtVrz8MRQWKsYsfQe8FMeSG6fxTiVIrxt
	 KgaNOIipy1ZCAfpFlwrwJ1kyqqsYka+vovm6jYgtSAzpZ0Wn/pZP+krqH+K+NQG5AY
	 jmygQWPDd7tr4eq2xtI+ufUyah6Ng24S3IqQSFYo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eugene Korenevsky <ekorenevsky@aliyun.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 018/136] cifs: parse_dfs_referrals: prevent oob on malformed input
Date: Tue, 21 Oct 2025 21:50:06 +0200
Message-ID: <20251021195036.406937686@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -913,6 +913,14 @@ parse_dfs_referrals(struct get_dfs_refer
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
@@ -921,6 +929,15 @@ parse_dfs_referrals(struct get_dfs_refer
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



