Return-Path: <stable+bounces-98489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4673E9E453D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F8B441EE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF33DABF4;
	Wed,  4 Dec 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czh3shEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69D3DABEA;
	Wed,  4 Dec 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332327; cv=none; b=kbRZ1QTpObi6aAKbqM1YdNX/uOHwgaTnASdDIF6XH4mhAO2sW6KGLhmxnMTP1DXPluVq/3B1MpCSDMQ7+TsEomBNRJolP0cqfA7nbcaQ7CaMadJgdFcprC5uDMAA6g/fgHf+ZUZv/vkjf1aPFQscFC3tfDmubDQhPv+QoXItOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332327; c=relaxed/simple;
	bh=Kdj8ZYQXb2wgy6ePNcx0/oAFu7VqFEnEy4hstoJ9W/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGFPLTv/OQ6I2QG6HKpzhkS54vv1B5u+jf+a12JyY+zhTlcdZi+nTaczUZ/9wL17Mmlu0shPEVwy5R2dqdDPzGnVb93gyfjPJ8Pu4BJ+DpEsUL7albwGWsPwumGl/fySmRIYThkAnpgo3BWHIRxXeqxDluKsFAly6YcFlpzdJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czh3shEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D4DC4CECD;
	Wed,  4 Dec 2024 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332325;
	bh=Kdj8ZYQXb2wgy6ePNcx0/oAFu7VqFEnEy4hstoJ9W/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Czh3shEY2rMieFdNZGh2U5jvPA2s6B2ibYSZsPIpOh1k+8M+b7NNMTx7aV/E4CxIa
	 z3XeFRkmNORVEHrp9v+KAGBtZk4Q47rzITAGIUQ/OvncOBrkKxGoTv78KAjiNaedtS
	 GtGX6/F1h56V4uRbLJ5MKi0vbrQpuZRfh/JtcHT3qQQMy8Rz5lMPSdoSpjOTqWiuns
	 kJ3bU9W6wLMH+FE8e48RTp3wKkx4sD1VvxTaA4H0dC4XHEhjOqz5ML3nHMKrpHBitm
	 Bkeq8QraAMeqYeF1Gz2hzlqQXvsPdEtyKAPw1KDiMKCarvNdp0gOVWPVVWcxeDKpv3
	 X/pnOQVvqwIrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qianqiang Liu <qianqiang.liu@163.com>,
	syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 02/13] KMSAN: uninit-value in inode_go_dump (5)
Date: Wed,  4 Dec 2024 11:00:27 -0500
Message-ID: <20241204160044.2216380-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Qianqiang Liu <qianqiang.liu@163.com>

[ Upstream commit f9417fcfca3c5e30a0b961e7250fab92cfa5d123 ]

When mounting of a corrupted disk image fails, the error message printed
can reference uninitialized inode fields.  To prevent that from happening,
always initialize those fields.

Reported-by: syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6678060ed4d2b..d60d53810bc12 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1537,11 +1537,13 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 	if (!ip)
 		return NULL;
 	ip->i_no_addr = 0;
+	ip->i_no_formal_ino = 0;
 	ip->i_flags = 0;
 	ip->i_gl = NULL;
 	gfs2_holder_mark_uninitialized(&ip->i_iopen_gh);
 	memset(&ip->i_res, 0, sizeof(ip->i_res));
 	RB_CLEAR_NODE(&ip->i_res.rs_node);
+	ip->i_diskflags = 0;
 	ip->i_rahead = 0;
 	return &ip->i_inode;
 }
-- 
2.43.0


