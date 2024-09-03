Return-Path: <stable+bounces-72798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311219699E5
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C559DB221B9
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A28F19F435;
	Tue,  3 Sep 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJC9t08z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418D19F42C;
	Tue,  3 Sep 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358620; cv=none; b=DAc5iQ4hCy5ikVDuSfDxprq/ubMXxkLebEwsZd0Yc2f4N3TNmN/GF5D/os/NjSJWi2teXn96e1E68qT+AhdRSL24Geb0ZEGJtwMm1CQdMY26lQeJMTJJwTnHTOxDtARdiXkc7su1IiTQGqxK+n9Mg4qXWcbKbhoJ8kl0g3IGDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358620; c=relaxed/simple;
	bh=9utSazRY/qKgo6c8USzwCqdAXCTvyg9eATp/0Gn+vpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei5mVrrv4mXqzJPEPpdhGPgPQVc8/iaVuH5+hQV0fCSsoLm2LWSozhlgw7j3DeJUJWT9f+fYws74Tne3/NRR+8iFcLjra/8EyMZdqWfrGPt+M8MoRu/S3yvWhKk/rxyZIV79w0fRf2Hpb4fksXwbw5GYAGo9HG/t54kvkkzW4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJC9t08z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F03C4CEC5;
	Tue,  3 Sep 2024 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725358619;
	bh=9utSazRY/qKgo6c8USzwCqdAXCTvyg9eATp/0Gn+vpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJC9t08zA39uECOAPYAlvuDW6Sg80mbpO/w6Qk4PrjxVbd5LENZtWtJzlo+1u6Bg+
	 +F2US7wK9oAU2nIGTogTd3MT2DSnefNpzCnJq48JqFW+05q22Q0dIxjmHSiRl69AFD
	 CzICafp1Of8pbAhhzwQ4BTBKEjjkmwrWhXneAcd2Y3w85VDp7KnVYkwb+ffm+ZNW20
	 EReuXAkHaM2daGfXEYMQ7RA27jPkP0bpzt4lWIDIVbL/tG+ucNJ89L+6pfCqL/IbXd
	 A2dJ4fdbdm5xjKwXDEVyZPvP2RsjabQ9tTc+5jaGcmstls+G/OeJvEs7PV1NPGXrs7
	 oKp+7fC0nQ8rg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 0/2] Backport of "mptcp: pm: fix RM_ADDR ID for the initial subflow"
Date: Tue,  3 Sep 2024 12:16:55 +0200
Message-ID: <20240903101654.3376356-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024083044-banked-tapered-91df@gregkh>
References: <2024083044-banked-tapered-91df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=matttbe@kernel.org; h=from:subject; bh=9utSazRY/qKgo6c8USzwCqdAXCTvyg9eATp/0Gn+vpQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1uIWRXkrIo1btgrXYQjsm9ehFI3DSzXW4THP2 oZ/3/MI9f6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtbiFgAKCRD2t4JPQmmg c23ID/0TQVl/0KhPMCniF5EB0UWSjcCUkdIh1k8Kk2xW0YbxnXFLZVaidZc5euBsudC4bjg3/cb t5/NRh4hc2ZnPEliwNmP8w0aSOrTwPYCfWXWN0QV+m+0aprJHjvEnfFLBMUQJ5JxXGu5WMJGlxn Yj1yzXn7hv/Jjy7+3Fkr8gQQ++LT179VBsK8B5DmfoAfvWheLdfpF/PELCW/82/YZs4XkRRHglB ZZwGoLrjPgJ0CJplTD5lfn7vDK9D68UfEUrJgegNRbPNBz3KbrlddOoo0PwIrohWWmcainTOoeL 4k+CZ/KOut2DNTBNALglu/00FMwuZBhxFIbd/Jz5cPtmEwSPeKxTfMNmfrJ1nWKo39UnEMZ6Yoj 9+pwSBW0AkBMTjdx77CyThU0gE2s1tamRCUlIoHy6Yfj/Y/pk5PlGq3MXB9sFI52WKng1b7scLi 5Dsl84FrmycSiJYAMiM+FQw+R3RogUvSrZaiKWv9T178AI6DlmJ+rZsK+UBWKwxJtZXXQZtTEai mEbqulqpEy7f8NuRO9D8QBy3rsyL3ax2iGtDbbq+YYOjaET2ThrQ7P55kyFkjdvXXdbWNl4DHCx P9MbEOvi9HncCKNTapqLvDBVeq8xgF/RgKVX0WdygAjRYF5ACdi6XcV2l4f25zg+14sSdxaQgLx 7CqhNDG9eEkXpQQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

87b5896f3f78 ("mptcp: pm: fix RM_ADDR ID for the initial subflow") 
depends on e38b117d7f3b ("mptcp: make pm_remove_addrs_and_subflows 
static") to avoid conflicts. Both can be backported to v6.6 without 
conflicts.

If you prefer, feel free to backport these commits to v6.6:

  e38b117d7f3b 87b5896f3f78

Details:

- e38b117d7f3b ("mptcp: make pm_remove_addrs_and_subflows static")
- 87b5896f3f78 ("mptcp: pm: fix RM_ADDR ID for the initial subflow")

Geliang Tang (1):
  mptcp: make pm_remove_addrs_and_subflows static

Matthieu Baerts (NGI0) (1):
  mptcp: pm: fix RM_ADDR ID for the initial subflow

 net/mptcp/pm_netlink.c | 32 +++++++++++++++++---------------
 net/mptcp/protocol.h   |  2 --
 2 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.45.2


