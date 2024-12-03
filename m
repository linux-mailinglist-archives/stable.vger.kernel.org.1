Return-Path: <stable+bounces-96710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FD9E20FB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A2E284D35
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18C1F7547;
	Tue,  3 Dec 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gkc6mO6y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAA1F130D;
	Tue,  3 Dec 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238364; cv=none; b=FtlIIL5+5Dl8l3oQBaTn+uX4rn41JBHspRQq1ANAC6KNx7ZmWPlT7/iGbGlOlGpdwBCoEd9tIC+uI04bmml1KyVmhqpfa91z3WBMWF/2n5UrcktD/553XViZtkwUpaSlwwBiKP08QdvEao0hfd+Sc3gaELi2I+wodKMbNN7+TLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238364; c=relaxed/simple;
	bh=7H+g/N6EoHqyrf+4TPl1bGtRVasI9sNYt9gD+2IrsCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMu1LZEi+K7vtPoUIAmS48AQ/NVfDwtV218ZWFn3AQntUM6KaAHLKLCbVQbKIktts47Xi7ulfolgUj7KSpqCFIKAI6yapI2qv+LgLap9PjgflexXttfU7wEFsudqy6C0gk+mYuDNcc9EoRRIGNDuPYkoI1lQ7mgJr20K1Yj15oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gkc6mO6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F94BC4CECF;
	Tue,  3 Dec 2024 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238364;
	bh=7H+g/N6EoHqyrf+4TPl1bGtRVasI9sNYt9gD+2IrsCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkc6mO6y9jUj6N3fQxkfDOBcZ98DgqQ0HOKRzRt4GWuQU8WudIP/+TSW1NQAcXe2O
	 ZpwxlB+m6x3Z5nnYGI2DV0S/DUNw8cIs6lvSjGHHemz0V/V15WJcqJpOdbxjh7TFSL
	 iEVD8WXgFEnBffpop9UeTnjbcEp5zLR4crJ+VYsE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 254/817] dlm: fix swapped args sb_flags vs sb_status
Date: Tue,  3 Dec 2024 15:37:06 +0100
Message-ID: <20241203144005.685888229@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 6d59f2fbfb18965f76ebcff40ab38da717cde798 ]

The arguments got swapped by commit 986ae3c2a8df ("dlm: fix race between
final callback and remove") fixing this now.

Fixes: 986ae3c2a8df ("dlm: fix race between final callback and remove")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 742b30b61c196..0fe8d80ce5e8d 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -30,7 +30,7 @@ static void dlm_run_callback(uint32_t ls_id, uint32_t lkb_id, int8_t mode,
 		trace_dlm_bast(ls_id, lkb_id, mode, res_name, res_length);
 		bastfn(astparam, mode);
 	} else if (flags & DLM_CB_CAST) {
-		trace_dlm_ast(ls_id, lkb_id, sb_status, sb_flags, res_name,
+		trace_dlm_ast(ls_id, lkb_id, sb_flags, sb_status, res_name,
 			      res_length);
 		lksb->sb_status = sb_status;
 		lksb->sb_flags = sb_flags;
-- 
2.43.0




