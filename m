Return-Path: <stable+bounces-8880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A1E820547
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874AC1C21015
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6BC79C2;
	Sat, 30 Dec 2023 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ePL/B1i9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA979D8;
	Sat, 30 Dec 2023 12:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F97DC433C7;
	Sat, 30 Dec 2023 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938002;
	bh=sjo1KcoFUZGlRjib0/hkLgwxf/4KZkp9PJ16qNSNeoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePL/B1i9Julr41CEOU0Yne2ctad8/3eMb1bZAQOT9GHZd9L8dskxlUr2BHAV4ZJ0m
	 E2i+0ybMB1ke/sBrz8a9SVObWGjAB674KxksnSCG+QmP7oKUh5zNZy2aLszZrt2hae
	 EAow5U6ctRpNWdXiwovjWyAEcXpW6gzgraCRNqJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6.6 146/156] bus: ti-sysc: Flush posted write only after srst_udelay
Date: Sat, 30 Dec 2023 12:00:00 +0000
Message-ID: <20231230115817.092478298@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit f71f6ff8c1f682a1cae4e8d7bdeed9d7f76b8f75 upstream.

Commit 34539b442b3b ("bus: ti-sysc: Flush posted write on enable before
reset") caused a regression reproducable on omap4 duovero where the ISS
target module can produce interconnect errors on boot. Turns out the
registers are not accessible until after a delay for devices needing
a ti,sysc-delay-us value.

Let's fix this by flushing the posted write only after the reset delay.
We do flushing also for ti,sysc-delay-us using devices as that should
trigger an interconnect error if the delay is not properly configured.

Let's also add some comments while at it.

Fixes: 34539b442b3b ("bus: ti-sysc: Flush posted write on enable before reset")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/ti-sysc.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2158,13 +2158,23 @@ static int sysc_reset(struct sysc *ddata
 		sysc_val = sysc_read_sysconfig(ddata);
 		sysc_val |= sysc_mask;
 		sysc_write(ddata, sysc_offset, sysc_val);
-		/* Flush posted write */
+
+		/*
+		 * Some devices need a delay before reading registers
+		 * after reset. Presumably a srst_udelay is not needed
+		 * for devices that use a rstctrl register reset.
+		 */
+		if (ddata->cfg.srst_udelay)
+			fsleep(ddata->cfg.srst_udelay);
+
+		/*
+		 * Flush posted write. For devices needing srst_udelay
+		 * this should trigger an interconnect error if the
+		 * srst_udelay value is needed but not configured.
+		 */
 		sysc_val = sysc_read_sysconfig(ddata);
 	}
 
-	if (ddata->cfg.srst_udelay)
-		fsleep(ddata->cfg.srst_udelay);
-
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
 



