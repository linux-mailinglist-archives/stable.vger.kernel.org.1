Return-Path: <stable+bounces-184816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D7BD438D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FF0188889C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94503090C4;
	Mon, 13 Oct 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2EfsL5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A25223DC1;
	Mon, 13 Oct 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368517; cv=none; b=tNu2pLsoA5VM5FZszENYNRMM15zPPOdgPTbk5JwW8aYi42FZw6TF+Ri6JHrFPquP+MZIn6jC2O19d9+GJIEslZ83XblqwaPvitFYve9B75tQQ1ATIAnIarENXGoEQcf+zmLS/m8FpiG91Z4HlsD6Gcfp9y8I6St61KOW6opXzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368517; c=relaxed/simple;
	bh=o+z99hE7i8E7NGVRlZNCtv9XxxvAjDW6sT5p0aztYpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac6BW/tPnpH21XhTT+QvdC3Mr9bVQCf2n4fDxfYsxOoGXU+UsF7Qfd/vYEj0oGMHgELGoJ5x/aaXqssyWmiSkQxGke7pRj2eQYbcCFkm/r2BJHnAByOzRsqyZEpqX1ckcQ4/gFwd+iRmoM/df1t18tQJUHXDpXVGbvvHQ95MoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2EfsL5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9898C113D0;
	Mon, 13 Oct 2025 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368517;
	bh=o+z99hE7i8E7NGVRlZNCtv9XxxvAjDW6sT5p0aztYpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G2EfsL5pE/tX3LzUbzxFXwLNgeaafAezR+1jjYGshMQOcoMjilFhcN3X/EcVo4h9g
	 eo7q5e4DUfJcl/zVq5Z6S3rYSAWJCx7B8TJtsSKeAXaWWS4ZI5sd8au82OqKiMvkUG
	 CcVEWPf1Gun+sdpwuoT5Ox3nWLsLDAjxKA94IcGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthony Iliopoulos <ailiop@suse.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 189/262] NFSv4.1: fix backchannel max_resp_sz verification check
Date: Mon, 13 Oct 2025 16:45:31 +0200
Message-ID: <20251013144333.056302100@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
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

From: Anthony Iliopoulos <ailiop@suse.com>

[ Upstream commit 191512355e520dfc45c8bc3b56d4de59c3ade33e ]

When the client max_resp_sz is larger than what the server encodes in
its reply, the nfs4_verify_back_channel_attrs() check fails and this
causes nfs4_proc_create_session() to fail, in cases where the client
page size is larger than that of the server and the server does not want
to negotiate upwards.

While this is not a problem with the linux nfs server that will reflect
the proposed value in its reply irrespective of the local page size,
other nfs server implementations may insist on their own max_resp_sz
value, which could be smaller.

Fix this by accepting smaller max_resp_sz values from the server, as
this does not violate the protocol. The server is allowed to decrease
but not increase proposed the size, and as such values smaller than the
client-proposed ones are valid.

Fixes: 43c2e885be25 ("nfs4: fix channel attribute sanity-checks")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ea92483d5e71e..c21e63027fc0e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9393,7 +9393,7 @@ static int nfs4_verify_back_channel_attrs(struct nfs41_create_session_args *args
 		goto out;
 	if (rcvd->max_rqst_sz > sent->max_rqst_sz)
 		return -EINVAL;
-	if (rcvd->max_resp_sz < sent->max_resp_sz)
+	if (rcvd->max_resp_sz > sent->max_resp_sz)
 		return -EINVAL;
 	if (rcvd->max_resp_sz_cached > sent->max_resp_sz_cached)
 		return -EINVAL;
-- 
2.51.0




