Return-Path: <stable+bounces-132844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE6A8B8A9
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0E7179651
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F324290D;
	Wed, 16 Apr 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fbx+fT+2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B1MygTTN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QCQMg/xs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SKjH0wzh"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7120ADCF
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805713; cv=none; b=k4Jqu6NBdIIColHZYGU6xKa+d1THO+53on60LeBB3gp5tr4PNyOuQxAtrYR1E1/ZOvs2qLjezyEF8v8MSEgGd0Tz+d29lCub3IKMHi36OhBGPIzzLPOiCjPO7BJCszFH/LT3/D2obbGLpGPCahZCGasd1Ow7qXrAFAI6vKO+mnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805713; c=relaxed/simple;
	bh=fUcG73S1rwZIXLkdw9siOhfKPOq0DiFzEXrcLyLFtiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhYlxNGwrcoEYHbESbGAhKsKNqTXnJPo/Q5ZPOMdxjdraY+TWPlFsBMC56u0AhEZRREsixGbtM8VLmd+rVZR5e3gzzzikvg90ReXncIRxKkDLHVWTNPA7HsWwXXl7ucNnwh7Mf1bDfUTIseV98wL0+EcKfrJEI/VWnUwnErnOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fbx+fT+2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B1MygTTN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QCQMg/xs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SKjH0wzh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4763211A6;
	Wed, 16 Apr 2025 12:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744805709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUSGZvjin/s/VaKHZ8mATatJ2r57hyBMQ2bLBcaP+pk=;
	b=fbx+fT+2ht2mJM5Hyie5E86RQ84yRcOT947SBzCLskeBmxwZHXUrCpqKn2ZT8M6MRTjZCa
	Koc0+pkAhL1as5+OHw22AnEV1LIj/MKGMQcHRw2O+9k0kxwEyEDlAsf2v07w8O8JocXHnH
	NpH+zSa3AZN3U52PIIliyKT0hXOgheg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744805709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUSGZvjin/s/VaKHZ8mATatJ2r57hyBMQ2bLBcaP+pk=;
	b=B1MygTTN+SKd3yDU9W6cUfh9g+zfXOY1QS19+AY/5O273l5bpiZxI1iqrl7CRtDXLHbhXg
	ocWd03RwR8KphQCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="QCQMg/xs";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SKjH0wzh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744805708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUSGZvjin/s/VaKHZ8mATatJ2r57hyBMQ2bLBcaP+pk=;
	b=QCQMg/xsQA1Zq9jj5Wxnm6Ox9QCyT5JoTuHCtNpcJZhy4T1L53ZfFm/GCQBSJr9wCRmqDw
	7cQfMXUzTbXRSx+MTFS2sklGnw8AXau7b6IgGuHf0XxR7mG+UKPQu6m3+BPS8qGE7NzocQ
	IqIrmZcAvt4hp/3jn8NPEyVVVjRk3Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744805708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUSGZvjin/s/VaKHZ8mATatJ2r57hyBMQ2bLBcaP+pk=;
	b=SKjH0wzhK7TWVezIlxsj0bfdzjX4AgRblfX5IXsUHw5NKgPTFS9n9OxtGViFnKCR0ergLr
	xWTf1kfNbD0dZ7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DD28139A1;
	Wed, 16 Apr 2025 12:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zuIOEUyf/2cgJQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 16 Apr 2025 12:15:08 +0000
Date: Wed, 16 Apr 2025 14:15:06 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Andrew Geissler
 <geissonator@yahoo.com>, Ninad Palsule <ninad@linux.ibm.com>, Patrick
 Venture <venture@google.com>, Robert Lippert <roblip@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/7] soc: aspeed: lpc-snoop: Don't disable channels that
 aren't enabled
Message-ID: <20250416141506.2d910334@endymion>
In-Reply-To: <20250411-aspeed-lpc-snoop-fixes-v1-2-64f522e3ad6f@codeconstruct.com.au>
References: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
	<20250411-aspeed-lpc-snoop-fixes-v1-2-64f522e3ad6f@codeconstruct.com.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B4763211A6
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,yahoo.com];
	FREEMAIL_CC(0.00)[jms.id.au,gmail.com,9elements.com,yahoo.com,linux.ibm.com,google.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,codeconstruct.com.au:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 11 Apr 2025 10:38:32 +0930, Andrew Jeffery wrote:
> Mitigate e.g. the following:
> 
>     # echo 1e789080.lpc-snoop > /sys/bus/platform/drivers/aspeed-lpc-snoop/unbind
>     ...
>     [  120.363594] Unable to handle kernel NULL pointer dereference at virtual address 00000004 when write
>     [  120.373866] [00000004] *pgd=00000000
>     [  120.377910] Internal error: Oops: 805 [#1] SMP ARM
>     [  120.383306] CPU: 1 UID: 0 PID: 315 Comm: sh Not tainted 6.15.0-rc1-00009-g926217bc7d7d-dirty #20 NONE
>     ...
>     [  120.679543] Call trace:
>     [  120.679559]  misc_deregister from aspeed_lpc_snoop_remove+0x84/0xac
>     [  120.692462]  aspeed_lpc_snoop_remove from platform_remove+0x28/0x38
>     [  120.700996]  platform_remove from device_release_driver_internal+0x188/0x200
>     ...
> 
> Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
> Cc: stable@vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index bfa770ec51a889260d11c26e675f3320bf710a54..e9d9a8e60a6f062c0b53c9c02e5d73768453998d 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -58,6 +58,7 @@ struct aspeed_lpc_snoop_model_data {
>  };
>  
>  struct aspeed_lpc_snoop_channel {
> +	bool enabled;
>  	struct kfifo		fifo;
>  	wait_queue_head_t	wq;
>  	struct miscdevice	miscdev;
> @@ -190,6 +191,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  	const struct aspeed_lpc_snoop_model_data *model_data =
>  		of_device_get_match_data(dev);
>  
> +	if (lpc_snoop->chan[channel].enabled)
> +		return -EBUSY;

This isn't supposed to happen, right? WARN_ON() may be appropriate.

> +
>  	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
>  	/* Create FIFO datastructure */
>  	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
> @@ -236,6 +240,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  		regmap_update_bits(lpc_snoop->regmap, HICRB,
>  				hicrb_en, hicrb_en);
>  
> +	lpc_snoop->chan[channel].enabled = true;
> +
>  	return 0;
>  
>  err_misc_deregister:
> @@ -248,6 +254,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  				     int channel)
>  {
> +	if (!lpc_snoop->chan[channel].enabled)
> +		return;
> +
>  	switch (channel) {
>  	case 0:
>  		regmap_update_bits(lpc_snoop->regmap, HICR5,
> @@ -263,6 +272,8 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  		return;
>  	}
>  
> +	lpc_snoop->chan[channel].enabled = false;
> +	/* Consider improving safety wrt concurrent reader(s) */
>  	misc_deregister(&lpc_snoop->chan[channel].miscdev);
>  	kfifo_free(&lpc_snoop->chan[channel].fifo);
>  }
> 

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

