Return-Path: <stable+bounces-180762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F32B8DAC2
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914373AD2F8
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AC2459D1;
	Sun, 21 Sep 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BHDN4ruG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DC2E40B
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457446; cv=none; b=tx4fmd4YQ1vhk0xWvfdx2vde5U+TWtHKRv4Gs2bSO0PLvOC539Z+A9aE2Epl6/8JSPQrV8CltTzD0WVFtxelqSo3nFTRkIz2EecvsIcnniyqCAE2oMzWj/mfxyYL49IYR4/6Fxlg7PZfLKf1vhLqYKacWxVzg+cZfDRAR0lHaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457446; c=relaxed/simple;
	bh=hs0BXOY8J9YHX59SIVibxzlMvaIBbldtDQimP8i5Hgw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Eau+KOuks+RNJ2/bWUJAhYMPfDUftWIYLhaopESK5+qpV6dtrUHeI2KcHXauvzDJwbVKyxj4NG7WVuGkVTBmPUhJXEcswEld3xjU47kXyiIqH0AVF2Xmm/95yJ16vdmtAompDoAlEW79HBoyAIDMsNmcQD0ks7FNRrUTAyCMCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BHDN4ruG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82185C4CEE7;
	Sun, 21 Sep 2025 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457445;
	bh=hs0BXOY8J9YHX59SIVibxzlMvaIBbldtDQimP8i5Hgw=;
	h=Subject:To:Cc:From:Date:From;
	b=BHDN4ruG96BxafPzR9E9L/l734C2Bh08PwFe+69HAGGaQc68gsz8OMLi9DvaKbGhc
	 RxX0gQQGmxM4ReWQo0rh+Si9NmQaP5OHdRJgM3zK/LaiXJh836PPcitnvWKsWaA3cx
	 8+O/i744h/IfI8F9prVft2atVKGyY0/omjIN5BL0=
Subject: WTF: patch "[PATCH] LoongArch: Replace sprintf() with sysfs_emit()" was seriously submitted to be applied to the 6.16-stable tree?
To: cuitao@kylinos.cn,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:24:01 +0200
Message-ID: <2025092101-lushly-steering-6b45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

The patch below was submitted to be applied to the 6.16-stable tree.

I fail to see how this patch meets the stable kernel rules as found at
Documentation/process/stable-kernel-rules.rst.

I could be totally wrong, and if so, please respond to 
<stable@vger.kernel.org> and let me know why this patch should be
applied.  Otherwise, it is now dropped from my patch queues, never to be
seen again.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d6d69f0edde63b553345d4efaceb7daed89fe04c Mon Sep 17 00:00:00 2001
From: Tao Cui <cuitao@kylinos.cn>
Date: Thu, 18 Sep 2025 19:44:04 +0800
Subject: [PATCH] LoongArch: Replace sprintf() with sysfs_emit()

As Documentation/filesystems/sysfs.rst suggested, show() should only use
sysfs_emit() or sysfs_emit_at() when formatting the value to be returned
to user space.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
index be309a71f204..23bd5ae2212c 100644
--- a/arch/loongarch/kernel/env.c
+++ b/arch/loongarch/kernel/env.c
@@ -86,7 +86,7 @@ late_initcall(fdt_cpu_clk_init);
 static ssize_t boardinfo_show(struct kobject *kobj,
 			      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf,
+	return sysfs_emit(buf,
 		"BIOS Information\n"
 		"Vendor\t\t\t: %s\n"
 		"Version\t\t\t: %s\n"


