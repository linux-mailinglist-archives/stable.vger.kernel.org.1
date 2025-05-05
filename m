Return-Path: <stable+bounces-141410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E7AAB6EF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8989C1C20EFD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD098226888;
	Tue,  6 May 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYkHoswe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009262DFA5B;
	Mon,  5 May 2025 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486196; cv=none; b=cllDUzZm72DUZKS5EG8hl+Bag1SoRJGGlAiwyf86HWEq4ng3ttJ6pcJMzBsVBjjmCaQxwf6Eyx7w77StPIIBtDD6xqyjlx/nwwGViU6L6CbKMWRVcJUjcnhfDOoMgVQwy7OcfPlmaM/pyQh/p2ZwqDq5a00j9l31nucd1QsRjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486196; c=relaxed/simple;
	bh=GVVXTEw23c+3r68phwdy/OxA9lfvg13unNs7GMRjoTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVrmNKuzf7B5bMLbkIdLvFmmWWbjOdYLZqdJj2yvOLVvFShGtLT+RSNU6w3Ulfd9wTGStpHYR/XLYu96v58c1HUx36fYpGxwC2CKtr63nQ/7xhRxcmSoBXOArvVH5bbOtwq22GkZWDkTLUfnoL98DT+EJ+wP9S165EieiWz2aPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYkHoswe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1397C4CEF1;
	Mon,  5 May 2025 23:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486195;
	bh=GVVXTEw23c+3r68phwdy/OxA9lfvg13unNs7GMRjoTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYkHosweXBv4PMyoIV24xN7hpTxBRCpFHiYCiq6lsvLxRR25nrUthAYv8nBPu8fuJ
	 5D7rYHNE3OeGXEQxLKQ9COfczk3iyr40sW5Ekvco5Y04zWEbwpbs2vG0bMWQlQDzPx
	 fvrUFBQIMcAgivEj8mjWSQa/dbOTNozM4B7WmYNx4XdQZoVW3kc78W4OtZRP9Xp3nv
	 HAeJFpXnXKtNeOi578VePrGHCqJdxbsjWqB0TdyFtdo9+PPRPg7C9ymnzx7DxYGlIO
	 AeWQFjuypwefnpiZUohJi6BvQJwaBNtHq0RxQ4SPYjT7+LrPkZZ/jNSlCPIugWLLHC
	 0qUY20cgnc5/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 198/294] firmware: arm_ffa: Reject higher major version as incompatible
Date: Mon,  5 May 2025 18:54:58 -0400
Message-Id: <20250505225634.2688578-198-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit efff6a7f16b34fd902f342b58bd8bafc2d6f2fd1 ]

When the firmware compatibility was handled previously in the commit
8e3f9da608f1 ("firmware: arm_ffa: Handle compatibility with different firmware versions"),
we only addressed firmware versions that have higher minor versions
compared to the driver version which is should be considered compatible
unless the firmware returns NOT_SUPPORTED.

However, if the firmware reports higher major version than the driver
supported, we need to reject it. If the firmware can work in a compatible
mode with the driver requested version, it must return the same major
version as requested.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <20250217-ffa_updates-v3-12-bd1d9de615e7@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 7cd6b1564e801..906f0988bb557 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -121,6 +121,14 @@ static int ffa_version_check(u32 *version)
 		return -EOPNOTSUPP;
 	}
 
+	if (FFA_MAJOR_VERSION(ver.a0) > FFA_MAJOR_VERSION(FFA_DRIVER_VERSION)) {
+		pr_err("Incompatible v%d.%d! Latest supported v%d.%d\n",
+		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
+		       FFA_MAJOR_VERSION(FFA_DRIVER_VERSION),
+		       FFA_MINOR_VERSION(FFA_DRIVER_VERSION));
+		return -EINVAL;
+	}
+
 	if (ver.a0 < FFA_MIN_VERSION) {
 		pr_err("Incompatible v%d.%d! Earliest supported v%d.%d\n",
 		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
-- 
2.39.5


