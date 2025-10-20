Return-Path: <stable+bounces-187989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D29BEFE14
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDD724E8466
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020832E8E0D;
	Mon, 20 Oct 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UKhTnhjJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B22E8B93
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948284; cv=none; b=nzd+wQsqVfm+5IH/VTtSaJzoL3y20EGbF1QnpgeibV3KiG5mISsOeDdEl0bQgwTz7TPgQtKcVlbnCpT5Fz29pCzRXZtBx6AlAbCKBawkkfum1Fway5XvMhwsX0GeV9+OQtZo8rTOT/Af6nsvnxsBRTJKKt+Ef6vjJET289joDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948284; c=relaxed/simple;
	bh=JrsnDqeFUuKBbZavIBx1ISJBOMTceEOj6qbObg2M9dU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YX9SDDy5cay+FcH5h7wdh7r9oMR/DwE13e+azYb39HlOzV25BwP0FIdOfB9nxk//NAJCB/XrB+PmB9bYNBsv0+nABn3cMrwPG0gAVBtHfP6Unkq7EjDi3Ig7xPmes6UAsGsXiaARp0rGqzAwPk2nuduJLjCbFpQ1R3cGr2nboYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UKhTnhjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25163C4CEF9;
	Mon, 20 Oct 2025 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760948284;
	bh=JrsnDqeFUuKBbZavIBx1ISJBOMTceEOj6qbObg2M9dU=;
	h=Subject:To:Cc:From:Date:From;
	b=UKhTnhjJYc69sNFmRgSu+SnfPqUWp321Lo6nA5M+qAAcvbFL3dJskRDWJqvl5GSTt
	 qmKtLc1TnEEPb6DptycA7OqnGw6/q3aQLYzlTbZ08E5bTIzTJ57YVNB6EHTVwlSan4
	 jdrlE7HACHBcTaBD/ysD4ZlFRceycOcegw8axS5k=
Subject: FAILED: patch "[PATCH] cxl: Fix match_region_by_range() to use" failed to apply to 6.17-stable tree
To: dave.jiang@intel.com,alison.schofield@intel.com,dan.j.williams@intel.com,gourry@gourry.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:18:01 +0200
Message-ID: <2025102001-outsmart-slackness-607a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x f4d027921c811ff7fc16e4d03c6bbbf4347cf37a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102001-outsmart-slackness-607a@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4d027921c811ff7fc16e4d03c6bbbf4347cf37a Mon Sep 17 00:00:00 2001
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 10 Oct 2025 13:57:55 -0700
Subject: [PATCH] cxl: Fix match_region_by_range() to use
 region_res_match_cxl_range()

match_region_by_range() is not using the helper function that also takes
extended linear cache size into account when comparing regions. This
causes a x2 region to show up as 2 partial incomplete regions rather
than a single CXL region with extended linear cache support. Replace
the open coded compare logic with the proper helper function for
comparison. User visible impact is that when 'cxl list' is issued,
no activa CXL region(s) are shown. There may be multiple idle regions
present. No actual active CXL region is present in the kernel.

[dj: Fix stable address]

Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 858d4678628d..57ed85e332d3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3398,10 +3398,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	p = &cxlr->params;
 
 	guard(rwsem_read)(&cxl_rwsem.region);
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
-		return 1;
-
-	return 0;
+	return region_res_match_cxl_range(p, r);
 }
 
 static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,


