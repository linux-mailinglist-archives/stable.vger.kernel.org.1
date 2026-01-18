Return-Path: <stable+bounces-210232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7ED3993A
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67E31300A1F8
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 18:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681D2FF15B;
	Sun, 18 Jan 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="lS58KSQU"
X-Original-To: stable@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster5-host3-snip4-2.eps.apple.com [57.103.71.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A45238C3B
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.71.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768761707; cv=none; b=nkhH24MDloeLsGRR4rXv66PaERJqd4DaNeUpDoiKNCowEcd0HM48MFeTHb/p1W3XIlW0v5CDsOBxxVG7BHStSvGIlzKsaENCFsclfFcfl2DxMbGF3kvzj/+oMw/Ga17n3XiZyMBGWdhSCAJUyCGLkMIG8lVzhrl/xnO9w90Z+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768761707; c=relaxed/simple;
	bh=pjtbuDlqoDmoMLqut2ibzsqKWg9OJwsmzEZB5/sUYBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rISaY/xLoetTOd3XSuT5/cQxUACTLlBGNLhRXegA2jvV5OmwOR8TxwdEwOuXwLAyu+8DM6lxs7/QlNoK2TJNc1NGS/M8siLysq4sdW32+TNjV+u441RqHXy4uWj9xYQbXRE9aLzPEfaid/ne/Cl5SrEXxsjqolUK8XV0B5vOAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=lS58KSQU; arc=none smtp.client-ip=57.103.71.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-0 (Postfix) with ESMTPS id 51D0518001CC;
	Sun, 18 Jan 2026 18:41:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai; bh=xjvMi6GFGlbqgGmmeOFvWqPwsPoBgy/JjXDenAmtqfw=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=lS58KSQUIXGRZPrvj3fnSokrXvpFexaSb6sRzGfpY/OYR+egnKsRRmUc9ESl+eWQXWwSJNaO8I5zPqGsPL4BgPrUkllQmXj9PoPahiCP4k9ac64btshfIOPENqiABavwfnaowdyZNBFKLaR/Ww0118D2zyKduIcJ0qq4uVkm7MU1A8nOLxCmGxpQrFWNsxQBf9ko5VUlyM8ksme652oJGU92iFYlQPrEHXnDtWOMcesxDIAQ4JETW0RJ+fywKREn/1LkmgZ3tbXF81Dpv4ruurTEzlKDORLONlbiwPUo6yKMa+6ZEmg/UYFIQPaxwgfckwkedI5zQ01pVRd6rkxn0g==
Received: from [192.168.1.216] (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-0 (Postfix) with ESMTPSA id CBF3218001FD;
	Sun, 18 Jan 2026 18:41:43 +0000 (UTC)
Message-ID: <4c70fe51-56c3-4292-9eda-f0f4535718fe@mac.com>
Date: Sun, 18 Jan 2026 12:41:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc: Add reloc_offset() to font bitmap pointer
 used for bootx_printf()
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Finn Thain <fthain@linux-m68k.org>
Cc: Stan Johnson <userm57@yahoo.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <22b3b247425a052b079ab84da926706b3702c2c7.1762731022.git.fthain@linux-m68k.org>
 <176680916368.22434.818943585854783800.b4-ty@linux.ibm.com>
Content-Language: en-US
From: Cedar Maxwell <cedarmaxwell@mac.com>
In-Reply-To: <176680916368.22434.818943585854783800.b4-ty@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Info: v=2.4 cv=XrP3+FF9 c=1 sm=1 tr=0 ts=696d2969
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=x7bEGLp0ZPQA:10 a=fPXO8E_wjBMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JXPk7LadgWurrYbJNRoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2NCBTYWx0ZWRfXwERN4npg9hhe
 QcSRTksUbDg8c5Aw8/AqjSopXXaAJ0IBhSDzpPGLBk39SaKa+6Yshw4eLS2GY57C/aZbh6SYq8M
 cgYuZqXW/WGKH6k7Srg5FNe1jK49aY9oAvVAF6igfb347JBnRsgN2ZIWmvpc6g+QT3gzusEFntS
 dOUbbLq7G1rUv0scG3vSUNQYI5rMLdJyz81qyJTeunI9+Zotbj37PwcIhuhQXa93Py8rTYVOf6t
 UCiC1q5u0666KCqRIFvcl2XEyMhguV44R5MPCVuRd3Mb16D9W/UX7x2J4j121FS7vKO9FgpsaPt
 vBOKSZGQDy+W3fNQPC4
X-Proofpoint-GUID: _RSHnb2iLwpQezYNpt68GTNW8-_s-jgY
X-Proofpoint-ORIG-GUID: _RSHnb2iLwpQezYNpt68GTNW8-_s-jgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601180164
X-JNJ: AAAAAAABp+XWJIMWjaKg1EdVIkMHUHCSmlU1XHxVWa15/VQ0U2VsLzL9GZR7Uo3OClqmbEGo8uoab8ZBBVoVjXkyAgD2Kf9OWSpiapwKQZSsGBC27ZxsHkJqQN9PdSmqs56YIWKktDCNDr19o/w804prbHwLb2gXkZmYh5Zzm11Hcu5FgCt/1PrS8/lYRhkwWjegR9wUrpSfNW/KC1hZsO2FQcbmEN6C+Hy0wdcQg3yVf7EXGp2DVmNb3QvLxTL6btjRN/G0sjC/p/fq71pFA95BlDQc9GFF7IZ6AhbhV/MCxM1xS/Zg+Xw94Kr95eLK2Y3eT+Xv2yapS4NSXziqqw1klsCr35qMCzop4TbazjYevalyoI6XRA1OALJHN7WziTwo3s5nQbMrS/z8sF74EPBep0qVeiBNllvC7+kgGIRI8LHudTtDcg43X3ylciuJPrW+BUVTERC/BYk5YfXKKaLMCjia+hO+f0HSZJN/cpA4nsTsbwEbYXt+JDdNj3YV9OEMnLrVmthgkUqsPkcP+xRZy+kkAQoDt4H6MUe7PqyaIgR1s7uXuWXRhW0Vzrfblf4LTqHsgzWulX2Jn2EVxAZApKhnDqfkUcEJ6BRV+0ZAIRszUGB57WXry25k5ycYGK5lge69BF5Imz48ht134zhv56kpbF2zCHWPLUbb6TzRGB9hnPg2192rRRVNv/gxMETmo6+HVtOzovHPMZya8RJG6/rZ/OdMt/pUKKgqHo7SDA4LHVILM612ziFLpLXeNSBKxbFKKtOT3gqJQy7D97FV6S9t15BQ23PZKdSpw2BassMoCVXhnQZNiSeM68f1Ivb9phegIw==

Maddy (and everyone else),


Thank you all for your hard work in solving this issue!


Cedar Maxwell

On 12/26/25 10:23 PM, Madhavan Srinivasan wrote:
> On Mon, 10 Nov 2025 10:30:22 +1100, Finn Thain wrote:
>> Since Linux v6.7, booting using BootX on an Old World PowerMac produces
>> an early crash. Stan Johnson writes, "the symptoms are that the screen
>> goes blank and the backlight stays on, and the system freezes (Linux
>> doesn't boot)."
>>
>> Further testing revealed that the failure can be avoided by disabling
>> CONFIG_BOOTX_TEXT. Bisection revealed that the regression was caused by
>> a change to the font bitmap pointer that's used when btext_init() begins
>> painting characters on the display, early in the boot process.
>>
>> [...]
> Applied to powerpc/fixes.
>
> [1/1] powerpc: Add reloc_offset() to font bitmap pointer used for bootx_printf()
>        https://git.kernel.org/powerpc/c/b94b73567561642323617155bf4ee24ef0d258fe
>
> cheers

