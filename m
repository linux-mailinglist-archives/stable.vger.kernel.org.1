Return-Path: <stable+bounces-165467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A3B15D89
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC640188D4DE
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743B255F5C;
	Wed, 30 Jul 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snwvsL9g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB41D63F2;
	Wed, 30 Jul 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869250; cv=none; b=jpRLqA1/gQ7dl0lxaqTHdnn2BHDSWK/ui5RC6ejllUYIvFUwbWJsMvrF5nfCXDk2iy/8UENCHNBQkIA8lw1JSOd3Iy8v/Rj5Ifhw66D6AzMXrwAMuAANmTr/18qAJav9TmD2gxc6jJsJR3VHuwC7Ny50Lghi6B93VTsXNmUeNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869250; c=relaxed/simple;
	bh=xq1ZMFn7hxVvdg5rY8mZockn9mkPhHww8CBWJz/bWkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZfvOERvPQ/ygBxNkhXcvD+ltZCu7mK0c0Pfkon+7ZfDxXnVFgtwsdckgsBHQPAWJC4Oa9Y3TeFk8WY9JiMYjPGnLmt1uZPWcqMx5UhF1uyBX8H3JIkZcJWMIKxufLu26jt7u+4MneOxoxAZ8ojaMGBFXIsB5QO9qJQMvd57OOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snwvsL9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE6AC4CEF6;
	Wed, 30 Jul 2025 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753869250;
	bh=xq1ZMFn7hxVvdg5rY8mZockn9mkPhHww8CBWJz/bWkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=snwvsL9gAiRVGMdXJaQg7392wc9PcJqYiD0OIw1Gu5UoA/8MBDJT5N+nGmOt4UeNQ
	 6YtWMsI3ujiEZIbtPK16q7eJPhfnhkYQSdkZvIviTGoMrwEw+JzNA8q+oBEi+dUKvz
	 B+z8tG4w69umDdjZj2q6UK3UV8MuBW6yrmg1u6Cc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15 74/92] resource: fix false warning in __request_region()
Date: Wed, 30 Jul 2025 11:36:22 +0200
Message-ID: <20250730093233.626144296@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
References: <20250730093230.629234025@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akinobu Mita <akinobu.mita@gmail.com>

commit 91a229bb7ba86b2592c3f18c54b7b2c5e6fe0f95 upstream.

A warning is raised when __request_region() detects a conflict with a
resource whose resource.desc is IORES_DESC_DEVICE_PRIVATE_MEMORY.

But this warning is only valid for iomem_resources.
The hmem device resource uses resource.desc as the numa node id, which can
cause spurious warnings.

This warning appeared on a machine with multiple cxl memory expanders.
One of the NUMA node id is 6, which is the same as the value of
IORES_DESC_DEVICE_PRIVATE_MEMORY.

In this environment it was just a spurious warning, but when I saw the
warning I suspected a real problem so it's better to fix it.

This change fixes this by restricting the warning to only iomem_resource.
This also adds a missing new line to the warning message.

Link: https://lkml.kernel.org/r/20250719112604.25500-1-akinobu.mita@gmail.com
Fixes: 7dab174e2e27 ("dax/hmem: Move hmem device registration to dax_hmem.ko")
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/resource.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1279,8 +1279,9 @@ static int __request_region_locked(struc
 		 * become unavailable to other users.  Conflicts are
 		 * not expected.  Warn to aid debugging if encountered.
 		 */
-		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
-			pr_warn("Unaddressable device %s %pR conflicts with %pR",
+		if (parent == &iomem_resource &&
+		    conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
+			pr_warn("Unaddressable device %s %pR conflicts with %pR\n",
 				conflict->name, conflict, res);
 		}
 		if (conflict != parent) {



