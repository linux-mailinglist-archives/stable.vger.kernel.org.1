Return-Path: <stable+bounces-238713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDZ4LVPX5WnWoQEAu9opvQ
	(envelope-from <stable+bounces-238713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3D427CA9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A01301E6D0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27002347506;
	Mon, 20 Apr 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="owj+J+BY"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89328641E;
	Mon, 20 Apr 2026 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670370; cv=none; b=AL8O8+wi0m7m5kkOxpkpUdzHHdKqeNvMOg6SpUwIabRpHIQQAeflCLky9WEXBtDwbwO5brirXYw72wMmD94cS5LxQgfE7/m4XDEtp/uXnSRrRiisonZ5Cb/mpIlCpPq3E1ph4gNe2DtiKjns7CGLhHzgNma4S+7ecR8VbgCCiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670370; c=relaxed/simple;
	bh=0ifAytL3E1AacPdhjW+KMvjty6JQP4iGtfxLc9eoUi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iRqCwMtXfJ+Sm5BbCa5pI/VEl7TMwyQx+kPQwteFL/uYcDymkfmEc4773sp5U/IVpgrJ9/0n1PpSV1HpJyS28lCxWekhbYMrPIVsve9MG2lbjoeKgBpiIC9PUlJdQo30PzMc8VEslY1zZe2pKyL/z/ihi8VEyTalm+yT+xYTjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=owj+J+BY; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BLv7nGBN27wPj3DbBK0dK/iUuPa+FDzIyHo8Ywtp3BE=;
	b=owj+J+BYp7cw8eq0UIp84LYOwAS2ReIdaKf/rX+kjqkBG0+p2qbMn9su3Xhana5cIkjJdWOsK
	1o4/LGEXSohpn1rGnHReSdP8+WWmeC2GHLARykzE2Ev3M63k3/+utAouh0+8UVzz28JwQWu6k/v
	H4mY1QPm6cAoATcspNtd+Ss=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fzcVS2NL5zRhTx;
	Mon, 20 Apr 2026 15:26:24 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A6B5240538;
	Mon, 20 Apr 2026 15:32:45 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 15:32:45 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 15:32:44 +0800
Message-ID: <d558a593-ca12-4237-a9b0-5f20441c9d52@huawei.com>
Date: Mon, 20 Apr 2026 15:32:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout
 in trace_start()
To: Yicong Yang <yangyccccc@gmail.com>, "Pradhan, Sanman"
	<sanman.pradhan@hpe.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sanman Pradhan
	<psanman@juniper.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, Jie Zhan
	<zhanjie9@hisilicon.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
 <20260414172451.14331-2-sanman.pradhan@hpe.com>
 <166964d1-2d16-43e8-b4d7-27b4a5e6286d@gmail.com>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <166964d1-2d16-43e8-b4d7-27b4a5e6286d@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn200012.china.huawei.com (7.202.194.135)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,hpe.com,huawei.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liusizhe5@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 20D3D427CA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026/4/17 1:25, Yicong Yang wrote:
> +cc Suzuki and Sizhe..
>
> On 2026/4/15 01:25, Pradhan, Sanman wrote:
>> From: Sanman Pradhan <psanman@juniper.net>
>>
>> hisi_ptt_wait_dma_reset_done() discards the return value of
>> readl_poll_timeout_atomic(). If the DMA engine does not complete its
>> reset within the timeout, hisi_ptt_trace_start() proceeds to start
>> tracing regardless.
>>
>> Return a bool from hisi_ptt_wait_dma_reset_done(), consistent with the
>> other wait helpers in this driver. On timeout, log an error, de-assert
>> the reset bit, and return -ETIMEDOUT. Move ctrl->started to the
>> successful path so a failed start does not leave the trace marked as
>> active.
>>
>> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sanman Pradhan <psanman@juniper.net>
> looks good to me.
>
> Reviewed-by: Yicong Yang <yangyccccc@gmail.com>
>
> I see the Suzuki has sent out the PR for 7.1, so this may wait after the merge window...
>
> thanks.

Looks good to me, thanks.

Reviewed-by: Sizhe Liu <liusizhe5@huawei.com>

>> ---
>> v2:
>>    - Return bool for consistency with other wait helpers
>>    - Add pci_err() on timeout
>>    - De-assert RST before returning on timeout
>>    - Move ctrl->started to the successful path
>>
>>   drivers/hwtracing/ptt/hisi_ptt.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 94c371c491357..b5d851281fbf0 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -171,13 +171,13 @@ static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
>>   					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);
>>   }
>>   
>> -static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
>> +static bool hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
>>   {
>>   	u32 val;
>>   
>> -	readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
>> -				  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
>> -				  HISI_PTT_RESET_TIMEOUT_US);
>> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
>> +					  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
>> +					  HISI_PTT_RESET_TIMEOUT_US);
>>   }
>>   
>>   static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>> @@ -202,14 +202,18 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>>   		return -EBUSY;
>>   	}
>>   
>> -	ctrl->started = true;
>> -
>>   	/* Reset the DMA before start tracing */
>>   	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>   	val |= HISI_PTT_TRACE_CTRL_RST;
>>   	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>   
>> -	hisi_ptt_wait_dma_reset_done(hisi_ptt);
>> +	if (!hisi_ptt_wait_dma_reset_done(hisi_ptt)) {
>> +		pci_err(hisi_ptt->pdev, "timed out waiting for DMA reset\n");
>> +		val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +		val &= ~HISI_PTT_TRACE_CTRL_RST;
>> +		writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +		return -ETIMEDOUT;
>> +	}
>>   
>>   	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>   	val &= ~HISI_PTT_TRACE_CTRL_RST;
>> @@ -234,6 +238,8 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>>   	if (!hisi_ptt->trace_ctrl.is_port)
>>   		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>>   
>> +	ctrl->started = true;
>> +
>>   	/* Start the Trace */
>>   	val |= HISI_PTT_TRACE_CTRL_EN;
>>   	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);

