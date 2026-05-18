Return-Path: <stable+bounces-249229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMS3EdHRCmou8gQAu9opvQ
	(envelope-from <stable+bounces-249229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:46:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1F056912D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0D08301C8BF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE203E3167;
	Mon, 18 May 2026 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="jpqZYLoy"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A53E1695;
	Mon, 18 May 2026 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093903; cv=none; b=fH3/M7FUQj3iaoBDoDehqXFQGSga3xok2qRMvEeR75vb+8tiHjHsAVUTlGYj0YAiXQmDPr/6NBjgatWNfc/hKFNokLPCa+oYEOn3m204MbOIN0hLGYRrohNAxoWXpIa9ddqhHi6kYxptZL8GTsBez76XIOzdLpI8MWU1qTzguf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093903; c=relaxed/simple;
	bh=F0W32FVYfdLbmnJp4LOdKE4Xc4GedI3E1n010WgBaYk=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=pqDPsRRtUIa6DOuu+F68QK+InqG/OP7cjyG12HwEDLvbBjLPNp3Evb0HQKFog0iSKPJT87Cm8+rmMQAqWuc6eYrZGfgDKyvzsY2W16bYzwzGBixiD2SlFYJOffmHtYXvrhXLVDKNUhyYw4ATRL6WwuPaUcvnrjidayt/+TlYKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=jpqZYLoy; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=MoSM3oNDxks2O9L5VU9jc7lW6/H6+hqc8WMoI8bWQlk=;
	b=jpqZYLoyjUcdk5lOEV8eP/pTvAef7X3LxosODLi1QalD5vbO+9oFyQIFlXOni1
	V7n1FUk3inJM76IGXsfMHy/qcekdKJbfMC5SG56zViDbkaa4PO04a2YR50r2HlVF
	kv1ghZTp0FPUiml/1Zevn6JyLLwys3SdASnpydgb/SqsA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXzwBf0QpqTvPRBg--.65235S2;
	Mon, 18 May 2026 16:44:16 +0800 (CST)
Message-ID: <6A0AD168.4040500@126.com>
Date: Mon, 18 May 2026 16:44:24 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: vkoul@kernel.org, neil.armstrong@linaro.org, johan@kernel.org, 
 kishon@kernel.org, rogerq@ti.com
CC: Hongling Zeng <zenghongling@kylinos.cn>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sashiko AI <sashiko@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 4/4] phy: ti-pipe3: Fix clock leak in init error path
References: <20260518062938.48114-1-zenghongling@kylinos.cn> <20260518062938.48114-5-zenghongling@kylinos.cn>
In-Reply-To: <20260518062938.48114-5-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXzwBf0QpqTvPRBg--.65235S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWDZFWrZw1DXw1fWFyUJrb_yoW8uFy3pr
	ZxJa95Crn5tw4vy3Wxtw4UX3WFqw15GayagFWjgw4rZ3ZxAr1DWFWxXr47ZryDCrW8CF4f
	t3WDtF13t3WUZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxEfrUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoQCpemoK0WCUdQAA3C
X-Rspamd-Queue-Id: 9D1F056912D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-249229-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[126.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[126.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongling0719@126.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

-- 
Sashiko AI review ·https://sashiko.dev/#/patchset/20260518062938.48114-1-zenghongling@kylinos.cn?part=4
--
Hi:
  Resend to fix threading / delivery issues.
   Thank you for identifying these SATA mode issues. Both are pre-existing bugs in
   the current codebase and were not introduced by this series.

   This series focuses on specific EPROBE_DEFER and resource leak fixes. The SATA
   mode issues you've found are valid but affect different code paths and should be
   addressed separately to keep the patch series focused.

   I can submit follow-up patches to fix these SATA mode issues. Would you prefer
   them in v6 or as separate patches after this series?

   Best regards,
   Hongling
  

在 2026年05月18日 14:29, Hongling Zeng 写道:
> When regmap_update_bits() fails in ti_pipe3_init() for PCIe mode,
> the function returns the error without calling ti_pipe3_disable_clocks().
> This leaves the clocks permanently enabled since the PHY framework won't
> invoke the .exit callback on init failure.
>
> Fix this by adding proper clock cleanup in the PCIe error path, consistent
> with how the DPLL program error path handles cleanup.
>
> Fixes: 234738ea3390 ("phy: ti-pipe3: move clk initialization to a separate function")
> Reported-by: Sashiko AI <sashiko@kernel.org>
> Closes: https://lore.kernel.org/all/20260518023657.41852C2BCB0@smtp.kernel.org/
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Cc: stable@vger.kernel.org
>
> ---
> Change in v5:
>    -Add Fix ignored clock enable return value in init patch
> ---
>   drivers/phy/ti/phy-ti-pipe3.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
> index 9ec228c2a940..4897e4ba2d7d 100644
> --- a/drivers/phy/ti/phy-ti-pipe3.c
> +++ b/drivers/phy/ti/phy-ti-pipe3.c
> @@ -518,6 +518,8 @@ static int ti_pipe3_init(struct phy *x)
>   		val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
>   		ret = regmap_update_bits(phy->pcs_syscon, phy->pcie_pcs_reg,
>   					 PCIE_PCS_MASK, val);
> +		if (ret)
> +			ti_pipe3_disable_clocks(phy);
>   		return ret;
>   	}
>   


