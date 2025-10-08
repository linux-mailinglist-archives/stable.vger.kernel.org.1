Return-Path: <stable+bounces-183642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93410BC6D34
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 00:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9624058D2
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 22:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F42C08C2;
	Wed,  8 Oct 2025 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6q9RRm0"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B584039;
	Wed,  8 Oct 2025 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759964366; cv=none; b=PeXQ3p0dLc9epmmOYzvzpQd7RY5LryQoGosj5sLgeUOai1T5jklvcBF8iAFULB94Im7+oQu9Dc+OHa68eD/qhJIpj2uCD5bbc6OOuoXU2AQjv9Q8tmyW6rtRZ7RrQte+M1zAeerjmJWEQxH41icaMWo/6C2XYs1KH+o0PJK6QiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759964366; c=relaxed/simple;
	bh=i79i+bUg5eCZTYfX9ZgOghJFCXfQE3kYGl8OBXHOMcQ=;
	h=To:Cc:Message-ID:From:Subject:Date; b=lPCicraj4rUOGXljlS/1E4kAHmwz3MfewEBLlOjFdXCmAEJFbXl25dba48EY91g1Clgspkf9k14DE/UsmK3hjh+wenpgqhoS3CH3K+KK8Am/7tW+9T/SQWc1BVmStLXx63nsq3/AkX7PcmgN4hQAjeZNcKh2uP9qEeBjXxlpQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6q9RRm0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DB3671D0028F;
	Wed,  8 Oct 2025 18:59:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 18:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759964361; x=1760050761; bh=b16CgqUYwDhd7yU4NyNftQntXr1J
	c5ksgcWR+Afr8vs=; b=b6q9RRm0hObBdglvYpOTO4AfTSPdlI5aWmCmXt4CEnWn
	egFl0nUuOGD4TCMMMnWeTM1s35hFo4Z+DQcKt86TCWkxtVxZTw4PVrqa2LVWwlh7
	nrovtGu1o0V7s5fZNte3RGQ2HWHwDTCGqd+SFb2usHgG+5Qu2Gd3UGE9TohhaCKg
	JXdU7qj6TlxaDQn2g5iJBcym5f4dqGbHqJuRlYFIwVEbp02bLcLHn9dO9WoR4tIa
	/LIV6CK1WfjWB9NJlvw6TPzHOUbF1hjtwUGm3SBkWCRcSSrjBiC4tTc6XqbO4z7W
	B36Sm9eYG2FCizSOpPJV/GL2/ildsAiMRAIWdQch0g==
X-ME-Sender: <xms:yezmaPr_LF8cX12FzBlGMQeXsXXuRINbYADjYCb_z8nq0Vjzd0-vhQ>
    <xme:yezmaMN5T-3_S8VI0lhKWdTmAr0mVGsS2zg1hGmb-AvvQ9JrrJvQ021uI3RggxkDm
    m3IJV4woiMzLaks1uXYCJTZmVyJUTeAEAw8PEFge-P2HkgZ60L29FU>
X-ME-Received: <xmr:yezmaP3eHVMk8XiR-e2ecL2MFkeOrjRN2U9A43rX83BDvsekieb28CUMaHjTalsX3Df_CmJyzqbmlFlYZAA0IKCdrIY_3pxceP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinh
    eslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtoh
    epuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehs
    uhhsvgdruggvpdhrtghpthhtohepjhgrvhhivghrmhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhgsuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yezmaDD11z4k02BTrdh8hYr7-7Q1XeRDGpuL1M1HskbQHvI8pdVj7g>
    <xmx:yezmaEK1_PH76SO-1RxUx7QBTXB7Dwni9OhKOscm11Ti3DEN4c7j1w>
    <xmx:yezmaEkv7HkKbwC2AjSkW9R1pAESS2eMEDlXzaZ6uctkPJkDwaFDaw>
    <xmx:yezmaFa0Xsr_0tEaNprULfO0bsTlg_TgMFZuKv_5f-XdpWB1h-rRaA>
    <xmx:yezmaNP7n09jyketXJs9Uwz3kxlKGf4Ugpj42Lr9LH06m8clrkyIkIm7>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 18:59:18 -0400 (EDT)
To: Simona Vetter <simona@ffwll.ch>,
    Helge Deller <deller@gmx.de>,
    Thomas Zimmermann <tzimmermann@suse.de>,
    Javier Martinez Canillas <javierm@redhat.com>
Cc: stable@vger.kernel.org,
    linux-fbdev@vger.kernel.org,
    dri-devel@lists.freedesktop.org,
    linux-kernel@vger.kernel.org
Message-ID: <f91c6079ef9764c7e23abd80ceab39a35f39417f.1759964186.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] fbdev: Fix logic error in "offb" name match
Date: Thu, 09 Oct 2025 09:56:25 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

A regression was reported to me recently whereby /dev/fb0 had disappeared
from a PowerBook G3 Series "Wallstreet". The problem shows up when the
"video=ofonly" parameter is passed to the kernel, which is what the
bootloader does when "no video driver" is selected. The cause of the
problem is the "offb" string comparison, which got mangled when it got
refactored. Fix it.

Cc: stable@vger.kernel.org
Fixes: 93604a5ade3a ("fbdev: Handle video= parameter in video/cmdline.c")
Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/video/fbdev/core/fb_cmdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_cmdline.c b/drivers/video/fbdev/core/fb_cmdline.c
index 4d1634c492ec..594b60424d1c 100644
--- a/drivers/video/fbdev/core/fb_cmdline.c
+++ b/drivers/video/fbdev/core/fb_cmdline.c
@@ -40,7 +40,7 @@ int fb_get_options(const char *name, char **option)
 	bool enabled;
 
 	if (name)
-		is_of = strncmp(name, "offb", 4);
+		is_of = !strncmp(name, "offb", 4);
 
 	enabled = __video_get_options(name, &options, is_of);
 
-- 
2.49.1


