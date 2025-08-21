Return-Path: <stable+bounces-172101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079DB2FAAA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D819362217C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329AB334723;
	Thu, 21 Aug 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FF4uA5be"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DE21C18E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783093; cv=none; b=BzltPS30I/7rK3we/ff9Kn9Crwo/JLc6CtMVr3lwK3gi2Y3LnoC5+xXvstTi4LjU5/pFetuGB9YinwbkeCM5YV7c97uehXh2W7e5FwYF0v0tqaNUottlMnQuL0CEB6dRYTsJm3wzr/AHbYxvLGyRhNDC3S3UFc//FmSokAzugB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783093; c=relaxed/simple;
	bh=V7Tu1KCraSHTPkMV6NAVnQ9lJnMhtS7XazRV1oxikbg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mD2ItKC7+b2fTVoWY14T3ZFg11NEbWXE7OLm1HOcf4lvwIDH7fBCKFJVWFvzWVNgt8gCwf5TJwU6jUZ0FmYXOqpdIPfmfCBbOHrkCYHqCCGzPCqiJFSVUnWyw5cYYenHmjeqOF9yV4QKYO6fmbBozKQXx+0sGmODENezX03QRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FF4uA5be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C48C4CEED;
	Thu, 21 Aug 2025 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783092;
	bh=V7Tu1KCraSHTPkMV6NAVnQ9lJnMhtS7XazRV1oxikbg=;
	h=Subject:To:Cc:From:Date:From;
	b=FF4uA5beXe24a8rZicghM9BN4BG+nQzaF5jTwwnRFAMWqhna68DsUYfSva7tsc97z
	 JWTvNp1QGd4/Wc3wTR/RH56k3tJgaAQXzU9+l9KeexXeXu/MxcZVDPrHmFBRjUZRSZ
	 YxA1WWHXsotwK8qiBBtkoz6r52UG2VslbnvRX+BU=
Subject: FAILED: patch "[PATCH] Mark xe driver as BROKEN if kernel page size is not 4kB" failed to apply to 6.12-stable tree
To: Simon.Richter@hogyros.de,rodrigo.vivi@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:31:17 +0200
Message-ID: <2025082117-juicy-abrasion-1549@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 022906afdf90327bce33d52fb4fb41b6c7d618fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082117-juicy-abrasion-1549@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 022906afdf90327bce33d52fb4fb41b6c7d618fb Mon Sep 17 00:00:00 2001
From: Simon Richter <Simon.Richter@hogyros.de>
Date: Sat, 2 Aug 2025 11:40:36 +0900
Subject: [PATCH] Mark xe driver as BROKEN if kernel page size is not 4kB
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver, for the time being, assumes that the kernel page size is 4kB,
so it fails on loong64 and aarch64 with 16kB pages, and ppc64el with 64kB
pages.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://lore.kernel.org/r/20250802024152.3021-1-Simon.Richter@hogyros.de
(cherry picked from commit 0521a868222ffe636bf202b6e9d29292c1e19c62)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 2bb2bc052120..714d5702dfd7 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -5,6 +5,7 @@ config DRM_XE
 	depends on KUNIT || !KUNIT
 	depends on INTEL_VSEC || !INTEL_VSEC
 	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
+	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs


