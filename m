Return-Path: <stable+bounces-76547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD797ABFF
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A9F1F22B7B
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596AD84E1C;
	Tue, 17 Sep 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoPZ0Ytr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912544C77;
	Tue, 17 Sep 2024 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557986; cv=none; b=lqNu7u02cCLl2YLexC1GwmfZV6o3FLpROwsqeypAUkRj+PcsPS/pvTe8QWiKEFmlHILBcdHecKCRMx7WTuklJhtELtG6vWqw0j4E4/Xb5dUF9gGWvslrc2X+kSLVq+qErNAu7Yk2z3j7v839OGBHDlmZGjCFbhCgDwtAtMrmtOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557986; c=relaxed/simple;
	bh=UCSpaTWiZLUCHCd6wPU8BJlWdYo/+shhmrU4IpM14fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTiHUh8/7ZADKPKNCIthQdKOkC1Kjg7sAosE73d0vclcns736JNop/HBf284q8PXiF65h13oCM0tSqlimHjp1QkwcnVeQg7m8YOvbJtZ8qQcc+oTiGVzt98nuUaJO6bbZOqikzbKvd4JNdSYQxfGOpgPyTKcsVDiEo8a92COc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoPZ0Ytr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5FCC4CEC6;
	Tue, 17 Sep 2024 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726557985;
	bh=UCSpaTWiZLUCHCd6wPU8BJlWdYo/+shhmrU4IpM14fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RoPZ0YtrcTYOP0kZyj5d5ARrZMpDL5UNx7KTbaxNhfdi2fhybdi+c0sob8Y5hcLsX
	 gIyh9ad4QFFu9ipWqqvHmKD61FtzNHLZFn++BSLYx6QwOUTUV1XMUvZ6+AlNyR9sys
	 rxINeeu6IBOjDCUNMyBRblIZ5P1H9jD/br8eyE/B7Y+8RVAkv2D9yIleQwoGZ76csT
	 GiT/kX6P6F8J0tXUraxVkaElLzze5tfa3og38obWBGI9vktKnSFEX7GaPKFVw3RIjV
	 taNuTHRCCvhcdU6Ff3fotfgSYxr28G31znNGSJpGLtSIRIyp1Up3hY/8BLy2cjz/xu
	 xc0k8ULjwQDfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.10.y 0/3] Backport of "mptcp: pm: Fix uaf in __timer_delete_sync"
Date: Tue, 17 Sep 2024 09:26:08 +0200
Message-ID: <20240917072607.799536-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024091330-reps-craftsman-ab67@gregkh>
References: <2024091330-reps-craftsman-ab67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=matttbe@kernel.org; h=from:subject; bh=UCSpaTWiZLUCHCd6wPU8BJlWdYo/+shhmrU4IpM14fc=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm6S8QqoaStaRdUVgAxQ+w7oTX6ywu+vt8eNj08 TwXgxQmbsWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZukvEAAKCRD2t4JPQmmg c7j8D/9vLrN9yiHlkipvJQffZCoGNx5BBkzrPugxXIafKC9CCiEtqNdct4eVypoP1mq0Keh9t78 Mou/0s+i9WF4MIRthwxN9QmTRO3xWZpg99nqMc/VMGmtRIGNwIFGlwmW+7UeL6lt+zf1g2CZANq v4K1bD/YLyjNLRwDViqg0mGgMXT8UJB3OUxVpNk72+muoUErpjaEs51l8qInlEshPgB0szlXXMC npS983+nCsZTpi1qf1BHJHFZbnEBONV6thkZa7aEc0L10IxvCxShtjinLA/sC429H4VGWNloq6k 2c6MOMjUW0CWNzKhZ36qTzbzTLFVmoaZDor+KNHpBWiEd0oc/f81G8ignUs+lbuoIGWNgBSXOfB 5tSines54OspDV/5DNaR5RBOSEyhin3fY9QJNIYLf7sU4JXZ4o4zEv8RVQl6uAbdr1J9e4/s0xF ZIBkjLkYOCXcDPinih25pM6XQt+djeX9JRDHoTQby8m2JJ1kCC9WHxQ0eAmTCn+icSFKTKTJXHB UWa87ZOp1iW7OOHPfG4RvBij7Cm96UFyFJqfku8le2L1/vRAhcysRFz4NjRYSbVb/dBAE1nZCIQ PPRs9HmM3XPsNbSsi7thcFGznJJTEHF4LgRDpVBtETYkBgedea/L8V30pokFxcyTwSUTbezRLQW 5SuIg1Uomaj4Egw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

To ease the inclusion of commit b4cd80b03389 ("mptcp: pm: Fix uaf in 
__timer_delete_sync"), commit d88c476f4a7d ("mptcp: export 
lookup_anno_list_by_saddr") and commit d58300c3185b ("mptcp: validate 
'id' when stopping the ADD_ADDR retransmit timer") look safe to be 
backported as well, even if there was one small conflict, but easy to 
resolve. The first one is a refactoring, while the second one is a fix 
that is helping to prevent the new issues being fixed here.

Davide Caratti (1):
  mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer

Edward Adam Davis (1):
  mptcp: pm: Fix uaf in __timer_delete_sync

Geliang Tang (1):
  mptcp: export lookup_anno_list_by_saddr

 net/mptcp/options.c    |  2 +-
 net/mptcp/pm_netlink.c | 27 ++++++++++++++++-----------
 net/mptcp/protocol.h   |  5 ++++-
 3 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.45.2


