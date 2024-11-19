Return-Path: <stable+bounces-93940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 815009D21AB
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47430282F64
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFD6198A10;
	Tue, 19 Nov 2024 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjvk4O8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17D1885BF;
	Tue, 19 Nov 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005367; cv=none; b=KsZEUQQ6QWVdF8ou9hTIT+K6biVeBhdl+1cH9Ke/sh26vYOlv5sHFlsmOv+t+k9aP3nlbWJChao/8fTgR+C+vFxoG3+8gfbCSeS+bwd+0GwVQSof6HtFMDk8wqWH23O4iYtnFeypx/Z+YhCGxzcde8TJpYI6HmsNwchqOuoW4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005367; c=relaxed/simple;
	bh=20Lj9jc3IvytiHT8Hf9XMs0G3Qm7XasUxrotdB9Zr/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk6xeS6R75l+ScvXe5PkXey5ykWaEtQV/J0bIT9/vxoJd0bBjTUxPLpWBGgH8rtgjd9MmVywJUnTZ9uu8UqwuFYbj1pWEkJ1BXiMr1iwMHASxW0FWqp4QsmhtzwkUOZFYhOXe1pdeVDwQiHRczO4hcEFGdIDyx1EDgs1U9720p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjvk4O8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA38C4CED2;
	Tue, 19 Nov 2024 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005366;
	bh=20Lj9jc3IvytiHT8Hf9XMs0G3Qm7XasUxrotdB9Zr/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjvk4O8VTqoNkqY+izB4ZMlGuCGoQ2HxS3/GwO1gxLQ0Yp6DquJ3nr756+S2/E1R9
	 t4b6my/w33n9TKk/pfZcW59OWu5JR3PCzuUAzyoxgR09zTE2zyrZO114jTYiSSOCX/
	 dhmrdAQgAR+z9dl5rZGOGy3dz2tU3rTFwstJ8On/EqLMZSshLMuTAw/tN5nvUm1pX6
	 4s7q0lKjW1UIuh/9GLWyFhPHWkQstq9FT+d9wtLUXG4hKzYR5vhPuGCWRSQnlf+Ix9
	 2BJ2vbMsZSm/BExLP00/IMn+R/Kinm5PXicFUsMfno7hNnw6LdaQ9rEs5TRVfE+EO0
	 TYTdC9pi3P6vw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 5/7] mptcp: hold pm lock when deleting entry
Date: Tue, 19 Nov 2024 09:35:53 +0100
Message-ID: <20241119083547.3234013-14-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=matttbe@kernel.org; h=from:subject; bh=aMO5NOvmxw6Q0jjN75Cvmc36iLaQOTTBJf/lO1QIrKE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3kdOwNK/w7Ko20Wu6zD7aFhm6aH50aBRFdu Af96CAVY6+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN5AAKCRD2t4JPQmmg c7fKEADGAHXSguz/4Yui/U5piMFsIG2TWGliuvnGuqKP1oEgq8XjqN9QkGSRPirPha3qg2RK6Oz 1XHvHo0i+sJsJp4DK3W9qGAlA9EMULUB1lHgfogxnXsEqapS4BVH2jBBqkGJ4wfw4p1z5kaxar9 51ItMTv10lzUBH1endKWsr0UDx+2XAE0nZIYpeJyPkNsQ/WdGm23wRyAFhuI6tegnUe7NXvMj3e h/kduWEyShTK9eXr1wSKaM5b3/MZwQgC2VWMurVn9gvALhsqrkGPR1fDKRgNH69yfqQmhoC8OSf 8/9KWvDxdE4gKOC8asyJG4m0SH6QtPSwlDMXncQkqM49rtAo8gYmwbdijPAHVR+QjxExD9bcBlK vshJf30yPVm0ACor2NLef8WY/hxzG4w71qM6RQyz9ODRYIzPhLwsu+VyyrgNc41FxSprZ3tQuRz /R/hXRPBPfEqBh9OEyO2v+Rb/wDSxtPAcvd1eZ5PHx8CN5Ws0laIue+AJ6EgMPEft7XJVN/hZMK DZSoxCGKD5Ms9ObbibauomhJG6Lq9aVuny3DL25L9Gmr9lfydcp6bXtPdAdfNLK1LbqqBbr1APz 8eUB43DxSBssxAyBt+NvGYc6fTVWQSvT2NSS8g/BmGklgKCl/eZGPtDCtasrJV9B8ru3dLPMfIi rQWrGnpkPIj8HgQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit f642c5c4d528d11bd78b6c6f84f541cd3c0bea86 upstream.

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.

This patch holds this lock before mptcp_userspace_pm_lookup_addr_by_id()
and releases it after list_move() in mptcp_pm_nl_remove_doit().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-2-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 195f84f16b97..9016f8900c19 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -326,14 +326,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto remove_err;
 	}
 
 	list_move(&match->list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-- 
2.45.2


