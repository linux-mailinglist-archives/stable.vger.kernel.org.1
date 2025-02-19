Return-Path: <stable+bounces-117890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE47A3B8F9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2545617F093
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A891BE23E;
	Wed, 19 Feb 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QdraI348"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838801CAA68;
	Wed, 19 Feb 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956637; cv=none; b=PlK4yiNOFqLiovCyLj0Q2KUijFguIB92FSJzpGi4wcGrv3nDve8eC6SjAeimna/60B5gNzJ0gJLCQ1QadujpST5zUZh7Ot4jCN9z4uI7m0YRtSL4IY/Xoa8Shfr9x0U97UdNo66qyKh5l6lrg35FC5/iltsTb2yDMKPbPTGI3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956637; c=relaxed/simple;
	bh=fJl2Ua5IZlMWAM0HvqDcbA6JSqrNL/r2eE05wcMsgJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiKZBDLjDxSiP+/lQWMjiTf9VSK5JtyVkG2ayGMWz5KJWrsb6fycoq9uT4/1laJ2+rUk/Bj2ECNaZKlbZzwJJ9VYlR3O6SWeriUwJ+IPpYtOs6oD/+pW/kuXsyG2zsrTRKMP5ORidJDvM7dax36tMXgqsqBBMiVZ0NJFrSVBxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QdraI348; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1329C4CED1;
	Wed, 19 Feb 2025 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956637;
	bh=fJl2Ua5IZlMWAM0HvqDcbA6JSqrNL/r2eE05wcMsgJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdraI348rgeOtt1/gTyU2kwP8BzysfeHALuxjViXgT+ff7hEjEETmKW6oGkEteGFf
	 wGgmVmD49moie5/Q7tgYIBofTSeEN3weVGAr5pOV2RkZRVP0tOujF4J5kGq2/2gLEP
	 A9Z/oedyVLdfV/fFYqz7/qROzM336PEzKqpkgPXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 216/578] regulator: core: Add missing newline character
Date: Wed, 19 Feb 2025 09:23:40 +0100
Message-ID: <20250219082701.552158718@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 155c569fa4c3b340fbf8571a0e42dd415c025377 ]

dev_err_probe() error messages need newline character.

Fixes: 6eabfc018e8d ("regulator: core: Allow specifying an initial load w/ the bulk API")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://patch.msgid.link/20250122072019.1926093-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 518b64b2d69bc..fc52551aa265e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4897,7 +4897,7 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = dev_err_probe(dev, PTR_ERR(consumers[i].consumer),
-					    "Failed to get supply '%s'",
+					    "Failed to get supply '%s'\n",
 					    consumers[i].supply);
 			consumers[i].consumer = NULL;
 			goto err;
-- 
2.39.5




