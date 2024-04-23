Return-Path: <stable+bounces-40588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B49848AE475
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD8CB23819
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD19135A68;
	Tue, 23 Apr 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNxN3Qa+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3C135A54;
	Tue, 23 Apr 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872423; cv=none; b=dQ7OK/PRgOU1Eo/KZ+s0hwGpASr3sOQrlQ/ON1bmIktBqJtJJwlJv71b/T3NYkTvZYud4dLT7d/JKf8r4Oxq1RTbMDj3C80/lreLva8Lsa4LpVuGOb+JDVwr/76SHl2v08Z3ZaVKiIxIYu5H49uRT5CY7tggA+vl3ipt9KXOAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872423; c=relaxed/simple;
	bh=hKwut95N+tCwwDS51J+BHVxNHPqZYt4fc8mS6/l5WkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHn0G3ujV/8Cb8OOKcrxi4rhQUU33BHeHPaWfFfFPbkwe4Xgg8A+3XOR2tvENMugcQmzd8N9JZzeDZYzYqk5OtGocdSDlVgnBBDXpbOtYpeBb4qQNHYLtelOaE2nTqgSiXHRUV3JIArg2CgXifEInEeDoHSN2v5kfKXiEZILhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNxN3Qa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B37C32782;
	Tue, 23 Apr 2024 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872423;
	bh=hKwut95N+tCwwDS51J+BHVxNHPqZYt4fc8mS6/l5WkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNxN3Qa+BgTzJgxOWG9hCT639w5Q9X/ySlP8Ad7loDKxZZ2pngUbah/DcLUtUwg7r
	 hrqxSWFupX8ZTJnl7egyPew5nmYFOs/goTt/wOcqYm2uXJy4ZJ6deSBj68dQAp3+YV
	 DhVR3Py9LIXg7neeNB1nHnvrguOzv4C93EFUISNyWjy7dKu98+g1aaKw5i4zrdehgu
	 ENPIR5GrMBAbIyYYU8NlVNXaNI6+9zojFqV2TpqQyYbQizCPfpDAo1z8yJSd6eo2Dp
	 d+1GYVWJomTK+71z5m/x0waPoXkPGJuEvEAPxXERALddFjVc/BFgQEzjcvzMgWKD24
	 7Y6+Ygfi7DHhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 14/18] platform/x86: ISST: Add Granite Rapids-D to HPM CPU list
Date: Tue, 23 Apr 2024 07:01:10 -0400
Message-ID: <20240423110118.1652940-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit d8c2d38c4d1dee8fe8e015b9ebf65bdd8e4da99b ]

Add Granite Rapids-D to hpm_cpu_ids, so that MSR 0x54 can be used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20240415212853.2820470-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c5..30951f7131cd9 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -719,6 +719,7 @@ static struct miscdevice isst_if_char_driver = {
 };
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
-- 
2.43.0


