Return-Path: <stable+bounces-186522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8ABE98F4
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243B07447F0
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE397332917;
	Fri, 17 Oct 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pzPN/1BA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5232C95D;
	Fri, 17 Oct 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713480; cv=none; b=dqeL0sc6ovXiA0bPvm4NaCm49t2K0BkW0cYPPGhdQTjmLu2N8nNUF3pSQraG5mKNF/OFHd7QzG1/keCNA25/h/OqF1zvPh9KexKAwV0WeXTSULjKY8IK0T0/CYPZuFfg4KBnJwu/xsD+RV/ZNOqy0JtJy26N9Eq5wM8A8XSPlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713480; c=relaxed/simple;
	bh=1ewfdxs5a1p3CX6ov/lFu0v/p948ifIz18UnoJjUg0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKRwY/CKZ1yHCRqOSVtfRM23Xb0+5JkrQT2e73e3VQWPAtwRBLsc7y9J6WwfuKu0t8wZ++LwXi40c/j5PymHCXilFJr64Ens6qJZUlHEOqqnOq8c7IRiUvB2blpbSpW0LaZgxUHfRvzLokf6dXX/lfoan01MsZLLHFKFFwZBrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pzPN/1BA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF9BC4CEE7;
	Fri, 17 Oct 2025 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713480;
	bh=1ewfdxs5a1p3CX6ov/lFu0v/p948ifIz18UnoJjUg0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pzPN/1BArmlIMdvCoaX+zI5QzYR4T64NcUoaPJJ7TH7fTyj1mBX4BWHdu1nR5KmUG
	 qMDAwkAxDZM6Ay+xI0BDpRhk0J1g6PRm4DHY2gJEDl/mqL3MFdTufRd4N8TwumNPRA
	 NE3dWBAsnaWFozfhMDtDjdRZo2maQj+zNwq2/yhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 004/201] iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE
Date: Fri, 17 Oct 2025 16:51:05 +0200
Message-ID: <20251017145134.887594706@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Hennerich <michael.hennerich@analog.com>

commit 1d8fdabe19267338f29b58f968499e5b55e6a3b6 upstream.

The clk div bits (2 bits wide) do not start in bit 16 but in bit 15. Fix it
accordingly.

Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF4350/ADF4351 Wideband Synthesizers")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250829-adf4350-fix-v2-2-0bf543ba797d@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/iio/frequency/adf4350.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/iio/frequency/adf4350.h
+++ b/include/linux/iio/frequency/adf4350.h
@@ -51,7 +51,7 @@
 
 /* REG3 Bit Definitions */
 #define ADF4350_REG3_12BIT_CLKDIV(x)		((x) << 3)
-#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 16)
+#define ADF4350_REG3_12BIT_CLKDIV_MODE(x)	((x) << 15)
 #define ADF4350_REG3_12BIT_CSR_EN		(1 << 18)
 #define ADF4351_REG3_CHARGE_CANCELLATION_EN	(1 << 21)
 #define ADF4351_REG3_ANTI_BACKLASH_3ns_EN	(1 << 22)



