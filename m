Return-Path: <stable+bounces-27246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0444877EA5
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 12:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEB1C210D6
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A57A38F97;
	Mon, 11 Mar 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knA8hxiz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128C22338;
	Mon, 11 Mar 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155577; cv=none; b=tdF+8uLprvVOQ91TX8w8BR+cRmv2nJDi9wRnNR3pO527qc8vpiQvq4puvT05LIIDekFvNFfeenOZ6K23+WKCzim2iuVpwbl4PsejCmHx3MkMGBlWtEFpO1XlzFlfSxrxmB0Ho34c6LANLVqTWHCs5VINNBxEFBCKVYVekD/0oB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155577; c=relaxed/simple;
	bh=CM+eUDxsbUMpQRvQcjibOZWF3uIbEEXRCINaMz1kBbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/qBpmkf8Tc026LwcRCboOxDi8Zs03gj2Rvp0Zhr3aoxpEmIFDWgAWjvT3rJTD1dyKOzW6FB40PV0CYMneZ0Bb944FhTcarjRMUOWKokvbx04oiO9doHkvqgqJJgcfpLTLJxX3+Id2JORw3He/afoSqXsEykIT+Ylq0yhLD5SRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knA8hxiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64D1C433F1;
	Mon, 11 Mar 2024 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710155576;
	bh=CM+eUDxsbUMpQRvQcjibOZWF3uIbEEXRCINaMz1kBbE=;
	h=From:To:Cc:Subject:Date:From;
	b=knA8hxizA9rXH9/26tN0j1sIIey3s+We7M3iMFepnLYJoprifjdgtG1Glv7f7RZd8
	 F9yyTGqt6WrpXA5sNNtvZ2BghSc7qkh1fYMNZvxImF71YgZe5xlXi8s1PWns/B70ag
	 +vktA06oQnWK2bA2oFk96O7JkPgAlE+U4lYhI9yo6XKYZEUS7ymdlmBS+y71UFKWyK
	 0WXLkYmv/Q/+jbdr/THPBBR8S3HP93cZQvEe0tBi2aLfeb4R5oSf7n1qs7hNvRTaip
	 of1cwwi4GY51+8IBMgyiV7PlxSwaVPk3TWI2UEdsc7lEWp5OA9jw8GxioyXz8E6UBI
	 +/zluqLX3fw6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: decrease BW in simult flows
Date: Mon, 11 Mar 2024 12:12:25 +0100
Message-ID: <20240311111224.1421344-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405; i=matttbe@kernel.org; h=from:subject; bh=CM+eUDxsbUMpQRvQcjibOZWF3uIbEEXRCINaMz1kBbE=; b=kA0DAAgB9reCT0JpoHMByyZiAGXu5xijlujc4Eq7FYNQYc2FZj4LM/es0sLblHzNR0/bOazkH 4kCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJl7ucYAAoJEPa3gk9CaaBzQpoQALWj 7XtI47zYtB8DnCcJvBbPqz8Skrp4To+rIPpbU4/NebbVL/QG8Bg1/VvWnA7xRtMfYUcPiwjpm2j qDNiN6kJxIGuUYzk/mIsO6YZ3zV6bY8y7/R98tJPOwiJxZ1inu9zYGK3Cqac+TyR3LU8h2yU8II fuazvPs+yT3LBJ/oa/Igx935CGFwz4gyJPJXZKL59/1jfedXqdwP2BC/VLpSiQ4lYWkMrviIMdB Q/LmlNnvRuuPFvdr6fZmhuEsJLgoOKxjG+UmqU/K5FN01MRLlAgorGLV32lrwLn4kNuZ1Tp+MSu B6YtV0ja/X8rKNAxxDG+bSl+itwsKEWxL3Hv0elyJmSOTPGfsTRfSe6Kslu+XjuGHqIeaGtsY/p 3BPbxl6OcQQ8oGOX8EFvRpCUD78s3IC3C8+ZS29ASpvgbirDB6jfa4zmy0L6cOxHvkR8WsaJrRz uSFkcLRCtmjZ6ozTRkZY6WhqQpsPAp2GtwEeMI1BeXv/10YymwismQb1A7KnmpjBURb0P12aF+Y Yd6jfyuRX6AgKD9HYZ7jN4cSqYhDqO9le7fi6LVkj0A1AmaqJNNHmGyoodl3COjF5ZIvu6oAic5 HlmmRaePWEq6dZomg/23NJf74kz8GE0egNToErBK/XFagBE9z63HfyaxEPhoGE+wSLfjeSsoZlL 3rtH+
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

When running the simult_flow selftest in slow environments -- e.g. QEmu
without KVM support --, the results can be unstable. This selftest
checks if the aggregated bandwidth is (almost) fully used as expected.

To help improving the stability while still keeping the same validation
in place, the BW and the delay are reduced to lower the pressure on the
CPU.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Fixes: 219d04992b68 ("mptcp: push pending frames when subflow has free space")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240131-upstream-net-20240131-mptcp-ci-issues-v1-6-4c1c11e571ff@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 5e2f3c65af47e527ccac54060cf909e3306652ff)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Conflicts in simult_flows.sh, because v6.1 doesn't have commit
   675d99338e7a ("selftests: mptcp: simult flows: format subtests
   results in TAP") which modifies the context for a new but unrelated
   feature.
 - This is a new version to the one recently proposed by Sasha, this
   time without dependences:
   https://lore.kernel.org/stable/9f185a3f-9373-401c-9a5c-ec0f106c0cbc@kernel.org/
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 4a417f9d51d6..ee24e06521e6 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -301,10 +301,11 @@ done
 
 setup
 run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 30 10 0 0 "unbalanced bwidth"
-run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
-run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
+
 exit $ret
-- 
2.43.0


