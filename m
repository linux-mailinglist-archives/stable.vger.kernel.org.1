Return-Path: <stable+bounces-253391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0In0LhAoDmp56gUAu9opvQ
	(envelope-from <stable+bounces-253391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:30:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66459AF32
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED2963027C68
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2738B122;
	Wed, 20 May 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qov4Ksyo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6994389100
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312624; cv=none; b=Sml5UNhE1q43AnH4K4mcfYRsJADlPmIQL5i58XHjVOTYk/3/RktGF6O4WtTddoFFeZIx0WIqiREV0zsaKCJD6mZLIrS3oltb3Y7bazmEOBXA5xDj0IKFRTxExsiA65Ywx3L7x3Sl9ZbRuH4tsq6kjQu2e4kE+9heh31b1GUpTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312624; c=relaxed/simple;
	bh=CNa2gn4pFs3ZChw13qtMs/nrIOyVd4U11OySKw0hQjc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FGIxipm7rA1cuTCXqZOkG5aiP+5gapER/dNltEqs8Viy28NAM/ww7qgw0vLDS7kSDYLF5SV8cC+H7tShrDG1FY888iLTz+fD3bV8r2ACUE+S+siv8sv9OI/DYYbCdAxlKWupL5VdFrNOlcHUGfyQYN6UK3IHWbK/fz8Xfafhb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qov4Ksyo; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c37eafcbeso5893609d50.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779312622; x=1779917422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+KjHLBU525JouIaDV1NgtcuH83HscW0YCgR8XNPGw0=;
        b=Qov4KsyodNaYoKKYGw8QXb0+Qu4SMVW8i44WdAko6Pn9HnrUsPa6L7IqX3v+/wC7+s
         o4SvVPDi3hO/Ka5e9rgBvgaF/rOVe5ZD5fDc2hhPu+R9gk82O4v19sddEP43dDG/5SJl
         0xXQO/w3Pt+qJdM3cGdz7gw2fZc5cwHDc3EzFXpr7Szk+iSe6FFDkYWbFYxNMpnOiG6C
         hUfsQu2nBVJiOYio+6Q/pBEF989u6fI3mTeFsPAvqEZFu80dMIQK2jUN3BjepdAOsfKQ
         CCbVpag47HIJWD1qjmXFu4KTEGlnWxQSMRD01mBEDL/JsOR6ihhyv6H7oLa+O/1Uggdk
         IFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779312622; x=1779917422;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+KjHLBU525JouIaDV1NgtcuH83HscW0YCgR8XNPGw0=;
        b=NIjqyFk5h+sLBC9yso15tX51cI30OYbbdDTfcHqTEB5MdqP/xxl26t16gD3f9q0AWZ
         1jocvfEKwTjhx3633kIunr3J0XG14kL8dAYHJOLoccvDhjzXuAMkRpLtd+rcTqfC7baT
         BL4KAup425EpP88HKGlvIFN6BAABzy4tMmrdY2CPZVKaYQUoB6qMujxmTVjqp1cNN1uo
         wcd088BNxCPNroOPmm9/1F5q8rJvmvOdyYsuDFvt3ocUtmU+iO3t+yrA+9BmPvHYK0m2
         5qZ5vcM1hPnHtulyjpQaXE8Nq2t5y3CQZuSEY3SK9sVTdD+6AS45Wfki5xoedtQ7ebK0
         AwSw==
X-Forwarded-Encrypted: i=1; AFNElJ9uX6H315xboT3RL6gmaXae7HD8ZaNhXeS9pLbyjXiT+zAxafJWbLwJWn2oLPF/UPyrmUmVJbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRzNJ4CxKgN65+nkUJXXCWLnmx20aK/o9pXDloOBiQZq7a6OHi
	LXMXj4ZHcl/vtt/NMXaPcInGNx2VjHo+70Y9jrZZ4aEMBjlT4W4O/nDT
X-Gm-Gg: Acq92OEQickHklVrLkU7SVInrEEFOmMyo2L9BP8E/2RXbVR6DRdWmbx11csoJoWw4i4
	XUsncv+vFVaNJozqxajFvmhRUlYy6cE7Bi3gy94SvGJHWk3dIuZYAm7KudkuLooHuXhQOUpCIJw
	rYktBdR9Kxgi+V6PHyjAwB0g+qKry+EVO0kbGyz6ILMGgCvvu3+vhZm2nsDeBCCbXl6f431Vn/x
	MlfYvTjT9MSG5B2KBcJTUDpAstA0Vekj+gWdxv4BIgcdKWYIn5kUnm5pcxoVR739q/ogQoDXdJ4
	vw/jPf3YCcBpHU5D5dqULHo35HMBYlXJLPxdzYyCCFcpkDf7yzeWiz8QFzcNYJevVwYzSkbnNfq
	EpUHfp+sK7ispsji6HXX4WsfSpwfWka3hi4XE/qH/I6T6oD9FIQESWVZXF0jlXs2HRFRn8aGv/z
	5u0El2kiYtKGiRIdVYPCyrl0SpvgbhZwfLpS99KaaD2GjvcG9yi6GL1pMNeJ2w4e4GtvkAYV65e
	io1M3weYf54+yA=
X-Received: by 2002:a05:690e:bc6:b0:65e:3c31:533f with SMTP id 956f58d0204a3-65e3c3156b6mr18817387d50.51.1779312621683;
        Wed, 20 May 2026 14:30:21 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b130sm9894594d50.5.2026.05.20.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:30:20 -0700 (PDT)
Date: Wed, 20 May 2026 17:30:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Weiming Shi <bestswngs@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 cong.wang@bytedance.com, 
 stable@vger.kernel.org, 
 xmei5@asu.edu, 
 Weiming Shi <bestswngs@gmail.com>
Message-ID: <willemdebruijn.kernel.377fc4fbfbed@gmail.com>
In-Reply-To: <willemdebruijn.kernel.69dc20190163@gmail.com>
References: <20260520075736.3415676-3-bestswngs@gmail.com>
 <willemdebruijn.kernel.69dc20190163@gmail.com>
Subject: Re: [PATCH] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253391-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,bytedance.com,vger.kernel.org,asu.edu];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Queue-Id: 5D66459AF32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Weiming Shi wrote:
> > In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
> > uninitialised on-stack struct sockaddr_storage to userspace via
> > ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
> > dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.
> > 
> > Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
> > macvtap chardev returns kernel .text and direct-map pointers, defeating
> > KASLR.
> > 
> > Initialise ss at declaration.
> > 
> > Fixes: 3b23a32a6321 ("net: fix dev_ifsioc_locked() race condition")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

But it should target [PATCH net] and

Cc: Stable@vger.kernel.org



