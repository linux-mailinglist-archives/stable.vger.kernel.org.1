Return-Path: <stable+bounces-122748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C064A5A102
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE001734BF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715E23237F;
	Mon, 10 Mar 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDfl7yvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458602D023;
	Mon, 10 Mar 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629386; cv=none; b=b/4JnhkoH8QTSnDvjH/8+GLBRWiTJUcYW5FIOqBm81PGa4HXUOw8qgu7Rx6eq8XmABjG9SUWfnrCUJiSwwZofm6V6ul5Yxatrx0GaGnjZG1jfzuII9tnnYeNhh5Pn4ICd83ely/axkVfhmL1QtdDI8De3LgfukH/YY8XzfWitLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629386; c=relaxed/simple;
	bh=S8cXEvITRpdXXr1qadwQ5zUANVXxaqpLmPtolD/VOjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te7GfZYzPhyomxUDRncrltl0Ce4h++1yUEM3O7WeSKuGog31DH8kwoQ5hRrpYqha6TDbjBZhhUdriU3gB2+ftEcF1Nfsl/SnXUmFD5Flo0d/4WCoP6n441k6MHpQGffjvV0scObYmMdvGB3UKdEFn+7qsMZoAcWuLwDadfN2kRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GDfl7yvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA57C4CEE5;
	Mon, 10 Mar 2025 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629386;
	bh=S8cXEvITRpdXXr1qadwQ5zUANVXxaqpLmPtolD/VOjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDfl7yvpV5RiulT/tX0/eDDSLwbEpwnUkH8prUMh4LBsc4edfYFOiTOLzgQRWFROm
	 1UbWNVl/JvSFVW5H/s09mIz4HeMXbJKXmw4bdi2vGe4VdxYswWFUGFC80fAbL13ydy
	 B3pYAIGccOAXUpbg6OXTEMtouEUX8rhCx1YAqUKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 5.15 276/620] of: reserved-memory: Fix using wrong number of cells to get property alignment
Date: Mon, 10 Mar 2025 18:02:02 +0100
Message-ID: <20250310170556.513197231@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit 267b21d0bef8e67dbe6c591c9991444e58237ec9 upstream.

According to DT spec, size of property 'alignment' is based on parent
node’s #size-cells property.

But __reserved_mem_alloc_size() wrongly uses @dt_root_addr_cells to get
the property obviously.

Fix by using @dt_root_size_cells instead of @dt_root_addr_cells.

Fixes: 3f0c82066448 ("drivers: of: add initialization code for dynamic reserved memory")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/of_reserved_mem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -105,12 +105,12 @@ static int __init __reserved_mem_alloc_s
 
 	prop = of_get_flat_dt_prop(node, "alignment", &len);
 	if (prop) {
-		if (len != dt_root_addr_cells * sizeof(__be32)) {
+		if (len != dt_root_size_cells * sizeof(__be32)) {
 			pr_err("invalid alignment property in '%s' node.\n",
 				uname);
 			return -EINVAL;
 		}
-		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		align = dt_mem_next_cell(dt_root_size_cells, &prop);
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;



