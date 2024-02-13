Return-Path: <stable+bounces-19817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F897853763
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0861F23735
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484DA5FEE0;
	Tue, 13 Feb 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uJUfOWPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692E5FB86;
	Tue, 13 Feb 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845089; cv=none; b=owzD98LaojqaOZJZ73SQPBnglw9kgc/2yV/zm7Zn+oM6XJS5bsOmgmEQCPpEeYVyuiqCdJziPV5CLT4HWFF2U6UzFGb2wMwZkiMQ/oyWlCr61g/4+ahpFHiRT3fbAVGuUrSc9L9lRzyY3xYb9+TH+LzOuXZTPPIiiksooc/FDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845089; c=relaxed/simple;
	bh=0lJTXRT9e/PEh9pIqNwm9NreAPnH8llz2HFiq5I6PDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPOJ+8hHIlYAOzk8vDqryYz+85xP/FVuDZA75xMY7chIFwBK6P7j4HdmKJtGl5q0EqBVmbCZ3W2OEMm85ToCGnP4dhntOX/OU0PwknLXLUu+/qQd6s5er6vNx6Pu1WSYA1EPQB7WwMTvQefnMEgR/vbTaGxKfKf4tzZEJ6WyeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uJUfOWPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620ECC433C7;
	Tue, 13 Feb 2024 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845088;
	bh=0lJTXRT9e/PEh9pIqNwm9NreAPnH8llz2HFiq5I6PDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJUfOWPINPu8mkRVSaqMF8sxuvPI/ckgLHHTBupib5nzWa3ZI+5YurBc9nCkJQa/C
	 hi0IWlhiw6T+heL8RtEl6sLFzm2bcD9j6pzogETrRmgW6uJsNCyl7uS0t2pEgLBIBH
	 dtZ8/+lK68aiGh7VUNOOb8Wqk4o8LdSfE5klo8m4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 44/64] mtd: parsers: ofpart: add workaround for #size-cells 0
Date: Tue, 13 Feb 2024 18:21:30 +0100
Message-ID: <20240213171846.130972996@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
References: <20240213171844.702064831@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Dolcini <francesco.dolcini@toradex.com>

commit 84549c816dc317f012798e706e58669b3b013604 upstream.

Add a mechanism to handle the case in which partitions are present as
direct child of the nand controller node and #size-cells is set to <0>.

This could happen if the nand-controller node in the DTS is supposed to
have #size-cells set to 0, but for some historical reason/bug it was set
to 1 in the past, and the firmware (e.g. U-Boot) is adding the partition
as direct children of the nand-controller defaulting to #size-cells
being to 1.

This prevents a real boot failure on colibri-imx7 that happened during v6.1
development cycles.

Link: https://lore.kernel.org/all/Y4dgBTGNWpM6SQXI@francesco-nb.int.toradex.com/
Link: https://lore.kernel.org/all/20221202071900.1143950-1-francesco@dolcini.it/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230124104444.330913-1-francesco@dolcini.it
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/parsers/ofpart_core.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/mtd/parsers/ofpart_core.c
+++ b/drivers/mtd/parsers/ofpart_core.c
@@ -122,6 +122,25 @@ static int parse_fixed_partitions(struct
 
 		a_cells = of_n_addr_cells(pp);
 		s_cells = of_n_size_cells(pp);
+		if (!dedicated && s_cells == 0) {
+			/*
+			 * This is a ugly workaround to not create
+			 * regression on devices that are still creating
+			 * partitions as direct children of the nand controller.
+			 * This can happen in case the nand controller node has
+			 * #size-cells equal to 0 and the firmware (e.g.
+			 * U-Boot) just add the partitions there assuming
+			 * 32-bit addressing.
+			 *
+			 * If you get this warning your firmware and/or DTS
+			 * should be really fixed.
+			 *
+			 * This is working only for devices smaller than 4GiB.
+			 */
+			pr_warn("%s: ofpart partition %pOF (%pOF) #size-cells is wrongly set to <0>, assuming <1> for parsing partitions.\n",
+				master->name, pp, mtd_node);
+			s_cells = 1;
+		}
 		if (len / 4 != a_cells + s_cells) {
 			pr_debug("%s: ofpart partition %pOF (%pOF) error parsing reg property.\n",
 				 master->name, pp,



