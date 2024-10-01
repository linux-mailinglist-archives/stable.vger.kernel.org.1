Return-Path: <stable+bounces-78556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9B98C389
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48A6B213CC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04211C9DCD;
	Tue,  1 Oct 2024 16:38:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF611C6889
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800719; cv=none; b=hDC4VNBREGVm96VxvzYYqsvDDqEqt2ZnuiF+bD2Muk1ocqp1xOHBpSVqB6Dbwhv+sEW3ua8sgg5ADY/0KyyOvRTUYZDdN4Fa/QviloFzgx81UDLW26MmUqOqnu2Kby5/a0d/iJ7RrfxgR9EXGaIYj57/pLcrmBXQocxXgpBWiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800719; c=relaxed/simple;
	bh=axzvmKFMV1qOjJQ1jmK6s5cmbWmN93I+vQyZ4Yp+Jxg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GmGgsqlSIiPlq88JlmyeJ2oj3wXCSzYJCfZkrisYJ8MlEWV0G6vR7kP69FvHrXkR8AsK960xoc5J9mCus/VC0Xe5Q48u9ONFHrWryIMpzv0EYgjTvkB99pofjnRSNvuDBhd4pEmXarbTB0If7xKcCeQFkVBKCvkmvaDQ1otz6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTPS
	id vd3es4xCiMArNvftUsCbQ5; Tue, 01 Oct 2024 16:38:36 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id vftUsPiHfE0IVvftUsVRYU; Tue, 01 Oct 2024 16:38:36 +0000
X-Authority-Analysis: v=2.4 cv=cI9DsUeN c=1 sm=1 tr=0 ts=66fc258c
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=M51BFTxLslgA:10 a=ag1SF4gXAAAA:8
 a=VwQbUJbxAAAA:8 a=3I1X_3ewAAAA:8 a=o4h3QDx3z5unFpuNuzIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 491GcZ6h009246
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Oct 2024 10:38:35 -0600
Date: Tue, 1 Oct 2024 10:38:22 -0600 (Mountain Daylight Time)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: gregkh@linuxfoundation.org
cc: brauner@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] debugfs show actual source in /proc/mounts"
 failed to apply to 6.10-stable tree
In-Reply-To: <723a6bec-0c41-a81a-c8f4-b8e1b20dc724@tuyoix.net>
Message-ID: <alpine.WNT.2.20.2410011036090.3332@CLUIJ>
References: <2024100128-prison-ploy-dfd6@gregkh> <723a6bec-0c41-a81a-c8f4-b8e1b20dc724@tuyoix.net>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfB/2G1rWUei/vaXiaVIapkacbuOYRM+vIp9B11aMinSBKFW0njy4CsuXU0wyS9yTC1cz0GrFSRErd5Dw79b6Y0fHdwEtFA6s1EA9pavV9eMQ+RtokeQh
 XDVIebuhu5G3V7UjnHPDeptaJkKiot4q41YKyiDKA0xZ1t4jnr8nOraeUTtQm+QoUV4Umz4oVQalsF2yG4c/tLlUKMcKgKzwqF653lhoc1fpP8EH6lOPj3Ou
 t6IkIoVudUBGJqnSKAEStR9KT1JTZmS5Gm8Nxri5CyI=

On Tue, 2024-Oct-01, Marc Aurèle La France wrote:
> On Tue, 2024-Oct-01, gregkh@linuxfoundation.org wrote:

>> The patch below does not apply to the 6.10-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.

>> To reproduce the conflict and resubmit, you may use the following commands:

>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
>> linux-6.10.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 3a987b88a42593875f6345188ca33731c7df728c
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to
>> '2024100128-prison-ploy-dfd6@gregkh' --subject-prefix 'PATCH 6.10.y'
>> HEAD^..

>> Possible dependencies:

>> 3a987b88a425 ("debugfs show actual source in /proc/mounts")
>> 49abee5991e1 ("debugfs: Convert to new uid/gid option parsing helpers")

>> thanks,

>> greg k-h

>> ------------------ original commit in Linus's tree ------------------

>> From 3a987b88a42593875f6345188ca33731c7df728c Mon Sep 17 00:00:00 2001
>> From: =?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>
>> Date: Sat, 10 Aug 2024 13:25:27 -0600
>> Subject: [PATCH] debugfs show actual source in /proc/mounts
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit

>> After its conversion to the new mount API, debugfs displays "none" in
>> /proc/mounts instead of the actual source.  Fix this by recognising its
>> "source" mount option.

>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
>> Link:
>> https://lore.kernel.org/r/e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net
>> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
>> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new
>> uid/gid option parsing helpers
>> Signed-off-by: Christian Brauner <brauner@kernel.org>

> ... elided.

> This is because the commit message should have instead read ...

> After commit 0c07c273a5fe ("debugfs: continue to ignore unknown mount
> options"), debugfs displays "none" in /proc/mounts instead of the actual
> source.  Fix this by recognising its "source" mount option.

> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> Fixes: 0c07c273a5fe ("debugfs: continue to ignore unknown mount options")
> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid
> option option parsing helpers
> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new
> uid/gid option parsing helpers

> ... along with ...

> Link:
> https://lore.kernel.org/r/e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Oops.  That link should be ...

Link: https://lore.kernel.org/all/883a7548-9e67-ccf6-23b7-c4e37934f840@tuyoix.net

Marc.

