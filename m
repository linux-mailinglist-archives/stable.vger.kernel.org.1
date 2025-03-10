Return-Path: <stable+bounces-122974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA49A5A246
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E4E3AF0D3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9BE22F3BD;
	Mon, 10 Mar 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s26+MWlR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118B1C3C1C;
	Mon, 10 Mar 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630678; cv=none; b=QfXZxsvrdOpqwAqNP+G3dQ4L+KF4JAConCtIcjFiOTMR/DBEchWirIgcze+reWrl1gp23zMuJTunFnWLP9fNC/z5jupWt1K/XI7RRsFqoKxKNFBEYqX3sB/O4n8nclh81wgOaTC8GBKLZrlLWQPeQkPY1Auod0o9QH4+LkjtT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630678; c=relaxed/simple;
	bh=RxFCCEGDZxrS1DDewubrzygLv9C6pZDCtMdHp5R+sis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwNe+gvNEPDx+3skK0VKeD5YyaRk32OQH/NUugbC639+qi6cZTmt6USZtjq+ktQFaXe34iJ4Y5cReKTqtoYl+5ROR7oaLssX7OeTMuS3+gt8ZQNA4gE43YdiMZacNIazAuDA04mlYbv+BdSRrSKDZak6/vRWhKAE7YVY1X2rDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s26+MWlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E8AC4CEE5;
	Mon, 10 Mar 2025 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630678;
	bh=RxFCCEGDZxrS1DDewubrzygLv9C6pZDCtMdHp5R+sis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s26+MWlRPNyaWDa8I5ZJcC4lasvWMZTaoGvdpxw/CTbZHD4QL3zC9l21btLu5jLit
	 Yx49xQ6xwhtOWcI3P5OnPX8qwgx9qpBx0b31gm6C2KpeWkHHCFc6vpawbg7WKmCn5O
	 dD1v44VUsM2KPiM72hmzTSm94xDikA27xWSU+134=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 498/620] afs: Fix the server_list to unuse a displaced server rather than putting it
Date: Mon, 10 Mar 2025 18:05:44 +0100
Message-ID: <20250310170605.227746704@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit add117e48df4788a86a21bd0515833c0a6db1ad1 ]

When allocating and building an afs_server_list struct object from a VLDB
record, we look up each server address to get the server record for it -
but a server may have more than one entry in the record and we discard the
duplicate pointers.  Currently, however, when we discard, we only put a
server record, not unuse it - but the lookup got as an active-user count.

The active-user count on an afs_server_list object determines its lifetime
whereas the refcount keeps the memory backing it around.  Failing to reduce
the active-user counter prevents the record from being cleaned up and can
lead to multiple copied being seen - and pointing to deleted afs_cell
objects and other such things.

Fix this by switching the incorrect 'put' to an 'unuse' instead.

Without this, occasionally, a dead server record can be seen in
/proc/net/afs/servers and list corruption may be observed:

    list_del corruption. prev->next should be ffff888102423e40, but was 0000000000000000. (prev=ffff88810140cd38)

Fixes: 977e5f8ed0ab ("afs: Split the usage count on struct afs_server")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
Link: https://patch.msgid.link/20250218192250.296870-5-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/server_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 4d6369477f54e..89c75d934f79e 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -67,8 +67,8 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 				break;
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
-				afs_put_server(volume->cell->net, server,
-					       afs_server_trace_put_slist_isort);
+				afs_unuse_server(volume->cell->net, server,
+						 afs_server_trace_put_slist_isort);
 				continue;
 			}
 
-- 
2.39.5




