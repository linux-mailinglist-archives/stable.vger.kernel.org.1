Return-Path: <stable+bounces-79293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843498D783
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F660282D05
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC51D040F;
	Wed,  2 Oct 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iwGVuV0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFD17B421;
	Wed,  2 Oct 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877021; cv=none; b=Qe3mPHoJMrVYf4rhKwUPMKzH3yw4FejAH9Y4cA1ibXSbpldfQUwJKkwKyIkBCgF1vqICKXhuwPUXLGvEclBgteUAeqAxO7wMC/f57jyXy47Ykjr1cIJP8XLAHob/YhhIZJM+cq1Zta6V4eXij6lw8uhq0YHCu6djx0kIBSE3LsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877021; c=relaxed/simple;
	bh=IqD3hnLiY7NMifP+WbubPYGFjExGvbac/SCBdEeGo2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6uqQRFJ2l2R1Dyasm7JXZXFg896FPXJkNZigcLfzIjKpiaUAFDap612oQpLKShU5pzAASOSZkXNaN7GMzIIxS8mNTL1bA6ObbwfS8rlcsk/AAaxE4FmQ9hH7i/hyzTFlFyuClRwwoNiSNgftUphpCVXa06Q56DlzisOsMNHl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iwGVuV0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB60C4CED3;
	Wed,  2 Oct 2024 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877021;
	bh=IqD3hnLiY7NMifP+WbubPYGFjExGvbac/SCBdEeGo2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwGVuV0ANz2oo8wW88cgh13VMiLArSHq6WYTbCdOGnqR2xupA/2DnRwzR0SaxtJq3
	 t6VHHJttbiMtxWlPJVsgUVBuof5OdrTl902cbCByzOe3N7rwKyFWzIazynEL4cQAWJ
	 WNSaNYFC9ULzb12SAsisw85jYsCA6rTZuMm64JgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.11 638/695] hwrng: cctrng - Add missing clk_disable_unprepare in cctrng_resume
Date: Wed,  2 Oct 2024 15:00:36 +0200
Message-ID: <20241002125847.985855689@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
@@ -622,6 +622,7 @@ static int __maybe_unused cctrng_resume(
 	/* wait for Cryptocell reset completion */
 	if (!cctrng_wait_for_reset_completion(drvdata)) {
 		dev_err(dev, "Cryptocell reset not completed");
+		clk_disable_unprepare(drvdata->clk);
 		return -EBUSY;
 	}
 



