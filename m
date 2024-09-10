Return-Path: <stable+bounces-74873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA89731D5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB2828C80F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9818B498;
	Tue, 10 Sep 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hiol86lH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3F1552FD;
	Tue, 10 Sep 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963083; cv=none; b=pAsrw1ifalVMXotLwu4Bgo2b9yTOgPHbMS6I5D14FlbDFlRQGmsHl+v4a45Dshc6AEwkjuErSioa9JJb4TOZnrswcYwlvrEIc3dNJzVYTrvxk7+W/IAIE5THXGTlGv4P7L6kEkEv+T8x0XnDcv5+Hg0cP6avrd/5BsRezdd2iZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963083; c=relaxed/simple;
	bh=5DRWSpC2yBuqc53shjawERuvsjzNj9wptG51szFXDcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4iY8XivpC8gKQLKQ+AFUCxDKNPYZe/tFa1ydyhIqcq3ToZ7HOXiNIvw/tnm/ajYAMcdTgnzcxV89pk4hk/Tc2uYc+o4wyQVAJDElMcQxVNTJCkSlizMdUgjgSqHZ1U6vXx6eY9M5guudqy98+vrkvI29trXUBTAkKkjo6XsYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hiol86lH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D767DC4CEC3;
	Tue, 10 Sep 2024 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963083;
	bh=5DRWSpC2yBuqc53shjawERuvsjzNj9wptG51szFXDcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiol86lHn7lYwnDdUwMz94ydyqJMdjX6hOFFcFo61PrUFrE9cLHmrKKpsinBrq+DP
	 VJNaRxmVHg+XkflLzNMzIMq/+0QY3DAjkqv6JsHwfetPJExJroVVo6LCsz7240Yj3v
	 CWWbp+DpUdWWnMWgoHj0mWB6I0D9GcpSChM4MguE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 129/192] NFSv4: Add missing rescheduling points in nfs_client_return_marked_delegations
Date: Tue, 10 Sep 2024 11:32:33 +0200
Message-ID: <20240910092603.325822533@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit a017ad1313fc91bdf235097fd0a02f673fc7bb11 ]

We're seeing reports of soft lockups when iterating through the loops,
so let's add rescheduling points.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 05ae23657527..f7b4df29ac5f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -47,6 +47,7 @@
 #include <linux/vfs.h>
 #include <linux/inet.h>
 #include <linux/in6.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <net/ipv6.h>
 #include <linux/netdevice.h>
@@ -219,6 +220,7 @@ static int __nfs_list_for_each_server(struct list_head *head,
 		ret = fn(server, data);
 		if (ret)
 			goto out;
+		cond_resched();
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
-- 
2.43.0




