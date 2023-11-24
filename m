Return-Path: <stable+bounces-1851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179937F81A9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93197B21D8C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E133CC2;
	Fri, 24 Nov 2023 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjXukKoS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE182FC21;
	Fri, 24 Nov 2023 19:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60C7C433C7;
	Fri, 24 Nov 2023 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852429;
	bh=Y0g4CvNKAjnbYOccR6BguXOa8KH7QKW8ZJuGfRyH2L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjXukKoS7cbI9otUtD7fbG+S0DN1fzaS951Z5oolBf3JTIY9uWvCQy+TDi3vchaW8
	 HvS0iukZa3DxuOZLkL0xBH5XMGSVYaSzn8Ydtn2vHJaaSFNdr1yMQH+Y8dHL30S0n0
	 Sy3q7xemIq/pnlGqAHXHVnrfw6DU8Qa54KLjtA40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Song Shuai <suagrfillet@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1 329/372] riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
Date: Fri, 24 Nov 2023 17:51:56 +0000
Message-ID: <20231124172021.358194922@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Shuai <suagrfillet@gmail.com>

commit 559fe94a449cba5b50a7cffea60474b385598c00 upstream.

Since the commit 011f09d12052 set sv57 as default for CONFIG_64BIT,
the comment of CONFIG_PAGE_OFFSET should be updated too.

Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Link: https://lore.kernel.org/r/20230809031023.3575407-1-songshuaishuai@tinylab.org
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/page.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -38,8 +38,8 @@
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif
 /*
- * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address space so
- * define the PAGE_OFFSET value for SV39.
+ * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
+ * define the PAGE_OFFSET value for SV48 and SV39.
  */
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
 #define PAGE_OFFSET_L3		_AC(0xffffffd800000000, UL)



