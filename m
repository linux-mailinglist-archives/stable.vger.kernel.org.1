Return-Path: <stable+bounces-249898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFjsErKhDWou0gUAu9opvQ
	(envelope-from <stable+bounces-249898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:57:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E484558D191
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1CA2303B265
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54E3DB325;
	Wed, 20 May 2026 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="w73AAFVO"
X-Original-To: stable@vger.kernel.org
Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B313DA5B6
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277948; cv=none; b=U2Aje+ePnFT85zvJf+6CTxqlbzPTm7y+bvdt5WANOUF14sTZZyngfKJHgXval5FDPn+0RdRWfO0hPykXZiWZtQo7QZnw80bWNUh1G9ZmPe9+Cakak0ra7Y/sQcuEcyHODSWj3IH2lFGxrV3Wvh2mWTs6OJomcle9CcC/I7n4IrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277948; c=relaxed/simple;
	bh=el2S41k3GjeBKjh+RQ5L4OpI+yWKBeBtdSZabeCtW8Y=;
	h=Message-Id:References:To:Subject:From:Date:Mime-Version:
	 Content-Type:In-Reply-To:Cc; b=rkpfJm8vnDoiYS3+1m8a1JkFTgM1dNZICaZeW5R+9Y669jAtfySvlA4sOITbkmZyGIVSGuCPoQDOgcZ28HRlAofP449dNUELM5FH2cOYuV64nM4tAhGi3+MIUlQHpnZD1tObVcSuFGTzboARWZBgvGuKeKpbrI4GSnksprr3pDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=w73AAFVO; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1779277926;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=3rje/RVr9F/WYxVvH0rv+/8EnZZIxtzmuyeWBNC/yD0=;
 b=w73AAFVO083UzbIM748ihwcB0h7oo7bG42j36QYWhTal2xYRkzCNkj31yVsuXug9wIlGVn
 fFd7O4HydFwO7uPQBTfsAHKMESUE/kMIOGDBZODcdGSWA5WkAX5wt01wrivrJbZA0TsqAE
 74MCfgqaVG0JskFvS5nO6PZZjAcz4gofG8wlVXmJyAkWJ0n3Rzd1TsmcqGU2kHt4+Gc8Tp
 LH7e8duo8QCsLXLmo5utqwPRr4KBuIxWVxnWdGx2n/+LzADZJNxNRyunQvdYqaWtyRE0i4
 Mh1XUG9lMd+kzzBaj3LLKEm0PKxRlcrBm0IasqAS7rR0qnoFHXrbWEC8DWvcqQ==
X-Original-From: Yu Kuai <yukuai@fygo.com>
Content-Language: en-US
Message-Id: <6224b47c-9a7e-4bbf-90ce-4b98691ceaa3@fygo.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a0da064+a445ef+vger.kernel.org+yukuai@fnnas.com>
References: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com> <beca1657-0180-4f9b-8de1-ca7776c9614a@fnnas.com> <CAHYQsXRN6uof4yyDR6qGteQ=wZTt86VUx7km6k=LbNAQ3wxGiQ@mail.gmail.com> <282278bc-7d71-4049-89f4-a9f3968504dd@fnnas.com> <CAHYQsXQhTn905RGCrw-qeb--VHsRGR2KEWm5X0ZJEW+krTJaNA@mail.gmail.com>
Received: from [192.168.1.104] ([39.182.0.188]) by smtp.feishu.cn with ESMTPS; Wed, 20 May 2026 19:52:03 +0800
To: "Yuhao Jiang" <danisjiang@gmail.com>, <yukuai@fnnas.com>
Subject: Re: [PATCH] md/raid10: fix divide-by-zero in setup_geo() with zero far_copies
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Wed, 20 May 2026 19:52:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAHYQsXQhTn905RGCrw-qeb--VHsRGR2KEWm5X0ZJEW+krTJaNA@mail.gmail.com>
Reply-To: yukuai@fygo.com
Cc: "Junrui Luo" <moonafterrain@outlook.com>, "Song Liu" <song@kernel.org>, 
	"Li Nan" <linan122@huawei.com>, "NeilBrown" <neil@brown.name>, 
	"Jonathan Brassow" <jbrassow@redhat.com>, <linux-raid@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	FREEMAIL_TO(0.00)[gmail.com,fnnas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249898-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[outlook.com,kernel.org,huawei.com,brown.name,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[yukuai@fygo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fnnas-com.20200927.dkim.feishu.cn:dkim,outlook.com:email,fnnas.com:email,fygo.com:mid,fygo.com:replyto]
X-Rspamd-Queue-Id: E484558D191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

=E5=9C=A8 2026/4/28 16:37, Yuhao Jiang =E5=86=99=E9=81=93:
> Hi Kuai,
>
> Looks like different maintainers have different rules. :(
> Can you send me the patchwork resource?

Usually just a link to lore url is enough.

>
> Thanks.
>
> On Tue, Apr 28, 2026 at 4:32=E2=80=AFPM Yu Kuai <yukuai@fnnas.com> wrote:
>> Hi,
>>
>> =E5=9C=A8 2026/4/19 13:59, Yuhao Jiang =E5=86=99=E9=81=93:
>>> Hi Kuai,
>>>
>>> This report was reported by me, so Junrui added me as Reported-by.
>> This is fine, however, please do not add downstream reported-by tag.
>> If you want to add the reported-by tag, please report the problem to
>> patchwork first. :)
>>
>>> Thanks,
>>>
>>> On Sun, Apr 19, 2026 at 12:43=E2=80=AFAM Yu Kuai <yukuai@fnnas.com> wro=
te:
>>>
>>>      Hi,
>>>
>>>      =E5=9C=A8 2026/4/16 11:39, Junrui Luo =E5=86=99=E9=81=93:
>>>      > setup_geo() extracts near_copies (nc) and far_copies (fc) from t=
he
>>>      > user-provided layout parameter without checking for zero. When f=
c=3D0
>>>      > with the "improved" far set layout selected, 'geo->far_set_size =
=3D
>>>      > disks / fc' triggers a divide-by-zero.
>>>      >
>>>      > Validate nc and fc immediately after extraction, returning -1 if
>>>      > either is zero.
>>>      >
>>>      > Fixes: 475901aff158 ("MD RAID10: Improve redundancy for 'far'
>>>      and 'offset' algorithms (part 1)")
>>>      > Reported-by: Yuhao Jiang<danisjiang@gmail.com>
>>>
>>>      So again I can't find a report, and Reported-by usually should be
>>>      followed
>>>      by a Closes link to the original report.
>>>
>>>      Applied with Reported-by tag removed.
>>>
>>>      > Cc:stable@vger.kernel.org <mailto:Cc%3Astable@vger.kernel.org>
>>>      > Signed-off-by: Junrui Luo<moonafterrain@outlook.com>
>>>      > ---
>>>      >   drivers/md/raid10.c | 2 ++
>>>      >   1 file changed, 2 insertions(+)
>>>
>>>      --
>>>      Thansk,
>>>      Kuai
>>>
>>>
>>>
>>> --
>>> Yuhao Jiang
>> --
>> Thansk,
>> Kuai
>
>
--=20
Thansk,
Kuai

