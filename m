Return-Path: <stable+bounces-153005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5357ADD1E2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713FA17CE57
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA082EBDCC;
	Tue, 17 Jun 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lekd1gs9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D918A6AE;
	Tue, 17 Jun 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174561; cv=none; b=k0upQKIYXCTg3CH0Nxqt1LDD/nJMWivqNJwSOmBmJhoSLkswbr5IS4vmUyIp4PbYfXN6RJjASqEwf/2g0i77mQaQLptL+wPCuItKnCSWu0tIw4cpXs+gzGoBoer6qTA9Q1y9kIm0IqoYbjrvpu7Uc+raO+3J63o2GxcVl+OsRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174561; c=relaxed/simple;
	bh=4snkcfjzb6tI/dODAq7mKZpsEKVgD3eiqnhOFKHuO8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USoPIFX49wYWo0r9mEGLaY2/wB0kJF/Ijoufr+i1sY8vNufWMtCGcvRTmcBbS1mMl2WzjDvVUQr8VibzXXP5+MJXMJuLfSG2MaRqod/OelVIaicUORJR13N+tfAAp9HghNSW0SMA5EG/9c+wK6vSfdCgfL2biJDMRZVPEndguiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lekd1gs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3980CC4CEE3;
	Tue, 17 Jun 2025 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174561;
	bh=4snkcfjzb6tI/dODAq7mKZpsEKVgD3eiqnhOFKHuO8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lekd1gs9km9k4S4UBwJ5MyPmVgh6aa5xoMsbHkTze1IktrT4EzHHmuGQAa5Du8fN1
	 9vLZcL5MtAtXo7uFbuk9KBpyXhI60JAsWfDM3Ngz9b8dSwPMwgska4lP4IXLAo+HZN
	 QaQMi9nCfR/ghZp9HTULUmPIZzG6viTjTZLFUE+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 082/356] selftests/bpf: Fix bpf_nf selftest failure
Date: Tue, 17 Jun 2025 17:23:17 +0200
Message-ID: <20250617152341.518592671@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saket Kumar Bhaskar <skb99@linux.ibm.com>

[ Upstream commit 967e8def1100cb4b08c28a54d27ce69563fdf281 ]

For systems with missing iptables-legacy tool this selftest fails.

Add check to find if iptables-legacy tool is available and skip the
test if the tool is missing.

Fixes: de9c8d848d90 ("selftests/bpf: S/iptables/iptables-legacy/ in the bpf_nf and xdp_synproxy test")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250409095633.33653-1-skb99@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index b30ff6b3b81ae..f80660c00a1a7 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -63,6 +63,12 @@ static void test_bpf_nf_ct(int mode)
 		.repeat = 1,
 	);
 
+	if (SYS_NOFAIL("iptables-legacy --version")) {
+		fprintf(stdout, "Missing required iptables-legacy tool\n");
+		test__skip();
+		return;
+	}
+
 	skel = test_bpf_nf__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_bpf_nf__open_and_load"))
 		return;
-- 
2.39.5




