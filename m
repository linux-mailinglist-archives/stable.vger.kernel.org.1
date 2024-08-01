Return-Path: <stable+bounces-65126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA3943EF7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D30B2731C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189401A720E;
	Thu,  1 Aug 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaANe/hu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0B1A6171;
	Thu,  1 Aug 2024 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472515; cv=none; b=PKTarJFhaCNLNK9JgvBXQItVs2r6owp72oOoOymiJDsFgSoCnw33xzbPYUgLOPSirgEMHClgGAr44/VDtVAtJPhHLUSV8vNlh0q7IYvOLQLgRZ/+HQCdB4AhuVU/iKRL42weX8SejerHSh2UJN6VPf2OxN6wZK3fqFr5yucLjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472515; c=relaxed/simple;
	bh=LK6zTajtoTZQV6EezgVVoyRpxqbqn/pTlxwoTFwONDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqJba01ntmllG+Dpr7DA8VPS3dWUwNUu/mWdq6nKryQpkHFR2a48jknyZTDhceYWy55ujGoeSI9ZdN0O+57VLAFGluAi0STzaLI2yw17WdexOtue9ZkumYLxW+IK0RmzXV6GQ2Gy72OtZKljgUeFr+dQTfMcZ3i37CHfzwsnA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaANe/hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00D7C4AF0F;
	Thu,  1 Aug 2024 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472515;
	bh=LK6zTajtoTZQV6EezgVVoyRpxqbqn/pTlxwoTFwONDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaANe/huHjUmtZlpF49Wt67OPEQTL47O9H58bQx8DMCVEfsEBOGm2jaqX0qHYlsdA
	 hBCgW9JRS597vby7Y16dlPZxzYk1OhaOBd3/qddhHDdzSC4gsGyh4HqZOfQvgXQyky
	 VoKXmITLuWjlZcVy/efiVYCxeNQjT6YcoDjZSUBQzy504IcWx2Qj97BxpUWF2Fgio9
	 knJPB2a/FFC6GrxWW1uMfOhRXpZLd9cXkZL3WWrsmO/w6m1czBodhTvM8fJyTSgxrS
	 aXl3v6gcS3oFb8HDQnq31JapIob0cUZxzw1Cp5RTrxhDfaz9ZfkOvSaY3anNhTBzZB
	 p2QlrrpV/rTfA==
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
Subject: [PATCH AUTOSEL 5.15 36/47] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Wed, 31 Jul 2024 20:31:26 -0400
Message-ID: <20240801003256.3937416-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 830e7de65e3a3..154cc427f4957 100644
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


