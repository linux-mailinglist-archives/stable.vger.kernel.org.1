Return-Path: <stable+bounces-66251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6A94CEFF
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693011C214E4
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26B191F9F;
	Fri,  9 Aug 2024 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6EacNLC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63A17993;
	Fri,  9 Aug 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200896; cv=none; b=lALAjltFenfiOY+LjQOXAbIXf1EgtMoTLIPQHZetGkAC0eXWHgTfWKHoadvJYIJ62YY+IXMOS2wOQ1SsrN9Ygim/0g59ajai+lup2SUDUagOJ1Avuel+jWCQtC4rxs8LsPjVez8NssY1CRGmFKmPHAJP5h0tcESE6h/vXT59rhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200896; c=relaxed/simple;
	bh=M/vr8qHa3wzNagYHd+xP2S0ULxXc8E1jCEtpCjR29JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOl+uIqGRi9dhR9ssDz/q7wQYJufZ87Zqk4/QLK3rt/9959myczOuCuMc2v7xKnW8On6uRJw0GvrcSTVB8r0pa2FitRTaKx+Gh4Kg1+CqspQlvnvfA2w+4BRNpnh16/uN9n/veXzdchowyDtbN607+qKnGuWndmTSoFe1s9Oymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6EacNLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249FDC32782;
	Fri,  9 Aug 2024 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723200896;
	bh=M/vr8qHa3wzNagYHd+xP2S0ULxXc8E1jCEtpCjR29JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6EacNLCirkLmUxea6QfChba0VoYB9inR86edXCmgLSYfZzUCuPJs8hvF1SnJEEob
	 YvLoqeob4bBfJpKgcVXXk+e3RyC1MPK9GTaN7Mo5lGe5if90Qd1bETGBY1uoimnBWd
	 t4u3nXCFVyg1SdVd8ERN28WY3Ycp4+y5GiPplQTMfFc7QMgxX2SoRDQ5Sm8q3xD2LD
	 Ano09GdwQu21u4h6IHWSixNAHHHCLbESqWfzSHVzrYlrjHcM1Qu9ORp/NDMHg0Q1n8
	 o0B/vdfsrgrJOHUJ2DLxRHOKlJNY0GRkDddvsfwpM/8nJpkJWM7Y50hgSdSqGZ75Qh
	 S7M9p3hnoIksA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.10.y] mptcp: fix NL PM announced address accounting
Date: Fri,  9 Aug 2024 12:54:50 +0200
Message-ID: <20240809105449.2902071-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080706-omnivore-undermost-43f1@gregkh>
References: <2024080706-omnivore-undermost-43f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=matttbe@kernel.org; h=from:subject; bh=w/nK9ybIYefSz/Kc8t7m2S7r4+6PsR6u079/vtr+paI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtfV5sWXWKJeMinh47jAo1nBevex0xh6kCIB9w RoDHa+tTBeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrX1eQAKCRD2t4JPQmmg c9tFEADkG3NYDocOEH2eP4rmaq6Zuj9pbwUoI8A1RVOijT1gdIL8k0DFUMfc1O3j+1DrJuwRoMy LSqzhwxdgKd2O6ZTU4lnHixPkw3C7wo+X5zd8lKUjcwm3Ttbzqi3slBhVGfprC3mk0MqrdWSlFM pF2SERDZpEVYc+LST+ZZD7C5c8SeNs2CKeS8/ywMY75ZicaXIglC82aj/khr5LPxbCsxwHoExrQ XTk/Ps2fG9399xyYrCyeTUpW+VhzvWL8dMXg0QHxljRcbbp2XCSU1KXmRq7iP6SeEmxIsnrurHp LY3Uwa6b7sUSNexUkqYrb2lUIF3tSz7bCExD6b3gW6WoEIYjBrj1TaGfBIm4aD38fgyaQQGDNk4 tL4aVGSiDAQUFmAFHtFyEWIdcisA36C463TcNpXVrlaCB1reSfPJ/5R9t47joGmLErsYHzPcb86 PZD/fUVXDbpObRO27l96LuxGYV+jOEnxmiwygNoVYeWdJbCjXaXrpCPZR6EBJcwp9K6UnzMTBH/ xU7IScnlhvMmsjS0Rk9ph4R9z2fOT70yGEh4YAEwbEUqzx8Pve1nqUGO+xS84bGfYv7dzZrVAmy uG8Dx0Oi6JbgVKjA/5zO724Hfq1O8jUALItXp3URIhztHt2txJYCLbQi61Os+JkzIP+u5ViMbVg 73KdlGPM+XNdV7g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 4b317e0eb287bd30a1b329513531157c25e8b692 upstream.

Currently the per connection announced address counter is never
decreased. As a consequence, after connection establishment, if
the NL PM deletes an endpoint and adds a new/different one, no
additional subflow is created for the new endpoint even if the
current limits allow that.

Address the issue properly updating the signaled address counter
every time the NL PM removes such addresses.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ Conflicts in pm_netlink.c, because the commit 06faa2271034 ("mptcp:
  remove multi addresses and subflows in PM") is not in this version.
  Only the modification in mptcp_pm_remove_anno_addr() is then needed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 452c7e21befd..7f4d84f5189b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -759,6 +759,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, addr->id);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-- 
2.45.2


