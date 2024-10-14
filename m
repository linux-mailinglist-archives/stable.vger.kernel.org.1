Return-Path: <stable+bounces-84605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDA99D106
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424E61C21504
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397B1AB505;
	Mon, 14 Oct 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2c7Ri4CT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268A1A76A5;
	Mon, 14 Oct 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918588; cv=none; b=oAFgsesBwnXiqNT7b0RW6tJFZtDXgSyakT5npLlaIspFpDdPAfFTHTdqc6AI66IEIk49fSPeUibhLa5xzuyNqa62MiwpnacM72gL/NVryQBNJmyJclGtNWAcqnhpXG4WZZr4oNMvDLJqknV2XTPhAfUrQUHNXjfMz3fOOZrYtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918588; c=relaxed/simple;
	bh=cvRWzcUSIWwszd+9v7LMK0rrdWjYWZe1NYpV7TqEy18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWyvfG3KEsFxUCa2guIRcsOvvoqvr+x9OsFd+PZ4q/QuPMbu2ocjxUVqMZ8tTbcVV6tbR6EmyhbB8dV+estqm9lefkNp1He6UFRuZh2hBheMmz5TMvzaB1IlxCO/SNtlmCLrTbtsXF75QBB6Sa9XkowbWZuL/OMmI43JWh1Ot84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2c7Ri4CT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FA1C4CEC3;
	Mon, 14 Oct 2024 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918588;
	bh=cvRWzcUSIWwszd+9v7LMK0rrdWjYWZe1NYpV7TqEy18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2c7Ri4CTOepm1nTkzdrf4kbYlMYHd72jmXkg9Ji3utTQDbOzxqyqX356ZiVevUoS6
	 Ez/qFHwXJeqDhCxSFU/9LIooOW40LqVshK1EMpg/+OpPdsVtlMiyCnU01mslPuy60I
	 bcGlx7qSgc3iX8vauhkJss6cgNMe8OskZjkA8ID8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 333/798] hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume
Date: Mon, 14 Oct 2024 16:14:47 +0200
Message-ID: <20241014141231.032658826@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Gaosheng Cui <cuigaosheng1@huawei.com>

commit 4b7acc85de14ee8a2236f54445dc635d47eceac0 upstream.

Add the missing clk_disable_unprepare() before return in
cctrng_resume().

Fixes: a583ed310bb6 ("hwrng: cctrng - introduce Arm CryptoCell driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hw_random/cctrng.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -665,6 +665,7 @@ static int __maybe_unused cctrng_resume(
 	/* wait for Cryptocell reset completion */
 	if (!cctrng_wait_for_reset_completion(drvdata)) {
 		dev_err(dev, "Cryptocell reset not completed");
+		clk_disable_unprepare(drvdata->clk);
 		return -EBUSY;
 	}
 



