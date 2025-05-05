Return-Path: <stable+bounces-139643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E28AA8EEA
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CB0188F0FD
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BFB1F460F;
	Mon,  5 May 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wSEj2qHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBF1F416C;
	Mon,  5 May 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436030; cv=none; b=qJbgrEnfzcphgL1TwMhAgmzk2A6ZC05+59iWtqz7hhao4QRu2OFVZuJWTPp9GuH8tpf7cmsgjrM3XIk+UK0SUykG8wxuCGFTGfYuqgmNtrky8JY3YLuqhGe6SB9ugNj0/vvMmZHuXDPxekQNPnqm1N7Pqn2d1qzOZqslZc1kpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436030; c=relaxed/simple;
	bh=0qwlBp/VGKPvJIkxcs61jQ3CIUDs6yOaB43o9dWb2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5c2VdM2zmcmMtabncrX2tNBZjAbAU0qvRlVdkYviOtmHUkuCWGwDYijOep2TYuggrTJpczFxFffzwYkupL+sUKws1m1d0bomOoH+otwoLDpPfDWQIr/MmVG/qDILF+5V5Wnx7jEZROPA1RQiBkXNO0K468JkVIydIAYr9Je/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wSEj2qHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC84C4CEE4;
	Mon,  5 May 2025 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746436030;
	bh=0qwlBp/VGKPvJIkxcs61jQ3CIUDs6yOaB43o9dWb2ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wSEj2qHziWS5Ttg/93h1lWnKFpy3EfisQARQXaM37MnB5CXFlSagUeG1VCTtJVpby
	 PnzrmCUDEokTKYxN1yzWE4oCer/x1Y7d1zydEssydYOPYt9w7RgyKsLaO31THNBhJI
	 dMogIHD16CdZ1WecjAAVtpcU6t0cowd/mWVcgOXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.137
Date: Mon,  5 May 2025 11:06:58 +0200
Message-ID: <2025050528-astronaut-prune-af91@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050528-kissable-viral-627b@gregkh>
References: <2025050528-kissable-viral-627b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 2a22ff32509d..d1994bf77e8f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 136
+SUBLEVEL = 137
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index cf3b8785a921..70b4a51885c2 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -47,7 +47,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 				pmd = pmd_offset(pud, addr);
 		}
 	}
-	return pmd_none(pmdp_get(pmd)) ? NULL : (pte_t *) pmd;
+	return pmd_none(*pmd) ? NULL : (pte_t *) pmd;
 }
 
 /*

