Return-Path: <stable+bounces-77377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4A3985C76
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CB31C24500
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB9C1CFEC8;
	Wed, 25 Sep 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+fNX+q7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79911CFEBA;
	Wed, 25 Sep 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265577; cv=none; b=upMysds1+hD1armW/dPQMHWsHw4/jsl/Y0bAwXWKgl2DBX9eEXC/coHAoGDV+QJpHQh18Jd19igeEzioyXbDkhHW9WEYBsB8rdBVB4yXdauFyOW8bRS454Xxl1T70Y8h5ug2V+wNXJqEieVxl5cKpXf7e1UtaP4X4n7/o9e5MyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265577; c=relaxed/simple;
	bh=TTbWIZdXyMpVuDN8EeQgVRhdDYyXSiHziBvITL0YI6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKyqKm2CBmk0M+5h++vPzlAIYlhW4we4aprd0iseVIebyXsWLHxuIZAJ0zIQVxTEYyLcDCUufLD1623dL/oO589q1vQ7YFAW0By0N4xiDunbetTg7oG6AQCeUh8AxaCqHYx/iH8AhxJxKVsSF0eCWU1MT60tQSQOhbOEcmOOaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+fNX+q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E33C4CEC3;
	Wed, 25 Sep 2024 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265577;
	bh=TTbWIZdXyMpVuDN8EeQgVRhdDYyXSiHziBvITL0YI6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+fNX+q7ghIVcBDI2dEQcmGMLoRyvuAwKilbsxQ2WzPodcBpgawpKof1xvuHWI+YW
	 NQC9TRyEzsauzURxVGZW9ujEteacAVLlGl3N2wWPHO/pGAlUxSYz7Xfa628NI+z76j
	 0AvvK1CsdWFbgmJUllSDAq9aw4G1KkaZcUY8qaRctmar7XId3mNaebF+E9KaQTQUHV
	 CIIUqK1fEyCVT5ET8/ti+cL9pHgBY1+Clh8aoM9J5gkSXJ5U8frchAgKALPAXxw/rH
	 xfdzg+MZSx0fANrLhB7sFQ5bQV3U7ta0YaOMgK812lWVFDixSfZg5L6BymNGJAFrkx
	 KF/ETkfvM/nqQ==
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
Subject: [PATCH AUTOSEL 6.10 032/197] l2tp: don't use tunnel socket sk_user_data in ppp procfs output
Date: Wed, 25 Sep 2024 07:50:51 -0400
Message-ID: <20240925115823.1303019-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 6146e4e67bbb5..6ab8c47487161 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1511,7 +1511,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
 		   tunnel->name,
-		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
+		   tunnel->sock ? 'Y' : 'N',
 		   refcount_read(&tunnel->ref_count) - 1);
 	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
 		   0,
-- 
2.43.0


