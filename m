Return-Path: <stable+bounces-61770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6A93C6FA
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE2B22838
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671019CD00;
	Thu, 25 Jul 2024 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tYPAk0tg"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994812B7F
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923706; cv=none; b=ZfxvWDmDvLoklWzm4TO2CP2d99mXhFMWk/BCGQnELgX4nKBsmZxlfiBYjTXF0jIOLphyvSLD+6VAWFePS8aftYqqAtdDNb+BCOJC5zPCzisgLdsnaWkylI2oG6B8PDOn//j1Gpz3M2qlUvTKYRTsY6lZRAAEPwjofh5BCTI+etY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923706; c=relaxed/simple;
	bh=zGk+1XDq2wqVxMFLUkFJM91275nw/uBVg9OBmF76kNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbrJc9m0Ns7NkxhCyj+qCcanRscypFKrlPUaKd/OeUm0RP26E9Atwx8xnK7+QZIXv+aY8SgTL0eDZXkT3OzL7f9aLHCG0HZeaXZXgCsWf5lno1lPmjB8UadlZOjqp8Z6ZjvvJ+DSds0k/bea4abqrQentBKHjHoHdJxE8fjWSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=tYPAk0tg; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id Wk1jsluHPvH7lX10ysUBfZ; Thu, 25 Jul 2024 16:08:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id X10xszbFu0vWTX10xs9fJa; Thu, 25 Jul 2024 16:08:23 +0000
X-Authority-Analysis: v=2.4 cv=ffZmyFQF c=1 sm=1 tr=0 ts=66a27877
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8
 a=tHr-hho-vk9zPFA4eZwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=buJP51TR1BpY-zbLSsyS:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KBkEHGbAoyAOBlt8vAmVxu6TclGwAJORdtaRDvbXo/I=; b=tYPAk0tgaOliMlJklLrwbRDPGv
	BLI9sYFFGe2Ps6FcYPbBKw/WjZ3W/5s4jtxsdrczCkSwGl6B/8trTWEIDP1NuUwOW2h0x16E/vB2/
	VzF27mF4rrQ2P7DLJWpo3Yr89syBm+gvMCEcD+tSCTKjiFkcMU5V5Rg4I8PFKAOR519OottJgOdxs
	LbGYfYeRolApx+KBDvUDy3LusYKaIur93KSCpN0xA02QW41rNl3ts+BUbj/BkzvcN4ysfzXUJVphK
	Kq/LFpfJWIlvXQnaOZcAvvkmqT2iIgeqCsflfQTpt7FFx07PF/8sCnrt0PoWnc5MBUp2RbY3s/wSF
	9zijrwUg==;
Received: from [201.172.173.139] (port=34306 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sX10w-002wVj-2L;
	Thu, 25 Jul 2024 11:08:22 -0500
Message-ID: <94600ca4-47ce-4993-b6ce-dabb93ef01dc@embeddedor.com>
Date: Thu, 25 Jul 2024 10:08:21 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header
 for CIP_NO_HEADER case
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
Cc: stable@vger.kernel.org, Edmund Raile <edmund.raile@proton.me>
References: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
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
X-Exim-ID: 1sX10w-002wVj-2L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:34306
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO4W62mfi3p3CWsXbjybefsdLTQlp00KnpPLX/Ap5NQ8Chexx0b94vPPV6ClyCXC/jjkpKltg0K4/bssF3SHRXrhV723vaQfFMpm4cM6fhvtLVYjnEMM
 sPvJanJSinyr/czGMwHfZB3ekFmFdbQw3U7acmCHIZneJ7nGInixlRnW8Gg+vDmAa94KdxuzV7+VIJejbKn9ffoYLMEp2QR8i2I=



On 25/07/24 09:56, Takashi Sakamoto wrote:
> In a commit 1d717123bb1a ("ALSA: firewire-lib: Avoid
> -Wflex-array-member-not-at-end warning"), DEFINE_FLEX() macro was used to
> handle variable length of array for header field in struct fw_iso_packet
> structure. The usage of macro has a side effect that the designated
> initializer assigns the count of array to the given field. Therefore
> CIP_HEADER_QUADLETS (=2) is assigned to struct fw_iso_packet.header,
> while the original designated initializer assigns zero to all fields.
> 
> With CIP_NO_HEADER flag, the change causes invalid length of header in
> isochronous packet for 1394 OHCI IT context. This bug affects all of
> devices supported by ALSA fireface driver; RME Fireface 400, 800, UCX, UFX,
> and 802.
> 
> This commit fixes the bug by replacing it with the alternative version of
> macro which corresponds no initializer.

This change is incomplete. The patch I mention here[1] should also be applied.

BTW, there is one more line that should probably be changed in `struct fw_iso_packet`
to avoid further confusions:

-       u16 payload_length;     /* Length of indirect payload           */
+       u16 payload_length;     /* Size of indirect payload             */

Thanks
--
Gustavo

[1] https://lore.kernel.org/linux-sound/dabb394e-6c85-45a0-bc06-7a45262a9a8c@embeddedor.com/T/#m0b9b0e7dd4561dc58422cf15df2dbd2ddb44b54b

> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1d717123bb1a ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning")
> Reported-by: Edmund Raile <edmund.raile@proton.me>
> Closes: https://lore.kernel.org/r/rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2/
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>   sound/firewire/amdtp-stream.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
> index d35d0a420ee0..1a163bbcabd7 100644
> --- a/sound/firewire/amdtp-stream.c
> +++ b/sound/firewire/amdtp-stream.c
> @@ -1180,8 +1180,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
>   		(void)fw_card_read_cycle_time(fw_parent_device(s->unit)->card, &curr_cycle_time);
>   
>   	for (i = 0; i < packets; ++i) {
> -		DEFINE_FLEX(struct fw_iso_packet, template, header,
> -			    header_length, CIP_HEADER_QUADLETS);
> +		DEFINE_RAW_FLEX(struct fw_iso_packet, template, header, CIP_HEADER_QUADLETS);
>   		bool sched_irq = false;
>   
>   		build_it_pkt_header(s, desc->cycle, template, pkt_header_length,

