Return-Path: <stable+bounces-3673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBC80137E
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 20:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC19DB20F8B
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5BD4EB59;
	Fri,  1 Dec 2023 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="BXSOtP87"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 11:15:49 PST
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72932B0;
	Fri,  1 Dec 2023 11:15:49 -0800 (PST)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout3.routing.net (Postfix) with ESMTP id 20FA860476;
	Fri,  1 Dec 2023 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1701457554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1KGPYRvYIOKuqyRIUAMSTTl/RZtGgGj2cX3gmi3st0=;
	b=BXSOtP87w0sNXDfd1BKrhZ0Hu9DzSraAdttZSa5r69wfWBSQ48L8FmzDdyDP0q5WEf5aMr
	pOjLdc294/cw8DeKNBTR8HyXMgta9srVE0airsEOGrvlSoQfTaq7xS3+lwM8cgdcVB/qEv
	vTgM1OQ8HETN66b+cDRF/HmxMU/0Fx4=
Received: from [192.168.178.75] (dynamic-095-116-189-134.95.116.pool.telefonica.de [95.116.189.134])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4AF95360200;
	Fri,  1 Dec 2023 19:05:53 +0000 (UTC)
Subject: Re: Fwd: Thinkpad X13 AMD: Problems with external monitor wake up
 after suspend
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Cc: Wayne Lin <wayne.lin@amd.com>, Stylon Wang <stylon.wang@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
 <da0efb19-c883-40c8-b284-7eb7f4d3640b@leemhuis.info>
From: Oliver Schmidt <oliver@luced.de>
Message-ID: <12db0c2e-a1b7-f8f9-278e-8aefe5619c1f@luced.de>
Date: Fri, 1 Dec 2023 20:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <da0efb19-c883-40c8-b284-7eb7f4d3640b@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mail-ID: 20b245b1-f3ff-4754-a7e8-c1632906f36e


On 01.12.23 12:37, Thorsten Leemhuis wrote:
> Maybe one of the developers among the recipients has a idea. Oliver, but
> if none of them replies any time soon, it would be best if you'd check
> if 6.6 (and/or 6.7-rc) is affected as well; and if reverting it there
> fixes it, too.

OK, I checked it: compiled a 6.6.3 kernel and got the same suspend-resume
problem as with the 6.1.57 and 6.1.64 kernels. I also was able to revert the
changes of commit ec5fa9 "drm/amd/display: Adjust the MST resume flow" in the
6.6.3 kernel and the problem was solved as in the 6.1.x kernels (however it
seems that resuming with the 6.6 kernel needs a little more time until the
monitor gets signal).

Best regards,
Oliver



