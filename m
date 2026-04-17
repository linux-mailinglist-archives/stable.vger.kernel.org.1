Return-Path: <stable+bounces-238411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +COGF6PL4WkhyQAAu9opvQ
	(envelope-from <stable+bounces-238411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:56:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED395417331
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4CAD3086F5D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673F366072;
	Fri, 17 Apr 2026 05:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gf7gl+Yn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613ED2F5A29
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405392; cv=none; b=j95QUCit7CskdJZ/B3x83vlm2qwLVM7B3I1eKD5ICuUNGeHeneF8BQT5np5OFeDzcENUTzreeo5lVVHeJyZQYtmG1m/7ccne7ypAhZW1jSbT3PhKWeTsVL+a3cv3GfRhuS+6VEj0d4Cs9n6z31X3bT6dpZOL7PfXMSgAe0SqDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405392; c=relaxed/simple;
	bh=n1WhHEo42t+lWUW/csAqxQ/xX1NCS+1cWRNXzxDUJfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On5LkowEJm70ZpXv6IuwLPuog7Q5Fg4IGKGxVWfUJHxMIc+2lSgA640hZkXe4Jv+RxqwEbX8aee6oUIglUncO/7F8nDouEYDb40qHN2XYUr+MA4i1zGe06My/XhXi54wdskEJW+XExKDTcHx9K50FtXYVGX27r4HgAjlHK3NziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gf7gl+Yn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so293789f8f.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 22:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776405390; x=1777010190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCNwB0p4fo3KBgBAhuhSg3ltFf7brNQ1Ddfg4S9ESs8=;
        b=gf7gl+YncMi6XM38kAb4wEw2EKb2riIU3pVoRbSgPoTePm1hWHqVyn6OAPI+7eMmt/
         Ia/mte40JfPzDeLlBuavH3UbBqzhQs5euSCJsu0tyT43cnE0Q8Z9lkdaKIm1zLPDGUi4
         F3XZ3jioebSj+138mTbU2fCc4zogIC3QwJ5mCSfYNZo21Tk69320xQzaGsTTFw9L26dw
         VabFajaRCUqXorhDYMopTW+4r3OyucIpr9hCqoMBwkb8GZ4vrrpJYr5CSn28cFbyL4r+
         ts7yagBOxPNwqgOWfM+UByHVYZn/0JY/EyDuJIFjdiwHhQQGAHoIIyWeVTY7c5rL7r0R
         COog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776405390; x=1777010190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCNwB0p4fo3KBgBAhuhSg3ltFf7brNQ1Ddfg4S9ESs8=;
        b=lW+BZfIoRmIBa3Uan/hBaGT4+4a0J419tJvVw5h0CpUdG7ZeoeQ1XEh9T6DMusSaoZ
         OsfTMODXuxRkVYSirs3XFjAKqs/V3lms7bSShhhxeyw8hs4UqAN5a8Ce/KPUEkYwpn1V
         qS+0zYDFfDFeDiLlsSb5C95H9XBO1hQ764jjcX8IrlhAp6xYXyNoQSDGgdFM2MD4V+2n
         w1qaD7i81t1aErtTD1sRexjD8O7CTjUiwNE1VBPIcj2tNgxvLmEouBpoWaDkaehW1Vt0
         QwDKCW95qQVSiU7vRd2eTjmqzuO5CooBQAFfxgqRzMA2vRV0jpgBA+hbaEdoWy1NrL9j
         mtGA==
X-Gm-Message-State: AOJu0YzW27lYCLhsgzH1k0TdMr6w3XaxsZ1S1Ce5nrKie0JFlUSxpDO/
	CM055vY0qEQdLEFtmgP/965CFL6x8tdmC/4eKQSl+e84z2sOFoKkjvUBxIfniw9tqAk=
X-Gm-Gg: AeBDieutgTbqszfi3Sg8YZ+OC+Z7WaYOnN8hGjwEnxcv1yYpzGAYDigCkdQiE15+tr2
	QCjxUKmCzfRsmiVxcDcSr+mhFTbLu4/BBzz2CLXHYw6S1Ejq75gXALMRViia68OCMP4UCnZSQlB
	PmBKpPl4uay5vm8BrdMLqZcDEphidw53Xf/3NQw114caJiFIiKa97wher4Pdd/GavTXc2gL013V
	iX6zvHGCk1iDsgS/c7yHjx/zmYNiC8hrYCmuT+BfvLZhVYIH4CW2N2oqlYo3f3jgGg2Hr4DBxUp
	E80ShD94if4F+jfJK3hyQ3jcehOeIXx2+e1TSwE+SYTtOz/vp9u7p3DNWlmjIFihKdUQZb0RlPx
	AApZ27UIODkr3MoUjXVmITb0BG+H9jhY4TwB7oozGY+SfXsW9Gs6UL1csb/2w4ZM/Tf923WZhOJ
	YFw9GuEqExKZWXVgetL3MxdDAiJqtH+I76ipPElRH3g+7aBMR+QUA+RElBwljacmwJspj7
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id ffacd0b85a97d-43fe3dc54ddmr1953516f8f.10.1776405389723;
        Thu, 16 Apr 2026 22:56:29 -0700 (PDT)
Received: from ?IPV6:2001:a61:2ae4:301:12fa:de76:8d51:fc21? ([2001:a61:2ae4:301:12fa:de76:8d51:fc21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a174sm1936117f8f.18.2026.04.16.22.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 22:56:29 -0700 (PDT)
Message-ID: <b1a6b96d-07d2-4a19-b9db-2cd8d878895c@suse.com>
Date: Fri, 17 Apr 2026 07:56:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [SCSI] advansys: fix host resource leak in EISA probe
 error path
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260416165935.3958686-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260416165935.3958686-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-238411-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org,HansenPartnership.com,oracle.com,SteelEye.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: ED395417331
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 18:59, Guangshuo Li wrote:
> A manual code audit found that advansys_eisa_probe() frees saved
> Scsi_Host objects directly in its error path.
> 
> Those hosts have already been successfully initialized by
> advansys_board_found(), so freeing them directly bypasses the normal
> teardown path and leaks host resources such as IRQs, DMA or MMIO
> resources, and the Scsi_Host release path.
> 
> Fix this by releasing the saved hosts with advansys_release() and
> dropping their corresponding I/O regions before freeing the probe data.
> 
> Fixes: d361db483241 ("[SCSI] advansys: Sort out irq number mess")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/scsi/advansys.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
> index fcf059bf41e8..022a8190ae31 100644
> --- a/drivers/scsi/advansys.c
> +++ b/drivers/scsi/advansys.c
> @@ -11373,9 +11373,17 @@ static int advansys_eisa_probe(struct device *dev)
>   	return 0;
>   
>    free_data:
> -	kfree(data->host[0]);
> -	kfree(data->host[1]);
> -	kfree(data);
> +	for (i = 0; i < 2; i++) {
> +		struct Scsi_Host *shost = data->host[i];
> +		int ioport;
> +
> +		if (!shost)
> +			continue;
> +
> +		ioport = shost->io_port;
> +		advansys_release(shost);
> +		release_region(ioport, ASC_IOADR_GAP);
> +	}
>    fail:
>   	return err;
>   }

You must be kidding ... EISA is died over a decade ago.

If you _really_ are concerned about this please remove EISA support 
completely from the driver.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

