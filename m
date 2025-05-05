Return-Path: <stable+bounces-141190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B3EAAB16B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC153AC836
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF63C4DA0;
	Tue,  6 May 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5zODUkV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B082D0AA7;
	Mon,  5 May 2025 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485460; cv=none; b=F+L0M4L6O45BS6+AZNMBWoSnoqVLGUB3OxP4xRZHRrnSu9aTrBMTOA08jYrvCZSXlQcCqWuDW3Xsn0mxEZCvfu624deMz77VFXIKfNne3F8cYEZ10mTqliYufLsqiew0kLrRLadip39oMc4w6430lYfIo+CqPUtxKd6i1cwID8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485460; c=relaxed/simple;
	bh=a23ET7tJlipfo1fkdcAPkVJGv+PyEDiFu7KM+QNHX1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OC6xRp8NepOskB9nAGvYItoK5K5frX2Rs2QD6mC9qTE6p9mONf8Tonbx/1ur8koyURUr8KwOZnjqJzFjeXZOJmcku81teB6hBviALiJ+5ry0CtIGLGWlnuLDR3BO7LMUx8jC2NV2y5vy3GHAE9TLvPejsYEPLrCwGREAaY636fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5zODUkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0765FC4CEE4;
	Mon,  5 May 2025 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485459;
	bh=a23ET7tJlipfo1fkdcAPkVJGv+PyEDiFu7KM+QNHX1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5zODUkVZ8EdTRWT330UENAMSBKvwRULi44jn2P1xJBreW2x83qUOO2eing6iBquE
	 jldn2wYSEbDgh6UJmnwHrH7B0F/TBfOsN/NxynS/fOF7QreV1z/UC/ItKMWVmwKMmA
	 GWUOydUuXlbeJKNwlLiRqVcp1ElhL/nqhxKCnGlkePM71DCOX9iE9yeKs/9ZID/TMW
	 jgfUbGRGeBWQI7jVdC9yG5dozreVkWewT4pLJpmnqiadlKBg/rwjJyeDqvnk1M13c6
	 6q7Hx9dyAJ+WQLzT9cWRkuxclG5zVWhJufpDxJ1xs9yJqQpXIAhKxcuNqxYF5tDFLc
	 3PMUUpDWVB3VQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 323/486] firmware: arm_ffa: Reject higher major version as incompatible
Date: Mon,  5 May 2025 18:36:39 -0400
Message-Id: <20250505223922.2682012-323-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 2c2ec3c35f156..e8efa6cfd58cd 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -150,6 +150,14 @@ static int ffa_version_check(u32 *version)
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


