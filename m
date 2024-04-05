Return-Path: <stable+bounces-36129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E489A168
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D251F24DA3
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975116FF22;
	Fri,  5 Apr 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbGlZXqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBA16F909;
	Fri,  5 Apr 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331435; cv=none; b=UqL8oO8+u/F7nTppzm0v6ZWmCrIeycxDBNzmDHfOHXc8+ZuQU3s7XO0V9Wfo07nPDVSsvZbyUU6qQOxvCyXAK6DEZxryOexQKlYK0Zlry1Y8nPZb2aPxuel1N+SRj86jJ37t/dtArl4jHNm4VCWKD0By2M1xXIH7XSDSgaEHf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331435; c=relaxed/simple;
	bh=KA/knw99kKvufZ3stg1yuksDQP+HkqNDjsO5wV3dBc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9rOr170FDQxpSJMbEke6Gq5/koAqW68uP4frR1kuQeFp7NUDycDOJpDQ5rR3ihz4g6g2AUYhLumBZUfwqNVYAFpbRq8eZKVpmQ+2r1w0xhwE5TCKN9dC35NOGy+n3CXWfFQvoNB7ZtUU5BE5NJD2cOqvkT1ZEy4q02YyZgJ8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbGlZXqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4F5C433F1;
	Fri,  5 Apr 2024 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712331434;
	bh=KA/knw99kKvufZ3stg1yuksDQP+HkqNDjsO5wV3dBc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbGlZXqKcmaFbYqhtyw8r0stuRV2Oa0EhJUdH6EmJVWRvDyTWfXiQ7j7hIt2zZLo0
	 giFVFgxErq2EwqFCvympDEmOjqWJhz+7xeV8Kgn0iIifpu55/8q3MEBAfNxBxj/ngk
	 ZuU9rLMt2IHROEcNAMksZ3bctB3Eoc0NWBg6QSvZONlmM5UuI12wHrDchoT0g0QEv1
	 +mAYcnKJk8/CtFmimDrx/g2GIsPacAR3zCwaJF8HldLXL+THspbcwBiZj2VR6bSWc3
	 pp3W0j4cOkN9KpXG0zmV0ayLfSHf6PrivHQ+MqB7F9bbB9/8g+1UVN7xL5I1Vpyj4O
	 baIi7K/m5WgRQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/5] selftests: mptcp: display simult in extra_msg
Date: Fri,  5 Apr 2024 17:36:38 +0200
Message-ID: <20240405153636.958019-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040520-unselect-antitrust-a41b@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258; i=matttbe@kernel.org; h=from:subject; bh=+3su2L5R0LAF+maxD80zLdm0OGtC8WNVW8mp3Y/kFX0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEBqFho4X/BqfSKjXJityTB1uGIEFqrLKlo36b fugGIv3ohCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAahQAKCRD2t4JPQmmg c1BzEADJrjdt1M7JWrHrgBIlbmdts044EAWCS3+LqLy+LM0AQQOf/e53DFvkoPPnpml9+5bjKz7 GIQSGrdCeWWLgJKR5yKe9SBSEf7tFjhvQz/58OcDy1gVeU5phzDCTG5eeNBeQJ5Vsalq7mr/ZT2 mzYOIob8Beq5ywSBAFuuH+pe5Y4qIG9fBkqbBTq2DD8IAvq+uvFnKE+kLSCCaqyPNMY3kBF0OXl kXy+lGSrueTMkE8x4tSiRav2smqs/563xUD0KxwfpyBSlCi6dr0xJ07E157aS/AtvhqS8SdKQnk OVV7JNKZJ6UcgORX5bFiEBs6Qc4SQasFcLhnNmVuW0hjXwkvvhUoi9LgM+gZa3XrL6lZHbh7cYg CsLdzin6NCFW5wsNieBaiRgUFQQZBhAB6/Y+QRpKb3XLcjTdwebRhlA1CELBn2KRyJZ8WIC1iNw oOwrwHlh3xEYrKgX9du9fhy3cZGXTaLMx4I6Jl84NPBNUKaBgDDM0Fx3GbLAUsCH8tNSIxVssnt UGbpVC9fMgbg6SHSA8Y+boU8aHiwLxn8Xt9CSjL9bVZx4KwiI2X3DnOANxYYo9kiF5SQAlzfxJL MBppERd4UOTHxfH/bRj1rXa9Ub0o7+8Dq/P98OlFvbm6hRrHnkvnJ363C6xhErIBLYOd4FbzfjS 4p5UKXehuelU1wA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Just like displaying "invert" after "Info: ", "simult" should be
displayed too when rm_subflow_nr doesn't match the expect value in
chk_rm_nr():

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ] 3 in [2:4]
      Info: invert simult

      syn                                 [ ok ]
      synack                              [ ok ]
      ack                                 [ ok ]
      add                                 [ ok ]
      echo                                [ ok ]
      rm                                  [ ok ]
      rmsf                                [ ok ]
      Info: invert

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231025-send-net-next-20231025-v1-10-db8f25f798eb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 629b35a225b0d49fbcff3b5c22e3b983c7c7b36f)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 34c342346967..e6b778a9a937 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1740,7 +1740,10 @@ chk_rm_nr()
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
 		count=$((count + cnt))
-		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+		if [ "$count" != "$rm_subflow_nr" ]; then
+			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
+			extra_msg="$extra_msg simult"
+		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
 			print_ok "$suffix"
-- 
2.43.0


