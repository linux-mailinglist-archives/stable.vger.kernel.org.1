Return-Path: <stable+bounces-120345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6921A4E7F5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D2B189F68A
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7AB291F88;
	Tue,  4 Mar 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ikqpuAkU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063C27E1A5
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106636; cv=none; b=nNQlvZcVH2ioGu7MUAGyTUcSDrpVv6H7KTIhU9nLe+TndRhXr6Y0wtzVB+apJHEY8aAH/3PfrhPDivHfqdacGtnYHBW5Y6ZVn5RMocEKC0ki53EwRDDWqiCrkXT0+H5mIwd02Dun3YTcR0lYgzUYcHhDaKlF27V5K5ufAtLzJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106636; c=relaxed/simple;
	bh=ZuG/3TFBearl2wrs8w349wDv8YGBkKrw07KRBtV5bFI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iiJ0VNyIx4b6US4FDaoEKoWhqre0GdOm/JQ+mTG3e/gevZUJSPW2HR5HAHHZKGy63D7RHUzbl7909VowH6Fs76c+nhNlRJzfSOHnzUfiYiehb3HBzClQgKtsGrVimh494+Y13/h75z88/4uL4wUHRoOhi4n5yjuQKBPwFjx5TEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ikqpuAkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C5CC4CEFA;
	Tue,  4 Mar 2025 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106636;
	bh=ZuG/3TFBearl2wrs8w349wDv8YGBkKrw07KRBtV5bFI=;
	h=Subject:To:Cc:From:Date:From;
	b=ikqpuAkUay5y6mGm0C+7Pyj9WgOhq7sJ1NKBOVj9aAfF8vr0wWalg45P3fxraYoXW
	 P6U3FOWYZ7HeCzvsJl/oee0Qqqxap3SEsvvUL65lRpRUI/Gkoa+GsQe5lCdFoEWCID
	 20rhzkrqqqMOI9xpgcTmtxB0XYLU7VCKSBSRua4U=
Subject: FAILED: patch "[PATCH] riscv: cacheinfo: Use of_property_present() for non-boolean" failed to apply to 5.4-stable tree
To: robh@kernel.org,cleger@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:40 +0100
Message-ID: <2025030440-graffiti-good-0bb6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x fb8179ce2996bffaa36a04e2b6262843b01b7565
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030440-graffiti-good-0bb6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb8179ce2996bffaa36a04e2b6262843b01b7565 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Mon, 4 Nov 2024 13:03:13 -0600
Subject: [PATCH] riscv: cacheinfo: Use of_property_present() for non-boolean
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Cc: stable@vger.kernel.org
Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
Link: https://lore.kernel.org/r/20241104190314.270095-1-robh@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 2d40736fc37c..26b085dbdd07 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -108,11 +108,11 @@ int populate_cache_leaves(unsigned int cpu)
 	if (!np)
 		return -ENOENT;
 
-	if (of_property_read_bool(np, "cache-size"))
+	if (of_property_present(np, "cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
-	if (of_property_read_bool(np, "i-cache-size"))
+	if (of_property_present(np, "i-cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-	if (of_property_read_bool(np, "d-cache-size"))
+	if (of_property_present(np, "d-cache-size"))
 		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 
 	prev = np;
@@ -125,11 +125,11 @@ int populate_cache_leaves(unsigned int cpu)
 			break;
 		if (level <= levels)
 			break;
-		if (of_property_read_bool(np, "cache-size"))
+		if (of_property_present(np, "cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
-		if (of_property_read_bool(np, "i-cache-size"))
+		if (of_property_present(np, "i-cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-		if (of_property_read_bool(np, "d-cache-size"))
+		if (of_property_present(np, "d-cache-size"))
 			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
 		levels = level;
 	}


