Return-Path: <stable+bounces-16955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA123840F35
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793851F2659C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D09164191;
	Mon, 29 Jan 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fni6bqGs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DB1586C1;
	Mon, 29 Jan 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548402; cv=none; b=jizV7VGHLpw/axktINSacaV9jpOIxlHhfMo2riNoL9P5k9BknZFjEH6KOEt/j+dz2SRd97FxgNfagsC+haScht3GLfxtUBBHVNBlXE4sImK4XwAvuRgKwJoQ4KgzNgu41DbBukgoJIT6g7ut++YreiV2VtGx0fBR84Lr5CcyBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548402; c=relaxed/simple;
	bh=rkgh9KKWIv73zJCUGbW5pxnmnio5InbZcaZHDZx2BsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBmDaClzpOAr+VZ+vnadmU8QN5tJ/dAk6MyxJFLBmbHIu2L5Y8sOZK2sWdCwVrzrDS5CmiB2yFADm1JcajtlqKp14e8Nkzm85UugjLgU2JvQZebN1U1US/JapLF0yJcQeP7GRFsp531v52qwz6MuGbhGivHxMKaXWMqJ8GSpn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fni6bqGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF0FC433C7;
	Mon, 29 Jan 2024 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548402;
	bh=rkgh9KKWIv73zJCUGbW5pxnmnio5InbZcaZHDZx2BsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fni6bqGsSPtCRSBBUat03nol3VQj0DGi1O0pOYy9C3TOAIO+oGEsicYSGZ81xyxXK
	 eXvXPCILw/ZvK2yw3KLAVF03JVDPquhFVQjGvSgcKlk++z5nNAgZaMp1A4yPU7n8B7
	 aYIsSAz2jaFhn1RrA9daJEwuX6c1GfZDUysRYB0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quanquan Cao <caoqq@fujitsu.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: =?UTF-8?q?=5BPATCH=206=2E1=20181/185=5D=20cxl/region=EF=BC=9AFix=20overflow=20issue=20in=20alloc=5Fhpa=28=29?=
Date: Mon, 29 Jan 2024 09:06:21 -0800
Message-ID: <20240129170004.405700024@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quanquan Cao <caoqq@fujitsu.com>

commit d76779dd3681c01a4c6c3cae4d0627c9083e0ee6 upstream.

Creating a region with 16 memory devices caused a problem. The div_u64_rem
function, used for dividing an unsigned 64-bit number by a 32-bit one,
faced an issue when SZ_256M * p->interleave_ways. The result surpassed
the maximum limit of the 32-bit divisor (4G), leading to an overflow
and a remainder of 0.
note: At this point, p->interleave_ways is 16, meaning 16 * 256M = 4G

To fix this issue, I replaced the div_u64_rem function with div64_u64_rem
and adjusted the type of the remainder.

Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/region.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -450,7 +450,7 @@ static int alloc_hpa(struct cxl_region *
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
 	struct resource *res;
-	u32 remainder = 0;
+	u64 remainder = 0;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
@@ -470,7 +470,7 @@ static int alloc_hpa(struct cxl_region *
 	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
 		return -ENXIO;
 
-	div_u64_rem(size, SZ_256M * p->interleave_ways, &remainder);
+	div64_u64_rem(size, (u64)SZ_256M * p->interleave_ways, &remainder);
 	if (remainder)
 		return -EINVAL;
 



