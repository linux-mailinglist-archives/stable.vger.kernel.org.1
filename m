Return-Path: <stable+bounces-128796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9483A7F1D1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A611795AB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857D25F7A1;
	Tue,  8 Apr 2025 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqop2yX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2A25EFB9;
	Tue,  8 Apr 2025 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073655; cv=none; b=Su+33noi1BvB1nJWKqjdrZX1eW/ATMdlyoPoPk4CS4rbmmGGGjiKHJKjNy3pASjojCwUACE1eYeHzBdWZsB52rvUcmf1QDVC5AAporcW7nlivT9WUQl2ck8xii5obv3+NoPMxdq7JyJy5ywxklwBJuZabPNoGbvq1cwTdNJHZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073655; c=relaxed/simple;
	bh=o9IIhpMkcq8AqUjhaGKgwTnHUVemufUNK/6bG3Ql40I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uw5sce3kX9qHGKsqEFPz+k4PhyxYyv12jgYlxXpijw10UQ5L92JynkETWMHuDGB50QCn9wm4S4SmsSduCxVvA7P8L/JA1ZniD6WSHF31p3RfnKMzaqkrEpMm/3ssbcKrn5OXBA2kcMpVniQIPEevs8HDvARKWdKlvMVmmZSI8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqop2yX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58CDC4CEDD;
	Tue,  8 Apr 2025 00:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073654;
	bh=o9IIhpMkcq8AqUjhaGKgwTnHUVemufUNK/6bG3Ql40I=;
	h=From:To:Cc:Subject:Date:From;
	b=tqop2yX84SZI5eUuqXfeolaM7t8a9OteKodikteaFyLft7nppkwmiWrNg/RyOYtPk
	 lKDH33AbvX9yS6B03Iw8Dc2DQbsw72Qwng2cW3VIWXEpwOEy333W+s0S+ZpkVvttSA
	 dBUN/GzSNsE6AYV7jgV9kU/U9hLHu/Hvf1mYxA0O/56B7Shs6R2ClgbJKQuwofglQF
	 RRgS6ctitEffTJqXQajkUQHwPP9m6uePtlLgHkcKEfuwECkcarDiv1IGtWprwxkVtg
	 sPCoWzUJ/LhFEJ53jPyYKpN2FzB47jcffsuTIwGo5Makg+A25g3+0ngHovuVB6ya3p
	 IZCWw2japm8qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	tj@kernel.org,
	akpm@linux-foundation.org,
	mmaurer@google.com,
	yoann.congal@smile.fr,
	jeffxu@chromium.org,
	roman.gushchin@linux.dev,
	axboe@kernel.dk,
	chenridong@huawei.com,
	jannh@google.com,
	mark.rutland@arm.com,
	brgerst@gmail.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.6] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:54:07 -0400
Message-Id: <20250408005408.3334851-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 975776841e689dd8ba36df9fa72ac3eca3c2957a ]

kernel/sched/isolation.c obviously makes no sense without CONFIG_SMP, but
the Kconfig entry we have right now:

	config CPU_ISOLATION
		bool "CPU isolation"
		depends on SMP || COMPILE_TEST

allows the creation of pointless .config's which cause
build failures.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250330134955.GA7910@redhat.com

Closes: https://lore.kernel.org/oe-kbuild-all/202503260646.lrUqD3j5-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 1105cb53f391a..8b630143c720f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -689,7 +689,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


