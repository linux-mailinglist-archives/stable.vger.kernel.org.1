Return-Path: <stable+bounces-3393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F97FF568
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4304B20D1E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21420524C2;
	Thu, 30 Nov 2023 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thSyCQTo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9C54F98;
	Thu, 30 Nov 2023 16:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFBCC433C8;
	Thu, 30 Nov 2023 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361718;
	bh=xSB05A5xO2bK6qAWEvbhTZz1Njho0Ioc4rfVo8rweCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thSyCQToJ+fWpaHTchStT4+uXiGeIzasTaKk+DHzHKNtXrjs5qOk9FFYGiRYNWRa9
	 mg++viNKumAAZ7VgAVn380d5yVhwFfP7BPjSKJtL6oeOsZV2Lf1m7Lk4jPTrCgeJyW
	 VgA9qMxko8vB/ZhUVZonree48+Pzs5WGxGJNgiJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Suvanto <markus.suvanto@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 02/82] afs: Make error on cell lookup failure consistent with OpenAFS
Date: Thu, 30 Nov 2023 16:21:33 +0000
Message-ID: <20231130162136.060387518@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 2a4ca1b4b77850544408595e2433f5d7811a9daa ]

When kafs tries to look up a cell in the DNS or the local config, it will
translate a lookup failure into EDESTADDRREQ whereas OpenAFS translates it
into ENOENT.  Applications such as West expect the latter behaviour and
fail if they see the former.

This can be seen by trying to mount an unknown cell:

   # mount -t afs %example.com:cell.root /mnt
   mount: /mnt: mount(2) system call failed: Destination address required.

Fixes: 4d673da14533 ("afs: Support the AFS dynamic root")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dynroot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index d7d9402ff7182..91e804c70dd0a 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -132,8 +132,8 @@ static int afs_probe_cell_name(struct dentry *dentry)
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
 			NULL, NULL, false);
-	if (ret == -ENODATA)
-		ret = -EDESTADDRREQ;
+	if (ret == -ENODATA || ret == -ENOKEY)
+		ret = -ENOENT;
 	return ret;
 }
 
-- 
2.42.0




