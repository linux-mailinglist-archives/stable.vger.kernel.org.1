Return-Path: <stable+bounces-77134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F29858B4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E779E1F23EDF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968D17E919;
	Wed, 25 Sep 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTLi0yHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1E190692;
	Wed, 25 Sep 2024 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264277; cv=none; b=U+FcnBbDsZM04RAggnNvDVyhfTE1q+XFSSqyBaieIry8ddgZvP5G7BM8R+suD60YHij+yL9/tpeLQNPcVrt3eFWDNQsTQI+XK/E3G64soM+f16MHbOwD7ff3hs3r1cE5Jcl5uvCH63R8iKrQ3peEv4kbYbepabVeLE3xJTtVZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264277; c=relaxed/simple;
	bh=T8YWGs608Nvuxt7bBkYsdcjeiVaMHtIqyk5FKANhjfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmkI9y0OOcmdDQ9VRnab5ZR/qC3KaqylGE88+/Zyk2L4u5gj7Kkn5oNKx1jBpReRa31HiEhS7rE02JGiBWRSBV+LRtxIt9K78grBiJllPa4rvy/qeH+28ZQ7yNqR9gb2DD5VcXRdmLKXPCbV1MsukXEuZI9GrJfszT5zPczTfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTLi0yHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D9C4CEC7;
	Wed, 25 Sep 2024 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264277;
	bh=T8YWGs608Nvuxt7bBkYsdcjeiVaMHtIqyk5FKANhjfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTLi0yHVzNUF6xbCJ5PL29UaT0CqeieB82UOSAfxr9qEscy1BXGfNaZTth+3E4Zoe
	 FsxOoudT+995dBTORXtcCU5+mVhd6+CyRFSQ/ldbve02wwQfJi0qJ7l1Oury5vrcpY
	 vm//6vxiV6s+2hAN2T4nb4JeG63mGM/G4aNZCcyfqYyxw8QnuLdRbSY17qteh5GVM2
	 aV1KNQEENpTFJMJdese8Jb1xcE1qD063q0C16ai1O+MSwoTwG/Akhv4IytlD4VswFs
	 7QgQZsGnkXNwN36LZeA8DxmGpLsDM8KzFYFgZbXCP3Jonx5MzsDdami39AtZj+MF30
	 qIhyyqTyy2rFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 036/244] l2tp: don't use tunnel socket sk_user_data in ppp procfs output
Date: Wed, 25 Sep 2024 07:24:17 -0400
Message-ID: <20240925113641.1297102-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: James Chapman <jchapman@katalix.com>

[ Upstream commit eeb11209e000797d555aefd642e24ed6f4e70140 ]

l2tp's ppp procfs output can be used to show internal state of
pppol2tp. It includes a 'user-data-ok' field, which is derived from
the tunnel socket's sk_user_data being non-NULL. Use tunnel->sock
being non-NULL to indicate this instead.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/l2tp/l2tp_ppp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 4f25c1212cacb..5351680425e8c 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1514,7 +1514,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
 		   tunnel->name,
-		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
+		   tunnel->sock ? 'Y' : 'N',
 		   refcount_read(&tunnel->ref_count) - 1);
 	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
 		   0,
-- 
2.43.0


