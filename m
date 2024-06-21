Return-Path: <stable+bounces-54812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABD912651
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD3B257E2
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A315357A;
	Fri, 21 Jun 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="D9upWGXw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QF1ss8Vx"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AF153828
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974734; cv=none; b=Bngt7ddmty3nWZwRNmYLQyx9imvBZS1ryb8D7hYMausrYouuqf5t8wIAY6Qk3isAWgB7IlVNlDKU2zl/ybDr9QU5TO1pp+GrPJFLC6yMYEC9diVFUjDLN9AEA3tWGjLPriiuiNEQj7saYg65IjNCO4W/4cfDEhFmXakPfEC4vEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974734; c=relaxed/simple;
	bh=hL+9adEfuSq3Edujq1XN2Ap29z4ZNpFoqZTthuhoy88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DcMV9ag0VU8PRat0P2JJH/XTRgBHGgCh8Lp/sTO1N0B6A1er6pbix01CWY+OozehDh5JuHlqToxkhgv4ZsgBSWVgTunGl0sv0PbZCJazv2U6n4Qz+VdASamqwZFbXIf0qvKZKRIp2tjV9A3IKqK4gK/icg37eesxxV281NUwZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=D9upWGXw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QF1ss8Vx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9546013801CA;
	Fri, 21 Jun 2024 08:58:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 21 Jun 2024 08:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1718974731; x=1719061131; bh=4S
	LyMxhz7plYrPfPBJgzVFI76T/wlnyp2pwLLAy9oNo=; b=D9upWGXwbpGZBhEcz5
	E/ICVIhYdZcvSV81CwQAzmodTeiuySM+suCb4M/dVGhRA45oa3BGOkcjaQ8FsNAW
	rNf6hjB8vaBtCkFDgDBHO9ixo3c9obatF5sZrCcTN4rTkmmgmcFBIGUpSs+qZFed
	XJsOxXjGABIhvZGsJoNCHna/gs0IHjUUY8CjWQzXxDIPQBY/iOy1RpfksLC5YElH
	AP/scUvZHduNgqf0LuTROb97qBiSm79im0Yxu7XkgT2Ipo1tf4K6O93uIRHSMwbM
	QLXs+AeHCdB1Iz/639ssFLyo63No94P/2GxiFxfNudJw3TrxXvjkYLOYwWxZAD6K
	k7YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1718974731; x=1719061131; bh=4SLyMxhz7plYr
	PfPBJgzVFI76T/wlnyp2pwLLAy9oNo=; b=QF1ss8VxH0P5w7Kk5pNUe9zvjFN2x
	malfnc2tgVO+PWY7u9Xr06gsCTl2VfeePQE45xlNC+vUF92/TVyKRrOaQAMd9hRy
	EPn/lsanrddF0d0wDuO5ub6Ulel1RrOE/YtTDGCVUx3B3fS16eRKmSBS5xPICvzW
	XstOf4yZ242nc0ikQXXQ8XMj9QfKtJE9/JhatDOgaqiu0cRPtB7SNdouowQhPeIS
	zRz5mt7pbHYVGop2GaFOpbYkGYvkEP+2tBjkudrzHsGYrXaJMnHhT6Nb40WOmIwL
	hq8889/VSMssh+uATFcoQG6I0oiQ9IDPFow83EbNQq3Nm5E8q8fwIx2Ug==
X-ME-Sender: <xms:Cnl1ZoBD3f-BviZ_0lD8RjAZ45neSBvZKijrAzEMf4oqLQ6VTK3v_w>
    <xme:Cnl1ZqjZ0D3tGBBafkGJK_UAwVW2GkHOujch7ZsFQy_NiIjruyJ4tm_IJoguLbApb
    8tEa74TrleE6O8V5fA>
X-ME-Received: <xmr:Cnl1Zrn0uUPGPib_53f23dS_TrgoP8BXYtsCNsfvm4nalOsMjRxO0vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
    veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:C3l1ZuzUejWvVgCM-xYxbhNRzvZ8UTMYNFM-ZVxc5RyVVnh5nPACTA>
    <xmx:C3l1ZtR0bE4v5jEOaN9nECVF_VlMOrmCQG6FxH6yQWPm-q0APm2inw>
    <xmx:C3l1ZpbSeuFAbXFPtbNLzMZg9oSYMMnx-ipYE_FZB5fNDn8-Iuj0eQ>
    <xmx:C3l1ZmT_YwPz8FQ5_ocGXZoNlaE2zIi8A5R7WTlxTEWolyWyXefrbQ>
    <xmx:C3l1ZsGIIvNL6eq6Q6KX6nFVgimKIKy3f7EA6YsWG4WCWhHut6LL5VNu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 08:58:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] MIPS misc patches
Date: Fri, 21 Jun 2024 13:58:40 +0100
Message-Id: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAB5dWYC/x2MQQqAIBAAvxJ7bkEtwvpKdIhabUHcUKgg/HvSc
 RhmXsiUmDJMzQuJLs4ssYJuG9iONXpC3iuDUaZXg9EYRKLPEjvkk9FJCHKjdv2ox6qtNVDTM5H
 j59/OSykfT8sYKmYAAAA=
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=600;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=hL+9adEfuSq3Edujq1XN2Ap29z4ZNpFoqZTthuhoy88=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTSSq7G00cmOzx5b9Zi1XpepVD3BXPdsmj3poKn7pO1B
 VSU+V52lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwETE8hn+Ci+sM955PFx6+txX
 T+QFEjZqpoUIr3187fYPySs2p1VMLzEyfOeXZuduSZnWvPzIyln3qjRWvbEMM2BfLP7T4ZZQw4R
 kNgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
      hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection
      linux-user/mips64: Use MIPS64R2-generic as default CPU type

 hw/mips/loongson3_virt.c       | 6 +++++-
 linux-user/mips64/target_elf.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 02d9c38236cf8c9826e5c5be61780c4444cb4ae0
change-id: 20240621-loongson3-ipi-follow-1f4919621882

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


