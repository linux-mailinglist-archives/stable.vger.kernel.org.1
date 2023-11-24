Return-Path: <stable+bounces-2310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEDD7F83A2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A73B26734
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238CC37170;
	Fri, 24 Nov 2023 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBB+b5ob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23A364C1;
	Fri, 24 Nov 2023 19:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CA2C433C7;
	Fri, 24 Nov 2023 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853570;
	bh=gg7x6IyTLZMF/eKZhXEdM1rtc1JckG8bFS8dtwLHLtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBB+b5ob1BchAEgSgcxqmGJQxsDJIxO3v5UAFLWkJc9dG8VjHkQPWIhCnMoGrMalt
	 wGxdbbSe1crQbQCHmzBid44I2dk65w9RAYJ1t+0CpN2pqjlSlPvrLAKgkVD0t/3d8C
	 4I8i7CaD3qpX8jTt0uyGIBJ+bMmkhJ+uchpOTpFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.com>,
	Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Subject: [PATCH 5.15 217/297] mcb: fix error handling for different scenarios when parsing
Date: Fri, 24 Nov 2023 17:54:19 +0000
Message-ID: <20231124172007.812630109@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
User-Agent: quilt/0.67
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanjuán García, Jorge <Jorge.SanjuanGarcia@duagon.com>

commit 63ba2d07b4be72b94216d20561f43e1150b25d98 upstream.

chameleon_parse_gdd() may fail for different reasons and end up
in the err tag. Make sure we at least always free the mcb_device
allocated with mcb_alloc_dev().

If mcb_device_register() fails, make sure to give up the reference
in the same place the device was added.

Fixes: 728ac3389296 ("mcb: mcb-parse: fix error handing in chameleon_parse_gdd()")
Cc: stable <stable@kernel.org>
Reviewed-by: Jose Javier Rodriguez Barbarin <JoseJavier.Rodriguez@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Link: https://lore.kernel.org/r/20231019141434.57971-2-jorge.sanjuangarcia@duagon.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mcb/mcb-core.c  |    1 +
 drivers/mcb/mcb-parse.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -246,6 +246,7 @@ int mcb_device_register(struct mcb_bus *
 	return 0;
 
 out:
+	put_device(&dev->dev);
 
 	return ret;
 }
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -106,7 +106,7 @@ static int chameleon_parse_gdd(struct mc
 	return 0;
 
 err:
-	put_device(&mdev->dev);
+	mcb_free_dev(mdev);
 
 	return ret;
 }



