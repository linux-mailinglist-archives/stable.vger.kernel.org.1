Return-Path: <stable+bounces-1072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6867F7DE3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B1ABB20F83
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39413A8C3;
	Fri, 24 Nov 2023 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I2uEiFKX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDF381D4;
	Fri, 24 Nov 2023 18:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2F2C433C7;
	Fri, 24 Nov 2023 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850490;
	bh=B/mtAHzwvr32IBqCIQePECIbKP/uz8c/4BGPiiX7rxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2uEiFKXNVJD+Bq7HfCib4nhg7R6ounA0oNYQFkn65ZD8Qq2bFkCwAt2rrI9MmfVa
	 h5GpsWEOwT38DoQMqrkLMWERDARqEEhvSNuqEQJnOtLYsVuY11rfnUpQvdCT5GoN6L
	 oYkKOil6PUAhNja8CzVfdkwOyeHpA/obAM/Mdr1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 052/491] md: dont rely on mddev->pers to be set in mddev_suspend()
Date: Fri, 24 Nov 2023 17:44:48 +0000
Message-ID: <20231124172026.245973419@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit b721e7885eb242aa2459ee66bb42ceef1bcf0f0c ]

'active_io' used to be initialized while the array is running, and
'mddev->pers' is set while the array is running as well. Hence caller
must hold 'reconfig_mutex' and guarantee 'mddev->pers' is set before
calling mddev_suspend().

Now that 'active_io' is initialized when mddev is allocated, such
restriction doesn't exist anymore. In the meantime, follow up patches
will refactor mddev_suspend(), hence add checking for 'mddev->pers' to
prevent null-ptr-deref.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230825030956.1527023-4-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 78d51dddf3a00..34b7196d9634c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -449,7 +449,7 @@ void mddev_suspend(struct mddev *mddev)
 	set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
 	percpu_ref_kill(&mddev->active_io);
 
-	if (mddev->pers->prepare_suspend)
+	if (mddev->pers && mddev->pers->prepare_suspend)
 		mddev->pers->prepare_suspend(mddev);
 
 	wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io));
-- 
2.42.0




