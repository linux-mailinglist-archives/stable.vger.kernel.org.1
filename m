Return-Path: <stable+bounces-65076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D57943E18
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101C0283C5D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DE1D54EC;
	Thu,  1 Aug 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtOU0QYZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B81D54D5;
	Thu,  1 Aug 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472261; cv=none; b=of0sUMhLnv/loym9C5IN/ZR7xa1MIf20+klm/Mxc2OjChpdey9Qw4kd8KHetgunahhWifQyd50uv3wJdUOMMBghUEAmz5S/Nh3wUxhAiI8okaZYJhfPV2sdn2GxldIJ/sL5MAple8OMF0NnSslIE5V2wFqVrxFHpK7lpiT3KBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472261; c=relaxed/simple;
	bh=9fXbwdzhwFMnniC7O2MzvI1C74jiNEkZl50KxhJ9O8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CttCpBsj6wvl5RXIVdHi3ox5JLfhYIVY9Lfc1OlVW9U9HQ1IBgs5tko0W+RYuPzsgT2PGWh1UPoNymgA/QNYMg3LuUtn6XWnHQUPyZdh0IUUnWhewOQCF+XaqsxijvGJ+DmegySN3ke6hxFPYGdeqCg0nwp6V0T1JZSHUNYVmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtOU0QYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AB2C116B1;
	Thu,  1 Aug 2024 00:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472260;
	bh=9fXbwdzhwFMnniC7O2MzvI1C74jiNEkZl50KxhJ9O8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtOU0QYZ1e3kL/z8HCJCT+YFP4aAmoaoC+0w8xNgIcSWJ7bkexqMEXYO9U3NOOdPS
	 wti8g/8e2qJ2QVCyw6d5IDmZmkdIcor3BKa09uzeBgjwb4cBiVswVrD4mE7W3CbOQF
	 mLh5aOA8ZbrCB7VrnLBbD2upMqPOfVsjrps6VhSeA+Mit/SbjEoji4yjrdnHmk0tDq
	 7tFC4LJ5shTgIujEFo49j88vmbfHaVzQ2JpgwHISVacfwodw0QCQ9XbBrv7OrOoPIE
	 bx9ESntw4WsSJ5secOYE8p0ps/u+lqBumrDTj+XE4QhAwkYaxm/GH0VaffgA6bO5Pe
	 oPR0i0ZAZP16w==
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
	christophe.leroy@csgroup.eu,
	akpm@linux-foundation.org,
	suagrfillet@gmail.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 47/61] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Wed, 31 Jul 2024 20:26:05 -0400
Message-ID: <20240801002803.3935985-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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


