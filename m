Return-Path: <stable+bounces-100735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8519ED565
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35700165358
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9101248FA5;
	Wed, 11 Dec 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF/+jFHn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3544248F9D;
	Wed, 11 Dec 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943152; cv=none; b=boPbVOVCGDWXvkNjuGScd/6I5joefoMJzIakEWEjoq1KFQjvgk5VItJlhI4DjR9HKhpfUjQocmVHFIX7Gff3ou1+tz4sd86l/N7lnJxS/Hl7+PCrTa6VL4ShYe0qHhFY3O0ao4kMhLBrjNItZPpqpw51jGEEdtpMusqtJ0qvKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943152; c=relaxed/simple;
	bh=/jyVdtp3fx9BUiZ7vVMszar0qiH/2Qt2V2ROWhoIFzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsFkds4fAr9DSkZ4IsUyKejWUh9uHAUNuODq6KfxrFgxKoyo1NDZv/iRufrLxfRbFUrHcb60PdHe/1onR7CeQbjQ56ETvdLaVauXfEuo3kLgx055WoD+GLdruB08+hgXKtuFG2hNMtjFy7WHz9SjbpKIDaCjJrR5q6RLFm8QqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF/+jFHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E88C4CED2;
	Wed, 11 Dec 2024 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943152;
	bh=/jyVdtp3fx9BUiZ7vVMszar0qiH/2Qt2V2ROWhoIFzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF/+jFHnd3OGb3lfjmFen+eDGX5JWmDULPgp84liWMHB2xhFLPiXsjFA5lqaAcrjx
	 eEMUe+acXLorE99/NDwXke/eEgknm5Ak80YPL+mkOam6V8sD4kPzOFxVgnsBE0KXfp
	 UnRPqnqXjL/iJp/RRBu6vO82Gi/jWLbvgR8yctN+57PNeJ07usxF9jD4aca3+epVhh
	 R0KcAut392N6HhDK+t3kZex1mh0noVGTTKfz0ZG4YZr7PzbhJ+KAPZJmyA4ffkEnYT
	 5jMTsg/SzppnNe1TotAFZw/2Fx/mVIXJWn7+CqXtREBCdjifC3ClrSnVq6wxm+ixbM
	 gDU6+KYi3uZkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.6 09/23] regmap: Use correct format specifier for logging range errors
Date: Wed, 11 Dec 2024 13:51:46 -0500
Message-ID: <20241211185214.3841978-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 3f1aa0c533d9dd8a835caf9a6824449c463ee7e2 ]

The register addresses are unsigned ints so we should use %u not %d to
log them.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20241127-regmap-test-high-addr-v1-1-74a48a9e0dc5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c5b5241891a5a..8c3a9922f35d3 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1050,13 +1050,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 		/* Sanity check */
 		if (range_cfg->range_max < range_cfg->range_min) {
-			dev_err(map->dev, "Invalid range %d: %d < %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u < %u\n", i,
 				range_cfg->range_max, range_cfg->range_min);
 			goto err_range;
 		}
 
 		if (range_cfg->range_max > map->max_register) {
-			dev_err(map->dev, "Invalid range %d: %d > %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u > %u\n", i,
 				range_cfg->range_max, map->max_register);
 			goto err_range;
 		}
-- 
2.43.0


