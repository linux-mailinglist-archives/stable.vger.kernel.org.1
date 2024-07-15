Return-Path: <stable+bounces-59283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED9930F30
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 09:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35EF1C20F68
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 07:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A551849EB;
	Mon, 15 Jul 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DfCm78Lz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D41849E3;
	Mon, 15 Jul 2024 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030134; cv=none; b=IuImyntTIh0C4HJ8BlSju2LWCmgcp7skF194BKNLVMISFXsl7Q9uU7iZyMO7SXPzYhRgw1Dl6IjAyskPhT6cecn0ne8mHboTn3S36IkLTDiws7a2NDrwyQ2mRWUvhgo/vSf+foTpU/Ee1IXDPfiZrzpCfdfbaIkOxZJudiLLHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030134; c=relaxed/simple;
	bh=zDxscHe/knoipIismhFi/wQe3h2kIIE/XWT1KfM+9AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdE7hR29wfe+RA3+uMVjfNq4roGJ+Kce9Na3FqxX96cZtIbEtPGDCI8wkRXA+cHlUUSeWJFJh25GLPfoNzp8290pafmBDMEGjssDYm4Y2t6G5XUrghjCshmj7JJBDgIUciVnkoo9af/V8EsueNcW9KMxbSCMhkb75td4Zo3PQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DfCm78Lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42B9C32782;
	Mon, 15 Jul 2024 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721030134;
	bh=zDxscHe/knoipIismhFi/wQe3h2kIIE/XWT1KfM+9AI=;
	h=From:To:Cc:Subject:Date:From;
	b=DfCm78LzJcCeqQkIlssNV0q8gN5fTX6Pc/jLK5HHlDdm1unLa6Ymg2UqCIX8o+c9X
	 +kjHFEw+cH05cACZOJ1KiAyh7M46dDnKou9PbmA3wZNuOqBgvRFE6ut3GOBSrfSpf9
	 ehmfxyamofSU4dD2MSa0apwMHStWBzJFOHIKCEew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.40
Date: Mon, 15 Jul 2024 09:55:22 +0200
Message-ID: <2024071546-savanna-giggly-15b8@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.40 kernel.

All users of the 6.1 kernel series that use the XHCI USB host controller driver
(i.e. USB 3) must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                     |    2 +-
 drivers/usb/host/xhci-ring.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

Greg Kroah-Hartman (2):
      Revert "usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB"
      Linux 6.6.40


