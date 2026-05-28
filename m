Return-Path: <stable+bounces-255078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K/7EJWDGGp8kggAu9opvQ
	(envelope-from <stable+bounces-255078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:04:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C75F60DA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28E703021247
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40EC403EAC;
	Thu, 28 May 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="euPQv9lF"
X-Original-To: stable@vger.kernel.org
Received: from mta-201a.earthlink-vadesecure.net (mta-201a.earthlink-vadesecure.net [51.81.229.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE93403E81;
	Thu, 28 May 2026 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.229.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991442; cv=none; b=A3jYDl0SsZwJpIpiPuiGG58e7LQ6rsTJzHFqia16VybDA3APoldwdjFauWGEUtJ5ctAjFmDMLvECLV2+CU2OB0QPR4Nf15GBsox/BEIf2reZ+SNsvECbNtPZ0ETJBDRjo55q7+FSd4/tL6mQxg5YKcHhQbqF3/UorpoGONbwEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991442; c=relaxed/simple;
	bh=J7Hoa1o2DODHqzE3OMeeezgCIxEnuRlyXm9GnyWtyAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMk3YCUTtUxe/OOjFEPbR2mG/PIU37IfsND4KXZ7r8tdE/usrEwZ0GMDGpazLzo7lW+x1iH92iyHClykRFlmotoA4x25W/W+9b0w/LeclWBzuyoGJkph0EsXwZIQdPj6BumLFzGufvCvfTXzDAE/S0Kj8amhtYR6K/pzIT+LF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=euPQv9lF; arc=none smtp.client-ip=51.81.229.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
DKIM-Signature: v=1; a=rsa-sha256; bh=sREcGobRJlL/jCIYnZKmxSLOCUxI4fpeHElPx2
 Fu/uQ=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1779991092; x=1780595892; b=euPQv9lFHk+cOGJEqHBymjov7JB
 cVkRNwebRQpcGZ+vGKYwAyO6P8jFuHSFgNaw6MezmNYutYOfLNm0J2adoJhdBgPIKZbw2Oi
 NWm1ClrX4D48eIME2Y2DL1mDLBYQ/bXxnwP8LxK7TsTFXp8hJCquJHw0O0yRnFVFvk7AMeJ
 IW2uSitBmWNObZsEv89XbcaVZtFSoVIyaGR9uTjKl47vAdsgdPDCX/w89TEN+deK9AK/+ki
 EUMsrLThVPhaAykHmOUnApQEXPXWIrdvGeh+KgXjtzNQuModTFwIAK7gCoR4FrXamyZJ6vs
 qUxDBNza4flnywo9NiWV4heooOJs3Pw==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel2nmtao01p.internal.vadesecure.com with ngmta
 id 9e62da41-18b3cc741b01b10d; Thu, 28 May 2026 17:58:12 +0000
Message-ID: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
Date: Thu, 28 May 2026 10:57:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: fix netdev leak in
 i40e_vsi_setup() error paths
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Dawei Feng <dawei.feng@seu.edu.cn>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jesse.brandeburg@intel.com"
 <jesse.brandeburg@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Zilin Guan <zilin@seu.edu.cn>
References: <20260527110205.1780595-1-dawei.feng@seu.edu.cn>
 <IA3PR11MB89860869ABD5A159C01A5634E5092@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <IA3PR11MB89860869ABD5A159C01A5634E5092@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[earthlink.net:s=dk12062016];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[onemain.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255078-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[earthlink.net:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[sln@onemain.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D05C75F60DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 01:49, Loktionov, Aleksandr wrote:
>
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Dawei Feng
>> Sent: Wednesday, May 27, 2026 1:02 PM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
>> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
>> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; jesse.brandeburg@intel.com;
>> sln@onemain.com; intel-wired-lan@lists.osuosl.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> jianhao.xu@seu.edu.cn; Dawei Feng <dawei.feng@seu.edu.cn>;
>> stable@vger.kernel.org; Zilin Guan <zilin@seu.edu.cn>
>> Subject: [Intel-wired-lan] [PATCH net] i40e: fix netdev leak in
>> i40e_vsi_setup() error paths
>>
>> i40e_config_netdev() allocates vsi->netdev for main and VMDQ VSIs. If
>> i40e_netif_set_realnum_tx_rx_queues(), i40e_devlink_create_port(), or
>> register_netdev() fails, i40e_vsi_setup() goes to err_netdev without
>> releasing the netdev. The existing cleanup only frees the netdev after
>> a successful register_netdev(), so these error paths leak the
>> allocation.
>>
>> Reorder the error paths at err_netdev to ensure proper cleanup of the
>> allocated device.
>>
>> The bug was first flagged by an experimental analysis tool we are
>> developing for kernel memory-management bugs while analyzing v6.13-
>> rc1. The tool is still under development and is not yet publicly
>> available. Manual inspection confirms that the bug is still present in
>> v7.1-rc5.
>>
>> An x86_64 allyesconfig build showed no new warnings. As we do not have
>> an Intel Ethernet Controller XL710 family adapter to test with, no
>> runtime testing was able to be performed.
>>
>> Fixes: 41c445ff0f48 ("i40e: main driver core")
>> Cc: stable@vger.kernel.org
>>
>> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 6d4f9218dc68..1ced01b0cc09 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -14491,13 +14491,15 @@ struct i40e_vsi *i40e_vsi_setup(struct
>> i40e_pf *pf, u8 type,
>>   	if (vsi->netdev_registered) {
>>   		vsi->netdev_registered = false;
>>   		unregister_netdev(vsi->netdev);
>> -		free_netdev(vsi->netdev);
>> -		vsi->netdev = NULL;
>>   	}
>>   err_dl_port:
>>   	if (vsi->type == I40E_VSI_MAIN)
>>   		i40e_devlink_destroy_port(pf);
>>   err_netdev:
>> +	if (vsi->netdev) {
>> +		free_netdev(vsi->netdev);
>> +		vsi->netdev = NULL;
>> +	}
>>   	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);

Would it make sense to put these 4 lines into i40e_vsi_clear()? Then you 
can also clean up i40e_vsi_release() and i40e_vsi_reinit_setup() in a 
similar way.

sln

>>   err_vsi:
>>   	i40e_vsi_clear(vsi);
>> --
>> 2.34.1
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>


