Return-Path: <stable+bounces-52669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BFD90CBA1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C321F239B3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B44C132109;
	Tue, 18 Jun 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir6+yDYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636C46557;
	Tue, 18 Jun 2024 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713502; cv=none; b=buo0QhvZ7YnfnLr95Kzr484WncXlATAhvJrBX0KPYLV7mkw7XZO28IMaiH0aeFL+5/WSGyRSi342wRE0Wg4+m5/4jZXoqN0eMllNMrWacrXsbjko4tUQaeyJe8jf+v6K8froKd6Mrml1bmsXuyG0cKLDqCPn0gI75hnSmVOH0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713502; c=relaxed/simple;
	bh=7jFLieY93XnEOiHmQjVBlz+PTDOpAeaQnSQDc8DWm9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NylbKChF9pTtxt3+217cooVqZSKFLRQNV/TUXFF804HRuIvF5UKCQ/9vdjV8Qz2v9AjOWJCBhvqjOTxIBuROrVBvOMvFmRHmbFmj4/ojXy9L8a5b3M9sGdoY3Cr8AAyXbEPKEDlgLkkQTGmDwpEqsK/E7OpoOI2If+m2hvX7YHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir6+yDYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D50C4AF49;
	Tue, 18 Jun 2024 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718713501;
	bh=7jFLieY93XnEOiHmQjVBlz+PTDOpAeaQnSQDc8DWm9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ir6+yDYO386xWCxRzcYDH/ld5x3AD6r6piktwffCep+vFt1IdbpJOPVlEe4ouRsnN
	 9DBUtTjPXmmY6DIPUvh5cCFybe/yaHph3DjJhwv+MWxEgOUh41pXp4q+epk455K12b
	 2386OBIys/NdytRY4XuVUwTr170wCJXv/LXjpvkB0n0j40tiN9OrkcE8ookKYZ+zLP
	 kNX3UZ37NCaXdojn9nvc2hrD9uaSf7AZncYSMebPzG8D4FSl/6ckl2hBWhVes5jdz/
	 jGtLLM1eqo6tKjAbiFhGTziIpDZp1xlGkGYtSH5GPqnr+laFN1csztBoAArBA6FIWD
	 AqjcDLImGwAxQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: ensure snd_una is properly initialized on connect
Date: Tue, 18 Jun 2024 14:24:45 +0200
Message-ID: <20240618122444.640369-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061719-prewashed-wimp-a695@gregkh>
References: <2024061719-prewashed-wimp-a695@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=matttbe@kernel.org; h=from:subject; bh=XuloGgQR2UwYQd/+z9GcJssTjFWtXSaGdOYYHWTYCmo=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmcXyMRoeIscP/u/XDRjvfzIL4phBCmQP+5QZ0A Xd2d/oGUF2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnF8jAAKCRD2t4JPQmmg c5WAEADftvZNAqvRbi3o/UbspalyFw9NLh/LP1b1mfoEr3tdWu6iOx61hq72vqr8iQYt76wkBqG gkVIeHAhfTthOuU2W8rN+ez3lIm+BbKK2tFaM0ka3yOvNoCqB3iqZPGrKVBIkMHjj4NzGkOJ9e2 o1CS7eRGNntMB19DpsB917tAmOsqbJ9FmvlR7EeqYQG4eF6wvErfEgf5aIRPUbembI/SgO/Reuv zK9v+nAVO5yimrYUWWphdUiFXkL1Ecu5S6qu0lXPzByoXrYaChT11RFOUbiGyi/bYJLaxjvyene hICc2UzJi9jr+HpoX3n0N6AxzUZZYxBvj0KemUUlovwFwo3s5m2EOng8FudEFs5yk1uC2XS82Io QMmSUQ1ptYupEjPvEVnFwkaiHFROywBh5gXk8hsYz/i4X9ZVhbcGKHulpBSmOToqX+3e2hx8iJ9 YaJlo/4i181p/cUIx6suggRQDxB1hQzHf8brl9EuF0oATw/V+76kT42kQF2dDLPOdWfSqAb83MF tgx3vKkGS40ymodid0yM0Fzxof5Yfn5uslLbkC7vKRZpzoH1OpJgXAz0wrpPBR0xUjGcV7IUCFK ECbwGteLw9xDnud6ihC+vFNOi6e9AQHQfcDNncf+GodGNGFJwqZRXbn+yozGW553Cq8G0+39mvX vpKNkgJ14W8Malg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 8031b58c3a9b1db3ef68b3bd749fbee2e1e1aaa3 upstream.

This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
is properly initialized on connect"). It turns out that syzkaller can
trigger the retransmit after fallback and before processing any other
incoming packet - so that snd_una is still left uninitialized.

Address the issue explicitly initializing snd_una together with snd_nxt
and write_seq.

Suggested-by: Mat Martineau <martineau@kernel.org>
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-1-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, similar to the ones from commit 99951b62bf20
  ("mptcp: ensure snd_nxt is properly initialized on connect"), with the
  same resolution. Note that in this version, 'snd_una' is an atomic64
  type, so use atomic64_set() instead, as it is done everywhere else. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 36fa456f42ba..a36493bbf895 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2646,6 +2646,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		mptcp_subflow_early_fallback(msk, subflow);
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	atomic64_set(&msk->snd_una, msk->write_seq);
 
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
-- 
2.43.0


