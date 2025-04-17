Return-Path: <stable+bounces-133975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A22A928F7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260583A3B69
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978C2620C2;
	Thu, 17 Apr 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p2JZjkXy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C14256C93;
	Thu, 17 Apr 2025 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914712; cv=none; b=OeaxMV9ZUAl5Q+j0MjEwEbUqFyZzco1PDA/cdm82vT8Vrc1fiU+mzMo6aaG3rTpvIGb8BcH5t5eyAvOb/GzTPTg4x9MzBBSizU9ofxaEZx2PTeS+qHeFF5cquG8g4o7bZbHHk8NhdXh0nDIkcf2xk+v6o+J1Wzdz9utbV/RqlxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914712; c=relaxed/simple;
	bh=u/uMPi6y+7kcfrp4REnV1AFmzF1DLiDChOPBFNmfmSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol/1DH7Ih0IBX3DjWTrh8WqP+6PgpJ1+eK0EvWxDy8YivuT+WanFEj3E0jHEsMhD/NuzBegTsmiZvrJ7G7nmUtuFzSS7+ULYoL3sUxgeoEbKZ+1jLly3tdqUL78LceqZNNDhSBqS3HWh1JRRX0SLmUUh/FmOZhXCf5+ieiNlwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p2JZjkXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6440AC4CEE4;
	Thu, 17 Apr 2025 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914711;
	bh=u/uMPi6y+7kcfrp4REnV1AFmzF1DLiDChOPBFNmfmSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2JZjkXyYPT+V3mF+x6x9uDwGXrkT2oaBR9/Ifxr52uJ5kSxCPf2lPmWmQMv3ZwM9
	 xzB58/YnAohavhtf4uTJeUlTP/C/GQ3YGzKp1nvSzhNZBPfsxHgOl3pCqe1Gq3y0Yd
	 tqy+WVnFczcMc97+eKf/A+JTG0junDiYe9GaurnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	David Hildenbrand <david@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.13 305/414] arm64: mm: Correct the update of max_pfn
Date: Thu, 17 Apr 2025 19:51:03 +0200
Message-ID: <20250417175123.698570587@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenhua Huang <quic_zhenhuah@quicinc.com>

commit 89f43e1ce6f60d4f44399059595ac47f7a90a393 upstream.

Hotplugged memory can be smaller than the original memory. For example,
on my target:

root@genericarmv8:~# cat /sys/kernel/debug/memblock/memory
   0: 0x0000000064005000..0x0000000064023fff    0 NOMAP
   1: 0x0000000064400000..0x00000000647fffff    0 NOMAP
   2: 0x0000000068000000..0x000000006fffffff    0 DRV_MNG
   3: 0x0000000088800000..0x0000000094ffefff    0 NONE
   4: 0x0000000094fff000..0x0000000094ffffff    0 NOMAP
max_pfn will affect read_page_owner. Therefore, it should first compare and
then select the larger value for max_pfn.

Fixes: 8fac67ca236b ("arm64: mm: update max_pfn after memory hotplug")
Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250321070019.1271859-1-quic_zhenhuah@quicinc.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1360,7 +1360,8 @@ int arch_add_memory(int nid, u64 start,
 		__remove_pgd_mapping(swapper_pg_dir,
 				     __phys_to_virt(start), size);
 	else {
-		max_pfn = PFN_UP(start + size);
+		/* Address of hotplugged memory can be smaller */
+		max_pfn = max(max_pfn, PFN_UP(start + size));
 		max_low_pfn = max_pfn;
 	}
 



