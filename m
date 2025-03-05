Return-Path: <stable+bounces-121116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BDEA50E4B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 23:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B98A1886A87
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 22:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68022661AF;
	Wed,  5 Mar 2025 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivK2Z0AY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EF1C84B9;
	Wed,  5 Mar 2025 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212142; cv=none; b=NmHmcC+bKPS8jrTV8pSMLQ/VfjzmPUsR+2BuyitwPFjEJhEVhfJW4eAutxDAa+5Z5gq0Us9pnrE3gkCxk3BTD+KmtRqH78mSjlUHqgO455osPsgO3C8j1LJdBCeOIjHBIqK2TVi+31m7XscVdgX9rOwaBaZJJtJXMo0BF2hL54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212142; c=relaxed/simple;
	bh=DPv+Ob6rW5/y0ptYNACzq7SuNUkYWcFNJctdua23Tug=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:References:Subject:
	 In-Reply-To:Content-Type; b=BbzMTaZJ1ppofeH2fEI8y6ynvTiCSQMieKbJRLV2/EwpEdLRpD1uuo+uL8TT/NV1Ca9YywEmaf4RZ1l/fuiD2LOi5McmxFxt3B/DuSIz4d8ndPaLkR8bzRA68eRAj4BmBvLBTKaMGKtKyuGnBMK6rXuLCtG3LdPSWtQtpcWPwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivK2Z0AY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so92275a12.0;
        Wed, 05 Mar 2025 14:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741212139; x=1741816939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Y9Iis2Hifb4TLyYQkPbjOpHcznh9p/seonioxnf3p8=;
        b=ivK2Z0AYd0mrakdXoxIAcPUQ8h2el9fnPlAoL3WvX9tC94fyfXb5KBgI85+XGjSmhu
         VKVdwi8OnSY5XWB6JNlk2X/NGdlZK6jvKyBldceaDyMJTh/+emiMEZYuobEDYJEcbTiV
         qQ7FMa1vN9Y86kNOYm8fr7S6z13B4dX+j4jJEraK2KGghR3qAc+mmMxZ8hdxZwqEBB4E
         FSaLVeieW1/4WrGWJ6JbCoNXM9WDEqHjH8SRhX3FO3KtCJNMisiZNfgsqU3PN5/k73EL
         k/lqftaqjaDNhvcsRKZUBMZIW9eo8kGzEi1SHHwvRdSIAWFDDLK4EVZHlsxR/eWlWGTr
         jPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741212139; x=1741816939;
        h=content-transfer-encoding:in-reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y9Iis2Hifb4TLyYQkPbjOpHcznh9p/seonioxnf3p8=;
        b=sW+tVUohgmkfUwfUT+fY2YCkatPMaYEo7N5IFh18LTCRQ/ZxADOW7nhKb6g/HG9+PQ
         K+HV/VPtu6xB+ia/Dc5l2dICuYdeAjLflU/K1P7h8viMC+SrVNp7ivQ9NIQvKfyYZFT4
         PaD5pEv1CbPzV8FIrtMpTSWlFikDf6LLQzhZhcc5t19pfbi4JBcxSZPanP6JmRLti4lC
         rx7/uH6lwV2z2oR2kMxCiqruLnyht2JrpckzG5dMEQH777RqasNp+VNDxzSMtFCIHG7i
         Cl41YAyCWT7MgPfeniYnCwTPR0HaQMQqDoXaPXSVxpN6FlpbbuWb2lFTDkxg3fbJwWdy
         E99g==
X-Forwarded-Encrypted: i=1; AJvYcCU27yyIHlbj+FvKJi0fRThYhUCEEI4x20cZvHeHJMdssZi+wsfHBaK0eNnfyXtylbKtaoJbkG+5@vger.kernel.org, AJvYcCU5Ua9Uni4oqjtn4OPKobK2c4dKTLxTNU75D74BNYE+bi7Eb+1J2bGRheR1FkWuzL6NndMg58qY4m6KH80=@vger.kernel.org, AJvYcCX6FDOXimQATNzHfLApwWUMJfoGfy+kGUHO6ma7XYJe45QkAMbKM+D8RmYJYrnRb42j4nReL8lhJfMM@vger.kernel.org
X-Gm-Message-State: AOJu0YytahAC7Ga4boebtNH2r+5eeUNgENk+YXMKQLKfN/uQ9vlAOUVT
	duHmLyBfJItH6b5y4M8McW66AiS/vS+C58xt18XMHJprY4pyveY0
