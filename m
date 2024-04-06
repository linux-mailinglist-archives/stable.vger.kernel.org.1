Return-Path: <stable+bounces-36171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272FE89AB87
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23392821DF
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040838F86;
	Sat,  6 Apr 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGrs+Adn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290D36AF2;
	Sat,  6 Apr 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416241; cv=none; b=j2fMLNUOg6HBjjUJjck3H9RfLSymDIBtLM7vogOswKN15EWvzvbM4mceTdjuo/1On86KKooqadw2uXiQxOK9pPbXkglZO2w+svxvwBPtxwflagzEEmNlBp/SkO4yqiRLeewH9ljRMN9rU9V3mb/hc9M4gYuq+U2id+okUKA/yZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416241; c=relaxed/simple;
	bh=8nEK/fgmvF2Xsifv3y4ZoW8B5zMXWr2DY3bEmPD7Po8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TgLpR+yQ4KPRAbhpdXgbrZ0qrB8Ck2kFhQdP4FkLFjSTVFztTZ1bBPGXQGquQLPi9mNXPwYg1gtRzqisW8xNTRPudwF06xIISMxt6zGALD4VVu5q6AMoGdQxcDw4l+kHY3s2aaqxCwTOmP8XpNr3namXKhYRCCa7KH3a5W4kF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGrs+Adn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d4d80d00so1887241e87.0;
        Sat, 06 Apr 2024 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712416237; x=1713021037; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nEK/fgmvF2Xsifv3y4ZoW8B5zMXWr2DY3bEmPD7Po8=;
        b=DGrs+AdnPRjOd5rz7FFKtdfW6WB2Y893SXfylcIxKPOYn4srHI6jR75XFs4qCGZiJ4
         dqrRHxIcMeuUBjLiEEPCMT7whclkAxmYlOUkTSVpbvZ51otR4/lDzcy+r0I6XChPhX3E
         jYwQhyC0MscG32wf7m9DEK7/sAI4xAf3faKmdg+IgRBfnPDKZ7yUO0vHYK6bH6PVrp+A
         IultYZLdDr8Gqnjr9oOk2mkPItnFea2sYdoSDctwSBJEshTlI/EDNfvuUN7PjBI8uLHE
         3v1CGxSh4gOaN/7DsTyyGCt5OGoGbg7lpc6ef9uTEHjylpCvpMq5j1mk7haRmiAQjgSs
         l14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712416237; x=1713021037;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nEK/fgmvF2Xsifv3y4ZoW8B5zMXWr2DY3bEmPD7Po8=;
        b=tpKZN4xpEsYpzwJtB64r8AtjtbZKVULqjGvFUMxvFhkpDpOPkrh1r/4LfpDA54YdkS
         UnXYvcOJZmT9oYzinXCDxJM9eQZV8skoeiGO1aqtxPldhMxyXcYfIKO5s3rOlKxx2S8s
         aJvH0uG8H8Uc/kJfNs+ozCMC9LAb7wfDOaSMqNXhgKxCqZ/F0pPlWavTgh/YJ63ybKYG
         uJLUZ0C6pHLT1u6OizoPvxyCkx9io8XrvYW4/UyJuB+FEpmliIVr0XxJ9CvPTzsaYYXM
         yKZMmG6KHSmxX2anhGZhmU+eaLjzrhyKosg4peKyJUE32mdyNq0yyXpGGoaKSv80FDEK
         9bfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXylpIK29I5HRKDWdSworiIaEBAJqAcCO2ZMFvya82KgNTU1KJU2mCfiAkfJF4hBEs3sn7pkBYj24EiQGqtO4b33aMUb+3Z
X-Gm-Message-State: AOJu0YxdrdzACfLBP3CU6vAid2jjmcUSG7sxL/+L1Lz9FjOg2DHwFVSU
	/62hDNmjJdkKsECIMXUgEkCUukBaEpL17+la9L7HdGcWAwspFJ6p11SSLqwaurU=
X-Google-Smtp-Source: AGHT+IGoBd+CTRAjda+8Wg8BIbtEUh4tgH/sLsRgI8hX9YjImlX+LAuihn/nkiW/HhoEhH9UBICpCw==
X-Received: by 2002:a05:6512:14a:b0:515:b777:50a0 with SMTP id m10-20020a056512014a00b00515b77750a0mr3130423lfo.48.1712416237165;
        Sat, 06 Apr 2024 08:10:37 -0700 (PDT)
