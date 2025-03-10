Return-Path: <stable+bounces-122234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69708A59E92
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7AF7A5D8D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CB233156;
	Mon, 10 Mar 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLg52I1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B823237F;
	Mon, 10 Mar 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627911; cv=none; b=TEftAslev61Uv0meKvl8Tnu89BCrQtsTDmncke7j9ukZj7mNZwnLt84XU2n2bpZN23EgOI9suBEkC0+knoEJl+yIkcTYhcVmA0288pK4Hog0x0cylKHqXq7sXTHJPUO3EstGApBq57rn2sXnchWeSxl2LqPveb9HhCxq9KbD1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627911; c=relaxed/simple;
	bh=9ZGneP/3VxEuVNaeNrt7MaSRHVx8dDS38HrSUhBvqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnUz/Rh/ENZ4WkEMUJrt5BLgdIpuO0VGIuvPvgW33dsEO8S/cXhVtEWxVcjb/42y/5a/rUxTembhPzjrX7hvDG6XBCzGblwK6GAJkDhBUPdC/4jivtmSCgsyMh3Nh54hn9boXExg+ez8ZadusAUJDsLRUQV8LbPh0tnxEUJj8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BLg52I1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C96C4CEE5;
	Mon, 10 Mar 2025 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627910;
	bh=9ZGneP/3VxEuVNaeNrt7MaSRHVx8dDS38HrSUhBvqkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLg52I1ZnIbv9/byfwmm3kFJkNmVnlr1Z31guUb8ykH2Ze31l43jc0PXYOs1ROqiD
	 vpmJQZBQKwTbDvehJEZSROQVzUsPa3fja2+YVXHs/qRyb/DK8Kb64xqzuuJUTZpJ+/
	 0GrWGgaWumm75bMuRRZTCrMzpGzC6s85HRUTD7EM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.6 022/145] x86/microcode/AMD: Add some forgotten models to the SHA check
Date: Mon, 10 Mar 2025 18:05:16 +0100
Message-ID: <20250310170435.634155297@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit 058a6bec37c6c3b826158f6d26b75de43816a880 upstream.

Add some more forgotten models to the SHA check.

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches")
Reported-by: Toralf Förster <toralf.foerster@gmx.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Toralf Förster <toralf.foerster@gmx.de>
Link: https://lore.kernel.org/r/20250307220256.11816-1-bp@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/amd.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -177,23 +177,29 @@ static bool need_sha_check(u32 cur_rev)
 {
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
 	case 0x86081: return cur_rev <= 0x8608108; break;
 	case 0x87010: return cur_rev <= 0x8701034; break;
 	case 0x8a000: return cur_rev <= 0x8a0000a; break;
+	case 0xa0010: return cur_rev <= 0xa00107a; break;
 	case 0xa0011: return cur_rev <= 0xa0011da; break;
 	case 0xa0012: return cur_rev <= 0xa001243; break;
+	case 0xa0082: return cur_rev <= 0xa00820e; break;
 	case 0xa1011: return cur_rev <= 0xa101153; break;
 	case 0xa1012: return cur_rev <= 0xa10124e; break;
 	case 0xa1081: return cur_rev <= 0xa108109; break;
 	case 0xa2010: return cur_rev <= 0xa20102f; break;
 	case 0xa2012: return cur_rev <= 0xa201212; break;
+	case 0xa4041: return cur_rev <= 0xa404109; break;
+	case 0xa5000: return cur_rev <= 0xa500013; break;
 	case 0xa6012: return cur_rev <= 0xa60120a; break;
 	case 0xa7041: return cur_rev <= 0xa704109; break;
 	case 0xa7052: return cur_rev <= 0xa705208; break;
 	case 0xa7080: return cur_rev <= 0xa708009; break;
 	case 0xa70c0: return cur_rev <= 0xa70C009; break;
+	case 0xaa001: return cur_rev <= 0xaa00116; break;
 	case 0xaa002: return cur_rev <= 0xaa00218; break;
 	default: break;
 	}



