Return-Path: <stable+bounces-35645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B6895D39
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 22:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AA61C2234F
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9722315AAA1;
	Tue,  2 Apr 2024 20:03:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3915CD72
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088187; cv=none; b=WFShuYcsRrcj5y4ZUfVFJtHDil9UBjxT2bQaMCeV+asTieIc2VpYznnEU5J+bVO8Dy0C0Qogy7J1cgcufLdGljDaxxsr7IOMm5VTT7s1udlJj4sVHiUIOyPAKIvOrYPcpSUmaSKBkNsvTsV8WLTy6bhiGiQLdqra6h7emXxhBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088187; c=relaxed/simple;
	bh=7uZCfmNAtD4Zk2/AALoalCyE13Z2i9dxS6bZMw5kwCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSwTTtZnzaggI9EfOdLmXzwC5L0YmAvwMpRqQpaGu6NJf6bV+JyUieJT1BeXnuJ9bfbcoOEzTxMMwogkynyM1NFJ8OsWjhJMzL8JF+dLdez+4qDqoQTbv3EhIPIxrq8k9ZU+Kd1OvZCWFwwQ0CE9cf8I02qky4uUrmAyaRZx+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id D53778755;
	Tue,  2 Apr 2024 20:03:02 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Linux kernel regressions list <regressions@lists.linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: 6.7.11: Fails to hibernate - work queues still busy
Date: Tue, 02 Apr 2024 22:03:02 +0200
Message-ID: <4912750.31r3eYUQgx@lichtvoll.de>
In-Reply-To: <13486453.uLZWGnKmhe@lichtvoll.de>
References: <13486453.uLZWGnKmhe@lichtvoll.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Martin Steigerwald - 02.04.24, 21:29:50 CEST:
> 6.7.9 + some bcachefs upgrade/downgrade fixes included in 6.7.11 works
> okay. 6.7.11 fails. Two repeated attempts failed with a dmesg like this:

Also 6.7.11 appears not to be capable to reboot the machine. Runit says
it is rebooting and then it hangs there with no further output.

Which reminds me of:

* Re: [regression] 6.8.1: fails to hibernate with pm_runtime_force_suspend+=
0x0/0x120 returns -16
  2024-03-16 16:02 [regression] 6.8.1: fails to hibernate with pm_runtime_f=
orce_suspend+0x0/0x120 returns -16 Martin Steigerwald
[=E2=80=A6]

https://lore.kernel.org/regressions/22240355.EfDdHjke4D@lichtvoll.de/T/#md9=
dd4c2abed8503c0613d39be3cdc833aadecd6d

I don't know whether those two relate as dmesg outputs differ.

The output from 6.8.2 on hibernation attempt

[  412.158400] port 0000:02:00.1:0.0: PM: dpm_run_callback(): pm_runtime_fo=
rce_suspend+0x0/0x120 returns -16
[  412.158418] port 0000:02:00.1:0.0: PM: failed to freeze: error -16

versus the output 6.7.11 on hibernation attempt

[  215.764813] Showing freezable workqueues that are still busy:
[  215.764841] workqueue events_freezable: flags=3D0x4
[  215.764869]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D0 r=
efcnt=3D2
[  215.764881]     inactive: pci_pme_list_scan
[  215.764895] workqueue usb_hub_wq: flags=3D0x4
[  215.764965]   pwq 4: cpus=3D2 node=3D0 flags=3D0x0 nice=3D0 active=3D2 r=
efcnt=3D3
[  215.764974]     in-flight: 350:hub_event [usbcore] hub_event [usbcore]

does not really look related to me.

Yet both kernels do not seem to like to reboot the machine.

As written I am willing to bisect this 6.7.9 versus 6.7.11 issue, but not
6.8.1 versus some 6.7 issues cause I do not want to risk filesystem
corruption on a production machine by bisecting between stable and rc1.

Best,
=2D-=20
Martin



