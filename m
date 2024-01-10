Return-Path: <stable+bounces-10439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D51829CBF
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 15:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EA31F25181
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1854B5C4;
	Wed, 10 Jan 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NoiKM3Zb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5F4A9AA;
	Wed, 10 Jan 2024 14:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5016C433C7;
	Wed, 10 Jan 2024 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704897859;
	bh=b/qznBEWl18xjvLjQWT/Cx+FEOKZe7qRKcTr4398xrM=;
	h=From:To:Cc:Subject:Date:From;
	b=NoiKM3Zbvh/ZqCyDWb3vCjtI9o7geA+cfnmdUiPEwwhR47F58WjGfjiYe5hJcQT29
	 5/DukVQrZatyTThQfFGhN67kizKAWZuMsFIq9XUAa5enWXfIfY0k2jdG8E8MWk5Pki
	 U3zin+Ffg1YaPh0ww1j1zhdUbfICE8Zj2N/+b7jg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.336
Date: Wed, 10 Jan 2024 15:44:09 +0100
Message-ID: <2024011046-ecology-tiptoeing-ce50@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.14.336 kernel.  This is the LAST 4.14.y
kernel to be released.  It is now officially end-of-life.  Do NOT use this
kernel version anymore, please move to a newer one, as shown on the kernel.org
releases page.

All users of the 4.14 kernel series must upgrade.  But then, move to a newer
release.  If you are stuck at this version due to a vendor requiring it, go get
support from that vendor for this obsolete kernel tree, as that is what you are
paying them for :)

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                       |    2 
 drivers/firewire/ohci.c                        |   51 +++++++++++++++++++++++++
 drivers/mmc/core/block.c                       |    7 +--
 drivers/mmc/core/host.c                        |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    4 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    |    8 +++
 net/nfc/llcp_core.c                            |   39 +++++++++++++++++--
 net/sched/em_text.c                            |    4 +
 8 files changed, 106 insertions(+), 10 deletions(-)

Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Greg Kroah-Hartman (1):
      Linux 4.14.336

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Siddh Raman Pant (1):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards


