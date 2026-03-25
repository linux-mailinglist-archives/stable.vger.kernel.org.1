Return-Path: <stable+bounces-230313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBrKLuHAw2kRtwQAu9opvQ
	(envelope-from <stable+bounces-230313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:02:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E25323712
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B6E8308FBC7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0DA3AF645;
	Wed, 25 Mar 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IPz6tQ/1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CE33555B
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436199; cv=none; b=MVPAa9GvmrnPYr//GxRwKzFpa8ZBnmn0ZJCSABzmRKwwF5Eyc948+nJZxrxpAel9YvMfHFNyJ5UmkcwFFLri7N5GTAvcnIMlE5mDbKlNeiyueyv9wsmMqAte6ow0JfPzKpSMWeqZDD/n9JH7p9fK1Y+Pz8TNBI4ylI/4wbqdeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436199; c=relaxed/simple;
	bh=aThMs7CHryE7CkoLYXzvwMpdt+joZGHszDjPdsusEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dwp7CxRx1DiZzPQ2xrLPoWwWEzgFN1WAS12ZdqQxsoc66C0CXuFD5KUiHAW+h4OgZIIZPggEXQDxx5NDitgpdaI/FgkxuNZRUBnTY2eVbUKJ6ChQbLhY6two+4l/11JagVh20JGNlK5yQwMwYscNWIWupj+6u8D2ADIL3xWdO70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IPz6tQ/1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486507134e4so28035765e9.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 03:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774436196; x=1775040996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXy/m9lI8oK0hGzNGrxRb/OaeFsO4shJQYX1qu7UPoA=;
        b=IPz6tQ/1jmjYhThJVchIQYKd64B9YTpv7/ngRlOgCFs3BCKMyEOv5oVrvbw2ko4xeU
         gPqfDLkGObMn+su3/304zSNbPEY8NH0BCmIA/sQDBByYWqTyqkBIFBX/cS5IgKJVtyE9
         44nT4NqVXWIRrPT2rYZmmsHDw4dJ7YAjfyuioozCYC2TVLb9oLpG7zLgBj0FS/zXUs54
         5wObKOK4Bp5iP30OZprzUSEl8t6c/NY0bIWpkW07TQ581U5LwTk3F1FuPDmj1CRgbIMc
         rz1pnx7WiemHZSw7k8sB6Pz+8OU+ZYIMamX5B2Jo0TVQ0F2Pv2EUmeXGgKjDS0A7ilw+
         yQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436196; x=1775040996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXy/m9lI8oK0hGzNGrxRb/OaeFsO4shJQYX1qu7UPoA=;
        b=p80qmJiVkenePXIkaM+NWnmksFC+vpmokdo5ZlSAjczaW7TrXRGAwN7i97p1G7gPjX
         bQXyi/TGlRSxIaufywRESb0vNQpelqFkW+PNP0zMnAF+GmjkKjJXrgP2mMLGX5nOKdbX
         oztxfW686mVCzppj1mGcZOjpumBmSjM8FsyBmpmzD92WgcW/2i9USXO5p/4nU0h9grZc
         nqHxesdPNFUl+40CKLGS8A78RCaZxivoVVFgrudQnNMmRHWvbI0fGsjmRgw3X5ZbTbXb
         15vv10FO6KEZqFJgG+5dZEPMZH4I1YCWz152dYcjtm4pOJtRvENh1PJqjw4vOgvi5Asx
         bumQ==
X-Gm-Message-State: AOJu0YxNgDjfzQvyMHk5/LZExqxxuQdiaO1tP/oUXzDA6M6l/rhwMa/n
	eooZCtqLSQWI4rOpBx3zznvq0NUDIHjdnfezEiM6juR60N7bJExj6Z3YjaeQR+C8Js8=
X-Gm-Gg: ATEYQzyjDIqiEzcQHBq2zHIjFjzvpVLgOnGt1/ObWww6mDF1cp0Ap6cWb27SKMOrMKA
	baVXY7nPmV/hKUlhPLDiYIoJ5VUwHkRj4YMzph/jzwkHHRZ5qhLbdt1GwupnboJb7/9MYuk6C0n
	HGX1BqUL07w/LXJN2NLU17pCOIoMNwbTVTH5tLRpcySkwHsK8HqPXkq7t97BmJn/AyvDELhQh1M
	WFDc8xshXoozS9jMFU9vLjB5CbE2DkdF6uZVs7a5dXMzxRer5355aDysyRQ5QvVuXrtM2P6JLqY
	Kj99mZk5PIIiQzlk24Ds4ptBNdxtBFsY8AUo5KmudLrbIaRCos1VwxE9hopRPlmHuPR9EaFJqZ+
	ppQ7XnZ9QK48JudjWQQcRYAeW0ZAKQs6dLBTmTK+cT7tEnTXw3FOgLTo4SYKVefDx1bwnmb1Xgw
	qKHkFWADKOjQoMA9pEdg==
X-Received: by 2002:a05:600c:1f95:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-4871608323cmr44167395e9.26.1774436196185;
        Wed, 25 Mar 2026 03:56:36 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:92ee:b67c:a5bb:13e0:f6f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836a3066sm175807585ad.75.2026.03.25.03.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:56:35 -0700 (PDT)
Date: Wed, 25 Mar 2026 18:56:25 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
Message-ID: <oghve3ghagpn6txd5y7degpy2souymqonz6hkq2kuys6n7d7ah@e5vf4hucvgn5>
References: <20260323134503.770111826@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230313-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7E25323712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:43:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23507388452/job/68418868880

[...]


