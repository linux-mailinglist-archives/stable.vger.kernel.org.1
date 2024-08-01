Return-Path: <stable+bounces-65011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B3943D82
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE64F1C2243B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0611C9DD3;
	Thu,  1 Aug 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJbimywW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF8E1C9DC1;
	Thu,  1 Aug 2024 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471929; cv=none; b=H2E+BYkUhyegTuiOXsojalamOVUPeFHRbKH0JpOG7dl75cyqGRW5X9ZbOy6fpNSuBwiHJWQrSFvPdu4TSINNldWqrR4bugszC9h17vsuoHAaV5GqNgIOkBIpTlE72fgrvKOABkcVJywYZ/p2EmpcS62Y07DjmPpNyWM6chmraFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471929; c=relaxed/simple;
	bh=9fXbwdzhwFMnniC7O2MzvI1C74jiNEkZl50KxhJ9O8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6U0EeVvTYy3MEFToId7y9szLlFAUWczeW5ve/F8B6HsaWdBErdJGJNnAtUOAeQx8rnks2d4Rouw5DMgpT4pFAQRSDo1wagO1Vi2RrF7yFBDzEo7mypuKZ2xx58m+GL7jNYJYjVw0Zt2i8J+kEYT2svhoB/JNCwtUUeeGgBiLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJbimywW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09597C4AF0F;
	Thu,  1 Aug 2024 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471928;
	bh=9fXbwdzhwFMnniC7O2MzvI1C74jiNEkZl50KxhJ9O8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJbimywWovhjK3XQpNZVijyDknn0rBmZK7Mj72i7aJhsG8EH5nx0b+6Fswt9+9PlE
	 1SqVV4Dy1smfQazN6eQ1FRX/1KNlDYFORpuMqzNW6em/tpT++I4XNcnoSLdvY5Ebg/
	 wSv9UrJjkrJdbLBGXVwxzesGD3hMYH6bxmawvyDlcb0lZcyYhuXDzMCQxM6N8iTg9q
	 TUALpgJQJs1QnbJx++dybyIixroYNVU8vn2XheRbofPsBZgfpxJt9WKyt5OldFrdXx
	 M8lXn6oyGKRhVbJkJfGV+0RgmdSLJY3RiIo1BFpRqRELE893P4jhaKWaVe6XlJLQow
	 NO8KDot/1vsPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	peterlin@andestech.com,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	suagrfillet@gmail.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 65/83] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Wed, 31 Jul 2024 20:18:20 -0400
Message-ID: <20240801002107.3934037-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 37992b7f1097ba79ca75ba5a26ddcf0f54f91a08 ]

During memory hot remove, the ptdump functionality can end up touching
stale data. Avoid any potential crashes (or worse), by holding the
memory hotplug read-lock while traversing the page table.

This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
Hold memory hotplug lock while walking for kernel page table dump").

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240605114100.315918-8-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index e9090b38f8117..dbc2baa95eade 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -6,6 +6,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
+#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 #include <linux/ptdump.h>
 
@@ -351,7 +352,9 @@ void ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
+	get_online_mems();
 	ptdump_walk(m, m->private);
+	put_online_mems();
 
 	return 0;
 }
-- 
2.43.0


