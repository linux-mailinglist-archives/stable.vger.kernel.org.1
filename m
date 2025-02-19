Return-Path: <stable+bounces-118012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2820A3B98D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874813BFB01
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656551DEFF9;
	Wed, 19 Feb 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+oOAfWd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F419D882;
	Wed, 19 Feb 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956985; cv=none; b=cVFlHGxI1HS6VYrOEUMOCB8bIz98NvW87ZHUpUN/+ngPUpOEtsx1ciOO9NWdxKNU3SSDhbKAj3Ri32nbTQ2xZ/Ok6M3FDAiVbaiJwdb3SCok+wsC+ortDyjM7MTNO9CjYdh8eCrrm6VSFbw6c2ubrAo++DfU9RXPVG++vVXGETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956985; c=relaxed/simple;
	bh=IBDGNcqWcRyCBCpp9bRrzRPqCSXiu7BZeKwmgJ1ZlS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcPvM0qs4jq1RqwGV7wZSciOIybgVRIkBiT9Uvq3eKLEK0hgrNlYMlh71hbWXprJkb/ZMirhn7hVM9LSV0Xj+PJLXN8eBvPQkQTyytX/RVoUPyXF46RVOsJbDdfUZSp828vNMO0z517c1ncNFdEmy1LflaHPNT9OO7CBj+WtcIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+oOAfWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D540C4CED1;
	Wed, 19 Feb 2025 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956985;
	bh=IBDGNcqWcRyCBCpp9bRrzRPqCSXiu7BZeKwmgJ1ZlS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+oOAfWdkcyjC22c5jaIfpi+ipjq0QZyQtZ9vhZtByfAsLKNsTe8OPc9TwKYXv0gm
	 83NnWz5X57dPSrrCyZWeCiOYZiYWKDW76z67AK/HPqXB8D+McQcNd5gzUWpuxWYTQH
	 zPt+psGd8YjrYMZp1WiWINldPnwfjBJUt4Y5fb+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.1 368/578] of: reserved-memory: Fix using wrong number of cells to get property alignment
Date: Wed, 19 Feb 2025 09:26:12 +0100
Message-ID: <20250219082707.494427037@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



