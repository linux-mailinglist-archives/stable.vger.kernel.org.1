Return-Path: <stable+bounces-244810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JO1IQ01/mnYnwAAu9opvQ
	(envelope-from <stable+bounces-244810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:10:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2328C4FAFAE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 21:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33668305BE88
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F92C3CCFA8;
	Fri,  8 May 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="lZE1OKml"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CED3783C6
	for <stable@vger.kernel.org>; Fri,  8 May 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267335; cv=none; b=jVKhOxttCmGzIuvQpxJDSrDDTDDqmk3DKE/GH4fX7fVryer7tIcPteHFrUXeGJ3M7kS/JpumaEBCovPza2bMEf/De8jyXrz2gANrIp3kr+Ha568aktXQF1InaMLXIllIbSgxG3Nu5jCXF8gaiHbyNRvtsrDtfF3RfP0Ursg44BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267335; c=relaxed/simple;
	bh=dHqbDz+QQ5BQjxxoqqdjxkptKnCx0juEhtkkEmz8g30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRNsxon2zWSVrKh1ZE1elBx3Oo6/BWHAaGAu9HP5t58YbZsWVsZUZpKSmuPl1d7wPDAB9XvC2VlV3xSUTw7pv2e9h1MjPrCQawoZJkKZ0Giyz9KcAjS4Nf63nJlQoQV62nZ9A0Nm5odkmVaoyuSxYAhT5a7z9iPX1V4o1buLfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=lZE1OKml; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id LNCswd7Otnwj2LQZ5wrwNS; Fri, 08 May 2026 19:08:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id LQWdwLOqxrFQpLQWewBci6; Fri, 08 May 2026 19:06:16 +0000
X-Authority-Analysis: v=2.4 cv=bqFMBFai c=1 sm=1 tr=0 ts=69fe3428
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=7vwVE5O1G3EA:10 a=ag1SF4gXAAAA:8
 a=sgGi2oMhMTPHD_uuIsQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tshay6nRwiV+vcSCbLh817UOpSD3/f9QDkM8OdCaNOU=; b=lZE1OKmlrWz5pGb8PhUN057Soe
	oBAsuMrEFnCoS7fKKJSzWyE1Ogh/FuKII46p0gXV408u0uROsz/87a0TPe9PZ3GjMgLhEYAh6Ub6O
	F1+mIIpBcrBrXqDuqt7+T/g3+Z7Fx1kP/tqBre9huOwpvSPgCoxMy7HR7zi2uKwxb7gUw1yWa4qVm
	MBrjwgReuao6DF3+nQY7TgQNya9Ug2rzGLCFEdRDkZLDwOXC4RTslYJphTavp+BZY2vFStdoSyf2m
	yoqPpmVwar04CxryfJIKAasIAnaMpwW7RFyqwPlCn4rwSoT/p4bfKBQOg6rqmdi74m5fjJYFCDlen
	E8m2AHlQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:60558 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <re@w6rz.net>)
	id 1wLQWc-00000001sxc-31Db;
	Fri, 08 May 2026 13:06:14 -0600
Message-ID: <f922379b-e8a6-4d38-9589-029a8d52126d@w6rz.net>
Date: Fri, 8 May 2026 12:06:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 5.15.205
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Ben Hutchings <benh@debian.org>
Cc: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>,
 Dominik Grzegorzek <dominik.grzegorzek@oracle.com>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "lwn@lwn.net" <lwn@lwn.net>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "jslaby@suse.cz" <jslaby@suse.cz>
