Return-Path: <stable+bounces-120343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D8FA4E80F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E3217D9DF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416428FFD8;
	Tue,  4 Mar 2025 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPVZdTZO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E71281520
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106630; cv=none; b=FSgZEsbSKOpa+0nNw3lwUzfcmuSET3TJkBHdZqOTXRSgQWsZwK59tkMCssYKcTUykmz90185xEcQx+fmpseWfl/uUL+KxOK4sQAwjQ44MaYGA2qawjq6953uU0UQN4VryH8WYEMSDDc1la/ZSdYU47kHn9xuu6jd2U1uF9nnBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106630; c=relaxed/simple;
	bh=EBx9ILRH8T22CSvqD8MHWLhdfoKxlm2rVdX/rVfcD54=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aR4of7Fuc+27HMbr9XkBcepjzonjjuoiT3fNBVUYqXqTPU3+V5DahUEGLfq81oT2n/YQSEe+dtgpQs5zIqbNsLxD0r4MLlMmQNz1VsMkLdKXCL/UDNqemawzTGHocqZ+ZMGiNlgYihci8RaOqSLvNKkClSxyATJwb66lBw0XOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bPVZdTZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E82C4CEE7;
	Tue,  4 Mar 2025 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106630;
	bh=EBx9ILRH8T22CSvqD8MHWLhdfoKxlm2rVdX/rVfcD54=;
	h=Subject:To:Cc:From:Date:From;
	b=bPVZdTZOlHVXq/AMF8izKW+RxhcPBOcXmyiWN+dTrO8mlJ1bRu3gIpeI5jXAiE8Ak
	 4du/rHZfoHklEmRDh8aKSqRcwoHg+F5KAiavINsVukeOK0acnBWPD+sj7vMN4lKzYm
	 6yolpmbxoRiw/Aeysm70CPoxDlOjJiOYW0libWIE=
Subject: FAILED: patch "[PATCH] riscv: cacheinfo: Use of_property_present() for non-boolean" failed to apply to 6.1-stable tree
To: robh@kernel.org,cleger@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:39 +0100
Message-ID: <2025030439-anointer-conceal-ab4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fb8179ce2996bffaa36a04e2b6262843b01b7565
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030439-anointer-conceal-ab4c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


