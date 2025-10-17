Return-Path: <stable+bounces-186722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E57FBE9D80
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F03DC583654
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8365335070;
	Fri, 17 Oct 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yaKmmq8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE37335068;
	Fri, 17 Oct 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714051; cv=none; b=p/RgkATmJsZnqJmxePf39ebyvgYkKbBhuDxJW+LLkzMUHJQXOB0Vfmjs+WM0+qe8gvJSrPtq1vGckl8ISU2wBSYZnToURpB2GYVfYxDhTfLbmMEr6TgXwjja58qv6ul78gRv1qeU5i9tZJ1bWdpfzkxvL5/0sfHQ1oXccdwMsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714051; c=relaxed/simple;
	bh=R4XrrOqQrMd0xZsv2/3QIYFjiZh+VmmEs4omvWa2xcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABDBgR1cT/Vhlx4lEXDNtrRQZHQKc1BFxCNWCtr/lEW4kSPu7W0OK4HIW5e/JlEYrk2SrbCYFDTXoQqvxaxDXya9epFixQrVafs4qtY6/FrcVN1l+810VSpcLdtZ/6q6IQ29yqR2XBIBPF4SuiZsxc1wVVVviopDOiG+zoSjM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaKmmq8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8026C4CEE7;
	Fri, 17 Oct 2025 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714051;
	bh=R4XrrOqQrMd0xZsv2/3QIYFjiZh+VmmEs4omvWa2xcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yaKmmq8kw6bZ0SMGnnJCyU30zsamSQwRkvPIYDtAkZ76LDKrqmugBp1HXuB0oIrvj
	 nj4aoubKJ+TjpLm81dWXVzgm0u7zCaLyEyP8lfQ9j6tPw72mPqf74ivXyvpofJPXq8
	 NPgxAUVl65PJhZdAN+7cRUxWEmy04UHe1oiagTSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 010/277] iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE
Date: Fri, 17 Oct 2025 16:50:17 +0200
Message-ID: <20251017145147.522534121@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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



