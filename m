Return-Path: <stable+bounces-10325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C36827467
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85734B23634
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0076A53E39;
	Mon,  8 Jan 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Vis3cVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2853E2E;
	Mon,  8 Jan 2024 15:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF859C433CB;
	Mon,  8 Jan 2024 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728693;
	bh=eDWJhVN3jts8+r7V/fldTzsXP1IoFouCTiTJCzvHbac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Vis3cVq1HXutJzFWfOUpooS5oqH8ku/Ur6dUUgwkxT1p73J6shYEXPRK9Zz6bVix
	 eVhYGldyakJsDcK/KD/6BdN17DoICFXNTE0yMrOtyE+ZhxSLGw9QvtCswSG+Y3iuvW
	 8MGRggBlfWRgKfZC7Mtv3LvL8lPEySAH7DoUJ6Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 6.1 150/150] Revert "interconnect: qcom: sm8250: Enable sync_state"
Date: Mon,  8 Jan 2024 16:36:41 +0100
Message-ID: <20240108153518.136303670@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Amit Pundir <amit.pundir@linaro.org>

This reverts commit 3637f6bdfe2ccd53c493836b6e43c9a73e4513b3 which is
commit bfc7db1cb94ad664546d70212699f8cc6c539e8c upstream.

This resulted in boot regression on RB5 (sm8250), causing the device
to hard crash into USB crash dump mode everytime.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Link: https://lkft.validation.linaro.org/scheduler/job/7151629#L4239
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/interconnect/qcom/sm8250.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -551,7 +551,6 @@ static struct platform_driver qnoc_drive
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
-		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);



