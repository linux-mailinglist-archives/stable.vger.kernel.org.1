Return-Path: <stable+bounces-106281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D09FE57D
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6E3A18D8
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC51A7249;
	Mon, 30 Dec 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxszRUFY"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE981A7262
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735555923; cv=none; b=iqQGNakWlE06rFhVQ3lKJsm9uEYH5Gt1K+WWU/vbdv6CXZIJnjS3Ofpg1g2cc4XuvW1VhqA++H7qCN7f42NDzwEMfP7yW5gOVUg6U+p3ENaKTdiDBRWLrm5fjdLD7iZsV7BgM4UAUxTC8RnXKc905jxmihHCKPFfnWmU5wb3QBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735555923; c=relaxed/simple;
	bh=O6GQyPe/a1hDIM7ZcDXIhtsry0hbTS2yv+qiNujTvnw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sQtT2REO4unJK0JAYiRlrNb0z2+jnLII0GpBeTsjvYP1S+1L4W5N8SGn2Md2neUkUEsJi4TUTSU4GwQnMBRSzh19Fl9OQEQVVjY3ZaMeH96J3nfkAU4m242Y66r9D0dAAmFa+QB91Uh46lDvJbt9kLaAT6yg9yCwJj1cfN+ilJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxszRUFY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso9420409e87.2
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735555920; x=1736160720; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3+RJRivGMZfM8jB3C8pcPW0/7/xzowBnKz9QGfAazI=;
        b=mxszRUFY+XqsGWNuGpZJuHgHEN00vPxCsGTYEhLboFBldQ3+xhIbCxj+WU0FRAlBbs
         a9lp0vqXQCej8H/OGjw9osb9r2PgpiK4DvhXawEAoIrEniwkf1FGIXX5Bh1P4+yI8xmq
         kVcU1rcxZ6+iML5ZfBf/BXDhFDHXd7MBFTtDgxPP6qrMQhA7o6t72kJuir34rHV0NwAR
         3mfxb7cOj8xlEKiqwf/Q1XwqzCvzRzJsiCi5cUdFHc0MpCXLAMv1oZhvoMs/y9mBcCLR
         PNziTOmULuY9nomGWW6OyGmwsQQgRXxnaeVXMhi3KeVjFmR4IXoJbO20y+Ug0EV8uK3S
         UNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735555920; x=1736160720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3+RJRivGMZfM8jB3C8pcPW0/7/xzowBnKz9QGfAazI=;
        b=Zsj+ZYFjbAqlARMkjkKh/hiOD2DbrwBT31oReEfZ66+Nc2+wQsQClY1Rx2ke+Q5rhu
         pG8oVVqxsqQ7JZWHeWXmTkzxIqpz0YtZNmP+jlTGlb3A0+eGYGaBZH1Zvoedwd+pZfJm
         odfPMBR0qNGAQWzzSdN9fUG5nQ9Ifn4cSuHgTMk3fqp917bqn6WVSdZPO5uSLHcaEEoa
         lrCfZq2RLLigoE5OcJH/3QSbb0XvS0mJ85qVNiept3Ezss/rG3jzC01LyhqKpao3pnb5
         qJHql269TqID3R0NVB96KnNVJqkjHodde4LkWD/JB1Roe9viBUE+xB3cpfOz8L00Na5y
         U5HA==
X-Forwarded-Encrypted: i=1; AJvYcCWyT0J351JFscigIJkl4o7daVX+6MaHrBHf6Yby1OO/50L2tT42fuWqCsamag+FLl0oFAmNppk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqvTsH7/QxFsAZQmmaIEgsSkxYB6sNIlDBW7bXwNwK7dUiz6i
	LaIzKhTeNxbd50MAUiutnCtJq6SCC/u1mhbRp2YkPw3YG4qh0vxd
