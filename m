Return-Path: <stable+bounces-48981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0E8FEB5C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD881C212F4
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDE1A3BCA;
	Thu,  6 Jun 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gPcNqfF/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B110196D8C;
	Thu,  6 Jun 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683242; cv=none; b=piq3oSDI/MRE6aL1bLgDjaunEZ2NLwhH2p6WRQEYwp8ZJmkxpVNwZJZV2imTZVbTw2ZEUEzWHW5T71l+vRbtp4uncWiwOg6hPWBk217tghnTFOWzqh+2vjnmnyJHcGreJkcgbhVq9rmvs1bny7kXuT0T01Q76JA6IabcO6j2PkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683242; c=relaxed/simple;
	bh=ZbcNK+oZO5k2s0oos35KdCwBIxpyVmT/+vmJBi5buno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSMVxtH6IcWxO/0MkPURp9njv/AWJrFntcSkA2HWAZgW+K+wvHIbFG4R3uml+W767EKlvJnCFnpixV58yENg8Og3F00XEmsNMHz32MS4yAWhLpFTTjryX6vLqp6wAdFmpH3kxH0a8udTqy8Mokkt9RfKX/c996Ci8Jvh43ZchO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gPcNqfF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC41EC2BD10;
	Thu,  6 Jun 2024 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683242;
	bh=ZbcNK+oZO5k2s0oos35KdCwBIxpyVmT/+vmJBi5buno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPcNqfF/mQZWzenNQFUpiB/rQV77o9Ibg8uX9Vxw5FqGSWBgReqwQ00VlqDXX7YWF
	 Vj4EVTHxPJEmPoRNuoZvS/w50DvfNnCZa5EMY0TQYxudD0vJhjv7RBJyWYZd8upNJj
	 PzKD4BREZyrhUxKxTOzm7zAJ27khuD78ZatCT5xc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Yonghong Song <yonghong.song@linux.dev>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/473] selftests/bpf: Fix umount cgroup2 error in test_sockmap
Date: Thu,  6 Jun 2024 16:00:48 +0200
Message-ID: <20240606131703.876697232@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit d75142dbeb2bd1587b9cc19f841578f541275a64 ]

This patch fixes the following "umount cgroup2" error in test_sockmap.c:

 (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2

Cgroup fd cg_fd should be closed before cleanup_cgroup_environment().

Fixes: 13a5f3ffd202 ("bpf: Selftests, sockmap test prog run without setting cgroup")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/0399983bde729708773416b8488bac2cd5e022b8.1712639568.git.tanggeliang@kylinos.cn
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index e768181a1bd75..d56f521b8aaa2 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2086,9 +2086,9 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
+	close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
-	close(cg_fd);
 	return err;
 }
 
-- 
2.43.0




