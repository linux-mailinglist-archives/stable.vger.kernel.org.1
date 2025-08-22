Return-Path: <stable+bounces-172410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7927B31AF8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5C3167057
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD3301476;
	Fri, 22 Aug 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4y0ic6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D62FFDEB;
	Fri, 22 Aug 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871875; cv=none; b=EyBEGvt/+Z8NEuJm/oE56av7Ug5caHOzIks/lDMvy/vbH2jkjINfRfEwojtjac2gFNQ3pO92Wn3D78YZ5R1tPYQJRCv4vGyedIR5IvXIah2VLQ8B2fgBg0Wd36f8FXEsHOUYguGFMLwCMUebZviYFVJiVF+978JOtNvBlkZkvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871875; c=relaxed/simple;
	bh=uJFEJegKIZHVK3E8MHmjN878D22/bUf38IDalQvSSww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOCIlGzRqp6vS7O3yQ2Ji28hPUdICeFLYMu373VMQ2IHYr1Ta7oI9Ms1oBSpSR1ZlkIlRAoycxic8r/oiEvJkiSgIflzfsKGIb5pAW0Xz4PjM8xbQnVlcTx9FgDx83nzbxlFSxP5h9Xp1RbraPKuqSg7UdBF5Y+AAFiDxAhtRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4y0ic6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30C9C4CEED;
	Fri, 22 Aug 2025 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871874;
	bh=uJFEJegKIZHVK3E8MHmjN878D22/bUf38IDalQvSSww=;
	h=From:To:Cc:Subject:Date:From;
	b=o4y0ic6p3Gn8u1r/kq6mDOJuNnSXOgQaYJWs0qZjdjKIix0OGhXKYXrEmivVgwai4
	 QdqOJkzHKrQa01rzm4mH9BdmsKbn3Bu6fW7xRim7o8SjUAthzABlAbIFiqboPvTQ+h
	 URNA1IIyQ7DD7hRIZnnOIUM1iAFcKxW7bBqDDeAPid5ozw/09a+Q6vLWSgAGg9NArF
	 zoh8b1xaYN9PuLOpzlZGS6pLc4LweRA1Kzx1JhmrrVm3Tz/3ebKlum+Glb37T3KKr0
	 0w5I/Hr9+KUvknb0cuqxuw/EokPIooAP1ZQg2TJeXvZTMOIzmrDIV02oP4VwviTaki
	 5ivKCUsFnLGyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/3] mptcp: fix recent failed backports (20250822)
Date: Fri, 22 Aug 2025 16:11:00 +0200
Message-ID: <20250822141059.48927-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=matttbe@kernel.org; h=from:subject; bh=uJFEJegKIZHVK3E8MHmjN878D22/bUf38IDalQvSSww=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVJX8ygmR/lGjtulJ5ok91l9Ppz1/yPLi9OeNNzJ1L 1ycFWf3paOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi0b0Mf8WKPmlfz5P78Tow MTDlA4sr77XzR9V1Vq7e+UBMw4Gf5S8jQ2vmnDBLXZFTHZtmhKzi4Xt49VmDxcvKQJ61kQK/U4V U2QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported the following patches could not be applied
without conflicts in this tree:

 - 5d13349472ac ("mptcp: remove duplicate sk_reset_timer call")
 - f5ce0714623c ("mptcp: disable add_addr retransmission when timeout is 0")
 - 452690be7de2 ("selftests: mptcp: pm: check flush doesn't reset limits")

Conflicts have been resolved, and documented in each patch.

Geliang Tang (2):
  mptcp: remove duplicate sk_reset_timer call
  mptcp: disable add_addr retransmission when timeout is 0

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: pm: check flush doesn't reset limits

 Documentation/networking/mptcp-sysctl.rst      |  2 ++
 net/mptcp/pm_netlink.c                         | 18 ++++++++++++------
 .../testing/selftests/net/mptcp/pm_netlink.sh  |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.50.0


