Return-Path: <stable+bounces-13989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B1837F11
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECB71F2B878
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F7A27450;
	Tue, 23 Jan 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J16e4a4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F43FFE;
	Tue, 23 Jan 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970916; cv=none; b=IewLQKUnqw2BimANXrigJ4Fm+EaMsuolfwMpmNhzWdqpdGOjE4ZqvOpLHRT2GEoUVuCVSJ1uA9IlusG+V/PnFubcdujhm4U+hsMoec452TvsbWmO+LgDgtMj0OH0/M3K0LegrNqk5PyCKkWpyJuu8PUu4v44Z16eAa/V677pDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970916; c=relaxed/simple;
	bh=M+KS7VJowzlIicsYshdPWEGla54Ou8tM79zT35fIQhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWOQMRLz8B//UkmScRen+oDhjDSQhaKg8HVwWcAzpNDdUjfvVdWxRtxzltCu1JswFlTkPf2dxt2DbAvyilZZHa1R+iAiAP41xpHil+JjqSjHXLY7rmAP/zRzsoO83HcyCXMWpdwvL3B2fA07MRzE4Y5tAUx3dg985lY2vHaf8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J16e4a4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A7C433C7;
	Tue, 23 Jan 2024 00:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970916;
	bh=M+KS7VJowzlIicsYshdPWEGla54Ou8tM79zT35fIQhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J16e4a4hxLYFGvy941qpgGE64m0NPaGMCORvZVAmPzcRN7SfWp01+WS9u9sPoWMQ1
	 J2nORtRI1SpsOmU/bmwzjHQ2Uge9SI+pKP8DbD2lFOuphhZJMGbyQyZzwC7tk36KYj
	 gYshgT3IedTsw0niSjGY61lHotuWtCvxbpxaAgPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cameron Williams <cang1@live.co.uk>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5.10 045/286] parport: parport_serial: Add Brainboxes BAR details
Date: Mon, 22 Jan 2024 15:55:51 -0800
Message-ID: <20240122235733.763970425@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cameron Williams <cang1@live.co.uk>

commit 65fde134b0a4ffe838729f9ee11b459a2f6f2815 upstream.

Add BAR/enum entries for Brainboxes serial/parallel cards.

Cc:  <stable@vger.kernel.org>
Signed-off-by: Cameron Williams <cang1@live.co.uk>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Link: https://lore.kernel.org/r/AS4PR02MB79035155C2D5C3333AE6FA52C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parport/parport_serial.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -65,6 +65,10 @@ enum parport_pc_pci_cards {
 	sunix_5069a,
 	sunix_5079a,
 	sunix_5099a,
+	brainboxes_uc257,
+	brainboxes_is300,
+	brainboxes_uc414,
+	brainboxes_px263,
 };
 
 /* each element directly indexed from enum list, above */
@@ -158,6 +162,10 @@ static struct parport_pc_pci cards[] = {
 	/* sunix_5069a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5079a */		{ 1, { { 1, 2 }, } },
 	/* sunix_5099a */		{ 1, { { 1, 2 }, } },
+	/* brainboxes_uc257 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_is300 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_uc414 */  { 1, { { 3, -1 }, } },
+	/* brainboxes_px263 */	{ 1, { { 3, -1 }, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {



