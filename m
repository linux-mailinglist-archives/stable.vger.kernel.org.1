Return-Path: <stable+bounces-237773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDQDF/gL3mnRmQkAu9opvQ
	(envelope-from <stable+bounces-237773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:42:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0B3F8186
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 435493016B27
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60113C660C;
	Tue, 14 Apr 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcJF8tMM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqUCO2/E"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474A3B8BC7
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159721; cv=none; b=aQF5GBUrGa7K5k0wRYid0J5LDNfw7J04qoQiJMSfuG4kMP0KXr5fw5Qix3yI2BF3iqD9VE2TD/E0dRPQ9n1rTX0jnIqi0lshhJ98gRLOKCY/G+54zmJBtwZlLq1l+q932df9tJ6hI0Ymlp+c9+O+UATs7ryQY8I80pArwoXfiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159721; c=relaxed/simple;
	bh=ydzgHuNWO26DXRwAKMsnQ0HVug0d+eooxg7k0fZvtVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8hcsbnsH4TDqQElrmoCplOsBzkenBilgL32SU+t6xsGgA3ywpaT3ki670nvxgbcWYvxSqM3FYPYVV2vWaD957v54pUzpmGMo58+WD+Lb6ArAuiz4VO5XTCMREDCOxatRGLxaOnns+0Ko9WwkKDerA1uFbz46yqN2/Ta58vw5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcJF8tMM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqUCO2/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776159719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FELt2dkZpqjTQBtoM2kh22WHuyLD0LqG0oQFeQHOlFY=;
	b=KcJF8tMMk1NOWovxMh9Qw9xAOi31yJ4U+HiYrNQACmgBna50v1xJ7ryab81qocs3MvpOdm
	mnztOyBmPc1v6c4dho6hpK20i47vaSFU4XALagFiTDhMZnrt971TGRoNK90CQfI0lYsYJt
	o9+L5/2896i82z2xnAqqM4dCkk30v84=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-hzSLhQolNRSNEomGO5UCWQ-1; Tue, 14 Apr 2026 05:41:57 -0400
X-MC-Unique: hzSLhQolNRSNEomGO5UCWQ-1
X-Mimecast-MFC-AGG-ID: hzSLhQolNRSNEomGO5UCWQ_1776159717
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d6ebe9cfso31998565e9.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776159716; x=1776764516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FELt2dkZpqjTQBtoM2kh22WHuyLD0LqG0oQFeQHOlFY=;
        b=YqUCO2/EsQGmNvzVDe6MMDaVj20yOp7JIHP1x4ZdjMyEq8i2Mqh7NcNe89l4Hfk4/F
         7Cbhjo+DWkIdp+9jLK8dJe15E1CiddjyP9JKfpSkxr43BZkIQ9YmkovieE6eiGyryAm1
         obAinFCT1uvddQVCo1PNIn0SLe69AvStAmHinT+RZ2ZgI2Wsl0Vn+aht5TlB+29rqmdZ
         MHS/eZbyB+rGWNKAxPlwHfMCtIT5CbL2ch6rsPNNni6lY5qmCJ0V94Jn/pgiRFgE6xjS
         5ZxEFdsdvTjy2wjs0VkFngNSenp/qedIN8IwJapaZh6Gxh+wny6QsgdLQjM9XV+8rb5f
         1cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159716; x=1776764516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FELt2dkZpqjTQBtoM2kh22WHuyLD0LqG0oQFeQHOlFY=;
        b=ZdevZS7E9e2t7u8EKIjECMQ/0jsm6PsXXDxusfaif8skTZV25QXMv9KwqW3TYBRfYk
         quMNCsijUKrhtGJGy5ZcLx2SqYS3FbvNGLEPieV/fQ8XRQeSSZsBJCxBIK1UuCYC9Jtp
         dVeUYVRKbkr7KatHKywzaAeyBxmwyizMbW/IW79anUe0+lXKn0eweqeMDTVrYpPwCCUh
         MGCn10T834TstULQxrMlauiPCMX2jyQdMHRHnHCMgZZKUl+zOXS/ADJTPdmlBqOdfeGb
         rTyY5DdFjQhsSF8Sio9YEPrCK5La2IPFdnp2jvgqC8sOB9XY2AlvxFfqcqRmRyozhE1x
         jgNA==
X-Forwarded-Encrypted: i=1; AFNElJ/2o1jArUY33cxS2zWsKKUoXDK7YYxq9zNw6iVyiFeYWco3Jzb6VmtuLYVrMPBifaT6+AEB9gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjt9d3JCzFvO8078GRJ7KClDZDKEf+lQeSYV24Zl6kGeRZ3s8o
	6in/HApoLg6ICR71SGwtE/BM+ejrBofbyFmiazzGdM4uE5Gfb768+QhM2ApQtgT4XqwD6afqWCs
	ic06fbklUgjtqV21x6gOumX5Jic7TQ0FxBrpe5//WLENJCWhtOr0TotnqNQ==
X-Gm-Gg: AeBDievGpdvx0fVxJBIBequE0WgCYHF+p6yU8OOf6Sw5O9scKf8s6r0aoODCO1YGlcf
	fK/GoBgiI6zfLPlBQ13SI8XSHGUf8FclSZvn2+xX5ivgTeIWhaCi21+JBk9c5yhk29bcb8dSiDX
	LqaBHmT1THy/hWmbBKJ59EuyfFix95A13W/sZwXZ84BEeE5b+8URLI41KEHuskJBfPFGerBFENx
	0/sQveoNjQ9PPJC1eg164pfIMJcv0bhYL/CT5xwwMpYBrJiLcNf3cEesH4e274IGl0yDhLS11Zq
	ZzGxi5fFz+fSl1/8U1P8dfDRxYLFVITSnryy4UwEL/IRBlQY24JI0+ZiPoee8LbP3xfSjkHopwz
	GvZ63PL1uS82dUFCjCwzQu/qMnXo9gGVmCra5V7Jeceb5j2KLk+bkPw2o
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr238976215e9.2.1776159716607;
        Tue, 14 Apr 2026 02:41:56 -0700 (PDT)
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr238975905e9.2.1776159716205;
        Tue, 14 Apr 2026 02:41:56 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddb9751sm61642165e9.0.2026.04.14.02.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:41:55 -0700 (PDT)
Message-ID: <3b67dedb-3472-4322-9a30-32bf8e3cef99@redhat.com>
Date: Tue, 14 Apr 2026 11:41:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
To: Pavitra Jha <jhapavitra98@gmail.com>, w@1wt.eu
Cc: chandrashekar.devegowda@intel.com, linux-wwan@lists.linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <20260411083957.567676-1-jhapavitra98@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260411083957.567676-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237773-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,1wt.eu];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EC0B3F8186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/26 10:39 AM, Pavitra Jha wrote:
> t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
> a loop bound over port_msg->data[] without checking that the message buffer
> contains sufficient data. A modem sending port_count=65535 in a 12-byte
> buffer triggers a slab-out-of-bounds read of up to 262140 bytes.
> 
> Add a struct_size() check after extracting port_count and before the loop.
> Pass msg_len from both call sites: skb->len at the DPMAIF path after
> skb_pull(), and the captured rt_feature->data_len at the handshake path.
> 
> Fixes: 1e3e8eb9b6e3 ("net: wwan: t7xx: Add control DMA interface")

Wrong fixes tag:

fatal: ambiguous argument '1e3e8eb9b6e3': unknown revision or path not
in the working tree.

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> index ae632ef96..d984a688d 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -124,7 +124,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
>   * * 0		- Success.
>   * * -EFAULT	- Message check failure.
>   */
> -int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
> +int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)

Undocumented new argument

/P


