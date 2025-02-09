Return-Path: <stable+bounces-114454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C3FA2DF7F
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E26188490B
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B351DFD85;
	Sun,  9 Feb 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0pKRt5b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09471119A;
	Sun,  9 Feb 2025 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739122927; cv=none; b=LekIRmksVW8vxVDQ9KSWBZGGMqFUxmdm30X2g/UEYir5DHV12hB98BknfatrwqKfiKXz0Ocf9VBif423M3OWjzakoyYws+aBYis5p7HbmtJhy2AA8aNF1ex/3Yr0isa61j1PJbizJk/jDgIbQZZFA6WXNwC7r6UTQlOB6Nseers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739122927; c=relaxed/simple;
	bh=mWSnmZu5lGv2oObG2ErrRYlCOsCcGzaqar/Bq/i5zRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1DctU8JF1UpL1kBxQHTLIg8XhM/H2FX/dPUl5Y+BY7yn3cYuVi5ZMs/TFh0jUoBFCsw3xy3dPNU5y9i7IyL2h4Yyoh4bZZ0pT+Zol2vH+Ioe+YdvlSWJPRRjPxnFHKHrFG3659XL8EbTzKkSEOkoDxrL/fuBH3aWUmrHQaGDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0pKRt5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8B8C4CEDD;
	Sun,  9 Feb 2025 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739122925;
	bh=mWSnmZu5lGv2oObG2ErrRYlCOsCcGzaqar/Bq/i5zRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0pKRt5bOG/fbsh6oGggCNG69VvmduiLsMu3Yr8oz85aPeZnR4F0MJ0/KOWAVaS5U
	 AIU92Gm7vySoppHX+41SorbPiKa6hRcrAYJY+E4k/QhTCdX2fGgPd/DGrbTg03wVfy
	 w9h6+uklxd/BFTXaXFKcujrVkrzuKKHmQQWXPYiF54//ZWm33DlmsIssnsznozr/FO
	 YwDhD4Csoin2fpetAVCAft4DCkHW24N5hcuFIcqG0iZqA/L7kfu4dt4uz/JzeJdFDM
	 n2RoWM4JT8hhwgEE93L7/PzWfFPob6TPx/1gLpwEyCCM2icM7oZscFpKYq/0F4NNXE
	 XG64H6e2mRADg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/3] mptcp: pm: only set fullmesh for subflow endp (and more)
Date: Sun,  9 Feb 2025 18:41:54 +0100
Message-ID: <20250209174153.3388802-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025020428-unashamed-delicate-248c@gregkh>
References: <2025020428-unashamed-delicate-248c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=matttbe@kernel.org; h=from:subject; bh=mWSnmZu5lGv2oObG2ErrRYlCOsCcGzaqar/Bq/i5zRU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOjhhSGwoIEjnd+RiAyh9WZ49fUKKBYnDv42M Za5y8E2p+yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jo4QAKCRD2t4JPQmmg cx2PD/4wd2CR0OaEX74xaY4snVzqIr7Drc9JyxzBTomS7mOjZkSCmwiyUBsLqrtGnNWt4fdfwzq YV7p961HKEUDtB8np0Sqxit9rsc2+m1E66eSLnUsZvk1PEGI8R4vSpuduqxL0WQH9RcrMgIsUW3 eRrrCQlQxaHYjdm6orj+Yp/kNuCBOAzcQiI5BPhc8KvQxM+Zv2gF5Hu1SWuEjqUs42d1q3xKaNg 3AvE/KePRJC9jIzKcyVJFFz2IVMpo3OlLiKNFmQTYlLv350+p5almDXrN+6FCO2xRk+FyKUuOWj +J4c0jDbtHyq5ozkvi3X4+VxHORGz+TvOZaErya5FTXxiZaWGQCeV6/k3WQGQhbgbRpQ5Sv54I1 mifhSQYcfty6Uvz94qJ5zLbc/VZMj5v5PB12jwwf+SvwmO+fM8Rmoe0jvciVtEFHNzjSOgosK6n bUNUkefH+vEWffPvbxroJ+sj0RNjUnwzJa620T3aZ4V7OwP1fgiUtBkMsZa6B7eZEC+l/4GeC5G 2U1KntVr8v3fbPNCvXy3Fi3eyr69Ci5LT10Dk6osUvMm0iZLe/0BlQdAbVz/vTjaZX0Seeea9Y9 fGFDfOZtJhh+3A/TVPgEbRp6msmZQxpUASAPZ+yHcU8qlCQ+3MJVOiGESdeE17igZnCAODG8f9l DtP6x5kchgROiZA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The commit 1bb0d1348546 ("mptcp: pm: only set fullmesh for subflow endp")
could not be backported to this kernel version without conflicts. Here
is an updated version adapted for this kernel version.

While at it, I also added the backport of the commit 56b824eb49d6 
("mptcp: prevent excessive coalescing on receive") that we asked to 
delay. There was no conflicts.

There is also an additional fix for the selftests, specific to v6.6.

Matthieu Baerts (NGI0) (2):
  mptcp: pm: only set fullmesh for subflow endp
  selftests: mptcp: join: fix AF_INET6 variable

Paolo Abeni (1):
  mptcp: prevent excessive coalescing on receive

 net/mptcp/pm_netlink.c                          | 3 ++-
 net/mptcp/protocol.c                            | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.47.1


