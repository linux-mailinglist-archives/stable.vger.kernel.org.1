Return-Path: <stable+bounces-48681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138B8FEA09
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31BE1C25C81
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F501974E1;
	Thu,  6 Jun 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MvwdxvNm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ECF19D09B;
	Thu,  6 Jun 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683094; cv=none; b=ln3HQKY89jwqpUodLYYn2glo1vRKjGz973/dg0UKJJB9pfs5tX2jDBtpRWuh3NMzje4L3BXqz5Mw8YvjH8jvuCB82vWfh8QLslxYesqgsSZ31c/EZA4p0MrBL7wbH4FFay4X4LsRgTIA7sxevpXa+dA7zfVHzVvBMcJWriWA3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683094; c=relaxed/simple;
	bh=jct6SWgEW2ocNHceU2bEe+inWKy1BWRMNJ/3RbNHWoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szb1dzhI/JrckM6A0NEH/xFyjhbUrjoJ5iQWyn4ReqL1Evv2fGE8agxpfWeOr2aCRiwB9k/tBZhMMcWmgLHuCgE3JUaGP403JfUtCqKTibnidW8lMu2b9Yf1hYCHFHE60Pim3yxqC3H3mJZFwWRg760abnTjyXP0CnllsWpxEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MvwdxvNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B557CC2BD10;
	Thu,  6 Jun 2024 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683094;
	bh=jct6SWgEW2ocNHceU2bEe+inWKy1BWRMNJ/3RbNHWoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvwdxvNmRv/1Er+bpM3tRlAGsUlP2F2d7CdML9CCji4GYCAOJ+mF6tNHuHkt6QKl7
	 h+Q9508u0lxEbDJhTCYbU+LD7iZhBN4sGwDfgVaym4KTiixMPjKgnKm8qV4rkS3WHl
	 HQkhKToH2GWS3k/mCVDpHSELhx5uTiDLvNB7c29w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hagar Hemdan <hagarhem@amazon.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.9 367/374] efi: libstub: only free priv.runtime_map when allocated
Date: Thu,  6 Jun 2024 16:05:46 +0200
Message-ID: <20240606131704.174267952@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hagar Hemdan <hagarhem@amazon.com>

commit 4b2543f7e1e6b91cfc8dd1696e3cdf01c3ac8974 upstream.

priv.runtime_map is only allocated when efi_novamap is not set.
Otherwise, it is an uninitialized value.  In the error path, it is freed
unconditionally.  Avoid passing an uninitialized value to free_pool.
Free priv.runtime_map only when it was allocated.

This bug was discovered and resolved using Coverity Static Analysis
Security Testing (SAST) by Synopsys, Inc.

Fixes: f80d26043af9 ("efi: libstub: avoid efi_get_memory_map() for allocating the virt map")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/fdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -335,8 +335,8 @@ fail_free_new_fdt:
 
 fail:
 	efi_free(fdt_size, fdt_addr);
-
-	efi_bs_call(free_pool, priv.runtime_map);
+	if (!efi_novamap)
+		efi_bs_call(free_pool, priv.runtime_map);
 
 	return EFI_LOAD_ERROR;
 }



