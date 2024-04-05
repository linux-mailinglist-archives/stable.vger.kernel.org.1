Return-Path: <stable+bounces-36134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A040C89A1F5
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B50AB21407
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468E16FF4C;
	Fri,  5 Apr 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2/5FLfy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5116F82C;
	Fri,  5 Apr 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332502; cv=none; b=DXlvyclcToQliuecpcQgQYBwVP5ljxzawKURq32mQCnkpXZ9qeydebfn3D+hxQqd0Xf6Y3l+hyvb148s7AFr3hsbpV4JJD6u7AXZKkJFUO7pOEX+cHWZYdqhn2whlQsZmLA7eu0y7bXdpPi1GTTQo89IFn8mMJtu4OqkcYqPpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332502; c=relaxed/simple;
	bh=5ij4/+7EdZh2WBzZEgybsllfa6XwwEYxPpDJnzXsd/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqjQA7uPxEl6qWUMcyGYH3zxLt3oHtEbxOPMHVx09vZhvf9FFrQy7cJhF99ymIpQIgsRS4dWzwloMNizFWGEkjFIiAdLzwaqzzSF1O9soG5IpS+55rI/e+Xqhutv/QNQkOxOyr0qkaOy8zhhFvoIc7CNA2QNI42SJhHEk0nP200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2/5FLfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D1C433C7;
	Fri,  5 Apr 2024 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712332501;
	bh=5ij4/+7EdZh2WBzZEgybsllfa6XwwEYxPpDJnzXsd/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2/5FLfy1afdR5spMBDh2MXWU1Bm9qdzFrBTKelKQ9RJBSw18xE+WO56N9Re5VEJi
	 AkjCpTb3NAsEW1PyxM7ed/nBMSVOW4rx74GmvyKyQmrAKXReknlMnqliDi5jrSFyS/
	 DYJfsx2FgtADugEKvUaPBW4dI8062bFbzEEgtQSPtk3fMDKuccA4/ArzJjIByb3O3b
	 2DHL1DD7rceLqh1bTMknNLU/+ozM7bi1d8qEk0xGeh/SulIA4JWdqpN/8XKoOvJc54
	 D6RpGCmy5xjfuwTSoiB7+59nBJ+Kn5jSpFoyEZKpsT7rGXbzN/HLTasYdOAORqizj5
	 zhZvPPNQ5BYLw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: fix dev in check_endpoint
Date: Fri,  5 Apr 2024 17:54:43 +0200
Message-ID: <20240405155442.1054470-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040506-skinny-unsuited-f487@gregkh>
References: <2024040506-skinny-unsuited-f487@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=matttbe@kernel.org; h=from:subject; bh=npnpC/l59fq7S8IMWHjtFMJFrHt3mRImtl8n34jmohQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEB7CBPR49r72teA/TptYNB4gxJSvnbFOQRzh9 q07BHdIV6aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAewgAKCRD2t4JPQmmg c6aUD/9t0cQxj6QwWB5YB4QFC+c/IIkERY6hYMNSOJrsn6cNuCqIYpoc2pytpys2qCP6lfitbYG Q5fxCkZ5bAOGB4aj/Npq9ptsgAkQtMWZXlnKpsj6tUxe/iRk4SJPC9HxZewGQdkOWRrvSufAFLo RhXDjxSOMPQM2tpDdPHNt4lLaZafP63G9yKV5FpinPBHCOTxf53bW1HUTi2z4663mM79V7Wy5ud 03m736ldUjmUmNMqSNRFash7DTafFxr3qrATpM82I5jDjz/H1vedfeh3Fhd2h+IadQ7df4Ofpj4 92Yw0YSVCb9C33v4Sow1IKhbrAH2g0rNLwTd9xx6CYd6xUV2eUlpulPoWl4Tk/2Z44kl1gH6vXX RltqjzLPc62lzpJNd12PKHmrOnCZurB6925ZEbyb4gh4E79WspKc00hxcTnpAyD+HLyi9OdWcSQ hIFJG9RAeuKFyQ/RJzapwYRuwyWvuvnYM4gfghztXF+m/aGjwDaTuArosCMOsuymdqMek2+Opth WO2WrjmYopzEV45RABQcpExvpp3tPu0lg3inTjtixx9q7xo7B79NyToMQ2+crugWdOPaQbVTKgZ L3awDtVgxlGbH/jS8uYRs3yc/I4czW89NlEJp0Y+W1U/fXWFt7apQvqPM/irSwflXNtAVEv6CbV a6Yh/p1cmfXCKmw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There's a bug in pm_nl_check_endpoint(), 'dev' didn't be parsed correctly.
If calling it in the 2nd test of endpoint_tests() too, it fails with an
error like this:

 creation  [FAIL] expected '10.0.2.2 id 2 subflow dev dev' \
                     found '10.0.2.2 id 2 subflow dev ns2eth2'

The reason is '$2' should be set to 'dev', not '$1'. This patch fixes it.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240329-upstream-net-20240329-fallback-mib-v1-2-324a8981da48@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 40061817d95bce6dd5634a61a65cd5922e6ccc92)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - Conflicts in mptcp_join.sh: only the fix has been added, not the
    verification because this modified subtest is quite different in
    v6.1: to add this verification, we would need to change a bit the
    subtest: pm_nl_check_endpoint() takes an extra argument for the
    title, the next chk_subflow_nr() will no longer need the title, etc.
    Easier with only the fix without the extra test.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a20dca9d26d6..0b433606a298 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -725,7 +725,7 @@ pm_nl_check_endpoint()
 			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $1"
+			[ -n "$2" ]; dev="dev $2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
-- 
2.43.0


