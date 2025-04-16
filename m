Return-Path: <stable+bounces-132841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D255AA8B835
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769C619059F7
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F92472B4;
	Wed, 16 Apr 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wTNuD1qF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VCd2cnKN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wTNuD1qF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VCd2cnKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD062309AA
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805044; cv=none; b=Ltp/0yCZt7LZ/nLdStz71JeZ7U0gsbVc2tobcUfqW8SfUjwgt08krMFb9T5xZQH6HlHRJIX00w2PL/SHKnoTI7JEBiEmSiMhRZJhZIzH+SyYWx4GJfsKNRTIne/t1Cx5pY2ihaNHBXeUcpFwliKqGG9+7IINADe+j1JoCc0/IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805044; c=relaxed/simple;
	bh=HWqh+T9xGdXr2x2ptTrd4xSwZnxgWGd8mannk8BWyqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maTOxtQoIm90LAA6R6yDqb2GUzmK2i5SyRFJ4uXYRGSTur7075RaEpTfOlTE0ptAhPFeHqlmtJs6rJjJX8jsZCdWd9nAK1Oq7tk1nRHbMXof//TK5vaEccoDDkg1MELLWScxBV6J2zzr3jUZ2KPgPTi2Nmww+HIs0FWBbtL94nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wTNuD1qF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VCd2cnKN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wTNuD1qF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VCd2cnKN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E251F461;
	Wed, 16 Apr 2025 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744805040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKmfoej560lM1dq41MrZF/R2J8/pmwdXbyf9GgGgEbE=;
	b=wTNuD1qFq7CpHVbaPYS5ikEd8Ug18IiRlzmytANVXa8eCWUoQow7jVqF8kAQHOdZZp3Li3
	LuptuBaPXBBoedRL225XO11ZsW0ZA1WPp/SJ/qAd0V0kQkEI0fx/gZt8NGC6B2cUi1FmdQ
	If2I8onvLAdU+ozbKglX4mIXCAXF+1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744805040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKmfoej560lM1dq41MrZF/R2J8/pmwdXbyf9GgGgEbE=;
	b=VCd2cnKN1Q9Z6AEH+q1H7FVL6fV1wujdhCJmLDVFhNgsuMSUYmg8TpuS9kr6HpBY4WaWcX
	hwlVAra6sxoZ/QCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wTNuD1qF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VCd2cnKN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744805040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKmfoej560lM1dq41MrZF/R2J8/pmwdXbyf9GgGgEbE=;
	b=wTNuD1qFq7CpHVbaPYS5ikEd8Ug18IiRlzmytANVXa8eCWUoQow7jVqF8kAQHOdZZp3Li3
	LuptuBaPXBBoedRL225XO11ZsW0ZA1WPp/SJ/qAd0V0kQkEI0fx/gZt8NGC6B2cUi1FmdQ
	If2I8onvLAdU+ozbKglX4mIXCAXF+1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744805040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKmfoej560lM1dq41MrZF/R2J8/pmwdXbyf9GgGgEbE=;
	b=VCd2cnKN1Q9Z6AEH+q1H7FVL6fV1wujdhCJmLDVFhNgsuMSUYmg8TpuS9kr6HpBY4WaWcX
	hwlVAra6sxoZ/QCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCFF2139A1;
	Wed, 16 Apr 2025 12:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yXsHMK+c/2d8IQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 16 Apr 2025 12:03:59 +0000
Date: Wed, 16 Apr 2025 14:03:49 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Andrew Geissler
 <geissonator@yahoo.com>, Ninad Palsule <ninad@linux.ibm.com>, Patrick
 Venture <venture@google.com>, Robert Lippert <roblip@gmail.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/7] soc: aspeed: lpc-snoop: Cleanup resources in
 stack-order
Message-ID: <20250416140349.52bffcf6@endymion>
In-Reply-To: <20250411-aspeed-lpc-snoop-fixes-v1-1-64f522e3ad6f@codeconstruct.com.au>
References: <20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au>
	<20250411-aspeed-lpc-snoop-fixes-v1-1-64f522e3ad6f@codeconstruct.com.au>
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
X-Rspamd-Queue-Id: 40E251F461
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 11 Apr 2025 10:38:31 +0930, Andrew Jeffery wrote:
> Free the kfifo after unregistering the miscdev in
> aspeed_lpc_disable_snoop() as the kfifo is initialised before the
> miscdev in aspeed_lpc_enable_snoop().
> 
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
> Cc: stable@vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 3e3f178b122615b33e10ff25a0b0fe7b40a0b667..bfa770ec51a889260d11c26e675f3320bf710a54 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -263,8 +263,8 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
>  		return;
>  	}
>  
> -	kfifo_free(&lpc_snoop->chan[channel].fifo);
>  	misc_deregister(&lpc_snoop->chan[channel].miscdev);
> +	kfifo_free(&lpc_snoop->chan[channel].fifo);
>  }
>  
>  static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
> 

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

