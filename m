Return-Path: <stable+bounces-59280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F55A930F2A
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 09:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC151F21488
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B781836C6;
	Mon, 15 Jul 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIZqLDjZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DC28F0;
	Mon, 15 Jul 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030119; cv=none; b=CEJTVqfGwZAV98w85HjeWMOV8IQx4RfxeLg6+V82yB/TY2Wl9yo08ET1oJAYEYKW028zfbBKkOSB6gpfCMyEqXODzJHjE+mqsJmcmbASru2MqHkMR33WRSzW8g0gvdhGg89txUmCk/xdCqIZxCg3wd3YQAom8jPg557ZlyFd3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030119; c=relaxed/simple;
	bh=Drhdx8lVs5GRDnZYrH3NRUSzXuEva1h4nmqeme2PsKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9ZW15HAiGxPZcHZWLazKZEVrzEKsoQAWVAHdTmuA3C64YXbzUwPPeam9LP2hCZpwoiEJ1WPZKDcuuDkvVxignmrNou7BWT6BsPlaFVXHgbChS1qiW3VrPSxS9geSl2yuKrmiXh0btDjgU954hN+S3N7+z3S6XlpPuE5eAF9Afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIZqLDjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E27BC32782;
	Mon, 15 Jul 2024 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721030118;
	bh=Drhdx8lVs5GRDnZYrH3NRUSzXuEva1h4nmqeme2PsKU=;
	h=From:To:Cc:Subject:Date:From;
	b=oIZqLDjZlvHMOFNpe98vAAl+D6o+pfaYWi4cYumnP/YkDzA+ZmBmaGDQ3nesmP89l
	 t/MrBCZ1f2gCxUSAx5SXpHtq31u0BFjLsylxI6NhX3jv1kLxT69kom1ksRRKm4fW4K
	 qrSgq4N7TkVAxUoN2lGB1B7UDj4cgKZTNCDqNwcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.99
Date: Mon, 15 Jul 2024 09:55:13 +0200
Message-ID: <2024071546-mortify-sphere-6c7a@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.99 kernel.

All users of the 6.1 kernel series that use the XHCI USB host controller driver
(i.e. USB 3) must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
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
      Linux 6.1.99


