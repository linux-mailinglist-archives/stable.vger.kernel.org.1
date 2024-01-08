Return-Path: <stable+bounces-9980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD22826BBD
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 11:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CAC1C22132
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92013FF0;
	Mon,  8 Jan 2024 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schenkel.net header.i=@schenkel.net header.b="0dTgqicI";
	dkim=pass (2048-bit key) header.d=schenkel.net header.i=@schenkel.net header.b="Y4rVDMh9"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19D14273
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schenkel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schenkel.net
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T7rKq3y2Lz9tQw;
	Mon,  8 Jan 2024 11:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schenkel.net;
	s=MBO0001; t=1704710687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9RvfDJDEBmxsrLzIf51PXD3Vc17TSefzzUyD7NKT+a4=;
	b=0dTgqicIeGuQrUHKaegnyEHv54RewfrLMUpOnvk8jDLYmrLGR1SwAy4TgsJvjo664Vurjb
	cMVfac+1FiWs3PzWpA3oDk+ig7fAB2cW2oWbcIiDVkegbrqaexhYJMlfkip3fO/OLsEqQC
	Rpj2dnDpHJLpHvf2fBaJG1JimsCKFHoWcBo6O1IcGSFkMPfwaTleUJZtV/+6PR46oc72NX
	D3wDGTs2yNYB6PSseQhfGXUzTpDc1DV64xyquUTCQoqBQV6GfyjQb4aNZ6ec19lCUixmXt
	dhWvLGB5feVU6zt9PZwmb/xmSoyoh6IbNBg3Lv1dgESD49cafKxv8Dif/KoWDw==
Message-ID: <8ad7c20e-0645-40f3-96e6-75257b4bd31a@schenkel.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schenkel.net;
	s=mail; t=1704710685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9RvfDJDEBmxsrLzIf51PXD3Vc17TSefzzUyD7NKT+a4=;
	b=Y4rVDMh9X81Rnsk+v49T6d7UTS2WCdl7HDCStbG0AWCIjdkrznLXLwqFKnSbKLg6Cs5MgC
	1VRb5eOzyfXgCbY5oocdRAC1KOloEnWNlDO8CDDqs7TG4hneUZ+7aUtwXcmrCfw6ab+P4e
	FFgkd7rj4rVEj3GdWWjx0S+5/eO6wUHWYV9HgFc9dZP1mjPor3GDBWnOUOHqxzKTvl8IO8
	Ev91z0UuhLTqj7RfnCxG/mfdgqehSeZcJtNPisj7tLUgZ4YCPjAbrjSx4yWjxEIwOklb51
	pg7yQ4P+pnek3OBoTqu/aOlxuJKvjg1eZLB7gzE3nSqiWDd2MvyFUjzDzZQmqw==
Date: Mon, 8 Jan 2024 11:44:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: stable@vger.kernel.org
Content-Language: en-US, pt-BR, sv-SE
Cc: regressions@lists.linux.dev
From: Leonardo Brondani Schenkel <leonardo@schenkel.net>
Subject: [REGRESSION 6.1.70] system calls with CIFS mounts failing with
 "Resource temporarily unavailable"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4T7rKq3y2Lz9tQw

I'm new here, first time reporting a regression, apologies in advance if 
I'm doing something wrong of if this was already reported (I found some 
CIFS issues but not exactly this one).

I'm using x86-64 Arch Linux and LTS kernel (6.1.71 as I write this) and 
I noticed a regression that I could reproduce in other boxes with other 
architectures as well (aarch64 with 6.1.70).

# mount.cifs //server/share /mnt
# mount
//server/share on /mnt type cifs (rw,relatime,vers=3.1.1...)
# cd /mnt
# df .
df: .: Resource temporarily unavailable
# ls -al
ls: .: Resource temporarily unavailable
ls: file1: Resource temporarily unavailable
ls: file2: Resource temporarily unavailable
[...then ls shows the listing...]

If I use strace with df, the problem is:
statfs(".", 0x.....) = -1 EAGAIN (Resource temporarily unavailable)

And with ls:
listxattr(".", 0x..., 152): -1 EAGAIN (Resource temporarily unavailable)
listxattr("file1", ..., 152): -1 EAGAIN (same as above)
...

Initially I thought the problem was with the Samba server and/or the 
client mount flags, but I've spent a day trying a *lot* of different 
combinations and nothing worked. This happens with any share that I try, 
and I've tried mounting shares from multiple Linux boxes running 
different Samba and kernel versions.

Then I tried changing kernel versions at my client box. I booted latest 
6.6.9 and the problem simply disappeared. My Debian server with 6.5.11 
also doesn't have it. I then started a VM and tried a "bisection" of 
6.1.x versions, leading to kernel 6.1.70 when this started to happen.
6.1.69 and older look fine.

I hope that this is enough information to reproduce this issue. I will 
be glad to provide more info if necessary.

// Leonardo.

