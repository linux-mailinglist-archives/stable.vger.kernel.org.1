Return-Path: <stable+bounces-106564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2656D9FE9AF
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 19:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6691884D5E
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954DD1B0408;
	Mon, 30 Dec 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNOqEu5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D56EDE;
	Mon, 30 Dec 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582359; cv=none; b=ZuIae6TsSSTmyg1fAkryGSoQacDI/8hLX0rAeXlHUS/emhitxDKxIoFIrxDg7Y319lqHUHrrMrLy5TPzVJbaE8jH6IKt2FM8xAD0n+LKitSxFXGskqbB/wZ3k3lKczJOEcmH2976/8t+8wGIFhG5cbnVSdlMtxHIKa0UacUKM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582359; c=relaxed/simple;
	bh=h6w2zPUzzp2R5NlQbgzRta52ssPzbwq3ofsg76Bo/Sw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gZVlRKmxM2+jlqnz86lwPl1IieB8VQr3mN6EcAeu1DbJvHBuyobuSp8Jv6Oyb1J1XzVKF4w1y+LDpve+VONu1REB+x/0HoLIIW/SaKWXTTNbhuglpB/b51VJWvqEM/F/S2SSR73JZIKqyHIWjoJbMIGOUyEx2vgL674qy6TW0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNOqEu5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F324C4CED0;
	Mon, 30 Dec 2024 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735582358;
	bh=h6w2zPUzzp2R5NlQbgzRta52ssPzbwq3ofsg76Bo/Sw=;
	h=From:Subject:Date:To:Cc:From;
	b=KNOqEu5pV6sXFIPEt52+tqt9hoYO/ITVGqc8UGkMs2vfzYPH9pp9z+VpeZ56jPiJM
	 4sOWWEvol2eVLEeOqT64ByVg/7rzNVCk7RchmiIB75hpw3vKO/802T4sQpNP2qLB7j
	 /nZnTZ/ICUl/9y0yXRxxdRYjRh2Lt7qq4UB3+RtfKvQmmXgmm1PWSwHTdkeejjJgIL
	 M6z5R1N+MqSq+mPL94vzHf6tFg9ZoXx/1kwgoAld++9m7dyTqvTrrmjCvgYglnIISZ
	 qPHTkoPCcKNy71yyhS60E58V+GJvhn+MuaG0/pAzlSK0XJKgs9j3wvGX6VTH55mA3Y
	 XYnRnz/EMzHbA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: rx path fixes
Date: Mon, 30 Dec 2024 19:12:29 +0100
Message-Id: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3icmcC/x3LQQ5AMBBA0avIrE2ipYSriAU6ZRaqaRGJuLuJ5
 c/PeyBRZErQZQ9Eujjx7iVUnsG8jn4hZCsNutCV0mWBng7cwjEHjNPp0PFNCZvK6JpMa1ujQGi
 I9A+RPYiA4X0/+EXwIGsAAAA=
X-Change-ID: 20241230-net-mptcp-rbuf-fixes-74526e59d951
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h6w2zPUzzp2R5NlQbgzRta52ssPzbwq3ofsg76Bo/Sw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncuKT9IkLKq6ih3njIaUhaYkZfgTUbqGe9dUCC
 MQ8SMMp8hGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3LikwAKCRD2t4JPQmmg
 c5tcD/0ayB2eRLES6pJ4RK0tInA1Mhz7/FDHaBHXhNCmO9OCcCxUIR2ssFjsSVoPWGQVIB59LOp
 4xc1Mmlvjqj9L6X7cRcp+FiyjGk+QHAy/oUz9zlvLQuypM03o5SNkdjgvBiQBZ1imdtF3kmcxqJ
 G8S3GQr++GvjsmVbSDjiOfMuJ7gTuzzAehrayLr8ibnq7Ly4kVkITx9zqbMHdRhNrtSb4garwJz
 Tteu2ENr8MIOS9hNiDA0Gkzw490Y+jr+xWKPYni2Rhm4cnCOFsXmM/hQgF6kL8fVYgzkEplG8nr
 +Z7ynmD4UvyadRt6CgfdHLwEfE730WyYl0KWfZbYPy/4S5R718mwgmZuislvEP6sJqqBDKrUKUz
 vL468ADf14MfRaraD0Iew1wXtvzpw9zlcjbN0PpoWhV7nQ46omx4qbELT1Ob8+2MYkPLEdJZ6Lj
 5NTWSLgilNBqLbEomRvT7pa0TOiWoJDJNoDh6sTjGgpQd96ohxrtNjXuzRQFGBPOvE4RDLkJ8Fw
 nnVqxxgO4jrp8kxMLCZGE0BpQwIM7sD7c2e0ZU24MXXKgSuQ5FPNnGH4DgYgFg9SLkvMGt6ZgDD
 mKTRq3NEoqAY+QmLlIpb87J8pDLjIEZr0/uCQnAT0bck+Za2GXn5pjQjpe4Sc+1Qm0llpA8oVye
 LtDkrOnZYX9LHWw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are 3 different fixes, all related to the MPTCP receive buffer:

- Patch 1: fix receive buffer space when recvmsg() blocks after
  receiving some data. For a fix introduced in v6.12, backported to
  v6.1.

- Patch 2: mptcp_cleanup_rbuf() can be called when no data has been
  copied. For 5.11.

- Patch 3: prevent excessive coalescing on receive, which can affect the
  throughput badly. It looks better to wait a bit before backporting
  this one to stable versions, to get more results. For 5.10.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Please note that there is no urgency here as well: this can of course be
sent to Linus next year!

Enjoy this holiday period!

---
Paolo Abeni (3):
      mptcp: fix recvbuffer adjust on sleeping rcvmsg
      mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
      mptcp: prevent excessive coalescing on receive

 net/mptcp/protocol.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)
---
base-commit: a024e377efed31ecfb39210bed562932321345b3
change-id: 20241230-net-mptcp-rbuf-fixes-74526e59d951

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


