Return-Path: <stable+bounces-126899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3EA74104
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 23:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147D61893EF7
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 22:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE21415442A;
	Thu, 27 Mar 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBG0ChBg"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E07125B2;
	Thu, 27 Mar 2025 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115433; cv=none; b=PscQhSeICctr3LawXSLWHq2MJQdN5W31gTJ5I87pZH1kx/JFPyrX2yPdBYt0YxKqJVfePYDS6QaBf0dQ+nwx/QYTPbV1dYioRAnVSh6D+y6j6fdwiTOA2NJuH1oi5mAlUC2seipktMZg7Rik+xGPXZDGBr06zm+GKhPDaYwXQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115433; c=relaxed/simple;
	bh=FckN3QymhbhxJN9d9tbdEVXZu8tXYQOqhTy7OnTj3Ao=;
	h=Message-ID:From:Subject:Date:To:Cc; b=qWa5WbgYjB1EP2UYZ3rSeOV/r5C+N1nnKBmbh20cLRTdakIPD8CA5OwzYl/JdEjLPBeUTOwTeFgPACgEd+Z4GxVIAVznLUK3+OuXaNnPHxe36FE+gvkg+PIO+UbjX+8Ubgz1lBg9Nnu57EeWOzeyGX6LKoNRcwsosfEARJOJCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBG0ChBg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 33E491140092;
	Thu, 27 Mar 2025 18:43:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 18:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743115431; x=1743201831; bh=pdFss1M2T3cKLSiYMFrAjNaqs540
	4L0Oi9UHUbecIW4=; b=RBG0ChBgJs52L9KTzKT/ltezVkYuUk14bdlyjnnQl3a2
	WEDHP71mYH6NdllpSE0q9gRA68jyA3fkpw+yFBu2g3MV4gCXPAcchovvvpFjvfsn
	V3jsYaM0IUGwtEVPlfYBcf2GuxMxt4uImI6B/fpbVTY8mKGO4lniMyOMOG62tYVd
	RxGGaXR3i9tLQ5QTMPFI3HwytCh0DX3XdT4WvyTMUnIj4VEq1HOQqxgLqutJbhbi
	NP8k/hVQd8B/pjAXkOH+KgA/gkDcY2J0I9d5YlGqDlh1Xp1KX5KJrhjucVS9YyIY
	BvoDBSTevVeUuLEDdSNIyJjc4jVIzHOIrKt5VyP07A==
X-ME-Sender: <xms:ptTlZz8q4U5nL_ovIeU6M91b6Rzh1W92zhWXgzYFuDeVLDxDVXwaWw>
    <xme:ptTlZ_uy3b2h5Fa05qfoPIDuzwwckW2YD_vxDoCcrt5l1fni371hngucVdmI7DKUa
    c66oGzfN-W613bX32c>
X-ME-Received: <xmr:ptTlZxAP96blRc4V83netzAJCekTi30u9wcuzhFd8xna7KZUzO9J1ctnEGjEEBDDHq9oXiljyaW6rmvrsCmZt-63Lnlbg5kbdxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkffhufffvfevsedttdertddttddtnecuhfhr
    ohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorh
    hgqeenucggtffrrghtthgvrhhnpeehffdukeetffdutedvffffheegtdetkeekfeevgfei
    tefhvedvtdelhfduudettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgvggvrhhtsehlih
    hnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhish
    htshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ptTlZ_c1XRbMwjUWicpwc1pe4VCku-FLRVc83esq7K71ZrY8Lh7LGg>
    <xmx:ptTlZ4OoI3Jk8DuFs8GPJC0M8wj7rBkUir7kryToW6R6pu7t1-0J0A>
    <xmx:ptTlZxkOPxb6pl3Tjl0Fxc80AX_TxJbhpbEIXn0Fq7VkUDSmiUG-_g>
    <xmx:ptTlZysILT_ChyovtghwGUst5r1g3SRM0hjs-50qGVyAazUZ54PvQQ>
    <xmx:p9TlZ9q9J366utRD4lXA8Mjuijqj6QHrdiIYg6TzjesKgJuSuXj0DmxD>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 18:43:49 -0400 (EDT)
Message-ID: <cover.1743115195.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 0/3] m68k: Bug fix and cleanup for framebuffer debug console
Date: Fri, 28 Mar 2025 09:39:55 +1100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This series has a bug fix for the early bootconsole as well as some
related efficiency improvements and cleanup.

The relevant code is subject to CONSOLE_DEBUG, which is presently only
used with CONFIG_MAC. To test this series (in qemu-system-m68k, for example)
it's helpful to enable CONFIG_EARLY_PRINTK and
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER and boot with
kernel parameters 'console=ttyS0 earlyprintk keep_bootcon'.

---
Changed since v1: 
 - Solved problem with line wrap while scrolling.
 - Added two additional patches.

Changed since v2:
 - Adopted addq and subq as suggested by Andreas.


Finn Thain (3):
  m68k: Fix lost column on framebuffer debug console
  m68k: Avoid pointless recursion in debug console rendering
  m68k: Remove unused "cursor home" code from debug console

 arch/m68k/kernel/head.S | 73 +++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

-- 
2.45.3


