Return-Path: <stable+bounces-52069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07012907872
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C421C22D66
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D621448E6;
	Thu, 13 Jun 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="OaCnBr8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIqKFfjk"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AE12D757;
	Thu, 13 Jun 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296899; cv=none; b=nJXCTpqalDfa/kbHXdadJVEc+t+ii0g7UkJ5hqCAGpXs0ibgiLXY6EH/+wLwmMhtroe1E8t30Km0ojNBaRulwCDCJDvd2fT5iMtB4+Q/l5NV0eUP/u8Rb1qG6uT8vtKnq4JkkxcJWDddoHDOmgrR3DkiATA40ccw3Y/atYzkrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296899; c=relaxed/simple;
	bh=SIwMvO39BmbW7c2qCC3FVPcLtHrn3VC2fa9BqViEGSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UMECC3uSLCOnCTXZQBK6/YRHxRRNGAcuF2PS4MIPvBsh+KbY/oJ/6GqniFO7zdfPW2rWo8+hBe49bFLEUqaNw2VLnBbwm8kDPHa82qnclT7NpffRlQKGUEvsN6HSKxZo7lKdv4VyC+NN2dMRxArU/m6eQfOJ0D4F7xKQkyVTVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=OaCnBr8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIqKFfjk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E4C8C13800BE;
	Thu, 13 Jun 2024 12:41:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 13 Jun 2024 12:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1718296896; x=1718383296; bh=AK
	wt86hx8VrZMzXcCZWfK6szZPgA3uEjcq8VP/L9IQc=; b=OaCnBr8DfSxfoQXg+d
	rdlqwrhll1vSkGKYPuN+GbkTaiAiWegRadk73wsxExVMY/ZWzlZTdmvF5/jboczE
	LFGbgJ9ie7oItGRkSwBlaGheKfvLQg6O9pYeWWIkS/m7tHxxwDE07rAeA7YgK2Ha
	ADyy6LpHqhdjF4FsLi1C/KWgQJCIWEbdoQfSmyutJQ8f55dfXy9S2oA9Gn0K2hlY
	9iUavQSfCy5WC0HAmotXzgfW06sTWiX3Dgi+XfHY7ndiVxoonUMkq4YKVyEoKNFi
	JahhcURXklttR2ZmY6hnKGZ9WwmpcxNOfoSEK+24lEVBkXrLR08DHhAy/uXAg+AH
	V3PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718296896; x=1718383296; bh=AKwt86hx8VrZM
	zXcCZWfK6szZPgA3uEjcq8VP/L9IQc=; b=GIqKFfjkbqatz7mRpMWYuCQ8R2Vot
	zptLZwb50JqIjA+TaPiQH11YsjYOJWZa+oBGEC7szerQIJhXwMLvSxcbLCxWz49B
	+uPrAB68oTOHc2FRMEajiXJVkISg6dAIrZCipwKC6GiJyZiJPfHVti8BcF96PvHa
	LRrBzeptmJZkREGEgEDElolQtXTHbDTp22W2ipw4+bAavkxuUZ0exjtEfK9vF+fX
	ktsdX/cWdpIjnVxw27u/ezCAEVzKXsvqx2NPRM96A7hojEy1kWgSTV3HaN/Tfvw/
	W52yHxs5AVOtojM/34YAlIJnqY7j8pYxqHvtgaRwMHsHbBT4pKZcBm21w==
X-ME-Sender: <xms:QCFrZrOjhjtvnxQy0aNPiAehCmRWao3uMbTEStxXy6jH_L-0-bwsxw>
    <xme:QCFrZl-hYLpvmBnyymRUf84MfH1Az5Nlv7wndJ0rU-99e0ksB2uTCI_wMlK6eiqsh
    fvtrySAjfeGdDU8o24>
X-ME-Received: <xmr:QCFrZqRnFEn_NtRAcoKxmbeMh3w69Vra8UTTNWaLLVkAxNz8EC7zF-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeeh
    keevudevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:QCFrZvvk4HroSmVCYb6Qrci8CRfG5i0qrL75UDhBddeVxj2iA98vWw>
    <xmx:QCFrZjfFIl1aVIVAal_MpmEjoAl511Jl_DO1_XiEivMf5aF2aSctww>
    <xmx:QCFrZr3-l-ahK74EbabNIAdwWxkA26Y7eqRzpPOyzGJIiZskNFqR-w>
    <xmx:QCFrZv_VbuyE0lF4VASRTr11b3czGbKw9PnWie8bYiF5070TSVJfiw>
    <xmx:QCFrZrRbACPnFw0R1FhSwhPRt4txrlu0rNoEnA4vxWiTZdbSwLxQ_m_C>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 12:41:35 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] LoongArch: Fix S3 sleep on U-Boot + QEMU virt machine
Date: Thu, 13 Jun 2024 17:41:33 +0100
Message-Id: <20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0ha2YC/x3MQQqAIBBA0avErBPMSqirRIvSGR0IFYUIpLsnL
 d/i/woFM2OBtauQ8ebCMTQMfQfGH8GhYNsMSqpJ6mEUV4zBHdl4PYlyISYhx5nIWKIFT2hdykj
 8/M9tf98P7cMiAGMAAAA=
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=993;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=SIwMvO39BmbW7c2qCC3FVPcLtHrn3VC2fa9BqViEGSM=;
 b=kA0DAAoWQ3EMfdd3KcMByyZiAGZrIT+imFecZ5S2NsCy2hMND++bVyGKsRUn6ql4zh/6aqaTK
 Ih1BAAWCgAdFiEEVBAijrCB0aDX4Gr8Q3EMfdd3KcMFAmZrIT8ACgkQQ3EMfdd3KcMVRgEAiwCE
 C0oAJBwbXMnYfZvq/oTJCLFXrXNFPhKQcjKuwpABALz+By/KjdKKHHVWCFLZwLqq+ynXrlEtgAk
 IDzvUXi4C
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series fixed S3 sleep on U-Boot + QEMU virt machine.

The first patch is a further DMW window setting fix, the
second fixed support of ACPI standard S3 sleep procdure.

Please review.
Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (2):
      LoongArch: Initialise unused Direct Map Windows
      LoongArch: Fix ACPI standard register based S3 support

 arch/loongarch/include/asm/loongarch.h   |  4 ++++
 arch/loongarch/include/asm/stackframe.h  | 11 +++++++++++
 arch/loongarch/kernel/head.S             | 12 ++----------
 arch/loongarch/power/platform.c          | 24 ++++++++++++++++++------
 arch/loongarch/power/suspend_asm.S       |  8 ++------
 drivers/firmware/efi/libstub/loongarch.c |  2 ++
 6 files changed, 39 insertions(+), 22 deletions(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240613-loongarch64-sleep-035ffcdff9eb

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


