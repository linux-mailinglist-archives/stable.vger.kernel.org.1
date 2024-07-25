Return-Path: <stable+bounces-61772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5C93C70E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AB7282100
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A266019D884;
	Thu, 25 Jul 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yePh+o2O"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FF17588
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924201; cv=none; b=bWzE6wggpTbZpFvzrMjLCGOa7FIhFptTByyxGGSgE+x3udNxkJQdh48RxkiAdt4ZhZ9t/ui12LUBbv462H42mHP+k6l/dWvGUIHJBqkllN5Dol+Hld3/zc0pfYdPRhC4szwFd/SLabmcMskYH9yOLjBdCgJ4qNbzcRVTdyEvhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924201; c=relaxed/simple;
	bh=K10B7iAO/dU5cYuTh3N0B2K3iZWnuF93LF3SmUkw8z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt6sXx9NykPe3YlF9wo+rbzVJIV2nImo+IQ3oubj+HafmpwuREKHZSwLbGib90+9K6+QUhQZw4Keykr79Y8do4JsVYoG2WkS2pO6Gk0q1DOLSTDwba0eI4kz1IgLse1r/2D9ca18tGkUGwEblV+C0bSe/vanae/bRvKAw55UbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=yePh+o2O; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id X0x5sHuKFnNFGX18wsNXeP; Thu, 25 Jul 2024 16:16:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id X18vswktf5D6dX18vslA2a; Thu, 25 Jul 2024 16:16:38 +0000
X-Authority-Analysis: v=2.4 cv=I6GuR8gg c=1 sm=1 tr=0 ts=66a27a66
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8
 a=11oPMboGJFEner-CIUgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=buJP51TR1BpY-zbLSsyS:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2nEZltKz7WxwmvGZlW+BjvoRkplNOXd/CRYqwOoDRFY=; b=yePh+o2Ouq1fQrZwZfHr2zyJpx
	9/2S/LbmRol789UAeB61tKlLohttT9vH/ekANXvPuE/L5i12s7j2shfUyEJmnk2k1LBMau5oPadVK
	NNEdubrnZzhBF9KpWk5cq9dLvHc0zqLbEu8FgTcU/eHPiGyfxz0DOf8T7skIp9thAfTDh/LIKNSv8
	mvcROjvllg87mOa3DSX3NGenPbQ0SQ9UPousdsg3exmgNXi1o8FiVuiJ96PT9aed0OSAO3JO2CklF
	IC4d6jZq5Tr9D+gZVJqbwuF33SP/kCM5bB6aXDR05PbetfwmGL51sOe9Z4O04sNTYwz2cr79kf+1t
	C9ihDbGw==;
Received: from [201.172.173.139] (port=38606 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sX18v-00358S-0N;
	Thu, 25 Jul 2024 11:16:37 -0500
Message-ID: <9d039b39-06c1-4328-bd5b-8b2c757ee438@embeddedor.com>
Date: Thu, 25 Jul 2024 10:16:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header
 for CIP_NO_HEADER case
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>, stable@vger.kernel.org,
 Edmund Raile <edmund.raile@proton.me>
References: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
 <94600ca4-47ce-4993-b6ce-dabb93ef01dc@embeddedor.com>
 <877cd9ih8l.wl-tiwai@suse.de>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <877cd9ih8l.wl-tiwai@suse.de>
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
X-Exim-ID: 1sX18v-00358S-0N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:38606
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMidm8u1kgpIHUJxxycC3w9QB1njxbtISflIEGK4koSlpI5Hrwt4lqYsrcYePRk7sfLm02iMXNCsG/zZRhUSSIm2WlWqfo7dgPgaL5qJBSy3uY3+sZgl
 3bxq+Vx9y6aGMOgXXvcE8JbELtqm+JJV9UaunT3A8Vk6ctdOBkGZ7Uw3kIit5bOnIB8kBCB5pyJwARZjIkpDpGOYgW7FpxJxs8A=



On 25/07/24 10:11, Takashi Iwai wrote:
> On Thu, 25 Jul 2024 18:08:21 +0200,
> Gustavo A. R. Silva wrote:
>>
>>
>>
>> On 25/07/24 09:56, Takashi Sakamoto wrote:
>>> In a commit 1d717123bb1a ("ALSA: firewire-lib: Avoid
>>> -Wflex-array-member-not-at-end warning"), DEFINE_FLEX() macro was used to
>>> handle variable length of array for header field in struct fw_iso_packet
>>> structure. The usage of macro has a side effect that the designated
>>> initializer assigns the count of array to the given field. Therefore
>>> CIP_HEADER_QUADLETS (=2) is assigned to struct fw_iso_packet.header,
>>> while the original designated initializer assigns zero to all fields.
>>>
>>> With CIP_NO_HEADER flag, the change causes invalid length of header in
>>> isochronous packet for 1394 OHCI IT context. This bug affects all of
>>> devices supported by ALSA fireface driver; RME Fireface 400, 800, UCX, UFX,
>>> and 802.
>>>
>>> This commit fixes the bug by replacing it with the alternative version of
>>> macro which corresponds no initializer.
>>
>> This change is incomplete. The patch I mention here[1] should also be applied.
> 
> Yes, but this can be fixed by another patch, right?

Yes, but why have two separate patches when the root cause can be addressed by
a single one, which will prevent other potential issues from occurring?

The main issue in this case is the __counted_by() annotation. The DEFINE_FLEX()
bug was a consequence.

--
Gustavo

> At least the regression introduced by the given commit can be fixed by
> that.  The other fix can go through Sakamoto-san's firewire tree
> individually.
> 
> 
> thanks,
> 
> Takashi
> 
>> BTW, there is one more line that should probably be changed in `struct fw_iso_packet`
>> to avoid further confusions:
>>
>> -       u16 payload_length;     /* Length of indirect payload           */
>> +       u16 payload_length;     /* Size of indirect payload             */
>>
>> Thanks
>> --
>> Gustavo
>>
>> [1] https://lore.kernel.org/linux-sound/dabb394e-6c85-45a0-bc06-7a45262a9a8c@embeddedor.com/T/#m0b9b0e7dd4561dc58422cf15df2dbd2ddb44b54b
>>
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 1d717123bb1a ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning")
>>> Reported-by: Edmund Raile <edmund.raile@proton.me>
>>> Closes: https://lore.kernel.org/r/rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2/
>>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>> ---
>>>    sound/firewire/amdtp-stream.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
>>> index d35d0a420ee0..1a163bbcabd7 100644
>>> --- a/sound/firewire/amdtp-stream.c
>>> +++ b/sound/firewire/amdtp-stream.c
>>> @@ -1180,8 +1180,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
>>>    		(void)fw_card_read_cycle_time(fw_parent_device(s->unit)->card, &curr_cycle_time);
>>>      	for (i = 0; i < packets; ++i) {
>>> -		DEFINE_FLEX(struct fw_iso_packet, template, header,
>>> -			    header_length, CIP_HEADER_QUADLETS);
>>> +		DEFINE_RAW_FLEX(struct fw_iso_packet, template, header, CIP_HEADER_QUADLETS);
>>>    		bool sched_irq = false;
>>>      		build_it_pkt_header(s, desc->cycle, template,
>>> pkt_header_length,

