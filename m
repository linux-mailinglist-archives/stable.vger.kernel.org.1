Return-Path: <stable+bounces-61758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE793C635
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E9F1F22002
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFC519D07C;
	Thu, 25 Jul 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="V+WiK0fC"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13CFC18
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920393; cv=none; b=Cs++n90ugsNJpWheGGA6CteeuTT0RXLXLZW9V/gOLvqi3oRMXQK0ZKtI3ax+S7EOUQJCqRAAj3EOrv/DKCGvuK8urtGryQrfJ1PqM2qHZeuf79Ei6VQNGDYs4NG/XN+rQJsCGDHRtEOdEwCxXCZAmw5Wrgd0rKcfNR6m/35RLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920393; c=relaxed/simple;
	bh=jfpxbbYFjJ8ExvzR3IT78xghG+hsUwRNjV1WpX5/gAg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y2LSSi5qpeXY53l4FhdKQ1OWrk46qcV0PUMeIhihqkitMKIFkHxHLe/XFxmA+BJPgk1UO/LUGL4MQj6bvuMtXxDvjnxjd5++CeDsK6YnI06JR61TDJF5Q57h0xKLlBWoCCaZX8dtdOEv1Pz5wNNXF9qMfM4oo+7UhLJygmJ2DU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=V+WiK0fC; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id WxRhsY6zviA19X07ysAGNr; Thu, 25 Jul 2024 15:11:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id X07xsda8geCxMX07xsmDR7; Thu, 25 Jul 2024 15:11:34 +0000
X-Authority-Analysis: v=2.4 cv=M/yGKDws c=1 sm=1 tr=0 ts=66a26b26
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=_Wotqz80AAAA:8 a=CuuAIQj4GImDlpz7EX0A:9
 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4AUt86fz3WgI+nh/WYGDkaSNSWXqMKkcQrskvV/W3o4=; b=V+WiK0fCst5/snfx81Aidx2T/P
	AZOI3n0RPog6CSnpynpVac2YPs5mdHX+3OtNqQPzLh0LgySIVOiS22TtMBhnmJSfeYTkhOnQm3Ign
	fDKEmFSATP3iTn2g5AzgVMdeBBOUwhx3Be7IvI6AcF6HlmDHSD4y6dCVbH7uYVw/qH7hM5LR5OMJ9
	lfY4CdZwtd7aak4+yCurz5On8C0znXY52JFHR9DPKNjkxSHg59oehHcg6RDRDAv5ZXZPXeQIMritD
	KyxEcgTFRcetgoNIF5PMluHRlL6FUeEgTxklewidq11pAgMM1sgqJTqtx4CF4HxRQ+llQmaZemoKO
	7TmXMXEg==;
