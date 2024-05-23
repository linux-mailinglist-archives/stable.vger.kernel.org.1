Return-Path: <stable+bounces-45898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D91008CD473
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9450C2829B9
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8414AD15;
	Thu, 23 May 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNkKngVV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995113B7AE;
	Thu, 23 May 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470680; cv=none; b=BlsMo6F8MK64tWb8WzsUasdJrupx9ZLG6BPCWjkXwPOHxJlg5JhHvDeB9Btw6FJn4AO5lOYWhtvgUKNFHw65aOTf2cMbn4eUuS0jvWpNXMUxNCIdixmAG3fCEHGqVNwn7Y7diJ3KiE7Y/DaZ6uycLwS3juXR3rljeFot0B1EmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470680; c=relaxed/simple;
	bh=6zFxNwKqyMz08RkLbHECnl4jxdZ60mQpLXzdrcaehBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jP0KLpLeFD5yBzF2pTCFe4TS71DZSbC/04xZ6iptPBHifMPdnawuq1mNaIuq65UT6qB65r4imrEqmqrLJbjaK4vtX30CtuREDZb90WB01SCQTzgGebhBWDajnIhpF1jkUg+Ryf7n3oV2B++AdHF+BoIKNehXQ7ruZmyxFNGE8Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNkKngVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35BFC4AF08;
	Thu, 23 May 2024 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470680;
	bh=6zFxNwKqyMz08RkLbHECnl4jxdZ60mQpLXzdrcaehBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNkKngVVzO3VqZNopN6QWi7dRjtCnfajWTeUjOPPd0mvNajkIdoX0y0p4ZBo6DpQg
	 BuMCb7iZfpDlroEBq5HhES18fsMn8dSavq6j1u9fpUso8LyhCmwjptbGLbO+qcdV6m
	 bvJTvOyADezLozJODBxZbpwmh3Aaipu0nYzt15GI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/102] cifs: fix in logging in cifs_chan_update_iface
Date: Thu, 23 May 2024 15:12:44 +0200
Message-ID: <20240523130343.187516949@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 516eea97f92f1e7271f20835cfe9e73774b0f8cc ]

Recently, cifs_chan_update_iface was modified to not
remove an iface if a suitable replacement was not found.
With that, there were two conditionals that were exactly
the same. This change removes that extra condition check.

Also, fixed a logging in the same function to indicate
the correct message.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index f3d25395d0d3c..5de32640f0265 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -442,8 +442,14 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	}
 
 	if (!iface) {
-		cifs_dbg(FYI, "unable to get the interface matching: %pIS\n",
-			 &ss);
+		if (!chan_index)
+			cifs_dbg(FYI, "unable to get the interface matching: %pIS\n",
+				 &ss);
+		else {
+			cifs_dbg(FYI, "unable to find another interface to replace: %pIS\n",
+				 &old_iface->sockaddr);
+		}
+
 		spin_unlock(&ses->iface_lock);
 		return;
 	}
@@ -461,10 +467,6 @@ cifs_chan_update_iface(struct cifs_ses *ses, struct TCP_Server_Info *server)
 		iface->weight_fulfilled++;
 
 		kref_put(&old_iface->refcount, release_iface);
-	} else if (old_iface) {
-		/* if a new candidate is not found, keep things as is */
-		cifs_dbg(FYI, "could not replace iface: %pIS\n",
-			 &old_iface->sockaddr);
 	} else if (!chan_index) {
 		/* special case: update interface for primary channel */
 		cifs_dbg(FYI, "referencing primary channel iface: %pIS\n",
-- 
2.43.0