Received: from nuc (77-246-195-186.cust.suomicom.net. [77.246.195.186])
        by smtp.gmail.com with ESMTPSA id x17-20020a056512047100b00513d3b5d4f5sm489167lfd.128.2024.04.06.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 08:10:36 -0700 (PDT)
Date: Sat, 6 Apr 2024 18:10:35 +0300
From: Jarkko Palviainen <jarkko.palviainen@gmail.com>
To: linux-usb@vger.kernel.org
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	jtornosm@redhat.com
Subject: [REGRESSION] ax88179_178a assigns the same MAC address to all USB
 network interfaces
Message-ID: <ZhFl6xueHnuVHKdp@nuc>
Reply-To: jarkko.palviainen@gmail.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Starting from kernel version 6.7.4 I hit the following problem: when I
connect two or more USB-to-ethernet adapters to the computer they get
assigned the same MAC address. Furthermore, the address is not the one
specified in any of the device labels but is selected seemingly at
random on boot.

This becomes a blocking issue when trying to use SYSTEMD.LINK(5) to
match the interfaces.

6.7.3 is OK, 6.7.4 introduces this behavior in the following upstream commit:
d2689b6a86b9 net: usb: ax88179_178a: avoid two consecutive device resets
Reverting this commit in 6.7.4 fixes the issue.

The behavior is also present in LTS 6.6.23. The commit has been
backported in 6.6.16.

Example system log when connecting two adapters. Both interfaces are
assigned address 02:a5:ab:80:e6:94.

kernel: usb 2-5.4: new SuperSpeed USB device number 3 using xhci_hcd
kernel: usb 2-5.4: New USB device found, idVendor=2001, idProduct=4a00, bcdDevice= 1.00
kernel: usb 2-5.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
kernel: usb 2-5.4: Product: D-Link DUB-1312
kernel: usb 2-5.4: Manufacturer: D-Link Elec. Corp.
kernel: usb 2-5.4: SerialNumber: 00000000001D4D
mtp-probe[2431]: checking bus 2, device 3: "/sys/devices/pci0000:00/0000:00:14.0/usb2/2-5/2-5.4"
mtp-probe[2431]: bus: 2, device: 3 was not an MTP device
kernel: ax88179_178a 2-5.4:1.0 eth0: register 'ax88179_178a' at usb-0000:00:14.0-5.4, D-Link DUB-1312 USB 3.0 to Gigabit Ethernet Adapter, 02:a5:ab:80:e6:94
kernel: usbcore: registered new interface driver ax88179_178a
mtp-probe[2436]: checking bus 2, device 3: "/sys/devices/pci0000:00/0000:00:14.0/usb2/2-5/2-5.4"
mtp-probe[2436]: bus: 2, device: 3 was not an MTP device
kernel: ax88179_178a 2-5.4:1.0 enp0s20f0u5u4: renamed from eth0
systemd-networkd[469]: eth0: Interface name change detected, renamed to enp0s20f0u5u4.

kernel: usb 1-5.3: new high-speed USB device number 8 using xhci_hcd
kernel: usb 1-5.3: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 1.00
kernel: usb 1-5.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
kernel: usb 1-5.3: Product: AX88179
kernel: usb 1-5.3: Manufacturer: ASIX Elec. Corp.
kernel: usb 1-5.3: SerialNumber: 0000249B2BAEC8
kernel: ax88179_178a 1-5.3:1.0 eth0: register 'ax88179_178a' at usb-0000:00:14.0-5.3, ASIX AX88179 USB 3.0 Gigabit Ethernet, 02:a5:ab:80:e6:94
mtp-probe[2440]: checking bus 1, device 8: "/sys/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5.3"
mtp-probe[2440]: bus: 1, device: 8 was not an MTP device
kernel: ax88179_178a 1-5.3:1.0 enp0s20f0u5u3: renamed from eth0
systemd-networkd[469]: eth0: Interface name change detected, renamed to enp0s20f0u5u3.
mtp-probe[2444]: checking bus 1, device 8: "/sys/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5.3"
mtp-probe[2444]: bus: 1, device: 8 was not an MTP device


