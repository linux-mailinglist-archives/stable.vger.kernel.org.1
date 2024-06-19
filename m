Return-Path: <stable+bounces-54221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960590ED3C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5606B225F2
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3086F14375A;
	Wed, 19 Jun 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZUzlKwCp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5CAD58;
	Wed, 19 Jun 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802940; cv=none; b=WaS3/25iawKctsvQgulWIAsA1BB3yiim1Rdwv1PCL5kTybvQWU8MARhKRUWEB/01CE+d3vSQdgmKJI/5ZdewqOu1EgpZEsWVD/omUbeVb8DnC3gBtXah+IiJCIMTz3I7Wy7ecy8lXnwfs4J3o3jWTESP4E5KC3jpGp12ikXLSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802940; c=relaxed/simple;
	bh=Oi46bwPfWBNuD/5YtgzBtcrjggXujFjcZdtWBDDQHls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOJsqz1xc7nXPucASwG4AztwGAx4wsgY0MJLOvh/JzrotgWWMifUiVAIMdAB9a1AKJSTgukp9dfWI6PsC6bPdOREu619tn+JcV1984/jSgSxi0duez/2ufByVuwfaTEtYvH+xoGXcuGrNmnv6Cu61Wdz1k7IJy8w3KQWCKfj+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZUzlKwCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E39C2BBFC;
	Wed, 19 Jun 2024 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802939;
	bh=Oi46bwPfWBNuD/5YtgzBtcrjggXujFjcZdtWBDDQHls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUzlKwCpezF5mBOm7gxadUYsYYuCafMW4QvynZHmi580Ed8wenVRvjnZ8pvStsL5b
	 yxmZ8VrWyC610NfwQZ3rxGbGczxT6Em38FtfrBDQiS/laBHbAYL+MhqxhNe6Pn5n2q
	 XcuxPcweLYfvXGc5z0ZkDx65SezAx4exumiCl7ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.9 098/281] thunderbolt: debugfs: Fix margin debugfs node creation condition
Date: Wed, 19 Jun 2024 14:54:17 +0200
Message-ID: <20240619125613.622608993@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aapo Vienamo <aapo.vienamo@linux.intel.com>

commit 985cfe501b74f214905ab4817acee0df24627268 upstream.

The margin debugfs node controls the "Enable Margin Test" field of the
lane margining operations. This field selects between either low or high
voltage margin values for voltage margin test or left or right timing
margin values for timing margin test.

According to the USB4 specification, whether or not the "Enable Margin
Test" control applies, depends on the values of the "Independent
High/Low Voltage Margin" or "Independent Left/Right Timing Margin"
capability fields for voltage and timing margin tests respectively. The
pre-existing condition enabled the debugfs node also in the case where
both low/high or left/right margins are returned, which is incorrect.
This change only enables the debugfs node in question, if the specific
required capability values are met.

Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Fixes: d0f1e0c2a699 ("thunderbolt: Add support for receiver lane margining")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/debugfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -943,8 +943,9 @@ static void margining_port_init(struct t
 	debugfs_create_file("run", 0600, dir, port, &margining_run_fops);
 	debugfs_create_file("results", 0600, dir, port, &margining_results_fops);
 	debugfs_create_file("test", 0600, dir, port, &margining_test_fops);
-	if (independent_voltage_margins(usb4) ||
-	    (supports_time(usb4) && independent_time_margins(usb4)))
+	if (independent_voltage_margins(usb4) == USB4_MARGIN_CAP_0_VOLTAGE_HL ||
+	    (supports_time(usb4) &&
+	     independent_time_margins(usb4) == USB4_MARGIN_CAP_1_TIME_LR))
 		debugfs_create_file("margin", 0600, dir, port, &margining_margin_fops);
 }
 



