Return-Path: <stable+bounces-146443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B4FAC5123
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437751BA1CB6
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B9C27990D;
	Tue, 27 May 2025 14:44:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED698279784;
	Tue, 27 May 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357063; cv=none; b=AKQboBMtdgGXEe8+W9Z4vyyAuPDHKNvWb53UX+uAHXIb+oJ8V9eZWPQ4yUuwZQkcZ65ojz3Ch/nGksm9Bszfgvov4IJxF21hKwLzpPyBC2WdC2i4S1yE/NYdvSxX+9ggEPuqN753FkKLgrAEmITDR6fQnoZHZLmAecpXf0z1izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357063; c=relaxed/simple;
	bh=hz3Joq1a64C61g0VvccWACRwidc8dzga+FzFmgtuxhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apFTk4dfL+k6ZxZB485HcVTNttYqxUS/zE+FSp1giSMgX/O06jmbIFeH2zKcCXObQQKWjBF1nFBq1Dad69bHLLlbsKzN1+LaRAMgli/raCdDb/+GCaAIksZA+xG99Y2mMVzHu4FtkhYzs8NRDuuv5c5xfLZjbnP4EHoM94Lptis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 65C8A61E6478F;
	Tue, 27 May 2025 16:43:23 +0200 (CEST)
Message-ID: <7eed2cf1-5d54-4669-9e31-96707a116f01@molgen.mpg.de>
Date: Tue, 27 May 2025 16:43:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] e1000e: fix heap overflow in
 e1000_set_eeprom()
To: Mikael Wessel <post@mikaelkw.online>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 torvalds@linuxfoundation.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, security@kernel.org, stable@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org
References: <20250527085612.11354-1-post@mikaelkw.online>
 <20250527085612.11354-2-post@mikaelkw.online>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250527085612.11354-2-post@mikaelkw.online>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mikael,


Thank you for your patch.

Am 27.05.25 um 10:56 schrieb Mikael Wessel:
> The ETHTOOL_SETEEPROM ioctl copies user data into a kmalloc'ed buffer
> without validating eeprom->len and eeprom->offset.  A CAP_NET_ADMIN
> user can overflow the heap and crash the kernel or gain code execution.
> 
> Validate length and offset before memcpy().
> 
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
> Reported-by: Mikael Wessel <post@mikaelkw.online>
> Signed-off-by: Mikael Wessel <post@mikaelkw.online>
> Cc: stable@vger.kernel.org
> ---
>   drivers/net/ethernet/intel/e1000e/ethtool.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 9364bc2b4eb1..98e541e39730 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -596,6 +596,9 @@ static int e1000_set_eeprom(struct net_device *netdev,
>   	for (i = 0; i < last_word - first_word + 1; i++)
>   		le16_to_cpus(&eeprom_buff[i]);
>   
> +        if (eeprom->len > max_len ||
> +            eeprom->offset > max_len - eeprom->len)
> +                return -EINVAL;

I think you used spaces instead of tabs for indentation. It’d be great 
if you could fix this, and send v3 tomorrow. Running 
`scripts/checkpatch.pl` with the patch as an argument, should catch 
these things.

>   	memcpy(ptr, bytes, eeprom->len);
>   
>   	for (i = 0; i < last_word - first_word + 1; i++)


Kind regards,

Paul

