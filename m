Return-Path: <stable+bounces-189881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3DC0AFCB
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 19:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299E73B45AE
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348821D432D;
	Sun, 26 Oct 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHpFT+uv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6F26290
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761501949; cv=none; b=izp5cXgkPAA+n2SjamQRoFmJYxHxEwgi0T+se+JJ8ykddCrjibrS10WVB3YAIfcZ9kNISKrvoOKgsiOR1jHb9+TFZzhCZkVV4NE76F2qMUmgHtYwcG9ErjgH30dEmNK55KoGtu9C2B0HF0J5quOKm+nj9QHnb/p6lrfSELiWZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761501949; c=relaxed/simple;
	bh=x+sJD5bnWpn35xZw2MOJMiMQpd1fSpFuWe/IuzzusJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRLAV/S3CjmHgCloeaFkaSTYoW0ajtaLuYz22tf60tcelO+Mguz7iGzQbfdwOypW+juUtiFbEbkzgWFD6+5Dc7EtqaA/S8xgLkYElieHbsHybuSuupz908+gQOl/rPvxw43JokLZ1VKibrPqXsLKpuCEHq8N6h0MEBptgegOfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHpFT+uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72435C4CEE7;
	Sun, 26 Oct 2025 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761501948;
	bh=x+sJD5bnWpn35xZw2MOJMiMQpd1fSpFuWe/IuzzusJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHpFT+uvokNt1eyN/VzrT3BShlaXZAwfCkHNUqMqV3MRO8ms9FQb16o4Hl+H0OEJM
	 Db2uBWwnCQJSVIwCgoHLOgA2qYcg09E67YfiHOynDUswPxknqXDWrqBO9UfCaGXQWP
	 2W3yuw1YLOOEDKKvL1rsnK6eLtD4SoqRas9zTgDFmYDLxsjxqq8SpaB9atyc3qPd1/
	 MA6VRRQt2pnhhNNnhnCfUIYG3edm7cQAHzRIEZslIhktOfi3mzigvrQnuKHb9ftuNM
	 17fiwJ8OUrxWoCAkls98yh3xUBtkCjDg+Odn+doblFjt/J1aALO359PYl89t4365lQ
	 bx2OULsMRI6mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com,
	David Hildenbrand <david@redhat.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] arm64: mte: Do not warn if the page is already tagged in copy_highpage()
Date: Sun, 26 Oct 2025 14:05:45 -0400
Message-ID: <20251026180545.172518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102649-rebirth-stray-74d8@gregkh>
References: <2025102649-rebirth-stray-74d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit b98c94eed4a975e0c80b7e90a649a46967376f58 ]

The arm64 copy_highpage() assumes that the destination page is newly
allocated and not MTE-tagged (PG_mte_tagged unset) and warns
accordingly. However, following commit 060913999d7a ("mm: migrate:
support poisoned recover from migrate folio"), folio_mc_copy() is called
before __folio_migrate_mapping(). If the latter fails (-EAGAIN), the
copy will be done again to the same destination page. Since
copy_highpage() already set the PG_mte_tagged flag, this second copy
will warn.

Replace the WARN_ON_ONCE(page already tagged) in the arm64
copy_highpage() with a comment.

Reported-by: syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/68dda1ae.a00a0220.102ee.0065.GAE@google.com
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: stable@vger.kernel.org # 6.12.x
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ omitted hugetlb MTE changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/copypage.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce09..9e734d6314e03 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -25,8 +25,13 @@ void copy_highpage(struct page *to, struct page *from)
 		page_kasan_tag_reset(to);
 
 	if (system_supports_mte() && page_mte_tagged(from)) {
-		/* It's a new page, shouldn't have been tagged yet */
-		WARN_ON_ONCE(!try_page_mte_tagging(to));
+		/*
+		 * Most of the time it's a new page that shouldn't have been
+		 * tagged yet. However, folio migration can end up reusing the
+		 * same page without untagging it. Ignore the warning if the
+		 * page is already tagged.
+		 */
+		try_page_mte_tagging(to);
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
 	}
-- 
2.51.0


