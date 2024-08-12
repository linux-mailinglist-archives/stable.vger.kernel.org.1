Return-Path: <stable+bounces-66730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340E494F130
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A431F22BF4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1F183CC4;
	Mon, 12 Aug 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI4OA9AT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0314C5A4;
	Mon, 12 Aug 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474960; cv=none; b=JyDsaDHc5AJRv3Nmh3Xfg/ybNtwUcNrsmdnGL1F2d0ltJIKCpkqsN3+05WWuZGDp1Ox3OECq3YORO+Ho9lhUAAUhE97NKSa97GThhgJIlIHxBgg5O0zBYxJQVtniaa2w7E0mxlFp+n+o+hHtgJVWgKHBAn9VK3+q44Ap+fCvNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474960; c=relaxed/simple;
	bh=fCUsuIBzscjkyioW2v5MMsmkAr95BekjeURnxa+kl0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6ro8RAQ9Gwm1x1Gg9cWvaYU9vBmNbJQzHuukzYV5cl6L3qQKWBXk78Z6NRBSxUWTn55fJr2DlHYUbc2bDK9BndgbkI/b2m5s1/LO6CYY1CBEQgxQ7uPhh0hDJ2yWeVBlmOADRWwqiAd/vHXUazRYv3zQD6IkuLk/AD8+ov1nTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI4OA9AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D898C4AF09;
	Mon, 12 Aug 2024 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723474959;
	bh=fCUsuIBzscjkyioW2v5MMsmkAr95BekjeURnxa+kl0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TI4OA9ATN8mgy6TBLn/EbTEw5Y7Zx3xLZ/RaedSbsT0nKDKBPsP2GTDM05kq2UH5e
	 NSoha1QLMLoPMiNTaYmrvIZYPmFiNL2mHLg+9TG4m1k03fzcKTBUGK5ZrZbj0ISnYl
	 n2D+DgXP3RE4Y3EnOp2wGFatSTQQUepgCWVQ0zXy1A+rWvI0ut5PjJLjX6rrVNbOef
	 VmusdiltJbStP9SzAN7o5qFk/crUDhYPHiXBjkTwdDCTVfFWz6rH4Mn3Gzb1ZKoh0s
	 X7DPINdF904ByvdTbrdPU6OlRFLhu5FKkP+bW7EM+a1vgoSMBpCrJfj9gEDjKWLYZe
	 znFYVSPi33hwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10.y 1/5] mptcp: pm: reduce indentation blocks
Date: Mon, 12 Aug 2024 17:02:15 +0200
Message-ID: <20240812150213.489098-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-smock-nearest-c09a@gregkh>
References: <2024081244-smock-nearest-c09a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=matttbe@kernel.org; h=from:subject; bh=fCUsuIBzscjkyioW2v5MMsmkAr95BekjeURnxa+kl0c=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiP1AD6UBgjzYpW/jJnP2cDRQiiLyqB6ooJOy iufL5udD4uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroj9QAKCRD2t4JPQmmg c9RWD/4473HmEc7RXprTagzDCQvJgrbEDnI9boEOy5yuokfDrjQbzb6TPzIm1sYHJpvqi1vQe9l ih5cg+e3OdeqmtmvMuJLrl3eTw8QqZOdVkyKKih+jtCwnzstasnP8a7+Ayj9h65nhBg6E8IYHuB EUOMg+U4qkL8mo86lpeWejeHtVezpvzlZp50JkLnJ2eBAhcVrdpfOgNkmw4P/PeUaUKsEGnAIfg A063KcZjdOY4pJsYR5e1vsGtqmjpUyysXqfxgufofsRv7heOufp5sSizGVVBMPsfki2JbYtPsLd F5CrYHJoAJXRyb2FuMUTbHTiRfho4z/CyNa9mn15QguTe/9B5h1ngc72huQBjeOg8AEX3zxl2GX wfs+2xSbPN5evLpC2mNGZkK1VrXZMU0/a5JqfNMevle982EgpzKMlbZUUiWb5IXBjQEg4kqbGld gR4rAw7jKzI84zBU+myKMsUBSLz6S+sR4uMgUUsaf3XAXYxl8Hgo2cgGIcrTbK/e+5oe+oIQg+3 AJQJSAc+vkrftYlzCBPGI9xOrmF1eyckRjjRBfHDU/rfG8ic58vj7HMaML1veJ6w206JySuFYAh Ko9Qj5P4dKB8qfUqDncHn/R3HX7WkJEiORtAeyWJm7i+/l7kt09vAomW41luOrkMMl18V/P00a9 c6fhcTtZWVZLEOQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit c95eb32ced823a00be62202b43966b07b2f20b7f upstream.

That will simplify the following commits.

No functional changes intended.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-3-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: cd7c957f936f ("mptcp: pm: don't try to create sf if alloc failed")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c921d07e5940..780f4cca165c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -567,16 +567,19 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_nl_addr_send_ack(msk);
-			}
-		}
+		if (!local)
+			goto subflow;
+
+		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+			goto subflow;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
 	}
 
+subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {
-- 
2.45.2


