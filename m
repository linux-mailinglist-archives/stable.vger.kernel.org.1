Return-Path: <stable+bounces-128795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D5A7F1C9
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D43B42E7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE725FA23;
	Tue,  8 Apr 2025 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ6QIA5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136525F7B1;
	Tue,  8 Apr 2025 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073647; cv=none; b=jJocIQlUCGfk1y7pVibcp3XV6qGXNFQXIST5WCMywJB+Z2hiH7PbbnPZD2GVEYZ5j+q+p4sgqJyFI2vxm3Udzw0vIxhOxAxAU6I6DH8dinCSjyJu1MUzWvuGC9aMFJE7YqGuNvHCjBXyVyVKfgWEVBVi7dpxtvMG3oD6ELN+HGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073647; c=relaxed/simple;
	bh=MVR2vAI22iGvBbBnR2pt1Mw9yEChpxWKfs51ldW/Ais=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RakQB4qMC4fCqT58y7a5YW0wM3uomXwDXl+iW3rXMlV9tpIeNQGUd/db4zN9S4UwG40v7bFWLfPRao7lGeAAoniELLupv2xc32hZPtDwyenGzcYK0VqlEcg5Es72objzvX+D5hAQOgm+FU6Pe5c1p63BxAWANEHAMsskHM1NBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ6QIA5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FB9C4CEE8;
	Tue,  8 Apr 2025 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073647;
	bh=MVR2vAI22iGvBbBnR2pt1Mw9yEChpxWKfs51ldW/Ais=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZ6QIA5ulnqQCaJNV/qlpKKKfvqCJ7KSXPMWQe6xWS+TGHG+8mp+yDUs1YJWk9lJm
	 slleQkCo+tbABqQ0UJUH2hzaRisnApg+hPr0Ph25B/dI9cJmRCex3q9uCn1YfsLJrw
	 gDogE0cNcmiMUApYvMB7wjTEi6pKMW4FWlZOCtxGg2ZJ0wk2BowqAuXItA4zz3gvPw
	 fcNaQ3O1hO+SQcRneZOPHl5Ao5llRkVRTT8dmNOd9hqWezifDv6wqUSBB5lF9Ekpwc
	 JckrtuKjiuji3QCrjgozHca+56QmC++eEY/EKv2RSEt8luAQUe312P+qGi1uyOzpuz
	 ipsQ4TQfMjICA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ojeda@kernel.org,
	aliceryhl@google.com,
	akpm@linux-foundation.org,
	tj@kernel.org,
	masahiroy@kernel.org,
	mmaurer@google.com,
	yoann.congal@smile.fr,
	jeffxu@chromium.org,
	roman.gushchin@linux.dev,
	axboe@kernel.dk,
	chenridong@huawei.com,
	jannh@google.com,
	mark.rutland@arm.com,
	vincent.guittot@linaro.org,
	brgerst@gmail.com
Subject: [PATCH AUTOSEL 6.12 2/2] sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP
Date: Mon,  7 Apr 2025 20:53:57 -0400
Message-Id: <20250408005357.3334801-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250408005357.3334801-1-sashal@kernel.org>
References: <20250408005357.3334801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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
index 293c565c62168..f3d2a9b50d76e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -703,7 +703,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
-- 
2.39.5