References: <2026050835-appealing-stallion-a207@gregkh>
 <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
 <2026050829-gladiator-displease-57af@gregkh>
 <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
 <2026050855-valley-slashed-c382@gregkh>
 <CALUEkOfBS7qsN-7ERMS+2wcPEixXAGmquREu7uv8ecXn6d7haw@mail.gmail.com>
 <2026050815-length-yummy-f8b6@gregkh>
 <036ef29e143799f9117792463d640916490fa61a.camel@debian.org>
 <2026050840-washcloth-showdown-b66f@gregkh>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <2026050840-washcloth-showdown-b66f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1wLQWc-00000001sxc-31Db
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:60558
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHRESJMcgljee5yReBT/LCBk4phcanM77K9yZ+imHYp4XtN67MChNxotZYZQK0M/fzjqxrRJhWR43hZSbV9dA2Dt492NXqzcYLwnGfDD0GEttPEx72gH
 iauwSvKoANJNhTkNWKHwGThCeytWDrJi83rU1boWnrmzgzn0ooUd+MklFiTEdxR6NrhL69SWm/YwiA==
X-Rspamd-Queue-Id: 2328C4FAFAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244810-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,lwn.net,vger.kernel.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_X_SOURCE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_X_ANTIABUSE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.995];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,w6rz.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/8/26 07:50, gregkh@linuxfoundation.org wrote:
> On Fri, May 08, 2026 at 04:38:45PM +0200, Ben Hutchings wrote:
>> On Fri, 2026-05-08 at 16:30 +0200, gregkh@linuxfoundation.org wrote:
>>> On Fri, May 08, 2026 at 04:07:31PM +0200, Massimiliano Pellizzer wrote:
>>>> On Fri, May 8, 2026 at 3:50 PM gregkh@linuxfoundation.org
>>>> <gregkh@linuxfoundation.org> wrote:
>>>>> On Fri, May 08, 2026 at 03:13:51PM +0200, Massimiliano Pellizzer wrote:
>>>>>> On Fri, May 8, 2026 at 2:44 PM gregkh@linuxfoundation.org
>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>> On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I may be mistaken, but I think there might be a small typo in this hunk in net/ipv4/ip_output.c:
>>>>>>>>
>>>>>>>> skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
>>>>>>>>
>>>>>>>> Would this need to be:
>>>>>>>>
>>>>>>>> skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
>>>>>>>>
>>>>>>>> My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shared_info->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.
>>>>>>> Adding Ben who did the 5.10 backport so he can comment on this.
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> greg k-h
>>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> The new released kernel 5.15.205 is still vulnerable to CVE-2026-43284.
>>>>>>
>>>>>> ```
>>>>>> $ ./run.sh
>>>>>> === Stage 1 — overwrite 'systemd-timesync' line (89 bytes) with
>>>>>> 'sick::0:0:<pad>:/:/bin/bash'
>>>>>> === Stage 2 — verify
>>>>>> sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX:/:/bin/bash
>>>>>> === Stage 3 — su - sick (empty password via PAM nullok)
>>>>>> [i] state saved to /var/tmp/.cf2.state — run './run.sh --clean' to revert
>>>>>> # uname -r
>>>>>> 5.15.205
>>>>>> ```
>>>>>>
>>>>> Does the patch below fix this up?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>>>
>>>>> ------------------
>>>>>
>>>>>
>>>>> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
>>>>> index 68509e1f89b5..5d8f8a5901bc 100644
>>>>> --- a/net/ipv4/ip_output.c
>>>>> +++ b/net/ipv4/ip_output.c
>>>>> @@ -1443,7 +1443,7 @@ ssize_t   ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
>>>>>                          goto error;
>>>>>                  }
>>>>>
>>>>> -               skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
>>>>> +               skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
>>>>>
>>>>>                  if (skb->ip_summed == CHECKSUM_NONE) {
>>>>>                          __wsum csum;
>>>> Yes, this works.
>>> Wait, is this also needed in the 6.1.y backport as well?
>>>
>>> Ben, I'm guessing you tested the 6.1.y backport, right?
>> Yes, but on 6.1 the PoC never succeeded for me even without the patch.
>> (On 5.10 and 6.12 it does.)  So unfortunately that testing could not
>> show whether my attempted fix was correct.
>>
>> Sorry for screwing this one up.
> Not a problem, thanks for doing the backport at all!  I'll go do a new
> 6.1.y release now.
>
> Releases for everyone!!!
>
> thanks,
>
> greg k-h
>
Doesn't 5.10.255 need the flag fixup too?


