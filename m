Return-Path: <stable+bounces-78279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B398A77B
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79A3B223E1
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A61917F2;
	Mon, 30 Sep 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPYUGeo5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851D1917C9;
	Mon, 30 Sep 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707411; cv=none; b=C7GELz+OViObsGpu+vG+RFGs8mEu6hfG5A7fd112Ga18LdVg114JgKZv+X8kTy+LCrds9/SdeEllsNiyn5OY2cT9PV6rVI3PPnZxkQqFdTNKl4LmgJKTmTVBvLf8v+6UY70xAougq0ill+xoiKKBqvYkBJZ1G46LdEOyJQSG7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707411; c=relaxed/simple;
	bh=vwCD1SAV0S/QuIQfaqdrHZXSuQOZMXi3SH5sKV9LszY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h99c9BfeZWy73NE0+0vgorPXm/dsII+4wuZUcdJizeczJ9hzKjhbBUaDPtNy+OqYn0qQs9yVPkk6PWIFRHX/83qBANshPiigFYXFBqqXFSz6kYg8qb68IDw2IXxNoD2iqH82DLqwtmxRCFtI+DfYV2eSRARwqxS+bDr8xUfTqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LPYUGeo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB171C4CEC7;
	Mon, 30 Sep 2024 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707411;
	bh=vwCD1SAV0S/QuIQfaqdrHZXSuQOZMXi3SH5sKV9LszY=;
	h=From:To:Cc:Subject:Date:From;
	b=LPYUGeo5DSjAwc6hYghhYZiM9n9hqcaukxuI+hB/nUWbfHBt2PNDcsyhyWZ+tDnlS
	 r9S+huE0u7Aa7W/rWuz+Ia70ecmMUYLD2XyT0uHcwbJQ5FfoAZQOLTdzy0YuAUDRdm
	 8h/Cl3GGRnlcH784d+L97PNFWy7Xz1B1+VPcJGR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.11.1
Date: Mon, 30 Sep 2024 16:42:51 +0200
Message-ID: <2024093050-lemon-grab-faf2@gregkh>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.11.1 kernel.

All users of the 6.11 kernel series must upgrade.

The updated 6.11.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.11.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                              |    2 
 drivers/accel/drm_accel.c             |  110 ++--------------------------------
 drivers/bluetooth/btintel_pcie.c      |    2 
 drivers/cpufreq/amd-pstate.c          |    5 +
 drivers/gpu/drm/drm_drv.c             |   97 ++++++++++++++---------------
 drivers/gpu/drm/drm_file.c            |    2 
 drivers/gpu/drm/drm_internal.h        |    4 -
 drivers/nvme/host/nvme.h              |    5 +
 drivers/nvme/host/pci.c               |   18 ++---
 drivers/powercap/intel_rapl_common.c  |   35 +++++++++-
 drivers/usb/class/usbtmc.c            |    2 
 drivers/usb/serial/pl2303.c           |    1 
 drivers/usb/serial/pl2303.h           |    4 +
 include/drm/drm_accel.h               |   18 -----
 include/drm/drm_file.h                |    5 +
 net/netfilter/nft_socket.c            |    4 -
 sound/soc/amd/acp/acp-legacy-common.c |    5 +
 sound/soc/amd/acp/amd.h               |    2 
 18 files changed, 128 insertions(+), 193 deletions(-)

Dan Carpenter (2):
      netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in nft_socket_cgroup_subtree_level()
      powercap: intel_rapl: Change an error pointer to NULL

Dhananjay Ugwekar (3):
      powercap/intel_rapl: Add support for AMD family 1Ah
      powercap/intel_rapl: Fix the energy-pkg event for AMD CPUs
      cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()

Edward Adam Davis (1):
      USB: usbtmc: prevent kernel-usb-infoleak

Greg Kroah-Hartman (1):
      Linux 6.11.1

Junhao Xie (1):
      USB: serial: pl2303: add device id for Macrosilicon MS3020

Keith Busch (1):
      nvme-pci: qdepth 1 quirk

Kiran K (1):
      Bluetooth: btintel_pcie: Allocate memory for driver private data

Michał Winiarski (3):
      drm: Use XArray instead of IDR for minors
      accel: Use XArray instead of IDR for minors
      drm: Expand max DRM device number to full MINORBITS

Vijendar Mukunda (1):
      ASoC: amd: acp: add ZSC control register programming sequence


