Return-Path: <stable+bounces-141609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F74AAB4DE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508E916E75A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC653561B5;
	Tue,  6 May 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3gjmvPO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB2283FD5;
	Mon,  5 May 2025 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486866; cv=none; b=WltmcRISVeNW50u5YNHaxDHmXvoDYi63QlDpJv0LWn2T0pTtUj6o55G7JeQ1U7+7+YHZyc7fCSEEadNvJabmsPekSwFx/0qEip5pdE39tQpHpnr6Gs+C9GLopiQoZl5QaEcqcyyuIUUEVXLxpdZxx7DPtVMWKrQDEqkgDxuQr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486866; c=relaxed/simple;
	bh=jW2FA8xm5AtnwtzEyIHUOqLCaeKwfjzLkHKUUBQWPc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmXSxs2iLldNjOfvVfGqbxeJSRh0Wecnm0gdk3DWGWxjfTZ3gDOO0LQ5DO2XEbF6ft8t085+YTmAAEfPeis4L0QPHxXejst2QI9v7Stva8bJGG14gx6aKThXFf7dZNvahdd3uQtjOsjo00KE3m8fPp5FB8gMKWqam93Mvkg258c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3gjmvPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5BCC4CEEE;
	Mon,  5 May 2025 23:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486865;
	bh=jW2FA8xm5AtnwtzEyIHUOqLCaeKwfjzLkHKUUBQWPc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3gjmvPOn+Yp68q+mWQa0hxPvEiaMtzfP2IFNoBynVcmFfA3sBbFB+xsTwoZ+g8Ge
	 ieqi95AOESX8836K7APzDJIIqtLZGkRJgLBxhug6GlD9AtGp4aHIflOQdaMHxy3zgM
	 PiHOm/F8lyMsVziRTFTgg5lt3btK7hlXOyj2Q8W2s0QR/zfbeVxO7ZiFI/gHsFyxxI
	 W9Z2+7Vieu88mtb65YGPXy6U4BY0apHOQ/Xs+beISj3I+JXBwSFEPyW6vy7Lqb+vjw
	 svqvTXMcjw5891gPY9avt0UmkbCyBYnrI+ioaH3vbJKxb2cJuXzdxRVhJaYltjoSRY
	 3gdsNhIwEvx5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 032/153] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 19:11:19 -0400
Message-Id: <20250505231320.2695319-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit e82cf3051e6193f61e03898f8dba035199064d36 ]

When uml_reserved is updated, min_low_pfn must also be updated
accordingly. Otherwise, min_low_pfn will not accurately reflect
the lowest available PFN.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250221041855.1156109-1-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 8e636ce029495..50be04f7b40f3 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -49,6 +49,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


