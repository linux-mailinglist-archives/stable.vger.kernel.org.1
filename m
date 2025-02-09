Return-Path: <stable+bounces-114458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA776A2DF93
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2B318808AD
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543A61DF730;
	Sun,  9 Feb 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzyLYGcy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDD1D934D;
	Sun,  9 Feb 2025 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123315; cv=none; b=gRelZXq8EoyLl0I1zQRDPCIyHfTZJCU//ySK3g0Vrz/l7p2X1t4/02FekRKc7CcOqxGGE8R5QNXKCkox3PrC6t+59lvbLVzG8KQs2XXtWNjC85Hr2jY/ubGAdhKrAY7B9vSyTMW4nAo4NUho0zIfSnKCKAa4LV52ecnrHRb6BIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123315; c=relaxed/simple;
	bh=QGYPJEEwHmbdoq/XRo2z+Pr6gasheGdFwZ7cDu7P3GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh49uliV0Da9AHrTSvWWX9nElufxgd7WI1q0B6EtTcDJqDuBsHthwaB47L1SusPBe6TZQJdiiVW9hkW+OzuXDVYOeDtDNjPw3/TedM9gsY7cUjYFw1cuEOsBXq7RVAvvXpPw15e5bGXKJVs3+FhiFN5uXBsUyYwwDynI+QSViTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzyLYGcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7247BC4CEDD;
	Sun,  9 Feb 2025 17:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739123313;
	bh=QGYPJEEwHmbdoq/XRo2z+Pr6gasheGdFwZ7cDu7P3GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AzyLYGcyfG/Fwx9LNoAZgs6b8Qe8I8GV2ch88+2mqeGTWxUAbYUKDcan3pZfrFhoT
	 UUn1yBYh1A7DeGL3MV7jA4ujL4fWH/Yy53tq+IVlRhUsy6OOddk8iI0z1Y6OGgatPM
	 Wi6FY99PNLEQkuOQ1TrFaG4Y5QUOj2ZFVeYQwd/6KAURhL5pdhbO6o6LLazFvfWhWb
	 6CNoKWx3J6V/f58nripJj3LaiestcwvufqIHIPBcLu30jQkT6iQBEjrQV/X6crlrbM
	 9Mz6ekCionUpjbyQq7k7p6EALO6QR+ewwjYxBjZZei+bsapuQsk8U+o8KLOFipvjr7
	 1kIiENngttv2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1.y 0/2] mptcp: pm: only set fullmesh for subflow endp (and more)
Date: Sun,  9 Feb 2025 18:48:29 +0100
Message-ID: <20250209174828.3397229-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025020435-eagle-precision-e8dd@gregkh>
References: <2025020435-eagle-precision-e8dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=655; i=matttbe@kernel.org; h=from:subject; bh=QGYPJEEwHmbdoq/XRo2z+Pr6gasheGdFwZ7cDu7P3GY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOpsUz4alaDzaYORDhnu4SCQ5A9X66mp6cI8W JmUJ/g7wA2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jqbAAKCRD2t4JPQmmg c+PiD/9rFY/am6cPG0sUdQdtAEvgqKf/7iNmlk1u6dPZDEb3NG59TN2s+AG30z8qPvYslzwKpE+ 8M8nkbjMVMCtpzxkdhrbToSpFRmvWnrQL4/3NYQrJ67cbhsW+MmikUUXhEtdS6FFb2YHiOFXuI7 +eISarCsZfmu07eWOMOeVry0/d8Zaat4M0hIkM0LiokGArfzAxazi188XBjfRTvJT5jSNxsVgUW ThCZeFa3l0krxP1bz/WUaTnWfYLY0+tQ1cqBw/AC5LcUP0Rwg9QkTxY6csa2HWCQ75/1jCDqBis ygg+ErCtEDCtVrMXcFIltx3ZjfLPlPgExBS9uIwuTp/5r7xFYFZnuyWMRWfLAdtIl54eB4/vwFI ETLyGY1LNsXsSLdon1jkfw96OVhp1UjIY1c7AIvP/gugokQK33TZSJQMam732jaNitD7e1mEyJc zlgSw2lQJSblAsouhNh3DtqyKDmUo8q5ZwLEvsLt609ZgKdA7GUZ2rzow+GUatwzBn+w6DFCOzM QNZgG69RSXeK2G/YcIXs6cogBop+1mbQEAfRfDyB1NNsn99XA6IBEnYDdtrBlHWm8TOj7UyGiWc I5prhTx907x6UEdYAUHD3Ai0ly2NqKXw3fVAfSaMi67fD647450F7oRx3YvVlmxBbRpS8V5y3L7 a2SgxMGEcl//CFQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The commit 1bb0d1348546 ("mptcp: pm: only set fullmesh for subflow endp")
could not be backported to this kernel version without conflicts. Here
is an updated version adapted for this kernel version.

While at it, I also added the backport of the commit 56b824eb49d6
("mptcp: prevent excessive coalescing on receive") that we asked to
delay. There were no conflicts.

Matthieu Baerts (NGI0) (1):
  mptcp: pm: only set fullmesh for subflow endp

Paolo Abeni (1):
  mptcp: prevent excessive coalescing on receive

 net/mptcp/pm_netlink.c | 3 ++-
 net/mptcp/protocol.c   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.47.1


