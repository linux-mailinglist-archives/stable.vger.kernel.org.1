Return-Path: <stable+bounces-164935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D303B13B80
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49CC169F10
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273D2673AF;
	Mon, 28 Jul 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+ZdoY/G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A4266F00;
	Mon, 28 Jul 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709373; cv=none; b=Zw0ZbBrRRHNGJK/+l5CeteuI3FMRPaSBnKcbc5U0nQ9yUZC3+6eETgvW+HHR5+LHkxdet6Q/7r8B5rnFG95/riK0FmkB1NyslIO8GJ0WQkxQ7ZYW3KLtfIsmv7UPXjfhr+mYi1G5ASTe2L4k6t5l8e/PKfpeC24arZRbj+GkOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709373; c=relaxed/simple;
	bh=M8Vhj+B3+aLfbEzYphDOwa08D5g90EcE1xf4Qjj7kZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tz6Ls4FcDmBxcF0e3VVS1zhsDW6KXGB70QgdEr9dnNtb+QctHp8Joep8n9Mlv6wsnVttvbdKB46JwXCIYpn1SznDczqSFezERdpScW96Ki1fIjIdIuqfkKCO4cgnsTpcEWe8w2PS0VBX4hj/EluZHkHVzPjFAg7MKD1xOuykmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+ZdoY/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E5DC4CEE7;
	Mon, 28 Jul 2025 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753709373;
	bh=M8Vhj+B3+aLfbEzYphDOwa08D5g90EcE1xf4Qjj7kZI=;
	h=From:To:Cc:Subject:Date:From;
	b=R+ZdoY/GjAh+aQmlxaZp60w0Qry15jPksUPM+dh7Zkmg2Kj2FvHQVsnfPf0o09sa3
	 DAPGpDMTs39qo+fgdvV5Row9FglaMpFcxs6PTuy7LXBVoS45tJjflILbOlgxb0z+Dl
	 YJcf8ny8mY+u3LHIE7LXlxaBqQqeG9oVXxNs5wxloQq8FQ+PTukNS8mRl4CSH3nGDU
	 KkON3RXOZ/EymWKxeWctauaI291kzTbZnLys99AjhRcu97LMFEC0Zuyr1uh5g+xotx
	 GPvwnzVIAKD8wfqFS8zbeNeQWtx3X2+HUFfUVAlkC9SCSoJ5oHYP0jw0HFa3N5etK7
	 GzemJE6GVTNrA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/3] mptcp: fix recent failed backports (20250721)
Date: Mon, 28 Jul 2025 15:29:20 +0200
Message-ID: <20250728132919.3904847-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=matttbe@kernel.org; h=from:subject; bh=M8Vhj+B3+aLfbEzYphDOwa08D5g90EcE1xf4Qjj7kZI=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLaqw1eVPo+C1OZoLjM1VfLKlP+2IGUciOWWztYE5cvl 1C1l1TvKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMiZSwz/sw79ueY7JXfW/PQ1 oocs+guV1mbEPszRPybt5OueIxPyiJGh/V63yDK5rXd+XJy38FnDxKuJZhWGxWxbix1DyvtdqkJ 5AQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Greg recently reported 3 patches that could not be applied without
conflicts in v6.1:

 - f8a1d9b18c5e ("mptcp: make fallback action and fallback decision atomic")
 - def5b7b2643e ("mptcp: plug races between subflow fail and subflow creation")
 - da9b2fc7b73d ("mptcp: reset fallback status gracefully at disconnect() time")

Conflicts have been resolved, and documented in each patch.

Paolo Abeni (3):
  mptcp: make fallback action and fallback decision atomic
  mptcp: plug races between subflow fail and subflow creation
  mptcp: reset fallback status gracefully at disconnect() time

 net/mptcp/options.c  |  3 ++-
 net/mptcp/pm.c       |  8 ++++++-
 net/mptcp/protocol.c | 55 ++++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h | 27 +++++++++++++++++-----
 net/mptcp/subflow.c  | 30 +++++++++++++++---------
 5 files changed, 95 insertions(+), 28 deletions(-)

-- 
2.50.0


