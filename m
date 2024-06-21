Return-Path: <stable+bounces-54822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB3091266E
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE0EDB2446F
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314C154C17;
	Fri, 21 Jun 2024 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="j1dlvxJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsOfVZWm"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD715444C
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975483; cv=none; b=PfvLodbL3m7qNVXzGUhqc3vY5FFqezm3dBP+hUSquH1BX5h2YcPVTWBYNm1oVyeO8luCeQdNaRHekCONnMVvfoBw3xl0tUjKCwf3UNWmYB/1CZwh3K8wzFWO4Yr39txSRsW/RNgRo/FRJIMzGD5yvFWiXrKbeZiFgPhmfarffzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975483; c=relaxed/simple;
	bh=8PfpE7R1R+XFwAqMiTgcG76EEadaddiSWZMhGn1FyXI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3NzsxMUH4D7iWTzmDAadJAXIlByqSeffIpBI3DQyT/VaIUfzdWxRk5bWhXuJMbLFpBy8uIvs/PZc+SOrW6MO/X0cennE2RwXqn/7Ms2KO3UhWw2Lok98PeM765WDCl9aWlLwD2u8bD0UQbaXBI6DDyPVJov3ALf3Gbgnbc6Pt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=j1dlvxJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsOfVZWm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 73EC61140210;
	Fri, 21 Jun 2024 09:11:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 21 Jun 2024 09:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1718975481; x=1719061881; bh=u9
	nLIxTxlEETiGDfpuynZrOn25XladFpzBT9nm4Dsiw=; b=j1dlvxJWxYCRYWmwu3
	OEytXWOIKKWUS2i7DNUkdsEAZsCdj2JCHThp25+kAjXAmP1wGjmdDHV0Ju2d1qfC
	DeRZEfXCwHY7FALUbRzbHLycuWuXHdxF3kEjl4XspF1RBDAIEjdXfRadd1kFiLi2
	X4N0n+IkpAevC7rV5c31GI0Yi5cUdAzxd4zBt3A6PVU4/+7OS0g8FRe2qaPrYxC3
	u3o34pa3LMECGFbqseu9qyNOtPResG6lG6kTpoCtPiMgFaQmTB3XIQ9MpWYgmBtt
	n89lRrt7yUZ3lt/dYCbFBN5lRE2u7RRoZonGHWxcP4J+FXoI15BYHZGQPb1nY1T4
	fCqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1718975481; x=1719061881; bh=u9nLIxTxlEETi
	GDfpuynZrOn25XladFpzBT9nm4Dsiw=; b=EsOfVZWmi/yVcax38wdNjG++J1gax
	FaJCUREXREm5RtzGdYe0G/96gqWhKOale8lK01djFf83naCZbmwFThSLonbpoa8C
	kooo5JcaSDOI4g4VP/tvRby9cIRbBqmKpytLq4wdNTDedyUhavAV8GhvvMilGIiz
	3dDi9+APTuglyXJaY+F0nX724zNw98ViQimi0U9u8uB5cD09LNaaFLCWuwhfkVY0
	ZbL2rbn4dpoT9cb0PQ523bVDuvVyv9LTqtaTSABA6wo9cz41VEYWAqdhXbJMcqOQ
	ptNThjcq2OGjcKSE2QISnFjPefjWqYiD5rhfFCBz3RjLGZfFLs+1BFb/g==
X-ME-Sender: <xms:-Ht1ZpKSNggVkSZdLdU6Y-NxvbqLWtP4pwEHFR0qJjZRBCcz2meFXg>
    <xme:-Ht1ZlKweYm42JWNV6frgpaBvh9M9avbI8ERnO0CPnN-w7BSLLFUJXXqrX_OQvsyF
    it21KxSN4WIjka8TC0>
X-ME-Received: <xmr:-Ht1ZhsXMnz47AJFnitlyq_q0ev_lIAQ8SdWELAnQp8oGWTYectIYGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
    kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:-Xt1ZqaE3d1xyeT0M5U-JhQyqY_g6WoT9zh4VCPjZJGDJBTa2OGZjQ>
    <xmx:-Xt1ZgZjyvUg8X4z1F_3YJwSNplSSlael5eQgg3dHXPtIDTSGUuu0A>
    <xmx:-Xt1ZuApkno2o8SA_bQE2lKRbDkvB5uV2W_z_LQTvYoHyL0ODH_pkw>
    <xmx:-Xt1Zual-M6GB0FkV9Zo8IbCCuUFW11F7L_9m9nb1q4Ar4SzoOyupg>
    <xmx:-Xt1ZlPAlVggB5HlbCB4psjTGmqCZbjc0KeOQVHfI13jluvjYIaF5kQT>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 09:11:20 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/3] MIPS misc patches
Date: Fri, 21 Jun 2024 14:11:12 +0100
Message-Id: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPB7dWYC/4WNQQ6CMBBFr0Jm7Rg6NAiuvIdhgdjCJLVDWoIS0
 rtbuYDL93/++ztEE9hEuBY7BLNyZPEZ6FTAMPV+NMjPzEAl6bImhU7Ej1F8hTwzWnFO3qisblW
 b66YhyNM5GMufQ3vvMk8cFwnb8bKqX/pHuCoscajNpbL0oEbrm3XbKP1yHuQFXUrpC9G6hn26A
 AAA
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8PfpE7R1R+XFwAqMiTgcG76EEadaddiSWZMhGn1FyXI=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTS6p83DXYZ6pp/SlI7ernj/IJksX6DZp6ry+0ffF3Cm
 nx6/qvCjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIvNkM/wN2HGH/1cd0bu5R
 7u7Ajat75ukbeuit0dsjFmsq0PVvThQjQ8fnfs7eJVUHt6iIfVrNFfvkhdq0CVK/qs6x1+kWCHa
 Y8wMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- v1 was sent in mistake, b4 messed up with QEMU again
- Link to v1: https://lore.kernel.org/r/20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com

---
Jiaxun Yang (3):
      hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
      hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection
      linux-user/mips64: Use MIPS64R2-generic as default CPU type

 hw/mips/loongson3_virt.c       | 5 ++++-
 linux-user/mips64/target_elf.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
---
base-commit: 02d9c38236cf8c9826e5c5be61780c4444cb4ae0
change-id: 20240621-loongson3-ipi-follow-1f4919621882

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


