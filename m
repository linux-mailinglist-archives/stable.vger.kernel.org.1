Return-Path: <stable+bounces-172109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382CBB2FAF8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A157225F3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFE5334398;
	Thu, 21 Aug 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZrV4u2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CA326D48
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783208; cv=none; b=CDBn+I82oSRKqUWvVe5xz2uXaAjm5mjCvL8f6RyYITvEu9PFrGUino2Q1wXVirUGccRvQtoPEUTEq5AoeGnl0D07TgzXBvzuvnyEBLYpvACbB0uqCzjIvkA3mEWpp0Yx0gFnj9GbvrQfD+1S56YQ6Eip+QtJKsXFgO9Lgoexy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783208; c=relaxed/simple;
	bh=YxMWQV0eHkoGR2A7/v/JVzrMqx5hWPaupYDUs7O3vec=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tVJ6PnphFaeD8rg03jGxmMS9/oFqlRQ8XHERdejho9B/VZg5SguSrw2uH4/8Vppr7F1XZmwE9i2Eq104BbRcXfheczCHpHa3LtyN5+KPKSXDDPZDwQlK93EoJrKKiJ60i1dEWI8JYkFWafvc7EZgZrz/oRQQnlneMKPhR68L6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZrV4u2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B78C4CEEB;
	Thu, 21 Aug 2025 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783207;
	bh=YxMWQV0eHkoGR2A7/v/JVzrMqx5hWPaupYDUs7O3vec=;
	h=Subject:To:Cc:From:Date:From;
	b=lZrV4u2c/Mt98h1dRatlxgBb2yZB8m87L/otyJA9xhx4bYBdJrOilw0fDax7+UTF9
	 EE4lFwveBJ7oCCj+Ar+qKZ8GIy9HyUvcTlO9n9+AndW4BdKJT22+pcxdaN+AocTlp2
	 6zKHR54gGXeq38rKm7Va3PFrIjA1Tt3eKt0fjHCA=
Subject: FAILED: patch "[PATCH] parisc: Makefile: explain that 64BIT requires both 32-bit and" failed to apply to 5.15-stable tree
To: rdunlap@infradead.org,James.Bottomley@HansenPartnership.com,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:33:24 +0200
Message-ID: <2025082124-undocked-gamma-38fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 305ab0a748c52eeaeb01d8cff6408842d19e5cb5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082124-undocked-gamma-38fe@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 305ab0a748c52eeaeb01d8cff6408842d19e5cb5 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 25 Jun 2025 00:30:54 -0700
Subject: [PATCH] parisc: Makefile: explain that 64BIT requires both 32-bit and
 64-bit compilers

For building a 64-bit kernel, both 32-bit and 64-bit VDSO binaries
are built, so both 32-bit and 64-bit compilers (and tools) should be
in the PATH environment variable.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.3+

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 9cd9aa3d16f2..48ae3c79557a 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -39,7 +39,9 @@ endif
 
 export LD_BFD
 
-# Set default 32 bits cross compilers for vdso
+# Set default 32 bits cross compilers for vdso.
+# This means that for 64BIT, both the 64-bit tools and the 32-bit tools
+# need to be in the path.
 CC_ARCHES_32 = hppa hppa2.0 hppa1.1
 CC_SUFFIXES  = linux linux-gnu unknown-linux-gnu suse-linux
 CROSS32_COMPILE := $(call cc-cross-prefix, \


