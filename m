Return-Path: <stable+bounces-164819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B35B12877
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4AA5838D0
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4C1C1F02;
	Sat, 26 Jul 2025 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH8v+N3J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F7819309E
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753493834; cv=none; b=QTmJinO05MSccsef9SahSGrtOVDf1n/F8bubJ/KQPQ4IMF2KRduqcqUHVgUD5+KMSmtsnq7NxHY9R9VWcQIHTVscaEiBvnsIVOe40UWiCi2fbmDx3KMJ9tJgPmDHD2u4WJeSS30pTT3UJE5uwjDtgshIVWnyNia2tebScV6WFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753493834; c=relaxed/simple;
	bh=e5POp9oPmZgEdfF30vWzov4UBEkJJoT1stVJOk4zSLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI9aRfA56+LFgTUjABlcWVNs1XWp54mJUT0gluIFhw7wOAkt9KN9laaafJPmzZa6l1tg5A4HL1UO3PWc1YcCR9vy3gVH2ERHNdR5Oj1wncwR8n/r+KOglCqQnsA/u/C3ByNS/xuyM5n/5kqRw/yne8vkecb7xlp3Duw6OIQmUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH8v+N3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2168C4CEE7;
	Sat, 26 Jul 2025 01:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753493834;
	bh=e5POp9oPmZgEdfF30vWzov4UBEkJJoT1stVJOk4zSLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SH8v+N3JZiACkINYvbZh+mHHUymOj0hDNYawxq2dPrHk3hUAtrUaCrjeqBNddi2gM
	 a76lIafC7xmY0J6tyAvSYPbvzYTV+emWfDCli6CfpzJL56v85KseXvWPTM7euaYila
	 hCd2MN92d3a9qE1H60hfsLzZS62cTe8YCNRC4NbGDOA6sOZH5vvlFCmYC3jKEGxSmH
	 sK06/RO7Td+jtu+YII/lsDefpFbxgxqkninwy7wEHj9aNHVdXVb3UKKYw9kiT/AU5b
	 SQ45giaIAYT+Z+ISiZkxwxYhLP+FrwCB+UytQb5ibryv3H/HzXuiCPfxnAdTvUBl9n
	 nzQb6DOcSXOxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	markus@blochl.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ice/ptp: fix crosstimestamp reporting
Date: Fri, 25 Jul 2025 21:37:11 -0400
Message-Id: <1753492278-e3830ff7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725-ice_crosstimestamp_reporting-v1-1-3d0473bb7b57@blochl.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Patch application failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: a5a441ae283d54ec329aadc7426991dc32786d52

WARNING: Author mismatch between patch and found commit:
Backport author: Markus Blöchl <markus@blochl.de>
Commit author: Anton Nadezhdin <anton.nadezhdin@intel.com>

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.15.y       | Failed      | N/A        |
| origin/linux-6.12.y       | Success     | Success    |
| origin/linux-6.6.y        | Failed      | N/A        |
| origin/linux-6.1.y        | Failed      | N/A        |
| origin/linux-5.15.y       | Failed      | N/A        |
| origin/linux-5.10.y       | Failed      | N/A        |
| origin/linux-5.4.y        | Failed      | N/A        |

