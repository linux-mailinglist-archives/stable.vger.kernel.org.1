Return-Path: <stable+bounces-253849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH+qOfC/EGoSdQYAu9opvQ
	(envelope-from <stable+bounces-253849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:43:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C685BA266
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 22:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 535FD3011C7D
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8AF385D89;
	Fri, 22 May 2026 20:43:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880059460;
	Fri, 22 May 2026 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482595; cv=none; b=ZeWxYqjNbOOPCL7QePEjxps0nFB4SPo4rC7wFBeeR1F3VZt30loJxPy5ehuU8Gl+/R5uzchYeINi4+q9s5NYUaaMQUDzsGcXLzs9JAVzzYl9d1sVvKfPrjA1vZPV0PLLTD2MJ7otM/fqSME/3FFJTyPzDqnmxabzipl4sXLX9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482595; c=relaxed/simple;
	bh=Jd/eoRPQE2bX2yJYBhvktUv7oe+kOBGD7Y63WYZkFcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSxYo5mWuCo8GIRsUbFCdQsVupOfVzVqQO+Hkntmb21ces3cu2cakjl3Bewm3RxSwbOkmxPXoNzLWTrET6a7aPQK5VdI7j+DzxgJXzJb064CN4NDefpqgREwhjbFXfPW4jqAM5Dy+nZ4P+nw4uVYpDIPKpkBI4N19r3Wqw5abZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.0.57.170] (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CAABB4C14FAA06;
	Fri, 22 May 2026 22:42:50 +0200 (CEST)
Message-ID: <55439fa7-2057-4dd7-9651-db15bd27de3a@molgen.mpg.de>
Date: Fri, 22 May 2026 22:42:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase SSR delay for rampatch
 and NVM loading
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
 wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
 mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com>
 <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
 <CABBYNZLQ5m-24twTZaHXzi6QHqgGdvuDt1aaYwbEi0Vt=R2Dfw@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZLQ5m-24twTZaHXzi6QHqgGdvuDt1aaYwbEi0Vt=R2Dfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253849-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.795];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 90C685BA266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Luiz,


Thank you for your reply.

Am 22.05.26 um 18:22 schrieb Luiz Augusto von Dentz:

> On Fri, May 22, 2026 at 10:50 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Thank you for your patch. Please mention the delay in the summary/title.
>> Maybe:
>>
>> Use 100 ms SSR delay for rampatch and NVM loading
>>
>> Am 22.05.26 um 13:08 schrieb Shuai Zhang:
>>> When bt_en is pulled high by hardware, the host does not re-download
>>> the firmware after SSR. The controller loads the rampatch and NVM
>>> internally.
>>>
>>> On HMT chip, due to the large firmware file size, the
>>
>> Please document the size (> X MB)
>>
>>> loading process takes approximately 70ms. The previous 50ms delay is
>>> too short, causing the controller to not respond to the reset command
>>> sent by the host, which leads to BT initialization failure.
>>
>> Maybe paste the log?
>>
>>> Increase the delay to 100ms to ensure the controller has finished
>>> loading the firmware before the host sends commands.
>>
>> Why can’t it be increased to 1 s?
> 
> Why would increasing it to 1s be a good idea? Actually a _proper_
> driver should be able to detect when loading has finished, not just
> use an arbitrary timer and hope that works and the controller is
> responsive afterward.

Indeed it’s not a fail safe in this case, and that’s what my comment was 
about, that it should be explained why 100 ms is chosen, and not a 
flexible way implemented. Sorry for not being clear.

>>> Steps to reproduce:
>>> 1. Trigger SSR and wait for SSR to complete:
>>>      hcitool cmd 0x3f 0c 26
>>> 2. Run "bluetoothctl power on" and observe that BT fails to start.
>>>
>>> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>> ---
>>>    drivers/bluetooth/hci_qca.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index ed280399b..184f52f9c 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1680,8 +1680,8 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>>>                mod_timer(&qca->tx_idle_timer, jiffies +
>>>                                  msecs_to_jiffies(qca->tx_idle_delay));
>>>
>>> -             /* Controller reset completion time is 50ms */
>>> -             msleep(50);
>>> +             /* Wait for the controller to load the rampatch and NVM.*/
>>
>> Missing space at the end.
>>
>>> +             msleep(100);
>>>
>>>                clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>>>                clear_bit(QCA_IBS_DISABLED, &qca->flags);
>>
>> Is the time it took to load the rampatch and NVM visible in the logs?


Kind regards,

Paul

