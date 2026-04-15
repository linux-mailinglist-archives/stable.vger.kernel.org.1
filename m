Return-Path: <stable+bounces-238024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePhsLN4K32n3NwAAu9opvQ
	(envelope-from <stable+bounces-238024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:49:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF46400216
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9063330A1F79
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77534FF4F;
	Wed, 15 Apr 2026 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FEP5uXvY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABAB32C94A
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224984; cv=none; b=J+lVfNLsqHAt18YHV0LmzlYGSD9+HvFb+QLTjXcLOmSkv1CrnFePU9pR9ner8N/xuUfdge8DviAumXm522HWmRb6gvbNYEt1ADQQUWgXgn41LZsLVc21f/HTpbqX049Vw884t4yJ5M7GnoVfGL9GMCV78YuWgpmdXkct8bCCn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224984; c=relaxed/simple;
	bh=ZijUqXMpRQ33RknbmDmD059T52xA36aGwzSZGewDrxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDAUUSDYiu2wmNPRiUXcFm9U4OOvZ5u3kmjCibk9dgdypxNx3FV2BWbdwYWbk3x3qmGOXhl81sjwfWfrruI/V3Y5JOLXaA06Uvin3zaIPDhZsc+LjzzaS7bWsWGpI++0FwEvVXYw8x+PP4PbLJAf+IMVkpS32IecpK2T5dJq/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FEP5uXvY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso63810375e9.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776224977; x=1776829777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGOvI5OHYbBtjjKEbHS0QOhfaoIWVWTKqWQFyvcz2QI=;
        b=FEP5uXvYdc0DAnwTOGB2APgnvJubEdzr1ZnqzOV8BOmut0zHcKbg/odTn3xvnmSsMC
         o3RWvWbU3pXZLGXHU1Yf1JdKWHQ7wQeVtDWmJ/u7p98G99syWZSnC0nCiEtQ01pCQ9QJ
         q5cO6mbWOr8leDT1+H1fZAacz4IyabzlK1WP5CJenaq5oPjVvHd8pcIkpTC/YqjQzN13
         w+YhHOqCbIbLFO01UihQN47EEhYC+BlXWntbBGuuD3aaXYZXFf3f04Yg8e5Y0qVM1DIK
         UcUr2k3VsjxPMk9f/y57N7eArNsawgDtNY8x8h5Xzb+nCkdt2qymMb/Np6ZJN2N/auZt
         mWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776224977; x=1776829777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGOvI5OHYbBtjjKEbHS0QOhfaoIWVWTKqWQFyvcz2QI=;
        b=G8LlYzOjf+8nIcMLCEGT01TDJaa0ovjeYORfLwkaFdf261RmgPv/DmcUOSRpwvw5Az
         zSteJtlbZcIoaNKQnfPOV+0WVxr5FPJ8u7n3CejH+GreLjp3BK0J05ZmS4ou4xkstHU9
         XpRcH5Nj4A6ifiXZzOXxCOXa2hI2BmpLL4ITwPEFzMqd/kPA246C9ufjuit2oq3n/3GK
         RmTOXjSazZpMLaaab8Fsd/OndRlNq2KNgOpGT2E7LGXACSGMsVspFNAqjsX+hOPzcUz4
         kDlUcq7+vEmzYEPiUN2TOhGdJtcEU9vIjaQtZTYnJoJLh/GEmEQn3InoAfIx9kSpWYVj
         MLVQ==
X-Gm-Message-State: AOJu0YzaRHr3Aj4MstYOz9k336xpY3DMn0RimdkQmWjUW2MY0ogOLgnO
	Vo5hnLsfEyBC7XygdgxkDMTSXibdXhdGVk2qAfivnMDuSLO+tQ71IcZtSMhxFnM0IW8=
X-Gm-Gg: AeBDieumHWdrg50OkU6ODN3oZX65ZLG0g3DajbLsmEOM68bLRFf7kWqcV0gwMCIbL5u
	7Qf/CzdB0i3YcB1wcyTSgufDKGwDLDqBZyHAOkdh21sgBfDE8EUsmNEbZvrUzsQskpAHwWeB/lq
	zxJYljt6oppB5+IQLTl8syAPIyLslRthEzyxK34sRENLZjYc+jgDcYQFf4XsbpGvG81GiNxnUUF
	9LTXu9MQuowT27zNdPDhrs/k8XE9NpPDe3MSwrLfPPhZt4DcfZcNRAPiKTOCsT61sig7qsFy154
	YQ0lZYEinjCbJEfohyzfE9StDNx2pm3eXlD2T4Ao/Sr+81CtaO9WojgKo+9L5zQqcspXsW7UGOo
	G680ffom8A234YiAKRCb5sCfFaa1NKxzkUthzNZOgpXM2bpDSxfOa1ViqT23EpjwX/6yskZUp9S
	2MR42GfjPbuNipUgEeXU/47A5+2uJAp8P3ArCEzugzkiWigMkTKJo=
X-Received: by 2002:a05:600c:49a1:b0:488:a502:8955 with SMTP id 5b1f17b1804b1-488cd4f4a9bmr228282245e9.4.1776224977392;
        Tue, 14 Apr 2026 20:49:37 -0700 (PDT)
Received: from u94a (27-51-0-223.adsl.fetnet.net. [27.51.0.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8443csm926559eec.14.2026.04.14.20.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:49:36 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:49:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 00/50] 6.6.135-rc1 review
Message-ID: <g4kr2vhnsgtnnurn7cjwqe2louy4joys5pv6fmvqbdbj7illtv@u7ze2ovcaplc>
References: <20260413155724.497323914@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238024-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AF46400216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 06:00:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.135 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24418242274/job/71333106580

[...]

