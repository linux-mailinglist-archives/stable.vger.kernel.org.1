Return-Path: <stable+bounces-106223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BE9FD7F2
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 23:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DE33A2510
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0711F8671;
	Fri, 27 Dec 2024 22:12:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7644140E5F;
	Fri, 27 Dec 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735337574; cv=none; b=r0PC565Uy0stwgQyaXbMBKb+m3qxniQ8+t4gJPYlqdvzVScukunvabIlQbEkaMb2s38IhQW/S/cbXwPZJLylJCeWWik/90CvWj4AeVEi90dPrOuepv2Gx3FUeDx/Cooulw0t0CO6GUCkoIa4Gb9p7FMd3Re12KT8WCG+5wylvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735337574; c=relaxed/simple;
	bh=tQYo7yFQHNTUCg4xYgaBSCoZpTcp0McFxVMUVfN0Ysc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzEk7S2XV+fnThxEjTmOYkEUGjnofpn31UdbmLmyi5obdnVAnI5fp134wX7IHnYBBj1fwuSqlcEoNFIc21eKZMIHrXtyrNRZm2ok0vrxf1l5eQseZy6r8MgqGwnQHTne1o5OVbdMFrlnkh8HY4VbaRlAFeCZkRxsI8hJ4E/kGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-189-61.static.sonic.net (192-184-189-61.static.sonic.net [192.184.189.61])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 4BRLxPHM028219;
	Fri, 27 Dec 2024 13:59:26 -0800
From: Forest <forestix@nom.one>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: [REGRESSION] usb: xhci port capability storage change broke fastboot android bootloader utility
Date: Fri, 27 Dec 2024 13:59:25 -0800
Message-ID: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVabdT5M3Uxujc7aSwDmt/6gtZZakyrLJYpvb4QM5G4wOXkXz6ZrkafRHKgKpLdKZ+d8LGr1bHHlSKbvQaxXNLth
X-Sonic-ID: C;Hrx41p3E7xGkb6xkvwPenQ== M;jAqK1p3E7xGkb6xkvwPenQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd

#regzbot introduced: 63a1f8454962

Dear maintainer,

I think I have found a regression in kernels version 6.10 and newer,
including the latest mainline v6.13-rc4:

fastboot (the tool for communicating with Android bootloaders) now fails to
perform various operations over USB.

The problem manifests as an error when attempting to 'fastboot flash' an
image (e.g. a new kernel containing security updates) to a LineageOS phone.
It also manifests with simpler operations like reading a variable from the
bootloader. For example:

  fastboot getvar kernel

A typical error message when the failure occurs:

  getvar:kernel  FAILED (remote: 'GetVar Variable Not found')

I can reproduce this at will. It happens about 50% of the time when I
run the above getvar command, and almost all the time when I try to push
a new kernel to a device.

A git bisect reveals this:

63a1f8454962a64746a59441687dc2401290326c is the first bad commit
commit 63a1f8454962a64746a59441687dc2401290326c
Author: Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Mon Apr 29 17:02:28 2024 +0300
    xhci: stored cached port capability values in one place

