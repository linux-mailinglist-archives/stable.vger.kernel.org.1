Return-Path: <stable+bounces-57533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA42925CE1
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178371F24861
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B83194C77;
	Wed,  3 Jul 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GC89Rfw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299C1891C9;
	Wed,  3 Jul 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005167; cv=none; b=TyTAQsMkrV0jyxDqmN+oK0BDwEz+ZwynarHqgrlYdT3DXeody3fRWOAwo0+TszwtJiSFuthjyhlE1EEyP8/qqR9AziBYt+MfOa7OCKe9FHpmwLvosXZ0Z8+53nBdqGxIQGT9/Eg5fwcwZ2CdUj0NXnKEPY0ahIJcTJtBjKjpJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005167; c=relaxed/simple;
	bh=ehUTJggruZep4io4KsacGHYbsEO8aLfPUjjw4qXzPTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJMq5y033wDohbztxne4Hikt7iV7+SLq2Y+6EksYWz9Z/foHdfMG2yiAP+XtCYA9xOJF82QpDZ7AoiHWDl0o7VPBrQiXTa8ZGTlCjmtxmbibfjZRWGywHvFwcQYiLW79I4w1NFN8lT+g4sP2U2o5lsgHvQaEHL+gPeY1QBsWpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GC89Rfw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC84C2BD10;
	Wed,  3 Jul 2024 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005167;
	bh=ehUTJggruZep4io4KsacGHYbsEO8aLfPUjjw4qXzPTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GC89Rfw+HihcW7H8STyfB8E0M/+DhMVoi7F66TjMBdFJSK1HJstot2V5Vu1FRPDTf
	 1D3FDc0NZZzLcuN7y1TwtoqJEdUuRyB4F4hv0THCdZDrmJ7+2MdQRnyzLLgoSIk8oB
	 XvyR4aByWZaKRvID3Co20gH73PoRfz1itfvCn4pM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liu Zixian <liuzixian4@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.10 283/290] efi: Correct comment on efi_memmap_alloc
Date: Wed,  3 Jul 2024 12:41:04 +0200
Message-ID: <20240703102914.839610252@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Zixian <liuzixian4@huawei.com>

[ Commit db01ea882bf601252dad57242655da17fd9ad2f5 upstream ]

Returning zero means success now.

Signed-off-by: Liu Zixian <liuzixian4@huawei.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/memmap.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -59,8 +59,7 @@ static void __init efi_memmap_free(void)
  * Depending on whether mm_init() has already been invoked or not,
  * either memblock or "normal" page allocation is used.
  *
- * Returns the physical address of the allocated memory map on
- * success, zero on failure.
+ * Returns zero on success, a negative error code on failure.
  */
 int __init efi_memmap_alloc(unsigned int num_entries,
 		struct efi_memory_map_data *data)



