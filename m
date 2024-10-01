Return-Path: <stable+bounces-78548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3598C122
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65112814E0
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E21CB322;
	Tue,  1 Oct 2024 15:03:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03591CB31D
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795024; cv=none; b=ErdAzI6BblqDShMIcLoOuS1q1ck/FJExpa5WwGS3vSxxiGmsFQcHjtdKDdMrQcY//ILEfAcrEQsVVb9RlauGIBx+uZZV56UJfL6AP70+xTpAcVx5lhebkqnQcsysLir8UO8/+HTULD+Xu4jdwT5fqacerYA5AbBCqsRBMD7enmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795024; c=relaxed/simple;
	bh=e+msiuc0dAEDFGvrik0RGNpgJRKjZJ3qHOiH2lIgwhU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DmZjd6fUMRy1ijnloLp4yCXyhZd6knozLWTEHFqbptNmGdSRgxhLU685mYk+4aoFZQPvyK0xpstQ8gTCrIcRe3Th/otevvowgAFMZF+17qoJJX4e2R3khrpvfZ8DViroW0zzOBqQ5DC/dFRb9LgRPOOqXlkTmclqnGgEsQF5kbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net; spf=pass smtp.mailfrom=tuyoix.net; arc=none smtp.client-ip=3.97.99.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuyoix.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuyoix.net
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTPS
	id vd3es4xCkMArNveO6sCCGq; Tue, 01 Oct 2024 15:02:06 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
	by cmsmtp with ESMTP
	id veO5sPEJjE0IVveO5sVCCc; Tue, 01 Oct 2024 15:02:06 +0000
X-Authority-Analysis: v=2.4 cv=cI9DsUeN c=1 sm=1 tr=0 ts=66fc0eee
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=M51BFTxLslgA:10 a=ag1SF4gXAAAA:8
 a=VwQbUJbxAAAA:8 a=3I1X_3ewAAAA:8 a=JbKLaDm34ewkrewylEUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=VG9N9RgkD3hcbI6YpJ1l:22
Received: from tuyoix.net (fanir.tuyoix.net [192.168.144.16])
	(authenticated bits=0)
	by fanir.tuyoix.net (8.18.1/8.18.1) with ESMTPSA id 491F23Zt007591
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 1 Oct 2024 09:02:04 -0600
Date: Tue, 1 Oct 2024 09:02:03 -0600 (MDT)
From: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To: gregkh@linuxfoundation.org
cc: brauner@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] debugfs show actual source in /proc/mounts"
 failed to apply to 6.10-stable tree
In-Reply-To: <2024100128-prison-ploy-dfd6@gregkh>
Message-ID: <723a6bec-0c41-a81a-c8f4-b8e1b20dc724@tuyoix.net>
References: <2024100128-prison-ploy-dfd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-CMAE-Envelope: MS4xfNxypvauFLLUW6Y8U9VrcmS9U67tt7/HxI6QWhFdtZTFDbLCjfcZKw0yboirZus+Jc7brlghn1pgMo/tjm6R2JdXvTw6zW+TdeQ5wl6wyXOWGcv3KV1q
 TNuhwjyAWGn7tXH8PodLguC73CFyq63YaSr4ao4Gl0TKkqg7IfRMZMM7FWll4/BVJYNqLOOyHQg9LWXwp1PCXmK6bmTdfrq7zxTFP0kWOTmwaU2AB1JOxiFI
 0aA76Yl8soWWpRPMizUjFxLQH1f1aZ4UIPngDVjiZMU=

On Tue, 2024-Oct-01, gregkh@linuxfoundation.org wrote:

> The patch below does not apply to the 6.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

> To reproduce the conflict and resubmit, you may use the following commands:

> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3a987b88a42593875f6345188ca33731c7df728c
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100128-prison-ploy-dfd6@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

> Possible dependencies:

> 3a987b88a425 ("debugfs show actual source in /proc/mounts")
> 49abee5991e1 ("debugfs: Convert to new uid/gid option parsing helpers")

> thanks,

> greg k-h

> ------------------ original commit in Linus's tree ------------------

> From 3a987b88a42593875f6345188ca33731c7df728c Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>
> Date: Sat, 10 Aug 2024 13:25:27 -0600
> Subject: [PATCH] debugfs show actual source in /proc/mounts
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

> After its conversion to the new mount API, debugfs displays "none" in
> /proc/mounts instead of the actual source.  Fix this by recognising its
> "source" mount option.

> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> Link: https://lore.kernel.org/r/e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net
> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers
> Signed-off-by: Christian Brauner <brauner@kernel.org>

... elided.

This is because the commit message should have instead read ...

After commit 0c07c273a5fe ("debugfs: continue to ignore unknown mount
options"), debugfs displays "none" in /proc/mounts instead of the actual
source.  Fix this by recognising its "source" mount option.

Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
Fixes: 0c07c273a5fe ("debugfs: continue to ignore unknown mount options")
Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers

... along with ...

Link: https://lore.kernel.org/r/e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net
Signed-off-by: Christian Brauner <brauner@kernel.org>

Marc.

