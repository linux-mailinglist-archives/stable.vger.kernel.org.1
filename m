Return-Path: <stable+bounces-57015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA73925A2C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9A91F22348
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418651741E4;
	Wed,  3 Jul 2024 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AbqgoCZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01194173352;
	Wed,  3 Jul 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003581; cv=none; b=N8iumvpAa1eOXQ3KVtrf75aBeTuXpfELLZendLALdmVVnK1vbdMxKlCSh3reCH7iokjhpjmLBLmw6pnrAS98vF9qhuTR0S4jLZ7+b/ZH0eGJ67l+V2P6sri+LsNldZ1keCgJxofT+u1vbapjj+Dv1B6JGcDBq7DD2HrJxLV5ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003581; c=relaxed/simple;
	bh=04CnYoP6ixZsNryeOcKsDeSL1VvdSZJJ6EjMEBTyz+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/BI8eLRi0bF+miuy2Hb20BOlnAkd262BRqx5pi1/+5nmOIanPvA5RBO/2JE3JTn6tMS03Cgj/Ili252kdvwuiPlbpS4ClWZ/8gY6BMErQrvdmw7e1bMi+5QEAXexzGrk6e7tPPhthcApkrk9oGvQsVxHhNVvYzac5E8G2RNUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AbqgoCZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199A4C2BD10;
	Wed,  3 Jul 2024 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003580;
	bh=04CnYoP6ixZsNryeOcKsDeSL1VvdSZJJ6EjMEBTyz+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AbqgoCZAZhQTH4oRkh9OJQTLAf1OZtBWiKbQ2AeNCVpHhw05dYQxIpt5dYbenmNo9
	 ydYib9s7AaJEyOWorwrLVdkFs0cZVKd7yTMRyIPnQ2MA3RqkIIJJJY2tbqESXMDYD4
	 kewRLYlBXIG1GOuXDwGQh31yT1VMSUgauiAK68qw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 4.19 054/139] intel_th: pci: Add Sapphire Rapids SOC support
Date: Wed,  3 Jul 2024 12:39:11 +0200
Message-ID: <20240703102832.480097037@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 2e1da7efabe05cb0cf0b358883b2bc89080ed0eb upstream.

Add support for the Trace Hub in Sapphire Rapids SOC.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20240429130119.1518073-13-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -276,6 +276,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Sapphire Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3456),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Rocket Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c19),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,



