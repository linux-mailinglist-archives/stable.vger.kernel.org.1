Return-Path: <stable+bounces-230488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP5RLLxWxWl39gQAu9opvQ
	(envelope-from <stable+bounces-230488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:54:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22E337EC4
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0985F30F8634
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BC4014A2;
	Thu, 26 Mar 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="iZWvtOxo";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="EkuaFTiN"
X-Original-To: stable@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78ED3F210F;
	Thu, 26 Mar 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538813; cv=none; b=Dny/VsXz4GCP4sY9A+SX5EWD9UVxgkpdbOYLLJxlW0mwC2c+Lr6kvD85ycG4xcvJ2KgeWzqndGXt9FXXovK77AW82iLNC/W7sxOejANaHTvVMRKPjcj51UI7aXsJAEV9Y6xDhiA0XomDah48NP07nPgP5rnAtYaiaXZcf90RV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538813; c=relaxed/simple;
	bh=KjbFPWZ52zjrwBOztZYvBAKOfo7bGoPD2DP/sKJUKVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzin3N8kCZpuJnJuApwqFLQCiIPS1VdyByUNysodIQ7t68IH7Efx1LxDSAsPPjBdq31+4DZUkupLM+5zLq8uENFn9k4sRu248z6W5+G2ZUZOZIiOfEf7k8GBmv5osfFevhjdisPyfWY47t4Q6/Dm6b9HwNUuLzaF0IefO92b2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=iZWvtOxo; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=EkuaFTiN; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1774538665; bh=5yWH0aBEsh9Z+ZlkcQnP2na
	Jb810iE/tfOrPtXpGt/E=; b=iZWvtOxobEN+2bXRJ9/vwqsowV7cc9Z2DM1mhUI68D5CoOvxSR
	VThBf0lpUiRBXLiPjJ/nVAu/zmrAet/8kSDGl3QTRYkub5oInA5ctJJWh3uuGj+LkKLVObcSc9C
	ErBHpKWYYG83uB+ZHKLagZM2aqIShLVe9JfmdkhUs2syErpzSjm+z+2lmTidwrL628aJTHSGsQI
	1pWGhqq5e4jb2r3K8FAqRDguWCuJyjmogALRIv58WzwBPF9o690GcKw9t2R5KnZt/cYXXsSYPvK
	s6afrW4j2wwRM/jaH2pmtLXxj/XPklt7NvSi/mV0htYvGv0xyKoc3yV4SCLR2yEZjig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1774538665; bh=5yWH0aBEsh9Z+ZlkcQnP2na
	Jb810iE/tfOrPtXpGt/E=; b=EkuaFTiNEjBrnLfchD8BGwWIIKWbo8LulXtIWJDdRORf5YJwVG
	FVS5iC2Pc2iTZ8B/6jyvBjPPad5ISrAG5VBw==;
Message-ID: <1f2dd742-a845-4b51-86a5-755c39f75b45@mainlining.org>
Date: Thu, 26 Mar 2026 16:24:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: u_ether: Fix NULL pointer deref in
 eth_get_drvinfo
To: Kuen-Han Tsai <khtsai@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Heidelberg <david@ixit.cz>, Val Packett <val@packett.cool>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260316-eth-null-deref-v1-1-07005f33be85@google.com>
Content-Language: en-US
From: Aelin Reidel <aelin@mainlining.org>
In-Reply-To: <20260316-eth-null-deref-v1-1-07005f33be85@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mainlining.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mainlining.org:s=202507r,mainlining.org:s=202507e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230488-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mainlining.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aelin@mainlining.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mainlining.org:dkim,mainlining.org:email,mainlining.org:mid,packett.cool:email]
X-Rspamd-Queue-Id: BF22E337EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 8:49 AM, Kuen-Han Tsai wrote:
> Commit ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with
> device_move") reparents the gadget device to /sys/devices/virtual during
> unbind, clearing the gadget pointer. If the userspace tool queries on
> the surviving interface during this detached window, this leads to a
> NULL pointer dereference.
> 
> Unable to handle kernel NULL pointer dereference
> Call trace:
>  eth_get_drvinfo+0x50/0x90
>  ethtool_get_drvinfo+0x5c/0x1f0
>  __dev_ethtool+0xaec/0x1fe0
>  dev_ethtool+0x134/0x2e0
>  dev_ioctl+0x338/0x560
> 
> Add a NULL check for dev->gadget in eth_get_drvinfo(). When detached,
> skip copying the fw_version and bus_info strings, which is natively
> handled by ethtool_get_drvinfo for empty strings.
> 
> Suggested-by: Val Packett <val@packett.cool>
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://lore.kernel.org/linux-usb/10890524-cf83-4a71-b879-93e2b2cc1fcc@packett.cool/
> Fixes: ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with device_move")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
>  drivers/usb/gadget/function/u_ether.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 1a9e7c495e2e..a653fae9c0cb 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -113,8 +113,10 @@ static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
>  
>  	strscpy(p->driver, "g_ether", sizeof(p->driver));
>  	strscpy(p->version, UETH__VERSION, sizeof(p->version));
> -	strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
> -	strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
> +	if (dev->gadget) {
> +		strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
> +		strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
> +	}
>  }
>  
>  /* REVISIT can also support:
> 
> ---
> base-commit: d0d9b1f4f5391e6a00cee81d73ed2e8f98446d5f
> change-id: 20260316-eth-null-deref-0304bb048267
> 
> Best regards,

Thank you for the patch! This does fix the null pointer dereference for me.

Tested-by: Aelin Reidel <aelin@mainlining.org>

