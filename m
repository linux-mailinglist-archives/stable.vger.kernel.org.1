Return-Path: <stable+bounces-208503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65C9D25E36
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D58B3019BE3
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEDA3A35BE;
	Thu, 15 Jan 2026 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBcPsIe2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034731C5D59;
	Thu, 15 Jan 2026 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496035; cv=none; b=Qr17+/Qygz/lA25niNJxO5+IfT0D9iDlViyDZTK8uCk5VAIVmJtJVa2pPP6hL8nAKGvnUS9Ab5bdxFIW8PIoV0OZkyGEnpgyF3bl0oi8g/bwgA3NwjAf2/vSw9k2+fhoyIopKSpHCAwdDtGLYBx8gxYm9j34vZBd3ShYAIIs7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496035; c=relaxed/simple;
	bh=h86JH/kMNGjPay2dJl5Qlk5q+7WO7jYXtybRxB95OwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwb2Br/oE9TC+1mv2kqHjeQEbpmKt4YdbFW8GK9rhuBgFG0kx5BaPEvGiUUp5SxfwLpkjL8Rd2RKi1Nik/1hcGCxQyC872zT1SN1PbL2maNaqr513U174IA+XnDpaI2FG2eMkzmPxr0tJmrcA02rGhq4plWihWqvz5hNmQSxhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jBcPsIe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87491C19421;
	Thu, 15 Jan 2026 16:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768496034;
	bh=h86JH/kMNGjPay2dJl5Qlk5q+7WO7jYXtybRxB95OwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBcPsIe2VpUlzRg94949IBtnZiVIRjFyZfZsYYY543uKjBt5wNbyfiM9vj3Fqba8g
	 nHPaCBzE0elBJhRdi31rXXBGeG7PuCJa1smuwYr0VMHrCFS0zS/ER43TtAJXd4m+tY
	 nV+CLZaVYXnh8RVCCU4NLH5hvrpdQ/6dWlhBIPFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/181] NFS: Fix up the automount fs_context to use the correct cred
Date: Thu, 15 Jan 2026 17:46:31 +0100
Message-ID: <20260115164204.279463558@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
References: <20260115164202.305475649@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit a2a8fc27dd668e7562b5326b5ed2f1604cb1e2e9 ]

When automounting, the fs_context should be fixed up to use the cred
from the parent filesystem, since the operation is just extending the
namespace. Authorisation to enter that namespace will already have been
provided by the preceding lookup.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 9e4d94f41fc67..af9be0c5f5163 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -170,6 +170,11 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	if (!ctx->clone_data.fattr)
 		goto out_fc;
 
+	if (fc->cred != server->cred) {
+		put_cred(fc->cred);
+		fc->cred = get_cred(server->cred);
+	}
+
 	if (fc->net_ns != client->cl_net) {
 		put_net(fc->net_ns);
 		fc->net_ns = get_net(client->cl_net);
-- 
2.51.0




