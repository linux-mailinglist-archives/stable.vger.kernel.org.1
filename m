Return-Path: <stable+bounces-154571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ECFADDC7F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016A1189CB56
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E86528981A;
	Tue, 17 Jun 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="googxCZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DC2063E7
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189136; cv=none; b=Lb0uNETJna/aF6x1ZsewLjwie8swMNELP5+kCVmjYMMxvAuSNQBvEZjJ5rzu6vwwjMeZnV91NCwfvvsssG0tfpd/xtzjVZmF1eYhQBq4KUnf7pNwe7qJnxqftyr9hWAKYkZSy7cnD19SXxqVKQjmWRQ6wkBOV1bvP3hTuufKOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189136; c=relaxed/simple;
	bh=dBkBm4B87fI0AHL/UN9PyrsRDOPtLiQZpgTg1a+Fv6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLf+Cr9vI1o3X7ncHpVhBrhl30dJ5aFlH1xjbYdpRZDJ9Fez/QeaVS5+P210xCZVt21IyBq/UsN5SDMosZDtUMPEalpWX9ZgraLtWxrAJFad7EXmWg2B15nM46B64A0AyQEwEuIK9ZCifTy9a6uw29UuBDCuhE8xa7I1M64YwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=googxCZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD23C4CEE3;
	Tue, 17 Jun 2025 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750189135;
	bh=dBkBm4B87fI0AHL/UN9PyrsRDOPtLiQZpgTg1a+Fv6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=googxCZ6GOh061fM+p7X+UmIXtHp5nYCIIZELpGNddUjTMcZ8wKvtthramBmdaRzi
	 CwmPUlshBFbSPP8Vhb+U0XdYnyjOJD6O90oX+itA9ZaW4sNd6FF+uJ6Dj9VIb8EEKV
	 QQy4JXHBH6wQxCQEOCxjTZoCN/QZzotc/Dg2TXMH185jnSmUlMMmFw2+SHIzmcvncc
	 Mo5tSG419izasjR/co02VOrA+yNSX/xvz5XI2DBX3tn1QgZ9sE2Zp7dj8lsiujeBQl
	 UmtzU1Ln92P64oRgjb4xLDC+0xRy1ZDwr+hGC8krDNEzoQBtDWZl/YY8pMg+ps3Al3
	 VMZggQuQRq+Xg==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6.y 0/2] Apply commit 358de8b4f201 to 6.6.y
Date: Tue, 17 Jun 2025 15:38:51 -0400
Message-ID: <20250617193853.388270-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2024021932-lavish-expel-58e5@gregkh>
References: <2024021932-lavish-expel-58e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Tested: "make binrpm-pkg" on Fedora 39 then installed with "rpm
-ivh ...". Newly installed kernel reboots as expected.

I will have a look at origin/linux-6.1.y next.

Jose Ignacio Tornos Martinez (1):
  kbuild: rpm-pkg: simplify installkernel %post

Masahiro Yamada (1):
  scripts: clean up IA-64 code

 scripts/checkstack.pl        |  3 ---
 scripts/gdb/linux/tasks.py   | 15 +++------------
 scripts/head-object-list.txt |  1 -
 scripts/kconfig/mconf.c      |  2 +-
 scripts/kconfig/nconf.c      |  2 +-
 scripts/package/kernel.spec  | 28 +++++++++++-----------------
 scripts/package/mkdebian     |  2 +-
 scripts/recordmcount.c       |  1 -
 scripts/recordmcount.pl      |  7 -------
 scripts/xz_wrap.sh           |  1 -
 10 files changed, 17 insertions(+), 45 deletions(-)

-- 
2.49.0