Received: from [201.172.173.139] (port=35708 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sX07w-0027tQ-35;
	Thu, 25 Jul 2024 10:11:33 -0500
Message-ID: <9135b5d8-01fe-4250-8236-e76194cd6efc@embeddedor.com>
Date: Thu, 25 Jul 2024 09:11:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ALSA: firewire-lib: heavy digital distortion with
 Fireface 800
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Takashi Iwai <tiwai@suse.de>, "edmund.raile" <edmund.raile@proton.me>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, o-takashi@sakamocchi.jp, gustavoars@kernel.org,
 clemens@ladisch.de, linux-sound@vger.kernel.org
References: <rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2>
 <87r0bhipr7.wl-tiwai@suse.de>
 <906edca8-a357-4fc2-913d-be447a86963c@embeddedor.com>
Content-Language: en-US
In-Reply-To: <906edca8-a357-4fc2-913d-be447a86963c@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sX07w-0027tQ-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:35708
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPdS1dlDVgxbDguXeafZ29b2S1YnFr3sNMvLGJlu4CpWxLTuALQwjOteAWJIPl4Ex+ZhBAeD9wNrYzEPmsV6BAFXxuXWpF/7RBHp+AxTlFvPexYIgBCP
 KJ/IicoADfz8IHKyWf6HVMGdhz5DTM8aXmWeh/AMiNbKvLCgEnJA1YaFbGphiBo7cE6qB/4NZCSIbP1af1n6Een/hAbKqDTXzXM=



On 25/07/24 08:08, Gustavo A. R. Silva wrote:
> Hi!
> 
> On 25/07/24 07:07, Takashi Iwai wrote:
>> On Thu, 25 Jul 2024 00:24:29 +0200,
>> edmund.raile wrote:
>>>
>>> Bisection revealed that the bitcrushing distortion with RME FireFace 800
>>> was caused by 1d717123bb1a7555
>>> ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning").
>>>
>>> Reverting this commit yields restoration of clear audio output.
>>> I will send in a patch reverting this commit for now, soonTM.
>>>
>>> #regzbot introduced: 1d717123bb1a7555
>>
>> While it's OK to have a quick revert, it'd be worth to investigate
>> further what broke there; the change is rather trivial, so it might be
>> something in the macro expansion or a use of flex array stuff.
>>
> 
> I wonder is there is any log that I can take a look at. That'd be really
> helpful.

OK, I found a discrepancy in how the `header_length` field in the flexible
structure (a struct that contains a flexible-array member) below is used:

include/linux/firewire.h:
458 struct fw_iso_packet {
...
465         u32 header_length:8;    /* Length of immediate header           */
466                                 /* tx: Top of 1394 isoch. data_block    */
467         u32 header[] __counted_by(header_length);
468 };

Take a look at the following piece of code:

sound/firewire/amdtp-stream.c:
1164         if (!(s->flags & CIP_NO_HEADER))
1165                 pkt_header_length = IT_PKT_HEADER_SIZE_CIP;

In the code above `pkt_header_length` is set to `IT_PKT_HEADER_SIZE_CIP`, which based
on the following macros is 8 _bytes_:

sound/firewire/amdtp-stream.c:37:#define CIP_HEADER_QUADLETS	2
sound/firewire/amdtp-stream.c:58:#define CIP_HEADER_SIZE		(sizeof(__be32) * CIP_HEADER_QUADLETS)
sound/firewire/amdtp-stream.c:72:#define IT_PKT_HEADER_SIZE_CIP		CIP_HEADER_SIZE

Then we use the DEFINE_FLEX() macro, which internally sets `template->header_length`
to `CIP_HEADER_QUADLETS`, which based on the macros above, takes the value
of 2 _elements_. We set `header_length` because such variable is the _counter_
used during the `__counted_by()` annotation in `struct fw_iso_packet`. The
_counter_ is the variable that holds the number of _elements_ in the flex-array
member at some point at run-time[1].

So, we set the counter to `CIP_HEADER_QUADLETS` because that's the total number
of _elements_ allocated for the flexible-array member `header[]` by the DEFINE_FLEX()
macro.

1183                 DEFINE_FLEX(struct fw_iso_packet, template, header,
1184                             header_length, CIP_HEADER_QUADLETS);
1185                 bool sched_irq = false;

Then we call function `build_it_pkt_header()` and pass as arguments a pointer
to `template`, and `pkt_header_length`, which at this point might hold the
value of 8 _bytes_.

1187                 build_it_pkt_header(s, desc->cycle, template, pkt_header_length,
1188                                     desc->data_blocks, desc->data_block_counter,
1189                                     desc->syt, i, curr_cycle_time);

Then inside function `build_it_pkt_header()`, the _counter_ is updated
`params->header_length = header_length;`:

  680 static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
  681                                 struct fw_iso_packet *params, unsigned int header_length,
...
  692         if (header_length > 0) {
  693                 cip_header = (__be32 *)params->header;
  694                 generate_cip_header(s, cip_header, data_block_counter, syt);
  695                 params->header_length = header_length;
  696         } else {

This causes `params->header_length == 8`; however, only enough space for 2
_elements_ was allocated for the flex array (via DEFINE_FLEX()).

So, regardless of how `pkt_header_length` is intended to be used in the rest of
the code inside `build_it_pkt_header()`, this last update to `params->header_length`
seems to be incorrect.

So, my question here is whether this `header_length` struct member was originally
intended to be used as a counter for the elements in the flex array or as size
variable to hold the total number of bytes in the array?

Based on the comment "Length of immediate header", I suppose `header_length` would
hold _elements_ not _bytes_.

Thanks
--
Gustavo

[1] https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-attribute-in-c-and-linux/

