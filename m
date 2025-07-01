Return-Path: <stable+bounces-159103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9899BAEEBF5
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9EB3E0A04
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86695195B1A;
	Tue,  1 Jul 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/mU0Ykr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB91917F1
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332545; cv=none; b=Pe4XjDs0u3CdICwFtjMxGVFVgJomsO4XFYy/lLmYoSyoY82kkVUgpAEDIgaorBomwUGxImXqGKbOrCwu6yRzSindNQ0p7tG3aUhi+GwZ+ZcoB7s3wIuP6pw/a+V+iSy16mblis8aZ65DH+YS3hyVHV9tp/apk9m9LKJ8nl0/uME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332545; c=relaxed/simple;
	bh=KHsZtTPilhoUjA3Et/4sw34TkB6hgQEUOi/j+34cjeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOobkeSDG/XgO89jugFo51h7Ryuomz/WG3Ds60AoGI+PddgK3yqjKL9tiI640lSsDBxgCD8urfKRx3q9OOtn+psd8o2zOQRyC8tsgGVNPppyDJf4H34aOYQgU0TuOrP61lvQdt4L2mzEaCkdpdiwqlWZI4H7HeKTnwqjpyv9+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/mU0Ykr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D27EC4CEF0;
	Tue,  1 Jul 2025 01:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332544;
	bh=KHsZtTPilhoUjA3Et/4sw34TkB6hgQEUOi/j+34cjeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/mU0YkrlmZ7SSaxRn0OrsN85RLR/WgDtlx9By/27QOoGjly5Jj1XgQyz9WbgBObD
	 SUaHba9h+eeAFJba8O152MeCnBWofMC+G0j9l5AUtWKQSqZXpvhWuiAXtjBppn5Q4p
	 x9sP7TtkwGscazC7u7rqRheRV2lxKXDRqSYVKUdQdD0NVtyCoqvPCHqqsh1mhfUWU/
	 czpDv5wxwIeLtgXSzkxkmWWK3GhAtvS8iL9bXNX5zKDf+8T1ClkQPyHE3fhFjh6962
	 Xq9TEA8gzJN4uFavQP/PmQq7YUJZl5WPAObpGFygwV/UcF4Te4DB2pa118oBgHYKxi
	 Y0HRlfOaS+JLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hca@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y] s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth()
Date: Mon, 30 Jun 2025 21:15:43 -0400
Message-Id: <20250630133526-e014c16780b106d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630082340.2741373-1-hca@linux.ibm.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 7f8073cfb04a97842fe891ca50dad60afd1e3121

Note: The patch differs from the upstream commit:
---
1:  7f8073cfb04a9 < -:  ------------- s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth()
-:  ------------- > 1:  18f3ce7cfe6bf s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |

