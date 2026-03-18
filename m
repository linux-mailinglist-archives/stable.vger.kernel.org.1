Return-Path: <stable+bounces-227120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMb3KbzVummfcAIAu9opvQ
	(envelope-from <stable+bounces-227120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:41:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDED2BF758
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A0F930AE7BE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5C13EFD12;
	Wed, 18 Mar 2026 16:19:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452123EDAB3;
	Wed, 18 Mar 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850762; cv=none; b=akX/VkFk/bgPfuNRZAdHQa4fP89cJgOqg5b7ST3GZ3N5bmEQz+v8OJY5drStSutfeRp2pYhfzb6fwfjymXpVzf/sQKS9HpNmgLERESYcoNKGeH4ghy6zNgLPewPjHCILn3J/RbBLnkiE4viefBbakqMKpuKPiXbJGYeFsZLvHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850762; c=relaxed/simple;
	bh=Gu49jJm8wHQwQ9hjXL9RUB67/7QCzFhFqZmAdWsGBEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9NnC3MQ8SJbfXXJ+7db9FBfocfoWYweJdV/jxpPKklyFS9w8djbTz3sdHPOOe5j67+W4Sqn996htDK1iBmXFBoY350RZRWtnDHwlerMjR7fhJT7SRJeG9MzVkZcfghJ+OV89MBI+HSVYkVpqgDIcJU5tIeTxoCD89kVnVruBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.20.10.225] (unknown [24.40.138.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 731644C2C37F0A;
	Wed, 18 Mar 2026 17:18:33 +0100 (CET)
Message-ID: <f26d4c73-99c3-4252-a880-f9e8eb57bf04@molgen.mpg.de>
Date: Wed, 18 Mar 2026 17:18:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] idpf: fix UAF and double free in
 idpf_plug_core_aux_dev() error path
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Joshua Hay <joshua.a.hay@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260318155220.642160-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260318155220.642160-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227120-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.815];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,molgen.mpg.de:mid,mpg.de:email]
X-Rspamd-Queue-Id: 1FDED2BF758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Guangshuo,


Thank you for your patch.

Am 18.03.26 um 16:52 schrieb Guangshuo Li:
> If auxiliary_device_add() fails, idpf_plug_core_aux_dev() calls
> auxiliary_device_uninit(adev), whose release callback
> idpf_core_adev_release() frees the containing
> struct iidc_rdma_core_auxiliary_dev.
> 
> The current error path then accesses adev->id and later frees iadev
> again, which may lead to a use-after-free and double free.
> 
> Fix it by storing the allocated auxiliary device id in a local
> variable and avoiding direct freeing of iadev after
> auxiliary_device_uninit().
> 
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_idc.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 6dad0593f7f2..0fcbf9f1ddbb 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -197,6 +197,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
>   	struct auxiliary_device *adev;
>   	int ret;
> +	int id;

Name it `adev_id`?

>   
>   	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
>   	if (!iadev)
> @@ -211,12 +212,16 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
>   		goto err_ida_alloc;
>   	}
> -	adev->id = ret;
> +	id = ret;
> +	adev->id = id;
>   	adev->dev.release = idpf_core_adev_release;
>   	adev->dev.parent = &cdev_info->pdev->dev;
>   	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
>   	adev->name = name;
>   
> +	/* iadev is owned by the auxiliary device */
> +	iadev = NULL;
> +
>   	ret = auxiliary_device_init(adev);
>   	if (ret)
>   		goto err_aux_dev_init;
> @@ -230,7 +235,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   err_aux_dev_add:
>   	auxiliary_device_uninit(adev);
>   err_aux_dev_init:
> -	ida_free(&idpf_idc_ida, adev->id);
> +	ida_free(&idpf_idc_ida, id);
>   err_ida_alloc:
>   	cdev_info->adev = NULL;
>   	kfree(iadev);

Ether way:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

