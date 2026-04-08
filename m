Return-Path: <stable+bounces-233765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPODNcT11Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:29:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 831DB3B78F7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D722301F998
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DE83644CF;
	Wed,  8 Apr 2026 06:25:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9434677F;
	Wed,  8 Apr 2026 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629549; cv=none; b=eIbpckben6g10iwttrmY/wHimQlozOa+3wdjDiXZd2E17+q3tcS1N8/QjA80VP3SyZe3VLupE+6tQJIZAyaWMGAAD38XKeTDmgev6252gjcOhArLzL00PAzSWDWHMXqD49dWHIP+ZFVKrHVzPWWolYH4V1iT9XA+LfaNZjy+AB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629549; c=relaxed/simple;
	bh=CiemxFLK0FrFTeBc/H2ciQYSwVU6DVeQ/QRqF9l+Ea0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWcAlHilaLmq3XfRfkeydNlSFBSZmw3O3rxCqpTNUdWMUmGzy7iAKsx9e9yOMNybKreXZJlzTv8rdGEeydCtLVfn2epTdXUHEuotBYyK/r779RvYzijUj1IQwzNfWhrxzU8Lad+sy9wXIrMKE1ncrfe0+Z0tQnxkaNuuRURwgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1AC894C2C37F04;
	Wed, 08 Apr 2026 08:24:36 +0200 (CEST)
Message-ID: <22f2d325-fc2a-4801-91b5-b64fac4d86e9@molgen.mpg.de>
Date: Wed, 8 Apr 2026 08:24:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix VF queue configuration
 with low MTU values
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, stable@vger.kernel.org
References: <20260406145641.1020623-1-jtornosm@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260406145641.1020623-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233765-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.373];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: 831DB3B78F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Jose,


Thank you for the patch.

Am 06.04.26 um 16:56 schrieb Jose Ignacio Tornos Martinez:
> The ice driver's VF queue configuration validation rejects
> databuffer_size values below 1024 bytes, which prevents VFs from
> using MTU values below 871 bytes.
> 
> The iavf driver calculates databuffer_size based on the MTU using:
>    databuffer_size = ALIGN(MTU + LIBETH_RX_LL_LEN, 128)
> 
> where LIBETH_RX_LL_LEN = 26 (ETH_HLEN + 2*VLAN_HLEN + ETH_FCS_LEN).
> 
> For MTU values below 871:
>    MTU 870: 870 + 26 = 896, aligned to 128 = 896 (< 1024, rejected)
>    MTU 871: 871 + 26 = 897, aligned to 128 = 1024 (>= 1024, accepted)
> 
> The 1024-byte minimum seems unnecessarily restrictive, because the hardware
> supports databuffer_size as low as 128 bytes (the alignment boundary),
> which should allow MTU values down to the standard minimum of 68 bytes.
> 
> I haven't found the reason why the limit was configured in the commit
> 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message"), so
> with no more information and since it is working, change the minimum
> databuffer_size validation from 1024 to 128 bytes to allow standard low
> MTU values while still preventing invalid configurations.

Should you resend, having the reproducer script would be nice to have.

> Fixes: 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message")
> cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>   drivers/net/ethernet/intel/ice/virt/queues.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
> index f73d5a3e83d4..31be2f76181c 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> @@ -840,7 +840,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>   
>   			if (qpi->rxq.databuffer_size != 0 &&
>   			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
> -			     qpi->rxq.databuffer_size < 1024))
> +			     qpi->rxq.databuffer_size < 128))
>   				goto error_param;
>   
>   			ring->rx_buf_len = qpi->rxq.databuffer_size;

Either way:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

