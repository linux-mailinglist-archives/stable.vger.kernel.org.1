Return-Path: <stable+bounces-179237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AD8B528A6
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1598A0579A
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3E258CD0;
	Thu, 11 Sep 2025 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MhCjIrjM"
X-Original-To: stable@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F693201278;
	Thu, 11 Sep 2025 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571789; cv=none; b=i7X+Wu4v5veIPlkjofpIu2jUn/S5z4U2N66Co6hOse7YhwiqvLUUHgoCYMUQeB3Tyd/8Rtu+f42paniTmcykD8QkjCXGIC8onUVSVDF8DmyeZzauDIXhxCU3m6/Hy0JG/VIQVBXd4xUTyt9gTFB16XjZWmjqqdZH6WiGgzV/5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571789; c=relaxed/simple;
	bh=mR2TVaT7oI0714GEW5XuhlwycbP1Ty/5Q+rPPkwY94g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XUlN+pNJe9jQjduJ2BuQyICxWjB/yI8FujvPj9bRB/cL2qTj3pWaBQKi67kMEa0LQVhQ50b07RqK/RexMuC87ms8DkGTifKT3X+xGCJERHq4U5LWj0oH3GjD5N5mOQyKk9/V43oK7dtXjF+3aNGC0sAlbQyIWfIfJIB3J15pQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MhCjIrjM; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58B6MVLl313999;
	Thu, 11 Sep 2025 01:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757571751;
	bh=VV4j2uohNmTsnTHXLlqzjhM3fCN2LIgoOEGp00OVD7w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MhCjIrjMDrZ7MCBSArxYv1pVgWnd+XuITrtTYVf7xa148UBjy1hmHMOVfUd6+JcZQ
	 zm+76Oj9z2+0xqLUMb4CzKIa6h6roipL+VX6eW1ba0cxwnuIp85n99S8cU2bkCcpTw
	 atcXaidA1C5Qj5lVrJwUqJeroXpXyuaMpu86vY7o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58B6MVRr857555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 01:22:31 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 01:22:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 01:22:31 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58B6MRVf1685850;
	Thu, 11 Sep 2025 01:22:28 -0500
Message-ID: <454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com>
Date: Thu, 11 Sep 2025 11:52:27 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger
	<richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Gabor Juhos
	<j4g8y7@gmail.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Daniel Golle <daniel@makrotopia.org>,
        <s-k6@ti.com>
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
 <175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

On 05/09/25 20:25, Miquel Raynal wrote:
> On Mon, 01 Sep 2025 16:24:35 +0200, Gabor Juhos wrote:
>> Using an OOB offset past end of the available OOB data is invalid,
>> irregardless of whether the 'ooblen' is set in the ops or not. Move
>> the relevant check out from the if statement to always verify that.
>>
>> The 'oobtest' module executes four tests to verify how reading/writing
>> OOB data past end of the devices is handled. It expects errors in case
>> of these tests, but this expectation fails in the last two tests on
>> MTD devices, which have no OOB bytes available.
>>
>> [...]
> 
> Applied to mtd/next, thanks!
> 
> [1/1] mtd: core: always verify OOB offset in mtd_check_oob_ops()
>        commit: bf7d0543b2602be5cb450d8ec5a8710787806f88

I'm seeing a failure in SPI NOR flashes due to this patch:
(Tested on AM62x SK with S28HS512T OSPI NOR flash)

root@am62xx-evm:~# uname -a
Linux am62xx-evm 6.17.0-rc1-00011-gbf7d0543b260 #3 SMP PREEMPT Wed Sep 
10 20:44:34 IST 2025 aarch64 GNU/Linux
root@am62xx-evm:~# dmesg | grep mtd
[    8.018107] I/O error, dev mtdblock6, sector 0 op 0x0:(READ) flags 
0x80700 phys_seg 1 prio class 2
[    8.032806] I/O error, dev mtdblock6, sector 0 op 0x0:(READ) flags 
0x0 phys_seg 1 prio class 2
[    8.043229] Buffer I/O error on dev mtdblock6, logical block 0, async 
page read
[    8.055082] I/O error, dev mtdblock4, sector 0 op 0x0:(READ) flags 
0x80700 phys_seg 1 prio class 2
[    8.065883] I/O error, dev mtdblock4, sector 0 op 0x0:(READ) flags 
0x0 phys_seg 1 prio class 2
[    8.075022] Buffer I/O error on dev mtdblock4, logical block 0, async 
page read
[    8.381213] I/O error, dev mtdblock6, sector 0 op 0x0:(READ) flags 
0x80700 phys_seg 1 prio class 2
[    8.394621] I/O error, dev mtdblock2, sector 0 op 0x0:(READ) flags 
0x80700 phys_seg 1 prio class 2
[    8.394704] I/O error, dev mtdblock2, sector 0 op 0x0:(READ) flags 
0x0 phys_seg 1 prio class 2
[    8.394714] Buffer I/O error on dev mtdblock2, logical block 0, async 
page read
[    8.410152] I/O error, dev mtdblock0, sector 0 op 0x0:(READ) flags 
0x80700 phys_seg 1 prio class 2
[    8.456064] I/O error, dev mtdblock0, sector 0 op 0x0:(READ) flags 
0x0 phys_seg 1 prio class 2
[    8.465774] Buffer I/O error on dev mtdblock0, logical block 0, async 
page read
[    8.469771] I/O error, dev mtdblock6, sector 0 op 0x0:(READ) flags 
0x0 phys_seg 1 prio class 2
[    8.469804] Buffer I/O error on dev mtdblock6, logical block 0, async 
page read
[    8.505866] Buffer I/O error on dev mtdblock5, logical block 0, async 
page read
[    8.522665] Buffer I/O error on dev mtdblock4, logical block 0, async 
page read
[    8.845572] Buffer I/O error on dev mtdblock3, logical block 0, async 
page read
[    8.855938] Buffer I/O error on dev mtdblock1, logical block 0, async 
page read
[    8.878292] Buffer I/O error on dev mtdblock2, logical block 0, async 
page read
root@am62xx-evm:~# hexdump /dev/mtd6
hexdump: /dev/mtd6: Invalid argument
root@am62xx-evm:~#


Reverting this works fine:

root@am62xx-evm:~# uname -a
Linux am62xx-evm 6.17.0-rc5-next-20250910-00001-g5f216cdf2764 #5 SMP 
PREEMPT Thu Sep 11 11:38:06 IST 2025 aarch64 GNU/Linux
root@am62xx-evm:~# dmesg | grep mtd
root@am62xx-evm:~# hexdump /dev/mtd6
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0040000
root@am62xx-evm:~#

Regards,
Santhosh.

> 
> Patche(s) should be available on mtd/linux.git and will be
> part of the next PR (provided that no robot complains by then).
> 
> Kind regards,
> Miquèl
> 
> 


