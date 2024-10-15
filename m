Return-Path: <stable+bounces-86092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4D99EBA1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC70F1F26A67
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A11AF0AC;
	Tue, 15 Oct 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bl8X2dOS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A041C07FF;
	Tue, 15 Oct 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997745; cv=none; b=ETt/hFdKLkI/arYJI0K1iftOMrGQtEVRrmUINwzlu981Lm8NZiHKisVvhKDPX3+HIIhHVDE9lZq4v9h68j0IYr99LEQNcBzXnk0TsqKY/vQX19VEJFVjdU7G4xhEW7dWjZPKq9cxMujpNgoJEugcrO90hEaGNNZT4a6E+0lWPwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997745; c=relaxed/simple;
	bh=em3Eij3MpB8/ckEuAg+q6Lkq0Nn9sck+CzE/rIBCJiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjWY5eN8otuhmelPAPvP9yUvfQYa62Q+IVRUxmEIf7I/F1bKsvmpZfHGd+1DaGdNvLyF31XtPguQLGgymO//ZeukHHp2IXn8QYgtIJCk8oqizjPVxOrvGUwB0ajBYt6Y0iV0lIgED/N6n7XgYEi1qJi464ped11GyORZ1WzT3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bl8X2dOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F51BC4CEC6;
	Tue, 15 Oct 2024 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997744;
	bh=em3Eij3MpB8/ckEuAg+q6Lkq0Nn9sck+CzE/rIBCJiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bl8X2dOSHdg8RMX/cXzk9Lb1Og6QjR3RsZ+ycdNxPYF4bmvO5zTCQu64A7XAOB4cl
	 VU8caGC9i2N/Jwj/kKcmfs9V924A+Ze0uqw/J6aAuAfTeaHoX/vkR3M3NwzmJHUWlH
	 jGVkwBAm82bJb6q5cmVIRg13GysIIoZBNgNswKbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.10 242/518] hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume
Date: Tue, 15 Oct 2024 14:42:26 +0200
Message-ID: <20241015123926.332238744@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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
@@ -679,6 +679,7 @@ static int __maybe_unused cctrng_resume(
 	/* wait for Cryptocell reset completion */
 	if (!cctrng_wait_for_reset_completion(drvdata)) {
 		dev_err(dev, "Cryptocell reset not completed");
+		clk_disable_unprepare(drvdata->clk);
 		return -EBUSY;
 	}
 



