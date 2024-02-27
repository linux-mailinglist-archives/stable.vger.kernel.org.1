Return-Path: <stable+bounces-24581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE8869569
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67D0B22472
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2352813DB90;
	Tue, 27 Feb 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Jzvvolp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584954BD4;
	Tue, 27 Feb 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042415; cv=none; b=fD3T7fQu01LBWB8Sgi2YxhWGZJEBF20YwyVsk8aR5TOmXEEAgxA98gANQ52tuufz4IWX5AII6RTvrFpSSKJh2CRrurGFU/n11SvD8Ti5LiLQFoJ4LGQxfwWnyi6lZlozDbA/X6w/enwBGykHN8T/Y46HyQo1BHFd/P0xFQYr8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042415; c=relaxed/simple;
	bh=YjaIUWO1B8lCChG31sKc3wwbBNG/apkNjHYSfbwUxL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0IOU/tE3PY3BnrVhS1pVMi4hUvsdwDu/Cp741lPgMLr1RQtDuOPO371QOKTCLEgFcf4aduVFr/PnR/oEhvMGCxIE+R6o35ksTj+6axl3GnWix+PPcI21tQ3pg5l+1+tSTULX0CQnPfTzdk6LzzYQmkPqjXEqcbMk0UTFlmGkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Jzvvolp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64570C433C7;
	Tue, 27 Feb 2024 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042415;
	bh=YjaIUWO1B8lCChG31sKc3wwbBNG/apkNjHYSfbwUxL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1Jzvvolpe1ENutdEOccFy5vnHzT7714NLfwjO/GZUbopT534C931L7Tb8ugFXuIRN
	 eCt+DeOCw1tUuLFQSseEDc8rt+pA0T0815D0bw+PG+jH8iY/sz71bN8CuEmrfSDjEV
	 GCrReawfbvdRgFHkJQbVdildqkAOSk1hx21/sH/o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 288/299] selftests/iommu: fix the config fragment
Date: Tue, 27 Feb 2024 14:26:39 +0100
Message-ID: <20240227131634.944726482@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit 510325e5ac5f45c1180189d3bfc108c54bf64544 ]

The config fragment doesn't follow the correct format to enable those
config options which make the config options getting missed while
merging with other configs.

➜ merge_config.sh -m .config tools/testing/selftests/iommu/config
Using .config as base
Merging tools/testing/selftests/iommu/config
➜ make olddefconfig
.config:5295:warning: unexpected data: CONFIG_IOMMUFD
.config:5296:warning: unexpected data: CONFIG_IOMMUFD_TEST

While at it, add CONFIG_FAULT_INJECTION as well which is needed for
CONFIG_IOMMUFD_TEST. If CONFIG_FAULT_INJECTION isn't present in base
config (such as x86 defconfig), CONFIG_IOMMUFD_TEST doesn't get enabled.

Fixes: 57f0988706fe ("iommufd: Add a selftest")
Link: https://lore.kernel.org/r/20240222074934.71380-1-usama.anjum@collabora.com
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/iommu/config | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/config b/tools/testing/selftests/iommu/config
index 6c4f901d6fed3..110d73917615d 100644
--- a/tools/testing/selftests/iommu/config
+++ b/tools/testing/selftests/iommu/config
@@ -1,2 +1,3 @@
-CONFIG_IOMMUFD
-CONFIG_IOMMUFD_TEST
+CONFIG_IOMMUFD=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_IOMMUFD_TEST=y
-- 
2.43.0




