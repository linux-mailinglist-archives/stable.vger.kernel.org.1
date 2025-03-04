Return-Path: <stable+bounces-120347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4EEA4E813
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A42162350
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A010291F91;
	Tue,  4 Mar 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wWtqEpCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B0291F8F
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106644; cv=none; b=fo8q6cCQml2qlaiFkNaBSGEfIbSl8TS5qsMlSpNWLsFbdcgNQCjyh69Zvd/+12vRWOCZcR+flgwk5d9vVG5UQMH0Hq8RHLDDcmjJYcJ5Ncv8opzf+qTm37D7Ew1fX1KMpASkReUx57JwKuXbglf8O/CJBIfLuMGrbzg6lFc0N5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106644; c=relaxed/simple;
	bh=u68Zdxmp16v6eoiU7RHUeW6BaDxZR7/VWL04HGs1TKM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e/wldGkI6SxqN6pmkpjnB5MGuRgyfTew1gO9XIkIBJ9viRYvMJhJbEHVWQuFobnCSzELW+nBMaEQOaExGpUmghjnq6SMXlgfJdCObkVLZP8nVxkM8K0isYKbk9Y64zTvFb/gmnDH64Ayd3rRfjH2w6zmUvRER3Lm/Q7jk6wu1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wWtqEpCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1946BC4CEE7;
	Tue,  4 Mar 2025 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106643;
	bh=u68Zdxmp16v6eoiU7RHUeW6BaDxZR7/VWL04HGs1TKM=;
	h=Subject:To:Cc:From:Date:From;
	b=wWtqEpCYlG3jQaCKVhd463kDUsaHOjmr7fnJsqqJK6Qul+376qi3Hf4FQbZXn1oFt
	 pg50utavLoRugtaaChljxVcA0uFV/ClLUb/pUnxjn+BmsHzVa7gSdw+Dnfvd6fIqYs
	 QdwcMDcCve5h2iew2HNidBpI6C+khuAXc11HOXDQ=
Subject: FAILED: patch "[PATCH] riscv: signal: fix signal_minsigstksz" failed to apply to 6.6-stable tree
To: yongxuan.wang@sifive.com,alexghiti@rivosinc.com,andybnac@gmail.com,palmer@rivosinc.com,zong.li@sifive.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:52 +0100
Message-ID: <2025030452-rural-foe-f342@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 564fc8eb6f78e01292ff10801f318feae6153fdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030452-rural-foe-f342@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 564fc8eb6f78e01292ff10801f318feae6153fdd Mon Sep 17 00:00:00 2001
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Fri, 20 Dec 2024 16:39:24 +0800
Subject: [PATCH] riscv: signal: fix signal_minsigstksz

The init_rt_signal_env() funciton is called before the alternative patch
is applied, so using the alternative-related API to check the availability
of an extension within this function doesn't have the intended effect.
This patch reorders the init_rt_signal_env() and apply_boot_alternatives()
to get the correct signal_minsigstksz.

Fixes: e92f469b0771 ("riscv: signal: Report signal frame size to userspace via auxv")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Andy Chiu <andybnac@gmail.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20241220083926.19453-3-yongxuan.wang@sifive.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f1793630fc51..4fe45daa6281 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -322,8 +322,8 @@ void __init setup_arch(char **cmdline_p)
 
 	riscv_init_cbo_blocksizes();
 	riscv_fill_hwcap();
-	init_rt_signal_env();
 	apply_boot_alternatives();
+	init_rt_signal_env();
 
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))