X-Gm-Gg: ASbGncvr+pRDCHQM19q2AmwjJS29dUzIm6SS5oAI0GsYoPdkLp77BQGxVUfw2GfK5E0
	uigehCxKVsoFPQK/bAkFL2VeSEeuROs5xE0qRxTB5OdbV1vnfpXPrjB7Tu/rEgiJeu1EFoRBJc4
	XoLNX+9hgJ8DAokzTm2/wRBMGDkrS9JkWtsjt/8YZXwJkkkQiuVQIPuXhj6xm/jjpCa7VVDuR4i
	ndyh+c/nlBVarjUlVs1OArMiU5tr6glGYIuLWrdVc1C9kuVJ5o2nCuO2s3CJQapjCzW6YrQNxg5
	TyfkfTvw4s2IqgTP4nkerQZ0Mrg1Td0739Lh5RQY6D+8j/8HLQvIUhcW3DzDY5RgYV0ZFETt71N
	U/w==
X-Google-Smtp-Source: AGHT+IF6L4s29kwZnkkouItJ5sNLY9Pd2U7jawux+fC/NcLBvWom9ith1hIO1J5uAOF7LxuXsarzLg==
X-Received: by 2002:a05:6402:274c:b0:5e0:8a27:cd36 with SMTP id 4fb4d7f45d1cf-5e5c1b35612mr1084079a12.8.1741212138144;
        Wed, 05 Mar 2025 14:02:18 -0800 (PST)
Received: from [192.168.0.66] (host-89-241-217-23.as13285.net. [89.241.217.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb526fsm10023783a12.51.2025.03.05.14.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 14:02:17 -0800 (PST)
From: incansvl <colin.evans.parkstone@gmail.com>
X-Google-Original-From: incansvl <incansvl@gmail.com>
Message-ID: <857c8982-f09f-4788-b547-1face254946d@gmail.com>
Date: Wed, 5 Mar 2025 22:02:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: eichest@gmail.com
Cc: francesco.dolcini@toradex.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org, stefan.eichenberger@toradex.com,
 stern@rowland.harvard.edu
References: <Z6HxHXrmeEuTzE-c@eichest-laptop>
Subject: Re: [PATCH v1] usb: core: fix pipe creation for get_bMaxPacketSize0
Content-Language: en-US
In-Reply-To: <Z6HxHXrmeEuTzE-c@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Team,

     I am experiencing a problem on multiple versions of the 6.x kernel, where initialisation
of a motherboard usb hub device fails and causes a stream of errors. The performance of the
machine is badly affected.

I would have considered this most likely a hardware fault except-

1) I am seeing the same issue on 2 machines of very different age and spec.
2) In each case the hub generating errors has no external devices connected to it, so
    the error can't be caused by an external device that has failed. In fact on
    "machine 2", having no devices plugged in seems to be a necessary condition for the
    error to occur (see details below).

I found the discussion of this patch, but I am not clear about this description-

> > When usb_control_msg is used in the get_bMaxPacketSize0 function, the > > USB pipe does not include the endpoint device number. This can 
cause > > failures when a usb hub port is reinitialized after 
encountering a bad > > cable connection. As a result, the system logs 
the following error > > messages: > > usb usb2-port1: cannot reset (err 
= -32) > > usb usb2-port1: Cannot enable. Maybe the USB cable is bad? > 
 > usb usb2-port1: attempt power cycle > > usb 2-1: new high-speed USB 
device number 5 using ci_hdrc > > usb 2-1: device descriptor read/8, 
error -71 If this is saying that ALL of these error messages will be issued for each "bad" port,
that is not what i'm seeing, and I might have a new issue to report.

However if the description above means that ANY ONE OF these errors might be issued, and
that single error will be consistent and repeatable for a specific kernel+hardware combo,
then that is consistent with the problem I am seeing.

I have included more information below to help determine if this IS the same issue or not.
If it is not the same issue, and not yours to look into, I would appreciate your steer on
which maintainer + mailing list to forward it to.

Regards: Incans


------------------------ Additional Info ------------------------

Symptoms
--------

