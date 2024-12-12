Return-Path: <stable+bounces-102204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDE9EF1DD
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6C18945E6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D39235C36;
	Thu, 12 Dec 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vSW5SgVB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AF223E81;
	Thu, 12 Dec 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020365; cv=none; b=Jnx3l0ewm5llEKLLq3ZuWrua0sGJULEAuCrIW/77XobMu6a4i4WKDKCaw2H1FXhLudalY8H1XOeLp5CsKfBMlAds8aE+N2HYFyNKWHByYpOP2t/PCH4yZMK5Tl0CeTaKMDH23LWjjZFV4RqEy/UgL2OePx4t2Pdrrnhd2h8JZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020365; c=relaxed/simple;
	bh=ex5dRL/V0Uid0vXFx3i+2pthC2MITxOAHn3mDCFNt04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBd0jiLcW7bnk2dB+J5jOrTOVIvLp5G8c7GW0EB8qJvtbFIsFvnEmKpxzYJzb10ia4vV1RNBs0jmezkVoxm3EAS3nvsgPae7fIDlCmCTW3weE9E86Ug61bB6GbypQZ8E7j+ZzzyB67EGrfJFFVY7zl4ysfHefE85VXJrs0hrvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vSW5SgVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC39C4CECE;
	Thu, 12 Dec 2024 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020365;
	bh=ex5dRL/V0Uid0vXFx3i+2pthC2MITxOAHn3mDCFNt04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vSW5SgVBqZErU+6ETKaao95wFojlUAr57QPC9KFo3pIXxCSREOxkW88Jpd8a7VfG1
	 a+DKIDx4ckDfp2pcJEYfxQKGWiERreLH7O9WSCfHyqQ5vtr37k1Hj9//H5Xgc3fSCy
	 wMpr2vIGi2kLoNrq90PMtl9ULFZmkd6gf7XBQ+w8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 448/772] sh: intc: Fix use-after-free bug in register_intc_controller()
Date: Thu, 12 Dec 2024 15:56:33 +0100
Message-ID: <20241212144408.434216922@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 63e72e551942642c48456a4134975136cdcb9b3c ]

In the error handling for this function, d is freed without ever
removing it from intc_list which would lead to a use after free.
To fix this, let's only add it to the list after everything has
succeeded.

Fixes: 2dcec7a988a1 ("sh: intc: set_irq_wake() support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/sh/intc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index ca4f4ca413f11..b19388b349be3 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -209,7 +209,6 @@ int __init register_intc_controller(struct intc_desc *desc)
 		goto err0;
 
 	INIT_LIST_HEAD(&d->list);
-	list_add_tail(&d->list, &intc_list);
 
 	raw_spin_lock_init(&d->lock);
 	INIT_RADIX_TREE(&d->tree, GFP_ATOMIC);
@@ -369,6 +368,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	d->skip_suspend = desc->skip_syscore_suspend;
 
+	list_add_tail(&d->list, &intc_list);
 	nr_intc_controllers++;
 
 	return 0;
-- 
2.43.0




