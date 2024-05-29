Return-Path: <stable+bounces-47622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5668D33D2
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C825E285140
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD44616E89C;
	Wed, 29 May 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggozvxJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C316D9D9;
	Wed, 29 May 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976709; cv=none; b=vALJ8VUpO+UNCM+JO6UuUMhCtqN/8ZBx92bJsKeVVBrDCJ8dGUgDgAPvKUjWzuhglVJL0/AcesurOCTjZvwA5d3EdMLtUkDmdYmXTk363dA99Nr5vBgCvhOzTxW47i+KonqO1AsMh/8lhqJmnYOu61y9HN3g1I7m8Zny8Ur2Mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976709; c=relaxed/simple;
	bh=WkD4hBmsscXkGO0rSV1JbqaOuPHFRTDlcy61U400FU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJ/+RUHNJKkvMoauVgbP109tWHm+whCqGcJ+lqhcHd6iblXRhJp5myZhAVqlL7Loyf+uoNds6yZlhBhiPS6fSXLtzvx45ADhBEgc9S6B+1meqfauE/NcHuyZKe0FbJAzK5rW2u2xbiJls+fRB5qMNAK++OSSbDZEBAXfnEz01gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggozvxJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0156C2BD10;
	Wed, 29 May 2024 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976709;
	bh=WkD4hBmsscXkGO0rSV1JbqaOuPHFRTDlcy61U400FU4=;
	h=From:To:Cc:Subject:Date:From;
	b=ggozvxJm64HH+cm7YwgqsaQabV+1t92/XcZCZc22D+IgqNoEMivT3dJxfbQcO8xt2
	 i7cQb8frfhvl4aR2koOIBTm5E5EgieZPVIxPCpXw5yZWhc7FA4F8X/Hg/u/o58vV2D
	 3ry52RGm7G8H8fS2vp3i+jutjKRI6R33OvbfigbVRvuZcn8Mh3RXdANz03LSoMGIH8
	 DopN79ozNyzomm+MNqA0czIwg8NsyHr2C+/qm8jV9i+g5CJu317+ws0qjTkoqLzgvP
	 cGXWDGiSnJVvzgvJq0TtTBHNkigMPSKwjL3DL6jAJEeZAZ6Fbd3uPg5j3BSGLPbcDU
	 iwuvCg+iZ6WAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/3] Backport of "mptcp: fix full TCP keep-alive support"
Date: Wed, 29 May 2024 11:58:18 +0200
Message-ID: <20240529095817.3370953-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=721; i=matttbe@kernel.org; h=from:subject; bh=WkD4hBmsscXkGO0rSV1JbqaOuPHFRTDlcy61U400FU4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVvw5w23Nd65jqOUhpV/EfrW4vTY0210LUg2Gx U+B/Sfk7NiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlb8OQAKCRD2t4JPQmmg c5EyEADBgYpzAC79gWmzgt+UKtDLEwDAEYpfzIHUOwwEeq9tYhTQ12h1h7zhb5jZbgecsyiGwQ8 LXj6PvNCcrKx1wdFdCNzfXNz5kt/TBKSsx2pL74SUqd/fMrLWac7cpsKpNcsalTtHw04Yv4SVOU V8bgvrNjA/MrQGOkiPDtHEeqXVMLWx0TbM76IeOtGEE3NrbAbO64n8H3skjOikVsJCf6MgkrzTt FG6uA6zX06myHnVf/C4oJfnUk82bQBn40qdofbMtN0yg2QlETvKoDHtJwybk7f3JmNZARgDvbRb 246jNxOzfxO0lercf+Mth7bq1fMvnrwwQStFlM4NRIlWf9/UODBvSNhBYVRzN5zzTnWVnyn7fHf Uu/x626PMT4mPt2Ags+PK7OgMgxi0IUBgLWStiaPaIyFtY0GbIqCDLBQOdoJoFp+Sek1i2XDTVf 4U7qI8N6ZMt+t4EEaN5S9hGzfxD8EnOk0jWwd/9LZHyf7tUna92NH9rL959yoPooi0CwJfexHBZ RcdnfJC3PIfCIANYw/kCouIlxyhSxB0qyawm/LJk0yX8xmDtWomLgCH3mbr0gv9s15E35VWXZML og5NfcxLzoBuXD7EgyTjWiMPXvZJ8xptdh5W91vgwXYEcMYUsXspdtydmkxPbDFc86XiWjRdWpZ Nm15lpdg2Ha/qZA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

It looks like the patch "mptcp: fix full TCP keep-alive support" has
been backported up to v6.8 recently (thanks!), but not before due to
conflicts.

I had to adapt a bit the code not to backport new features, but the 
modifications were simple, and isolated from the rest. MPTCP sockopt 
tests have been executed, and no issues have been reported.

Matthieu Baerts (NGI0) (1):
  mptcp: fix full TCP keep-alive support

Paolo Abeni (2):
  mptcp: avoid some duplicate code in socket option handling
  mptcp: cleanup SOL_TCP handling

 net/mptcp/protocol.h |   3 ++
 net/mptcp/sockopt.c  | 123 +++++++++++++++++++++++++++++--------------
 2 files changed, 87 insertions(+), 39 deletions(-)

-- 
2.43.0


