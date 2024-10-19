Return-Path: <stable+bounces-86908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58A9A4CDC
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 12:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B2B2834DE
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3191DDC38;
	Sat, 19 Oct 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDFfN0lr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76656B81;
	Sat, 19 Oct 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729333751; cv=none; b=TiZQs6BmzUoHldYXCGhRqa4oyIE85uYbwkCN5r7RDz8OCHEBPpdnW7LU2fnqMqrhvBRHVx6JNRFhv9u+REmsN7qb6Es6bMdZXHgNHbhBB1CNAvTHNUP1vEaqO0XOYDsMfvRitN3hTqVY6TuF1WGeFecov/FEbau7xe2b7E9NOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729333751; c=relaxed/simple;
	bh=xow7wwmvzjBee/4fLW/BMvU81SKPfvNVTS2Izah2R+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EldhqzIIwsqjEtwFxlmqytg+VkBRUekdVRxWXTxPCkP7i9BLJaVCyRRC6ge0giq1z9KURk0oszAPm38kf8l6F2ZYRJW6YDbtZ/efAHna7SyXSjfBoXCR8eQIp01bH+BlNs18GJ7dnaR6O2jeVTiNwT+syjvaNnTxtTG8/TwcSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDFfN0lr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3B1C4CEC5;
	Sat, 19 Oct 2024 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729333751;
	bh=xow7wwmvzjBee/4fLW/BMvU81SKPfvNVTS2Izah2R+w=;
	h=From:To:Cc:Subject:Date:From;
	b=QDFfN0lrVjXLEZlS5N0ZSCa9F3DfucL+CbmrLbNK9SL3B6UXhMZTsSJMtmq9KAkJ/
	 fJD6eDNfgH+bIWCMjq9GM0pbdpHqykIXMuSE6Bw/DmmMYpWmBcr254fLHPFU2TXMSo
	 dL7XiV9h8x1uLTvOPIFtX63gN3tKvgx2amhkxlAVXx5e/y9yhR3Ar32T/sUrhoA289
	 7BGwjksTRjxzYMTW30qOCSnVFZAghSNVW4XJzWU600/LBiTIJWgI8kB8bfBsueQRBb
	 TmreG8/PqMaLXT6/T6OvPHNiDsV7eOUl7vU0sYIiGbqYKSLHf13+5+PFdlWkjdpNRQ
	 5Y9kg++ITNpTw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 5.10.y 0/3] mptcp: fix recent failed backports
Date: Sat, 19 Oct 2024 12:29:06 +0200
Message-ID: <20241019102905.3383483-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=matttbe@kernel.org; h=from:subject; bh=xow7wwmvzjBee/4fLW/BMvU81SKPfvNVTS2Izah2R+w=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnE4nxis6HwKG2M57UZ1nTD9/xdvXIn/mQoqJH0 qbBe605+q2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxOJ8QAKCRD2t4JPQmmg c79YEADuOVhqqYMps4p5/wMdporeVum5rtgEgDYTY1dzC5TCjhSaawefeYCsKavAOrTUL1ysx4d Jeuz0JBW2VRE9nmO3xOlBx4Z2thMuoRINz/DJ5QohPP3XCcLPkURgHSNEsipWuOM5kF5bd4wVe+ FH1hb31f/B/LS0qosjvrY/dgFb3bamZwepFG4IJrkD4LThCP5SvEZEo+PvJ0n8P/gM1xG6t2zPF DRnCBYXYMuakKcdeR3+8IrNHm5NS98OQ8xN86r0jApjuN35FUMAYISmUywzbIwrf3K8PzFYSxxt 6Ww3AsSyoC2Ap6oGLAOaKYAQTAdgU8h2UuZBYLpPoyRvNP5iQJKjAS5+UjoqXQJg2bY37JbkXBg SebXyktJK7kZ4VX0jL48aMtMVXGIrRGBbQzWNbDsHytZ85AXDoyqGjwSJ5QLqdSAB/kxbanNGRq 36IBQHLJ1qmib5ecJh0jOYm0UlF1bcEynKfMZV916rQvvKIF7CGLzko8vdFkfFGHMEYee7AtHNh jHHdNnbJRVJYAG6sinYK1bAtKXKFOe1yYVVe8p9bKtJ3EN4PsTmh5ZAnwz39f0w4syZPdn7BgD2 M2siNKrJjygWRPXR+BUii6FLN78eL8pgfwvDpFaWw/fbSXWeb5iWpM1tESyZONFi5+I1veCTi3W z8jTjdMfS47H2dg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 2 patches that could not be applied without
conflicts in v5.10:

 - e32d262c89e2 ("mptcp: handle consistently DSS corruption")
 - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")

Conflicts have been resolved, and documented in each patch.

One extra commit has been backported, to support allow_infinite_fallback
which is used by one commit from the list above:

 - 0530020a7c8f ("mptcp: track and update contiguous data status")

Geliang Tang (1):
  mptcp: track and update contiguous data status

Paolo Abeni (2):
  mptcp: handle consistently DSS corruption
  tcp: fix mptcp DSS corruption due to large pmtu xmit

 net/ipv4/tcp_output.c |  2 +-
 net/mptcp/mib.c       |  2 ++
 net/mptcp/mib.h       |  2 ++
 net/mptcp/protocol.c  | 26 ++++++++++++++++++++++----
 net/mptcp/protocol.h  |  1 +
 net/mptcp/subflow.c   |  3 ++-
 6 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.45.2


