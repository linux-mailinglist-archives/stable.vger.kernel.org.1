Return-Path: <stable+bounces-114457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD8FA2DF82
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2262F3A5898
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197A1E0DBA;
	Sun,  9 Feb 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3RdnNwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C01119A;
	Sun,  9 Feb 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739122931; cv=none; b=Ina9ZW+E2VDP7DOG+k+/tYA332sYjb3Rm7FXEdW2y1xBmDI7dyA1KbdLVjcJ1hgK88Ax1sDp6BGXoH0XJvYT+bzL8eqVeQ1ioVYHngDYw7yCOohewZdBDYySyFUMYIQ65V7xoP4oft8L1xk2no1BIXE8kvic6YoIlrPbs5pdIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739122931; c=relaxed/simple;
	bh=cuUt1egyq8aLzljEavuWKEmeQscdzA1ymBVXkxO5Ixg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaOw+Bi5cV1vY4XxQNRzsBvFkQWNKkgbFENoZ5R//axuq4144v7Kk5fx2SUvNILvXepdZWrrSI2zco4TPJIogqsVArLVHnkUx+/vpt55tDIJnzhLN9vg6mLCebp2KKRads6ck4+Re9UxRKZoNvjgygnHWK7l8zMrqh69eQeYo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3RdnNwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45EBC4CEE8;
	Sun,  9 Feb 2025 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739122931;
	bh=cuUt1egyq8aLzljEavuWKEmeQscdzA1ymBVXkxO5Ixg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3RdnNwl6ulwqGfRHaTtmm9Qx+YIArEonUmeAzBGx1801ksxxp5ztGm9fOilt64Oc
	 bHIu2WYkCccfkiI/NOjJl5LoIN9B1NyFrZok7BZXwR1cQkbFVky3aZP+t8siI/DOZc
	 f4R/3cpXQspQfRBvbCkBIqSib2BTIF3jF3FBOezqm1wO73/ckq7H012mvg5xD53k6m
	 XX6znq2Q8NjwQZ3cdk0wU/regDj4oBktC7m2btYpkYVdZj2Y9CA2dtzfVFlAPwzJyf
	 styf464y3BA8mByZCO2J3WMS7TyBcWuZTi6F9GBU7vz4ikxe9UXzoj6MbOQjR5LEkc
	 rUinSADV4y05g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.6.y 3/3] selftests: mptcp: join: fix AF_INET6 variable
Date: Sun,  9 Feb 2025 18:41:57 +0100
Message-ID: <20250209174153.3388802-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025020428-unashamed-delicate-248c@gregkh>
References: <2025020428-unashamed-delicate-248c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=matttbe@kernel.org; h=from:subject; bh=cuUt1egyq8aLzljEavuWKEmeQscdzA1ymBVXkxO5Ixg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOjiRV4fA0gjHJOxKlvQkoLsxmBTU+Iw3w9/K EQjMWgjBeSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jo4gAKCRD2t4JPQmmg c+XtEADLindeuWwZ9tKqLp3MjcboT27jY/+kWoJziXaluEympQ6c0YgzVDHzzZNVXJoLFPRqP4z /I+eRr+d87buhLZik7jAj4jUT5ghrb0jVlipE4FiSYTJyP9YGFh4Cbsyf4NcnTgCyMSYCB1HUCG Dg/+WOeASMQlQ+q7RmYGBSnGIv2r+ALqq5ih/TsyT+vlmBxd+VXB9Ct1A82JzmgB9IEkV8HSHbx McMRrps0m1lqHTeZBtQKyJbnZ2vg1/KB/BHmsIPrZRgsoYXdNUbQmouV9l+UT3hpFYIQu4uloFr QnbVOW0aCbMNpjp+sOlPEuJOtCnrZDDsblX1SDzfmx/sWd/m2hWB7d/lsh/fMdxUX7ItSrDibp+ qfv0XzDIBMviKteeg5nKJgzF8YcXzab4RuDALtfC1yHqvq+5bCTHr7A4+gOiZ6UnRuNJozekRDz dOGHo6hUKte2HQ04PN35rOlWoqw0tkvnmCmB6FGdEpufcTX+7i3VeDvXlNVroPOeQCcMi8E8XmM /MJkDxqzPMGW5t6xpSNToT2UvKN3jfBhSHjirCie+ALNenJZrv2OUXSJ8JsqVdHeAUIAV9bJklt QGZUatN/1lT9etFNCVPkeDd8MtCPz6Wi5wY33Lortb3Uqi7LDWwsT19+T2fglRkut/LHXNmx4z+ gs9e6Il/eOCQi/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The Fixes commit is a backport renaming a variable, from AF_INET6 to
MPTCP_LIB_AF_INET6.

The commit has been applied without conflicts, except that it missed one
extra variable that was in v6.6, but not in the version linked to the
Fixes commit.

This variable has then been renamed too to avoid these errors:

  LISTENER_CREATED 10.0.2.1:10100     ./mptcp_join.sh: line 2944: [: 2: unary operator expected
  LISTENER_CLOSED  10.0.2.1:10100     ./mptcp_join.sh: line 2944: [: 2: unary operator expected

Fixes: a17d1419126b ("selftests: mptcp: declare event macros in mptcp_lib")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 17ace5627ce3..497dc187387f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2941,7 +2941,7 @@ verify_listener_events()
 	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
 	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
 	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $MPTCP_LIB_AF_INET6 ]; then
 		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
 	else
 		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-- 
2.47.1


