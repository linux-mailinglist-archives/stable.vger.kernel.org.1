Return-Path: <stable+bounces-249191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECrqDUq0Cmpx5wQAu9opvQ
	(envelope-from <stable+bounces-249191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:40:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9879D566D1C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00E7230285E8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 06:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7203A3CBE95;
	Mon, 18 May 2026 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZZekhNhU"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18A3B9DBC;
	Mon, 18 May 2026 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086100; cv=none; b=dawziUonkyquqhgfLJp2OIJLQLJ7EwBjL6CiE1JDVDN1QHC7f4iYYmBs7Gw/zEzgIzNS4fj3XzPaSb9FuziIT54Mt15vAP0+IXLUsRXZcxHAeQHmhCiaOjGSn2A0k2wO45x6kKrKCdaIP6WwrPQ6Jg/0sq7kaTB0YhFILgVyeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086100; c=relaxed/simple;
	bh=sibF+s6I00NkiIexv5eillM53CQ4gPHCtUOHSkRX6/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HcOfdJlIupTmOTx3H5ermlSmnzrwFaMgB21o9mgo1w+lKWwZVqqdb63B5Q+HKPffr2GzRIBjnWOuOOkI5lc4nVBBbpJJjAS2bZ7qUWxWe6RLddUQmxF862ZX+Tb2XUxtQPnEKmx27l+XY6w/d0H5XIE+KSnF+FcDqJPvnc/gs30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZZekhNhU; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RiBiEJoGO8e+ET2Ji/6JNkgdquRadWqYFE6AePCfdvc=;
	b=ZZekhNhUzccfldwRZ1g4HTnF4cTQ7Sdid/wIe36HPbSYlfrs44ibdiY5rDzW6bW+iHuz7lt/f
	kZcNRLZAKuQrPhnP7G5Y9AuSD28hTKVvUqlrEvcCqj36tNmIKuOjhIS/zyOlRG/NhMbLF/E9yEY
	orqev7hPaTM0e6/izgAYgfU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gJns26ppzz1prKB;
	Mon, 18 May 2026 14:27:02 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 8603440571;
	Mon, 18 May 2026 14:34:45 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 May 2026 14:34:44 +0800
Message-ID: <a462e95c-6aad-4d70-8499-3aa5f090f0a2@huawei.com>
Date: Mon, 18 May 2026 14:34:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/6] mptcp: pm: fix ADD_ADDR timer infinite retry
 on option space insufficient
To: Matthieu Baerts <matttbe@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mptcp@lists.linux.dev"
	<mptcp@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Eric Dumazet <edumaze@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Mat Martineau
	<martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "weiyongjun (A)"
	<weiyongjun1@huawei.com>, yuehaibing <yuehaibing@huawei.com>, zhangchangzhong
	<zhangchangzhong@huawei.com>
References: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
 <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-2-701e96419f2f@kernel.org>
 <85b89125-57f2-43ab-a834-4dca56881e26@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <85b89125-57f2-43ab-a834-4dca56881e26@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Rspamd-Queue-Id: 9879D566D1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-249191-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action

Hi, Matt

On 5/17/2026 1:50 PM, Matthieu Baerts wrote:
> Hello,
> 
> On 15/05/2026 06:27, Matthieu Baerts (NGI0) wrote:
>> From: Li Xiasong <lixiasong1@huawei.com>
>>
>> When TCP option space is insufficient (e.g., when sending ADD_ADDR with an
>> IPv6 address and port while tcp_timestamps is enabled), the original code
>> jumped to out_unlock without clearing the addr_signal flag. This caused
>> mptcp_pm_add_timer to keep rescheduling indefinitely, not sending ADD_ADDR,
>> preventing subsequent addresses in the endpoint list from being announced.
> 
> (...)
> 
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 3c152bf66cd5..3e770c7407e1 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
> 
> (...)
> 
>> @@ -414,8 +420,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>>  	/* Note: entry might have been removed by another thread.
>>  	 * We hold rcu_read_lock() to ensure it is not freed under us.
>>  	 */
>> -	if (stop_timer)
>> -		sk_stop_timer_sync(sk, &entry->add_timer);
> FYI, sashiko found a pre-existing issue here, but I guess that's not
> blocking this series.
> 
> https://sashiko.dev/#/patchset/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f%40kernel.org
> 
> @Li: just to know what I do with this pre-existing issue, do you plan to
> look at it?
> 
> Just in case, I just opened:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/issues/623
> 

Thanks for the heads-up. I’ll take a look at #623 separately and follow up
there.

Best regards,
Li Xiasong

