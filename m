Return-Path: <stable+bounces-76156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561529796D1
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF7C281852
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC51C68A6;
	Sun, 15 Sep 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/RAD9pA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E23125DB
	for <stable@vger.kernel.org>; Sun, 15 Sep 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406827; cv=none; b=iUU9YAoc+xfA4OQEAT2FhwqS4P1zHPQBM/6gslATRh9bYaR5gPV3GcZEt3qqtI1GTBXyxEWaCP6GfZG8QWg2U0l8gaq3Narvs5Y0FOChp1cKmHdWCiX5jMFNFH3VBAcILPRtnXvn4aCEB2Hsf2K1BGj7RfWeZg+o6Dh7Zk99W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406827; c=relaxed/simple;
	bh=EqX708RvPiLTH6h0xuT3eljqAFrxjTCjgyYowgRyZYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lFQcPHbFV9OjcLW50UukriTSuZwM/WsnMLGzxS2pLL3Zz/SPja7KbnNjULJaNwyhlfPGNnENI+oaAdtK9aJOYMTKHGr0gQQDxSOQnRZR23P1f0pOtG9qGkqQqYRnyvBqZL+vwn0+obwRHkQy9FUdfyoGqwkjqlFYwXNKKrLxwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/RAD9pA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A9C4CEC3;
	Sun, 15 Sep 2024 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726406826;
	bh=EqX708RvPiLTH6h0xuT3eljqAFrxjTCjgyYowgRyZYA=;
	h=Subject:To:Cc:From:Date:From;
	b=z/RAD9pAUbytYbSi4gem8Hhnt6cQsRxR1BH+tmaFdMxMw3Vlppq64cK5bUIn4/TIH
	 qcHSFRqwCjTcJ38PlzM7JGwLxFyfz3BpkSrMgF6ZTyhGjg1a8wlFI7l5I48sRTqVPO
	 goffjDe13PK5nvHsT+RU3sUui1Kz1WipOVEXLeMw=
Subject: FAILED: patch "[PATCH] ASoC: meson: axg-card: fix 'use-after-free'" failed to apply to 4.19-stable tree
To: avkrasnov@salutedevices.com,broonie@kernel.org,jbrunet@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 15 Sep 2024 15:26:54 +0200
Message-ID: <2024091554-obtain-sibling-75bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4f9a71435953f941969a4f017e2357db62d85a86
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091554-obtain-sibling-75bf@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

4f9a71435953 ("ASoC: meson: axg-card: fix 'use-after-free'")
aa9c3b7273a5 ("ASoC: meson: axg: extract sound card utils")
9c29fd9bdf92 ("ASoC: meson: g12a: extract codec-to-codec utils")
dd28d54c248f ("Merge branch 'asoc-5.3' into asoc-5.4")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f9a71435953f941969a4f017e2357db62d85a86 Mon Sep 17 00:00:00 2001
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date: Wed, 11 Sep 2024 17:24:25 +0300
Subject: [PATCH] ASoC: meson: axg-card: fix 'use-after-free'

Buffer 'card->dai_link' is reallocated in 'meson_card_reallocate_links()',
so move 'pad' pointer initialization after this function when memory is
already reallocated.

Kasan bug report:

==================================================================
BUG: KASAN: slab-use-after-free in axg_card_add_link+0x76c/0x9bc
Read of size 8 at addr ffff000000e8b260 by task modprobe/356

CPU: 0 PID: 356 Comm: modprobe Tainted: G O 6.9.12-sdkernel #1
Call trace:
 dump_backtrace+0x94/0xec
 show_stack+0x18/0x24
 dump_stack_lvl+0x78/0x90
 print_report+0xfc/0x5c0
 kasan_report+0xb8/0xfc
 __asan_load8+0x9c/0xb8
 axg_card_add_link+0x76c/0x9bc [snd_soc_meson_axg_sound_card]
 meson_card_probe+0x344/0x3b8 [snd_soc_meson_card_utils]
 platform_probe+0x8c/0xf4
 really_probe+0x110/0x39c
 __driver_probe_device+0xb8/0x18c
 driver_probe_device+0x108/0x1d8
 __driver_attach+0xd0/0x25c
 bus_for_each_dev+0xe0/0x154
 driver_attach+0x34/0x44
 bus_add_driver+0x134/0x294
 driver_register+0xa8/0x1e8
 __platform_driver_register+0x44/0x54
 axg_card_pdrv_init+0x20/0x1000 [snd_soc_meson_axg_sound_card]
 do_one_initcall+0xdc/0x25c
 do_init_module+0x10c/0x334
 load_module+0x24c4/0x26cc
 init_module_from_file+0xd4/0x128
 __arm64_sys_finit_module+0x1f4/0x41c
 invoke_syscall+0x60/0x188
 el0_svc_common.constprop.0+0x78/0x13c
 do_el0_svc+0x30/0x40
 el0_svc+0x38/0x78
 el0t_64_sync_handler+0x100/0x12c
 el0t_64_sync+0x190/0x194

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Cc: Stable@vger.kernel.org
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://patch.msgid.link/20240911142425.598631-1-avkrasnov@salutedevices.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 8c5605c1e34e..eb0302f20740 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -104,7 +104,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 				     int *index)
 {
 	struct meson_card *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai_link *pad = &card->dai_link[*index];
+	struct snd_soc_dai_link *pad;
 	struct snd_soc_dai_link *lb;
 	struct snd_soc_dai_link_component *dlc;
 	int ret;
@@ -114,6 +114,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 	if (ret)
 		return ret;
 
+	pad = &card->dai_link[*index];
 	lb = &card->dai_link[*index + 1];
 
 	lb->name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-lb", pad->name);


