Return-Path: <stable+bounces-102062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E119EF059
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B94D178DCE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3671923695A;
	Thu, 12 Dec 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UBhHh4de"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BD2210DE;
	Thu, 12 Dec 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019825; cv=none; b=mQwCWHL43MxWmMOl/gW9n6hYm6sbqVswALBd5kpC//qAho5hyduq5RNdb98p9XgYhlWaaV/PLbEFqeSos8FRZFdcu4SdRSohjbDwm+RT3ioliNDHdalTBXn3+Bhv3ExTrAgvH3yoGlgBofE4hk8bjjDClWCIzZ9W1OIqtcWk0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019825; c=relaxed/simple;
	bh=B1trj24p6keq507aNCAY6WmWCevfqYvaKWhBfXpjCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxhSZLf0eDA/NgzdJqz+tB2PQt9jIlCEj4bwG+/HKvHQJNwjbSGIo78xy6cPhPZmFyGhZ0Ba3Dq+cZdqcFs/HQym8OVE/l2T2LLf0ddEQhLiBuBNrv0ZnHSQ5OELzaVaJcrN4NpPP8wOsmtzA+8JAlhRy1WEs1ZHSAC2fkaaP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UBhHh4de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D05FC4CECE;
	Thu, 12 Dec 2024 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019824;
	bh=B1trj24p6keq507aNCAY6WmWCevfqYvaKWhBfXpjCs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBhHh4deV1C9xvElUL6QQ3//6DAAR69wNLEJqXk4aD+xiNldWCjPh5aMtfY9FOKk3
	 Ofsm9PDT0NHp8zbhv/OTORfBxX7rkRNJgrRfHGnJvVMZc2zqBCNen63wyHTLbRe6Vc
	 xgJURrOam//agHN271HCwygMaFkteAFf1+oJ3APA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 290/772] NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
Date: Thu, 12 Dec 2024 15:53:55 +0100
Message-ID: <20241212144401.884635246@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 1e02c641c3a43c88cecc08402000418e15578d38 ]

@ses is initialized to NULL. If __nfsd4_find_backchannel() finds no
available backchannel session, setup_callback_client() will try to
dereference @ses and segfault.

Fixes: dcbeaa68dbbd ("nfsd4: allow backchannel recovery")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 4eae2c5af2edf..18d62d3424c1a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1379,6 +1379,8 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		ses = c->cn_session;
 	}
 	spin_unlock(&clp->cl_lock);
+	if (!c)
+		return;
 
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
-- 
2.43.0




