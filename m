Return-Path: <stable+bounces-134397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C960A92AE1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0363B462068
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67664257450;
	Thu, 17 Apr 2025 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RdOdKpWn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F02571AD;
	Thu, 17 Apr 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916005; cv=none; b=YiDN9O8fMXXo2Y7aGMUkGalhdjEJEmSa1U3tZ+mM7LF8KDiMYl05P7/Rhxy/b+h47HGsR1HeCYdxxulUBWTU9dK7I8cXOnFSNZFuN6lBUblMKwVI3R9DICJ/r34A/vjLlpJhsRrWT6Bhm0bZGv1J3Xdo+guv8ixc1R9NubWmL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916005; c=relaxed/simple;
	bh=DoSDaHg4cU7+I2/BO9aO9Xsl61jeyEWiBK3uAuOGC/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aehuKXncrvXv/+KPmYrHlJSltisi2s5a+cyKfs21AucGplC6fNACWEgvTP0UJ+IS6V7sW6SUcPmJTMJkNoXRtyik0WFI3LrEtTsDQVbeupi61mALL0i/hjWdq68ZAvqql8CctWHF9ARfM4DlxYrIi6N2SK7lSq3U94VKoaiDTs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RdOdKpWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F66AC4CEE4;
	Thu, 17 Apr 2025 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916004;
	bh=DoSDaHg4cU7+I2/BO9aO9Xsl61jeyEWiBK3uAuOGC/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdOdKpWn3EUgu1YcIqsw5LmBzu5mrb1/mEYD9dIWC4yM7atOny0HRWEnlEgqkK976
	 YAaC31SNW6SitTqSiRWcLIO/OvVf9tIbObiUfqdc9ArDmx2P7Z/jUKe28VCef8uvzh
	 Jk99Uouu4cs4vodIE6ajFYFwY4FBPi+n+clJdlvo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 311/393] mm/hugetlb: move hugetlb_sysctl_init() to the __init section
Date: Thu, 17 Apr 2025 19:52:00 +0200
Message-ID: <20250417175120.120169802@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Herbert <Marc.Herbert@linux.intel.com>

commit 1ca77ff1837249701053a7fcbdedabc41f4ae67c upstream.

hugetlb_sysctl_init() is only invoked once by an __init function and is
merely a wrapper around another __init function so there is not reason to
keep it.

Fixes the following warning when toning down some GCC inline options:

 WARNING: modpost: vmlinux: section mismatch in reference:
   hugetlb_sysctl_init+0x1b (section: .text) ->
     __register_sysctl_init (section: .init.text)

Link: https://lkml.kernel.org/r/20250319060041.2737320-1-marc.herbert@linux.intel.com
Signed-off-by: Marc Herbert <Marc.Herbert@linux.intel.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4863,7 +4863,7 @@ static struct ctl_table hugetlb_table[]
 	},
 };
 
-static void hugetlb_sysctl_init(void)
+static void __init hugetlb_sysctl_init(void)
 {
 	register_sysctl_init("vm", hugetlb_table);
 }



