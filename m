Return-Path: <stable+bounces-120442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89006A50250
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A283A409E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D424E4B9;
	Wed,  5 Mar 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCw7VAMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F61E531
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185383; cv=none; b=bG9PvNkTIjEzHXBXgWFlGJ4H1b1uHHLA9AB8E+K5pQ2nJ6ZF5UU+phi/zHlTYf21NDqIQusq7M5U5V7kE3dSQvYCyAIQqnhD3QaeAYIVItdqXU8ypgpVxWGSZ8wvc7i15cpDUXajhKMMc1PiP9hSBSQaO6FDaPFDWcsNtlStldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185383; c=relaxed/simple;
	bh=QJc+qRuqkwcZb7Sn809zJJZE/+ArPkC+pkDJ5IkxPt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWY6EfgNAYKvsh+VhPGrt8WUgLmDuRgeaw6Z+zF4JTG0VfoJN2bo+ucAoIly8GHBgvVWpxbO+MVZ+LbEMcXVKL97EUV6hrTBeVrcLITanAbKDx+k9os27dKWsKk6mxmFkwyRYCW5TpepSJKzVEZ6tzdSIEPrf6STWWqwbMFyLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCw7VAMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADE5C4CED1;
	Wed,  5 Mar 2025 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741185382;
	bh=QJc+qRuqkwcZb7Sn809zJJZE/+ArPkC+pkDJ5IkxPt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCw7VAMdJh+i/+kUlAPZ+TvdTNNxmD3M2RPAPgKM6vjlaLDNi/0lTY68Owx8UP8Pd
	 jCfQ+pXOt0UceqgpPTbUkesr7zuIuXDQXUCMrv2+jJEUGoV+Q+d+4Mk/Up/OvimM8A
	 QcViJpq4kpBuUaclmjK2RoAAyHa2ZTPsP6q0MuPetZ4OOpHEBQLiFSzNLWpTrhXhtx
	 aOR+7W5bMrgkoq3HnzPG/oSu8RCNx7EBuXBNcU95xcGQr8/00WKfl8wGSs4f/wnECt
	 xvM2MkoGkc5pjIJ4H1on6dAXcBKceXExpm8kb8ha/24hv67cLPVW1GSeLUvFN4ZnWP
	 wcX9pKAzV0ddQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pjones@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] efi: Don't map the entire mokvar table to determine its size
Date: Wed,  5 Mar 2025 09:36:20 -0500
Message-Id: <20250304195516-2cc77e149e431b91@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250304192829.3044702-1-pjones@redhat.com>
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

Found matching upstream commit: 2b90e7ace79774a3540ce569e000388f8d22c9e0

Status in newer kernel trees:
6.13.y | Present (different SHA1: cf90c3123578)
6.6.y | Present (different SHA1: 9927271225a9)

Note: The patch differs from the upstream commit:
---
1:  2b90e7ace7977 ! 1:  9f74008ccfa4b efi: Don't map the entire mokvar table to determine its size
    @@ Commit message
         Cc: <stable@vger.kernel.org>
         Signed-off-by: Peter Jones <pjones@redhat.com>
         Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
    +    (cherry picked from commit 2b90e7ace79774a3540ce569e000388f8d22c9e0)
     
      ## drivers/firmware/efi/mokvar-table.c ##
     @@ drivers/firmware/efi/mokvar-table.c: void __init efi_mokvar_table_init(void)
    @@ drivers/firmware/efi/mokvar-table.c: void __init efi_mokvar_table_init(void)
      	unsigned long offset_limit;
     -	unsigned long map_size = 0;
      	unsigned long map_size_needed = 0;
    - 	unsigned long size;
    +-	unsigned long size;
      	struct efi_mokvar_table_entry *mokvar_entry;
    + 	int err;
    + 
     @@ drivers/firmware/efi/mokvar-table.c: void __init efi_mokvar_table_init(void)
      	 */
      	err = -EINVAL;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

