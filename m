Return-Path: <stable+bounces-113900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F9A29499
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CFC1892D70
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3B165F16;
	Wed,  5 Feb 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0rY9HUtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068C16CD33;
	Wed,  5 Feb 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768555; cv=none; b=HAsYtN9uEFDvXgxXyMaLJXMLULBxLspaVQ6OTnRRr+BYYSk6wzcnTVYQSP2QQjB1Fa9V94Fm81gQ7fArEgtDp1DVglCwL1tBZotIpCGcSlqEPcSoeVSo68s1GMvgSwD3jRtwyU/auDA5INmU2YEdb2TXCMdKr+lIsYP0VQRAHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768555; c=relaxed/simple;
	bh=9CrHEaYapEKJlQ/U6hZ/p83in2BMuagMDJOdnLVplYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAh3HiW+GRTE3nFrcrZQxGLlL/N/BzZSfwRCxlIr5CyD7YO0dZxfixcPZA2xxWSfrubRSsvPgK/YLZ33GMaOsiMdYDdqoYI4BwfKpDquSMtr8PWI4HtEe7Mkkb9/hg147tXCG8nxSBoIaM8n/FzOCmefUVrPIZOvfmwpy7PbvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0rY9HUtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A3C4CED1;
	Wed,  5 Feb 2025 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768555;
	bh=9CrHEaYapEKJlQ/U6hZ/p83in2BMuagMDJOdnLVplYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0rY9HUtcqha8TcGtuZ2WDe0ruVxGFGU6zDriquiUhisaoh5fVVniGxbZiJ0aCgDdp
	 br0JsoGPUUNQ0qmR0ANyIhH6R1CAPwnlQT4aekge1e58vlJeaHKjuYIqr4KvPHEjfm
	 xtsk/z8h37fG5UCja8h+vco78gZaqnYKAjXiNBac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Hawley <warthog9@eaglescrag.net>,
	"Ricardo B. Marliere" <rbm@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 6.13 582/623] ktest.pl: Check kernelrelease return in get_version
Date: Wed,  5 Feb 2025 14:45:24 +0100
Message-ID: <20250205134518.485369841@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo B. Marliere <rbm@suse.com>

commit a4e17a8f239a545c463f8ec27db4ed6e74b31841 upstream.

In the case of a test that uses the special option ${KERNEL_VERSION} in one
of its settings but has no configuration available in ${OUTPUT_DIR}, for
example if it's a new empty directory, then the `make kernelrelease` call
will fail and the subroutine will chomp an empty string, silently. Fix that
by adding an empty configuration and retrying.

Cc: stable@vger.kernel.org
Cc: John Hawley <warthog9@eaglescrag.net>
Fixes: 5f9b6ced04a4e ("ktest: Bisecting, install modules, add logging")
Link: https://lore.kernel.org/20241205-ktest_kver_fallback-v2-1-869dae4c7777@suse.com
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/ktest/ktest.pl |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2419,6 +2419,11 @@ sub get_version {
     return if ($have_version);
     doprint "$make kernelrelease ... ";
     $version = `$make -s kernelrelease | tail -1`;
+    if (!length($version)) {
+	run_command "$make allnoconfig" or return 0;
+	doprint "$make kernelrelease ... ";
+	$version = `$make -s kernelrelease | tail -1`;
+    }
     chomp($version);
     doprint "$version\n";
     $have_version = 1;



