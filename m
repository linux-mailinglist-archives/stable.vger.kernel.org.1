Return-Path: <stable+bounces-23750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B12B86800B
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB8C1C2795D
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955EC12DDBB;
	Mon, 26 Feb 2024 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbhwLYpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C61DFF4;
	Mon, 26 Feb 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973449; cv=none; b=NDOrlYF85M+N480ItAP9V8Se6cM0nDF+y3JKu4eYyDj6rybSKSz8j6plwKbCTHItediZ/esNIbqXimVCYzKs/ktUWTveK87Zh/6XrE0v0fVL+K1G0O0kqaq4oqFsD6SJE3wg5MjLD1eKw/cBIj0G88vKNFJ/NNHQIfR9H4oaEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973449; c=relaxed/simple;
	bh=1LDz9k/WIYEGkftI9LRKZ0K+QjD2ND5CIN2Ozj+3DtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLnGag/R/jqEQrQMoPN3O0CbRPIEKldBd7aAWniRP1lG18H0s5WJIOaDeHC/ioKBEuBs4EP9ChDTtMiFs90/DhvnmQZV516nSBSEyCWVACChn2PFKK7Xc6vXT2q2o4B3KQ1hqXR2ELMVRzlctWrWob7+jeMNOAY3UrgYwHc1gNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbhwLYpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8AEC433C7;
	Mon, 26 Feb 2024 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708973448;
	bh=1LDz9k/WIYEGkftI9LRKZ0K+QjD2ND5CIN2Ozj+3DtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EbhwLYpFcxYboGS4AklZhV7JkBc4+nxUmmVbT5CIoi3/qAV8AI82uQ3GhLb7Z7Uid
	 vlkrk1E8SlZDvRowOUoU+yy3C0eAAcJC6I5Gk/VGyyfcp7sHh+Q0bxYLJF5OtPuvdY
	 iXbS3QLJS6ZaFkghIisbdY6PyduAffr6cGUq/zzEsSZvmGUiQkISSG6SO2WdkzM5dT
	 FttuT+BW9BHqID2KDGBwlLix8DudxyRAh6zoEQCg3mIcTAgv/a6J1/SuPwrxlfoHyE
	 XafcEAGtgs0BfScVkFcc4d/G5GzxMBU+mrhJqvjoui5gfnlG88Y60s5UcooJuLSFF4
	 buMzPX+AP2MoA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.7.y] selftests: mptcp: join: stop transfer when check is done (part 1)
Date: Mon, 26 Feb 2024 19:50:16 +0100
Message-ID: <20240226185015.446712-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021916-striking-evoke-4847@gregkh>
References: <2024021916-striking-evoke-4847@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=matttbe@kernel.org; h=from:subject; bh=1LDz9k/WIYEGkftI9LRKZ0K+QjD2ND5CIN2Ozj+3DtM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3N1niWZdRLs3sJ7Q50oeg6J4lR6oOhwtiTUvL ZrqEuvz2EGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdzdZwAKCRD2t4JPQmmg cw0OD/97IEBAgmhbaomBBfNb4MUkNd1hKNlvtu349KFSaqS2T0srj/E9O1Qug4+Fs8Dv+lsSabE 141d0C9ADe7VTXfYPTBVtq//wJtex1xe/BTaXjRN1j5H7rHoRS6rRGR+eimcVTinT4gJEdn/Acd JMVCEwF9Khf1P/GdFVGbFj8BWVVi0bSwZw2H6Z60oa0nbj0kOXfe0Uo5xgSK9NRUGZb+qrNL0A2 zrlJpawEWA+1Fo2pR7T2B+dVvz9D31sQI/396RMCDRkv/UD0ObfjXUMWqWQKUJIi1zwUC8eonfh TQsJp+WCta3zKYJd/lGTZvRnsl6V1mXzj2bRXcm2bKU046UBlUaNEzxOJEmokTDhLaEC/N3CvD4 hBcv+sareRYtfPd4XBgo8379JIX0MUYW3X36IsISLSA7jMOddtYAXAxEWvuTdrYv9z7uBv0UruA hp0XivqTs+qnTzJ6/Bm8Rf2UmdKkV/CwieSTm9XnvviR48TBIbCll4v4q+Vs2tuQOnvNe8+0cyq MIGcYezcppU89n4rYUTiuN/7ECx7Sginosc448VYyQi6F1FMYLmns2viar+Nz7q4OHnwz5Y3Mcj t/+m0Wy0ovzAR9lU1pdt/NnmDe9dBOpMogFs7iLgaWEfeF8N3U+1nfhr8Ac2xLpIDVP1VyZ4ZoF jav14wEei+GvX9Q==
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
   v6.7.x
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ed665e0057d3..99674dafa698 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3433,7 +3433,7 @@ userspace_tests()
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3452,7 +3452,7 @@ userspace_tests()
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
-		wait $tests_pid
+		mptcp_lib_kill_wait $tests_pid
 	fi
 }
 
-- 
2.43.0


