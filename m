Return-Path: <stable+bounces-94612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527A89D6055
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1E71F232FB
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A37E0E8;
	Fri, 22 Nov 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TX1ZsGJT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1237580C;
	Fri, 22 Nov 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286054; cv=none; b=ahp0EaD5h4TSiiXxqqLX8DfAE011ER54xoA5tcavS1gAm739ol29hEhbB9nv86sAtCR3XNg6NEuB/DT9ZTMe06u+4fFPyTvPWIH96RjtuL1xlKlO2hzNQjpABxdFwh1fvqmNhzQ5J9royyoWA8X5sh+bJ8VK6Md+l/Yovl84Q/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286054; c=relaxed/simple;
	bh=sKt2lY9FZaDQIPP+tg6QnKOT6bguFN3JVTFOTuBaCC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9sa+uECTpOIuGBw20wzQXfudCZ2hCwqGZufen1DjmJvPKPSRg/RbqVclhU4N9T1+3InyjAOEViF/+aiuj9XYkf/HYw8aYdonSF+c55sQbAlUVHczDkc4UkHljfhWF+x39R6neKGGRJzlqDJ6wGxMQCb2ay8XNW84MzdgMks6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TX1ZsGJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDFFC4CECF;
	Fri, 22 Nov 2024 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732286053;
	bh=sKt2lY9FZaDQIPP+tg6QnKOT6bguFN3JVTFOTuBaCC0=;
	h=From:To:Cc:Subject:Date:From;
	b=TX1ZsGJTppX5FBGTj35Eq6m6C/o3UHlcwXE5dfsyGtvWWixoGNWzVqZYkhybN1B9j
	 Ml2uUFHbjWgXfoSUh1IniRgUJu2KHJszbyvbf6S41pqhAhMBoTYuWeB3dBPRdGktMe
	 hUItWAjkkaDvTxldrsJA7HbmfNb1W2S0OORHWHes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.1
Date: Fri, 22 Nov 2024 15:33:45 +0100
Message-ID: <2024112234-circle-number-6388@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.1 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                           |    2 +-
 drivers/media/usb/uvc/uvc_driver.c |    2 +-
 mm/mmap.c                          |   13 ++++++++++++-
 net/vmw_vsock/hyperv_transport.c   |    1 +
 4 files changed, 15 insertions(+), 3 deletions(-)

Benoit Sevens (1):
      media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_parse_format

Greg Kroah-Hartman (1):
      Linux 6.12.1

Hyunwoo Kim (1):
      hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointer

Liam R. Howlett (1):
      mm/mmap: fix __mmap_region() error handling in rare merge failure case