1) From boot, the console then dmesg show repeated messages of the form:

        |usb usb2-port3: Cannot enable. Maybe the USB cable is bad?|

|2) Performance is badly affected. Boot and login times can be 10x or 
more slower than a comparable (in fact slower) machine running a 5.x 
kernel. Desktop Environment (KDE Plasma) performance and stability are 
both impacted. E.g. in KDE panel widgets can stop updating requiring a 
plasmashell (Wayland) restart 3) A "canary" command to show the error is 
lsusb. This will show symptoms like- * lsusb run as root (sudo) can be 
30-100x slower than when run as normal user * A variant such as "lsusb 
-t" might sidestep the performance problem and run in a 'sane' amount of 
time |

4) On both machines the errors relate to a USB root hub that has NO DEVICES connected to it.
    On "machine 2", having a powered USB3.0 hub (which has a number of downstream devices
    connected) plugged in to one port on the hub is enough to suppress the errors, although
    I note the that "bad" port number (hub 2 : port 3) is not enumerated (skipped?).


Software Versions
-----------------
I have seen the same errors in:

OS: KDE neon 6.3 (Wayland)                       Kernel: 6.11.0-17-generic (64-bit)
OS: EndeavourOS (2025-03-05)(KDE 6.3.2 Wayland)  Kernel: 6.13.5-arch1-1 (64-bit)
OS: EndeavourOS (2025-03-05)(KDE 6.3.2 Wayland)  Kernel: linux-lts 6.12.17-1


Hardware
--------

*Machine 1*
Processors: Intel® i7-6700K 4 Core 8 Thread @ 4.60GHz
Memory: 32 GiB RAM
GPU: AMD Radeon RX 6700 XT
Motherboard: Gigabyte Z170X-GamingG1
Primary Disk: Orico 4TB NVME (Gen4 but limited to Gen 2 by motherboard)

*Machine 2*
Processors: AMD Ryzen 7 7700 8 Core 16 Thread @ 5.3GHz
Memory: 32 GiB RAM
GPU: AMD Radeon RX 6700 XT
Motherboard: ASRock B650 LiveMixer
Primary Disk: Orico 4TB NVME (Gen4, motherboard supports up to Gen 5)


Example (Taken from Machine 1 while the problem is active)
----------------------------------------------------------

$ sudo -s
[root@EdeavourOS admin]# time lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 045b:0209 Hitachi, Ltd
Bus 001 Device 003: ID 045b:0209 Hitachi, Ltd
Bus 001 Device 004: ID 045e:07f8 Microsoft Corp. Wired Keyboard 600
(model 1576)
Bus 001 Device 005: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4
Bluetooth 4.0
Bus 001 Device 006: ID 045e:00cb Microsoft Corp. Basic Optical Mouse v2.0
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 002: ID 045b:0210 Hitachi, Ltd
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub

real    0m22.861s
user    0m0.031s
sys     0m0.013s


[root@EdeavourOS admin]# time lsusb -t
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/16p, 480M
     |__ Port 003: Dev 002, If 0, Class=Hub, Driver=hub/4p, 480M
         |__ Port 001: Dev 004, If 0, Class=Human Interface Device,
Driver=usbhid, 1.5M
         |__ Port 001: Dev 004, If 1, Class=Human Interface Device,
Driver=usbhid, 1.5M
         |__ Port 002: Dev 006, If 0, Class=Human Interface Device,
Driver=usbhid, 1.5M
     |__ Port 004: Dev 003, If 0, Class=Hub, Driver=hub/4p, 480M
     |__ Port 013: Dev 005, If 0, Class=Wireless, Driver=btusb, 12M
     |__ Port 013: Dev 005, If 1, Class=Wireless, Driver=btusb, 12M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/10p, 5000M
     |__ Port 004: Dev 002, If 0, Class=Hub, Driver=hub/4p, 5000M
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/2p, 480M
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/2p, 10000M

real    0m0.024s
user    0m0.013s
sys     0m0.011s


(tail of "dmesg -w")
[  781.020436] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  784.990637] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  788.960543] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  792.933684] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  796.906907] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  800.883545] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  804.863692] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  808.840075] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  812.810130] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  816.790281] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  820.783424] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  824.760157] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?
[  828.730143] usb usb2-port3: Cannot enable. Maybe the USB cable is bad?



