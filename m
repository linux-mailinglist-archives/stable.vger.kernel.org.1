Return-Path: <stable+bounces-45393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4454A8C860C
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 14:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F281C285CD3
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93E53370;
	Fri, 17 May 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQcm0CWq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25ED52F8C;
	Fri, 17 May 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947147; cv=none; b=EryS0zx2cx6+SOTzKTYRSTRgIpx+zN/k2CV1LiRPWyPpWctrnZGRwpyEcStptjO2wiIJz7PqvUhPM4Wk6hLSQW7UdxbrLq8FswrQ6OtE+0rrptzFh3+6SNeIo/CIXEJek7exApn0KML2Kf/31mWnn/DjEMekrUQ7+jTDP8Gp3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947147; c=relaxed/simple;
	bh=WTMIO1sZTaI9e4Ow1fRZJ6VLgD3v/PaYq1VPhvKbfH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JI8w6FqEo0I4UxCDw5ZiKRz69VrVu7lLwoxbuFpI55TdyHDc7Et2MFy0DURK8OW00+C2TfJ/jkoYwMV1U3vTmvTJond3KhNhYYoZqtJoZXcu2q9hMTWvNRRTMu6fJOfYVhUEh4jJUfZaLSdALbxBYbfM1jAJyUYvtkDJML8iaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yQcm0CWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FB9C2BD10;
	Fri, 17 May 2024 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715947147;
	bh=WTMIO1sZTaI9e4Ow1fRZJ6VLgD3v/PaYq1VPhvKbfH4=;
	h=From:To:Cc:Subject:Date:From;
	b=yQcm0CWqou2H32q2mqnFAfBvjw9aBAfmGehEdQALLO2y44ga7Hr7k8r2IU42i4n5c
	 Ga6qMK3sAi826Wtomfo0Hbr6YeJXlhoEfBVSdM0j8tSJ6KIZXoityNzCOrI9LkHBBh
	 b/6sSWbvEiZzKGzrjUBOdRwcjd+HzVPoEbwVwFLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.9.1
Date: Fri, 17 May 2024 13:58:57 +0200
Message-ID: <2024051758-parchment-unadorned-15ed@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.9.1 kernel.

All users of the 6.9 kernel series must upgrade.

The updated 6.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                         |    2 
 drivers/dma/idxd/cdev.c                          |   77 +++++++++++++++++++++++
 drivers/dma/idxd/idxd.h                          |    3 
 drivers/dma/idxd/init.c                          |    4 +
 drivers/dma/idxd/registers.h                     |    3 
 drivers/dma/idxd/sysfs.c                         |   27 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c |    4 +
 drivers/vfio/pci/vfio_pci.c                      |    2 
 include/linux/pci_ids.h                          |    2 
 security/keys/key.c                              |    3 
 10 files changed, 120 insertions(+), 7 deletions(-)

Arjan van de Ven (2):
      VFIO: Add the SPR_DSA and SPR_IAX devices to the denylist
      dmaengine: idxd: add a new security check to deal with a hardware erratum

Ben Greear (1):
      wifi: mt76: mt7915: add missing chanctx ops

Greg Kroah-Hartman (1):
      Linux 6.9.1

Nikhil Rao (1):
      dmaengine: idxd: add a write() method for applications to submit work

Silvio Gissi (1):
      keys: Fix overwrite of key expiration on instantiation


