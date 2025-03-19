Return-Path: <stable+bounces-124892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2925CA68888
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CE03B692A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D073253F23;
	Wed, 19 Mar 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OD/6+peC"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF449253F22;
	Wed, 19 Mar 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376843; cv=none; b=H7cf2F5hBFTAov2GAKJOXFa99UGjGCm6r6ZJlmD9RSXWtWZZYDJQ7IL+LbhEispbf6N5YMJgON92WEDdg/O2GEsQKG2pTsD5bqouoJqEtU0tlBLt/t4Pr9+hMeSBrSm7LF8SUFUJpABHcI0KzGqM0Wxg0u7/EiKKH5t6uTVXi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376843; c=relaxed/simple;
	bh=QcE3Exv6KWMB/patQRXwotoVumCkfcWotNC0z3khxKI=;
	h=Message-ID:From:Subject:Date:To:Cc; b=KRKuJSOV11rn4tIPzjsDuH1itOk7+ZQmVQzYoArtFsl5BL1Xl8CJsY80LoKP1W9iPiWPlFtlo9p9NOpb3PFpMhf1YXhjRbqctuo9yP6WQBYWaqF+6fm0le6vymO4Z1u5iY9qdD1VxHkvpmpfJ9IFMYo/kpM0+iXSGcWiBrb5xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OD/6+peC; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A9FC31140144;
	Wed, 19 Mar 2025 05:34:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Mar 2025 05:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1742376840; x=1742463240; bh=UNJGVlQxrzCOJumx5WZITHasmGjw
	CM9NyMzgM9QYtKc=; b=OD/6+peCmuxTSXRUCQWGZfopfD6PZhAVlCQD5TsB5Kh+
	725BFyzE++f4lptAgiKvQSvALEXLRGWubd/GaCqcdFFiiAayf+pgcAYP76tjX0Em
	RHgu75m80GpRe5A00BtxkfzXqFx9lsandKcU2yRNCz3QVwBfM1NcP7RTFOL6xp/R
	nes4kx+qHszMqgRjoQ06hAx+nu6jZuCljDliClvqfdbURCtVJK9doxDj65F1QK2L
	bKJHbdxHldKd2A4H3/GrFO49ggiZgUCedSbWzgtpZg4hPYBL4lgoXL1xqjSbcTEa
	QvNUxFRBBm56MtexMpgeoVluVCaULzElKn4eIxdvww==
X-ME-Sender: <xms:h4_aZx27oWXba03aWNDIPiZS3zfyYceJ4VeaQ-ZMaS0SB1zBnhRUcA>
    <xme:h4_aZ4HVqoBTKFS084MHE9pHjA2xSmFsLyEpq6OaexrINlh0t3tTecmJTTGIEx-mu
    abt8pN-pY_uijmCtw4>
X-ME-Received: <xmr:h4_aZx4m2-zm_HOoXh-Y2bcgNCLHW8Y8cP7IQHEFAsOwENObwNxru8oYZ1sf46W3aLENokNEKL-9tEzS3Aas12FlxE9PAGNU7tU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegleelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:h4_aZ-2aGSobBImGG39kDFVfKxbwL1FZVcZ6RBrZJ4vGWkMKoNlCzg>
    <xmx:h4_aZ0Gp14Jp4fiPeSqpOKeRs4LhFdvGx70xCGve0b9EwZX__O8O3Q>
    <xmx:h4_aZ_8Stl7_q5f7MifNo2YdCwRi7R0Kucy1e8AQ6G5SAShHT6VTvQ>
    <xmx:h4_aZxnCSADfSZILkRgGBar5zZTCbs6WycrjgTQiKRdarwU6abKckQ>
    <xmx:iI_aZwgbfSPy4latJ58DFYmd_z3eDTeccdmKvwgb_5zbT1AFm9_PkHFz>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:33:58 -0400 (EDT)
Message-ID: <cover.1742376675.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 0/3] m68k: Bug fix and cleanup for framebuffer debug console
Date: Wed, 19 Mar 2025 20:31:15 +1100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This series has a bug fix for the early bootconsole as well as
some related efficiency improvements and cleanup.

The relevant code is subject to CONSOLE_DEBUG, which is only used
on Macs at present.

---
Changed since v1: 
 - Solved problem with line wrap while scrolling.
 - Added two additional patches.


Finn Thain (3):
  m68k: Fix lost column on framebuffer debug console
  m68k: Avoid pointless recursion in debug console rendering
  m68k: Remove unused "cursor home" code from debug console

 arch/m68k/kernel/head.S | 73 +++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

-- 
2.45.3


