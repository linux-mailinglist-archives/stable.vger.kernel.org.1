Return-Path: <stable+bounces-172415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49100B31B0E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF2FA20EBE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B030146C;
	Fri, 22 Aug 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9C6YcM4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07414393DCA;
	Fri, 22 Aug 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871897; cv=none; b=JZhIRfW7uYDH6e0oH1bqwBLpf7p31vWoCEtM2dArr+WTB+K2oYAKKOIwkTErZkdt87I3dTfv8biOIQU0czCKqRhlyLi5sUZUPq7ra2P86LehBc4AmgLt3fojl6JRmE6S2vpVvITlAnXHlESqjkOt9j72+i45a3hDDI+PnQbS9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871897; c=relaxed/simple;
	bh=uJFEJegKIZHVK3E8MHmjN878D22/bUf38IDalQvSSww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYv6oiEUilstn6IvNwdXOvxBjxJhvnCtc7qWtVUuN5omRAJJUzJof7EVdV1t8d8Kh7ozHsXMFyAN3Q2+Zdr15UvSRurK5jJiC8ANuCHRQP19QOMF/gmvNM/7b2WMNTVumBzA8jhqOK6l3cvw+KpjafSo/HBZpoz22Yp28q7RmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9C6YcM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4C6C4CEED;
	Fri, 22 Aug 2025 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871896;
	bh=uJFEJegKIZHVK3E8MHmjN878D22/bUf38IDalQvSSww=;
	h=From:To:Cc:Subject:Date:From;
	b=T9C6YcM4SRbHzSKbdSx/rIP7DTjEUweksgWZQ8qOy5SVNzf3sNyUDGHv3QdiW5gVJ
	 ZUso1rPtCvjBaN8xWhnH+/v1TGNaMu7CF0QldP3ub1fJuzoRyrrYASZYq8pczpAbf0
	 r6txoKEVTJxN0KzjgZWRGn8IxPkk8SIu3DaDl6BXa3U1yXk7yc8zlGs3NIgpXRpVh/
	 MPV1wRPmGgwfEa+cedriAFrokE9WyOCKjD36olkkP3DfjVpO4H1+N6e2+sbvvvWxEm
	 7OEf8yttU/x1fzbjtxPtl6ArpTk2vp/qxwkeIJYgTegEyd1lNAdacIJ3ArCIxzQ0nc
	 vh0V55Hnx2bBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/3] mptcp: fix recent failed backports (20250822)
Date: Fri, 22 Aug 2025 16:11:25 +0200
Message-ID: <20250822141124.49727-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=matttbe@kernel.org; h=from:subject; bh=uJFEJegKIZHVK3E8MHmjN878D22/bUf38IDalQvSSww=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJWVPX+ygmR/lGjtulJ5ok91l9Ppz1/yPLi9OeNNzJ1L 1ycFWf3paOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi+YsYGR6GLOKxMHuQuipu mSdDrRf3TYYb+/cmVKovk4vUtPuUfYaRYY6U6z1N8f3WvX9MS3qP3vwqWljwdjVjqZUAE5/SDSV jZgA=
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


