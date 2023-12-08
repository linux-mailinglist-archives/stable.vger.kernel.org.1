Return-Path: <stable+bounces-5030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE880A768
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AA01F21353
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB730659;
	Fri,  8 Dec 2023 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZmCRlnqO"
X-Original-To: stable@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707CF1706;
	Fri,  8 Dec 2023 07:29:42 -0800 (PST)
Received: from [100.75.103.134] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: padovan)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B37F66073BE;
	Fri,  8 Dec 2023 15:29:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702049381;
	bh=i7oXbb7HJvRluYtr0iGCFaISEbrfI5APYc6sg5tq7XE=;
	h=Date:To:Cc:From:Subject:From;
	b=ZmCRlnqOZ3sSapxSiecOwLgJZvY1FYkeTizv0T7/DV9xNgCFUcH1QSeDTIDTDCIo8
	 b88eQN4Nx6mcTCGAWDQXWJ90tAKxMO+XV8nhsUsgzrwIsVKgTthpCXoWHq+qJx4H8W
	 iRp2Adil/1ZRjivpRHlTzx5FX6THT9o2LVcPA7QW3hSS+v57Yy5IxG40pn4AOwZSVh
	 AKmZzZ8oWP/sv4JPGHnEfF7bVLwSSeJsfYkp8Xt8cbo/LqLeH2DfW5nO4fOX2QqBZw
	 ai9AGGx/hjtOR/aYzOZr5yprY9WiVA6D1Dp3W1GhPjWwZZPxTMyd5JXTV3Vwk065iQ
	 j4Dbq7+WaLKaw==
Message-ID: <738c6c87-527e-a1c2-671f-eed6a1dbaef3@collabora.com>
Date: Fri, 8 Dec 2023 12:29:35 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: stable@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shreeya Patel <shreeya.patel@collabora.com>,
 "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
From: Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: stable/LTS test report from KernelCI (2023-12-08)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

As discussed with Greg at LPC, we are starting an iterative process to 
deliver meaningful stable test reports from KernelCI. As Greg pointed 
out, he doesn't look at the current reports sent automatically from 
KernelCI. Those are not clean enough to help the stable release process, 
so we discussed starting over again.

This reporting process is a learning exercise, growing over time. We are 
starting small with data we can verify manually (at first) to make sure 
we are not introducing noise or reporting flakes and false-positives. 
The feedback loop will teach us how to filter the results and report 
with incremental automation of the steps.

Today we are starting with build and boot tests (for the hardware 
platforms in KernelCI with sustained availability over time). Then, at 
every iteration we try to improve it, increasing the coverage and data 
visualization. Feedback is really important. Eventually, we will also 
have this report implemented in the upcoming KernelCI Web Dashboard.

This work is a contribution from Collabora(on behalf of its clients) to 
improve the Kernel Integration as whole. Moving forward, Shreeya Patel, 
from the Collabora team will be taking on the responsibilities of 
delivering these reports.

Without further ado, here's our first report:


## stable-rc HEADs:

Date: 2023-12-08
6.1: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=45deeed0dade29f16e1949365688ea591c20cf2c
5:15: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=e5a5d1af708eced93db167ad55998166e9d893e1
5.10: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=ce575ec88a51a60900cd0995928711df8258820a
5:4: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=f47279cbca2ca9f2bbe1178634053024fd9faff3

* 6.6 stable-rc was not added in KernelCI yet, but we plan to add it 
next week.


## Build failures:

No build failures seen for the stable-rc/queue commit heads for 
6.1/5.15/5.10/5.4  \o/


## Boot failures:

No **new** boot failures seen for the stable-rc/queue commit heads for 
6.1/5.15/5.10/5.4  \o/

(for the time being we are leaving existing failures behind)


## Considerations

All this data is available in the legacy KernelCI Web Dashboard - 
https://linux.kernelci.org/ - but not easily filtered there. The data in 
this report was checked manually. As we evolve this report, we want to 
add traceability of the information, making it really easy for anyone to 
dig deeper for more info, logs, etc.

The report covers  the hardware platforms in KernelCI with sustained 
availability over time - we will detail this further in future reports.

We opted to make the report really simple as you can see above. It is 
just an initial spark. From here your feedback will drive the process. 
So really really tell us what you want to see next. We want FEEDBACK!

Best,

- Gus

-- 
Gustavo Padovan
Kernel Lead
Collabora Ltd.
Platinum Building, St John's Innovation Park Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

