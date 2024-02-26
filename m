Return-Path: <stable+bounces-23766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C386835C
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9927B21AC0
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D3131733;
	Mon, 26 Feb 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGdcMpyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A212F388;
	Mon, 26 Feb 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984509; cv=none; b=M61tqYyr+WDWAlpxdO+iG655lXOqVv06f0ldF13JrnFWy2nfsK/6fxWWPFR5spJ7q+n6m2KOFMlnmLw/LSRRsoWS1+0IWrHkKe4sleOgEMlzbu7Pim3wkQYxM0BJB/uhb4uYWjaDK75kIv6CazCFyU8K6ToMUIJ2dc8Li7X6n2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984509; c=relaxed/simple;
	bh=bQSmb6GWubXwm1spsbbOAH7ioeH2IKfF/AObHhjwbmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVXgjZ6/vvKSg0SMs91sDL3VuHhLGGgp4nE6Oq37kjdF5ijH1ENfMSTuRBiC7s90PCp7csdsoCrtaKFOviQXTO7NTs7SV7zmgV9Vd2wqtG/KDWJ2wvvW1KFvHglOdfEVu+gAUOkJ1Pe362JB3g/jok2UFvzbKZEpKXfRIGx++7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGdcMpyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F603C433C7;
	Mon, 26 Feb 2024 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708984509;
	bh=bQSmb6GWubXwm1spsbbOAH7ioeH2IKfF/AObHhjwbmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGdcMpyom2lu8ravyHzgrW1pJXMDoS3+DFEOxXcKl6Ys8fhA9NFnkgpE6w8rRRbkG
	 J6I089E0fDbnBsUZ0kN7Ed6226mad+HPOR6cstCFIYmrMWcbmgEn+++FDZgHzEO2zb
	 F15lW2/vglgE4IHU+zOVy9iK1iR0uBOvFOAcbnw0b87lmX45M2J6WX50izmfh43vB8
	 lH+gcB0A2IcUj4VTTHj7M9diOsEi7d2aUlnpU/Sm/+eAUpsS3nKJXxkYq7J/iUMsZY
	 8FNMJZHPb5KYSiif32G9QwZhWQvfsVmKp53grbo8uh5OJdEJboBVZ/QfPkhYxEf6jP
	 WcU0sr1D093uw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] selftests: mptcp: join: stop transfer when check is done (part 1)
Date: Mon, 26 Feb 2024 22:54:58 +0100
Message-ID: <20240226215457.756126-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021917-nuzzle-magenta-7de4@gregkh>
References: <2024021917-nuzzle-magenta-7de4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=matttbe@kernel.org; h=from:subject; bh=bQSmb6GWubXwm1spsbbOAH7ioeH2IKfF/AObHhjwbmY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3Qixec5zuYo47PzPBHWv9tGREt0L9/eRCNWP/ hTPR8qZdrWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd0IsQAKCRD2t4JPQmmg c1+dEACz73L+7MxT+V2wJGC5wNAqubfF5lxVh4vJbBoITIPWqGc0U+1jSamUOzcc8jQImBm1eBE G0ekRGFz960r3USRf4+g+goepbe7wWtphp/9BJwBL6Qw75eulOBuyYaevkJQdt3cxodRLHJYw1R zgMWr7ub2y2K7848xhsFTOumG3eC7jPXdG5ejrr2EXoL0c6u0u/zuEIi82/Q5yALCFTezf7DRKN baBML1GLKwb2JvyOb82hIqbax4ESW+o8cbTz8qObCORStm+bfx/+ivj23MHtqWjQIouK0FYMd4u WBcV0G3pXrXX5OcDZrTiWOHESZEvikzbOd/HvmpHuv+H3UTSsM1eceFnEd1biE59QLMx9GqQdXN 6gI8ZsOHAt+MljBxscvPFZ2BX95Z4jw5mdQiBI+eRC4TE1s0RU//MdorvKA+ZuBA3lL6v8lLTxe 1DlhYZ0q5L6uq0rinx37g/+xiM94l8PRw15qjNqi+qSQVGNGKmz+yn2OIrkkmk7NsrDJ71pVGeu CeS8pK2aT1uPzImJSB8vftj9LObtyn43Ptzr1hOvM4zy8pHxiGZUWsVVOm6ocMqfoUARKGQ+ad/ G5UQovjpw3A+BW/M+llY79ErnzVda7stzm+aLDEbFxaXW1hXktkf0HhA+pZ9VC1DstJJAsIkdCx 0o6/6b6jAuECIzg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Since the "Fixes" commit mentioned below, "userspace pm" subtests of
mptcp_join selftests introduced in v6.5 are launching the whole transfer
in the background, do the required checks, then wait for the end of
transfer.

There is no need to wait longer, especially because the checks at the
end of the transfer are ignored (which is fine). This saves quite a few
seconds in slow environments.

Note that old versions will need commit bdbef0a6ff10 ("selftests: mptcp:
add mptcp_lib_kill_wait") as well to get 'mptcp_lib_kill_wait()' helper.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org # 6.5.x: bdbef0a6ff10: selftests: mptcp: add mptcp_lib_kill_wait
Cc: stable@vger.kernel.org # 6.5.x
Reviewed-and-tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-8-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 31ee4ad86afd6ed6f4bb1b38c43011216080c42a)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - conflicts because "userspace pm create id 0 subflow" test is not in
   v6.6.x
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 67ca22856d54..a0584417bcab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3430,7 +3430,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3449,7 +3449,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
-- 
2.43.0


