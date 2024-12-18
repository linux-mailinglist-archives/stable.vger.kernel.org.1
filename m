Return-Path: <stable+bounces-105106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA2A9F5D60
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 04:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFBA188D114
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 03:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE8143890;
	Wed, 18 Dec 2024 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iG3Q0RSp"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AAE487A5;
	Wed, 18 Dec 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492247; cv=none; b=Iy/L/hc2wi0Tv6JpfWkAsuPcAX6OSxKsjT5Oa4g2WEnjR6LiQ42r8U0l076bf57aaJoA0j6CWXn/P38nL/8+bQcMkWiGBrdqiTIA3zKbcXN9/Bqya/kid2VY0f8h+rcfCGjEJR6mA55eGASuJCj5lEnEPEJKDXw655vUMbywoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492247; c=relaxed/simple;
	bh=AvRPSSADwBzEm4yBmxLiAi1B4o237htlWPyMHKVkTjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kjf+r+63BEsEiyKDauuYLnDSnncKb2Rkh+YQ5ayJVnrpOesAa8B5lp/OFze9zh6zsKKWEzOPBzprH8Sk/E5d1RuzpiUo+STehxoOV/pArI+o1FYgGdCL6Gt10X/jx2s1asO59y8PBnM4/ZUJSuK/XcATasPz4z5ZMES+bouWhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iG3Q0RSp; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0lwtQ
	cBdlxCHdBdfdBkXyYY4Y1WI4OYcIeX78yKZP5c=; b=iG3Q0RSpwxJh9Mb0+ZImJ
	wFQJ9BUB1PN8mgWC2Pqsr7///+O9Y6Izo7hWoMh1cM3ZGGD71rG+AXb8uu+WuWyp
	UlGmgxIz5Bcx/6BM3BErNgusevgTap6sn7cYG+tvv3/+n+zVhvnWnSJIM+9k2222
	zuwcaJIk6MI6dTGAumT6Cc=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHEp0CQGJnA60VGA--.48780S4;
	Wed, 18 Dec 2024 11:23:00 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: stern@rowland.harvard.edu
Cc: christophe.jaillet@wanadoo.fr,
	gregkh@linuxfoundation.org,
	javier.carrasco@wolfvision.net,
	kay.sievers@vrfy.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	make_ruc2021@163.com,
	mka@chromium.org,
	oneukum@suse.com,
	quic_ugoswami@quicinc.com,
	stable@vger.kernel.org,
	stanley_chang@realtek.com
Subject: Re: Re: [PATCH v2] usb: fix reference leak in usb_new_device()
Date: Wed, 18 Dec 2024 11:22:42 +0800
Message-Id: <20241218032242.2969330-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2aae349c-dd80-44da-9715-a214f6946b75@rowland.harvard.edu>
References: <2aae349c-dd80-44da-9715-a214f6946b75@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHEp0CQGJnA60VGA--.48780S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr4fJrWxArWxCrWxtFy7Wrg_yoW8XF4kpw
	4Utas5KrWqgr1kKw1DZFy0vryUCw42y34fAr1rC34Y93Zxu34SqFZ5trZ8W34rZrZ3Ca1U
	tr47Ga95Xr1UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUItC7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFR25C2diNgT7+AAAsO

Alan Stern<stern@rowland.harvard.edu> wrote:
> Ma Ke <make_ruc2021@163.com> writes:
> > When device_add(&udev->dev) failed, calling put_device() to explicitly
> > release udev->dev. And the routine which calls usb_new_device() does
> > not call put_device() when an error occurs.
> 
> That is wrong.
> 
> usb_new_device() is called by hub_port_connect().  The code does:
> 
> 			status = usb_new_device(udev);
> 			...
> 
> 		if (status)
> 			goto loop_disable;
> 		...
> 
> loop_disable:
> 		hub_port_disable(hub, port1, 1);
> loop:
> 		usb_ep0_reinit(udev);
> 		release_devnum(udev);
> 		hub_free_dev(udev);
> 		if (retry_locked) {
> 			mutex_unlock(hcd->address0_mutex);
> 			usb_unlock_port(port_dev);
> 		}
> 		usb_put_dev(udev);
> 
> And usb_put_dev() is defined in usb.c as:
> 
> void usb_put_dev(struct usb_device *dev)
> {
> 	if (dev)
> 		put_device(&dev->dev);
> }
> 
> So you see, if usb_new_device() returns a nonzero value then 
> put_device() _is_ called.
> 
> >  As comment of device_add()
> > says, 'if device_add() succeeds, you should call device_del() when you
> > want to get rid of it. If device_add() has not succeeded, use only
> > put_device() to drop the reference count'.
> 
> You are correct that if device_add() succeeds and a later call fails, 
> then usb_new_device() does not properly call device_del().  Please 
> rewrite your patch to fix only that problem.
> 
> Alan Stern
Thank you for guiding me on the vulnerability I submitted. I will 
resubmit the patch based on your guidance and suggestions.
--
Regards,

Ma Ke