X-Gm-Gg: ASbGncuYWK/N9pUgR+IQf3/5qOOjSDEtQ5Zbf4Ok/TuW1EiMIJRssw6qANvR7Z1T1dt
	CJGPrVy8n8lr8u8BvHxm/lVLsdYuUBvtCR6/jm1+B4x3m4570Nhvc2yQWAFItzu+tbxDorsoPck
	gPqol+k9LOlzFQuhWkPV7aviv2XjeJTKXHmds+2gtG5Ce5wnlE2JPf6dmbdHF8qnu6D1RI4j64z
	IsG6CCxiFbwtbIdxfdRsPMVO924veFOZyBJmftNP4g8QALydqLmAf20QQSQygdqJPjjMVFrmaMi
	lJUHA7/c8V97D92JgAir
X-Google-Smtp-Source: AGHT+IF2V/AQHJ4sC1r4bukuTr+sQoV3QZYo/fZSo+S9RxR5O0N/R86h9CtUv9IEL3uDWMWDcoUuTw==
X-Received: by 2002:a05:6512:6d3:b0:542:28b4:23ad with SMTP id 2adb3069b0e04-54229530096mr12288185e87.16.1735555919380;
        Mon, 30 Dec 2024 02:51:59 -0800 (PST)
Received: from localhost (broadband-5-228-116-177.ip.moscow.rt.ru. [5.228.116.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f6019sm3028523e87.5.2024.12.30.02.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 02:51:59 -0800 (PST)
Date: Mon, 30 Dec 2024 13:51:58 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org
Cc: Chris Lu <chris.lu@mediatek.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-mediatek@lists.infradead.org
Subject: Request to backport fixes for crash in hci_unregister_dev() to 6.12.y
Message-ID: <ky2pwjrcwd42h24rkvlanyj3ty53orpyirm34hpo74lehhpg3n@3mnfibfr6yxm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 6.12 there is a kernel crash during the release of btusb Mediatek
device.

list_del corruption, ffff8aae1f024000->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:56!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 UID: 0 PID: 3770 Comm: qemu-system-x86 Tainted: G        W          6.12.5-200.fc41.x86_64 #1
Tainted: [W]=WARN
Hardware name: ASUS System Product Name/PRIME X670E-PRO WIFI, BIOS 3035 09/05/2024
RIP: 0010:__list_del_entry_valid_or_report.cold+0x5c/0x6f
Call Trace:
<TASK>
hci_unregister_dev+0x46/0x1f0 [bluetooth]
btusb_disconnect+0x67/0x170 [btusb]
usb_unbind_interface+0x95/0x2d0
device_release_driver_internal+0x19c/0x200
proc_ioctl+0x1be/0x230
usbdev_ioctl+0x6bd/0x1430
__x64_sys_ioctl+0x91/0xd0
do_syscall_64+0x82/0x160
entry_SYSCALL_64_after_hwframe+0x76/0x7e

Note: Taint is due to the amdgpu warnings, totally unrelated to the
issue.

The bug has been fixed "silently" in upstream with the following series
of 4 commits [1]:

ad0c6f603bb0 ("Bluetooth: btusb: mediatek: move Bluetooth power off command position")
cea1805f165c ("Bluetooth: btusb: mediatek: add callback function in btusb_disconnect")
489304e67087 ("Bluetooth: btusb: mediatek: add intf release flow when usb disconnect")
defc33b5541e ("Bluetooth: btusb: mediatek: change the conditions for ISO interface")

These commits can be cleanly cherry-picked to 6.12.y and I may confirm
they fix the problem.

FWIW, the offending commit is ceac1cb0259d ("Bluetooth: btusb: mediatek:
add ISO data transmission functions") and it is present in 6.11.y and
6.12.y.

6.11.y is EOL, so please apply the patches to 6.12.y.

[1]: https://lore.kernel.org/linux-bluetooth/20240923084705.14123-1-chris.lu@mediatek.com/

--
Thanks,
Fedor

