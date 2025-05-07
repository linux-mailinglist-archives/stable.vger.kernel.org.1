Return-Path: <stable+bounces-142321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9BAAAEA21
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C794C1D9B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8C289348;
	Wed,  7 May 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o40cvFqE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F442A83;
	Wed,  7 May 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643891; cv=none; b=lIqbRD1A2/glc8yiPEZioc9zl9ZpmfDgBnjW3voKun3gzj2JgdnPmNzb3voWDNhbd3YY1TRExLhqwDJnrZPvhjoBjqG0iYXYQB6IfUtEHSTovhuBNAReFum97zlQUMp/dNrsPa1n6AODS2O5VEsdkKcc2ne7Z86xBnKBNORxomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643891; c=relaxed/simple;
	bh=wXGQ5VVE5NqAqh0w/yLR1gEppFfZjNrT3uLXLIhLSbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh/OANnckvYGCOy1OYBUKCGqmsLfBbEL4jEp3uNeUyvNqMusBYE9xs6WC75BqI5Gt07Wim2pCCq33BvNWEjXqLDu1NYEqrbc2zBl6MnYhWhCWGXm5PMPmxrUOvWjVLwALH5T4nTGcBfVlJ8kLDwyZi9nOMyk6DTBk7LnIUeLno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o40cvFqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DEEC4CEE2;
	Wed,  7 May 2025 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643890;
	bh=wXGQ5VVE5NqAqh0w/yLR1gEppFfZjNrT3uLXLIhLSbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o40cvFqESGFsU6yrK0pfGaRx7gM/qSqgEVQfWCcrYd4ByBL5BxKdK6Q4aZb+KnefT
	 UADb877mhdgcdGOkHkPUI7gFYGGUj/q2tzeV5QUmH7Utc4oNlvXapVQR6rZsY/uaX4
	 mth8nCsaLjnWL56Z7Oe5rX7i50QacUlLJWMfBzww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 6.14 021/183] mm/memblock: pass size instead of end to memblock_set_node()
Date: Wed,  7 May 2025 20:37:46 +0200
Message-ID: <20250507183825.548538538@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yang <richard.weiyang@gmail.com>

commit 06eaa824fd239edd1eab2754f29b2d03da313003 upstream.

The second parameter of memblock_set_node() is size instead of end.

Since it iterates from lower address to higher address, finally the node
id is correct. But during the process, some of them are wrong.

Pass size instead of end.

Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: stable@vger.kernel.org
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20250318071948.23854-2-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memblock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2193,7 +2193,7 @@ static void __init memmap_init_reserved_
 		if (memblock_is_nomap(region))
 			reserve_bootmem_region(start, end, nid);
 
-		memblock_set_node(start, end, &memblock.reserved, nid);
+		memblock_set_node(start, region->size, &memblock.reserved, nid);
 	}
 
 	/*



