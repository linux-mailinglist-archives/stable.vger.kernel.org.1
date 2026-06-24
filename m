Return-Path: <stable+bounces-268148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KAXUHubEO2qScggAu9opvQ
	(envelope-from <stable+bounces-268148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:52:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE85E6BDD93
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IEdr0QeT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268148-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268148-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D36B30C6553
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDA72EC0A7;
	Wed, 24 Jun 2026 11:50:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392C2C11F3
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 11:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301840; cv=none; b=En9ftXUrgcTZXpdew0UULRyxY8Y9HsDT9lGfhWo4AhiPk/I3DGrv0zgRMN0LKAunOU3oI9BZzUh8KQRYK+Tj5NQFpYXYEIPcc79yehZ/nmx2QRvxRVJ3rtzAcoJ1213KG2tm34dA5SfeiiylaN27aCUzYh8BghLMNNleJZtsBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301840; c=relaxed/simple;
	bh=H9kzeArIrdtsSKoAfhoyLovvflrT2KaPvrL2Ox7o/8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9iJxBt3Dy+TSGXJZ9TkBP1CfSEOLTANjY/om/QULWW1D+jW/tIj5tHV1RDCgilN7ymvxxicfqjPdefkQpUvcG83rLWphL8D+hqHlayd+dWhYl8L859Gwn4St+KSxSAMSEIE3DxOrtQP2jYobWdIkFWdtuKmXx11rIKY+LZo1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEdr0QeT; arc=none smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69690062350so1088940a12.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782301837; x=1782906637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZbMotHgAD6jel0fNJNyUErzOCiB1TTJiURnxn+giCc=;
        b=IEdr0QeTvyLbkzuWalrvMRmYqQ1cpzB0/5C/JR40me6SP1HEMGeydjHVVHeyhCxqQA
         vhSb4nQGZmt00ZeLHC6/jI9UsDQh6sXpOwsc0dfOTnFEwPvCLwsfduJlIsF5odzbC01I
         njIJH/Dll8GuMBtPMtDLm9EAuIlqqY2oEuAVpvStLtkd7XX0yVRdbsOWDYG5ApjSTrvk
         xgNanypcSXPRlEgF9E5dmiaWiZy79ZlnEwEVK79itWSEaUpCuLEshM9sUJgDT3qeP9Qh
         NWdOaMRAIhLfsPwy3hV56eQPmZ0IgVA5srhEYSesI7GlbmTzxDo2jACdKEKP7sSpIL0+
         +sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782301837; x=1782906637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZbMotHgAD6jel0fNJNyUErzOCiB1TTJiURnxn+giCc=;
        b=UbU1TlzzAbJXRt/AC+HvwAfzf4lKMA5Tj2vzO76bd3rP8SRcDzXkWPeWkV/A8c6P1s
         6SyphJ0mO+pa+WObL/vFsM+g8uOD+h/9PAHFgtZsPtgXhHMmOPMbqe89EjPCBMMG1JH5
         uC0EQQWYXaE2A8sioAEBzzg19C3M9Pb64c+CLvwLMHzCjhrxkXszf56SYJM7dROAPbbw
         /IOyHA2BISLWhIo1/pj8CtS2AQ0pz1EcpyJTIwMKRcBbAEuzP7jMtXKFWJkHjmzZ5OCU
         z/xup8fbQ+eTfDCiGObs3obMM/PLRVYH/AtjSUgwmxk+lc9IlU8TqUUuyX45Xy3awjFJ
         j5LA==
X-Forwarded-Encrypted: i=1; AFNElJ8v6IguIB/Y86WJepy2sOQvh316UTnmkvp/l4/Oo7XEmBgu1a7NjnGBG2OLvCdktrgIwi2WMg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylQPevEImkZUhK3373rFzkZoapEUuyAgj4egQ+vpOW8DykDTmI
	z6vNr2pVAEkM7O5losQRwdU7LsNa/DFpAcVWDMoEaGZ4+Yap6qrWH3p5rLIIfw==
X-Gm-Gg: AfdE7ckiQkQ9me3CgEeQBfr7fXRRjCdPBHAcpdZUDsU8pq7yjcBP/IWJ2tdUrf+B0VH
	m1tgjL7urb/JjFa1to5T9FWHME5e/6eEZ3Fb+71p1bg+KgK/i/QIaWswv0Dmn9Dolcub+Mn4Zs6
	VNWS+UngMogSmI6DshF9dAtA8Zz/jp6o2UZ9Lw5saQHIOFDY2tZhsCVKr8BtMVh1Q8LD1DFqh0y
	mdg9FYr6OTkH/zRnuUWhgJLQTxs45xFEmso0dNH2rcKF7dMUe+b2CYrxqByy16HMSC2z0y8SPxW
	qTYks/0BtFXkXlS5GTLivvHqgSEcee61Hnb0teXb4VDStWwMpLSHeEVLAyuWhUY4SWFVPcC9H2J
	dg6ActESzvIilLLuIWC9sVB9iTdUxNu8DGmEWnUbrpampPLiQ/P6onc4Y+hHfysQWeTFPIpdydD
	7+WuD1/dSB
X-Received: by 2002:a17:907:9719:b0:c0d:8c04:92d0 with SMTP id a640c23a62f3a-c119f6127cdmr148307466b.49.1782301836889;
        Wed, 24 Jun 2026 04:50:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c6161f195sm656749866b.63.2026.06.24.04.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:50:36 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:50:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: mripard@kernel.org, paulk@sys-base.io, mchehab@kernel.org,
	gregkh@linuxfoundation.org, wens@kernel.org,
	jernej.skrabec@gmail.com, samuel@sholland.org, hverkuil@kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: fix memory leak in cedrus_init_ctrls()
Message-ID: <ajvEiDkI_CcXUz4_@stanley.mountain>
References: <20260624085920.578446-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624085920.578446-1-dawei.feng@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268148-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:mripard@kernel.org,m:paulk@sys-base.io,m:mchehab@kernel.org,m:gregkh@linuxfoundation.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:hverkuil@kernel.org,m:linux-media@vger.kernel.org,m:linux-staging@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:stable@vger.kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,sys-base.io,linuxfoundation.org,gmail.com,sholland.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,seu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE85E6BDD93

On Wed, Jun 24, 2026 at 04:59:20PM +0800, Dawei Feng wrote:
> In cedrus_init_ctrls(), the V4L2 control handler is initialized before
> allocating memory for ctx->ctrls. If this allocation fails, the function
> returns -ENOMEM without freeing the previously allocated handler
> resources, leading to a memory leak.
> 
> Fix this by calling v4l2_ctrl_handler_free() on the ctx->ctrls allocation
> failure path.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> Allwinner SoC or board with a Cedrus VPU available to test with, no
> runtime testing was able to be performed.
> 
> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---

Looks good.

Reviewed-by: Dan Carpenter <error27@gmail.com>

regards,
dan carpenter


