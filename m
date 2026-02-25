Return-Path: <stable+bounces-219567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ez2EE2fnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:05:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21EC192EF1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C61C13008994
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4219E97B;
	Wed, 25 Feb 2026 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LbbsewL+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40B284B26
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003144; cv=none; b=CTHIbDP7oguuvwove3Kd259xcCH8zLCcuoyJZ4k5+ZrD3S6fOlTdGKvD3pxAgaEEL888Ghk1057+aufljbh+HHXC/3JY8Z2uSwwzaJ3iBJhxyPdOUf1k7gUg2yAFg08DUBuUNTLkpK9Ye1A+H2qC+enCG5fz8jftllTvdgK+ABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003144; c=relaxed/simple;
	bh=oaiN+3Q6JNH8HN69LB/Dz3Df6D3B41uiZsYqTvO3sQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9nTRLpmUMMDPa1TPbxEkfnYbEqB1S+n72oJr30SZdaA00MIwzAe86fxFdHLu+o7kPtxJx4Sg+ZKv4ck9MwmAdFkiGN7Lq1B6KfcHFvExTOdy/nH8ZmlHX8//uiRqMwY0Hyh8mj3+ezGXJn+qPBztDqsVphJkTrGJuFjuiiqgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LbbsewL+; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so77831135e9.2
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 23:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772003140; x=1772607940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twOtzFU4v1Xv/698z9QHqw7hrH4sKsKYh/GTOoz43aU=;
        b=LbbsewL+Kww0BDxWZ35mFYJ6qCTI4cFfv65RKh/DmBHcX/1vJeHIZgduW7jT8k6pyy
         1URYd6Nq3CpSF8YE/50xfp4+dCvXN4aNefSuFoHW7EoWVruRrrbBWQQtgTfNE80vP/57
         PTu3Fm0n918R6iZRPe5ZkoCXQl8QUMhobLTOi8sVSQHLTpCMs9p93guexPSorKDN7qwE
         cKTChy/r2X8+lO6eGTkj3bm5mYhzcMGWr0jTBXwHbpk58wVs1bVAFvyLLt7iTrZb7okx
         3Jgj4FjnNpRJXcTPvvwwZVSZyaEqoeNUuaL7sXd4WsrqsQr2eDgfEDpmZGN0qTabWSV8
         U/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772003140; x=1772607940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twOtzFU4v1Xv/698z9QHqw7hrH4sKsKYh/GTOoz43aU=;
        b=PWDuEWVhRK+/JEbpLeqePCm0symusjBqVw2ySINMKa2BOytO3EevrrcjTwTydb4knK
         tLsCaJ3ADL0HrqTa4tcq8G8j3pYIZ6Ud0TOXwV1bjiljDCy5U9bxutwMAq4gOMAY3oms
         73u+RFYrMJpLcrO4avyfcbO9husP7IDdZ0osOebIoQsBkYY/hqArzI+DIllyJ+ZI7aZt
         FKh9c5vsuX1vRJ9WpDjRwntlENqfUZErcQS3Tk7t1WrWBMLDJQZKRfpczu0oD+9Dy8EU
         fiaHtty2A5OVtVvcsUQZt60+PJJzc44p5DyIDjmxxxg5mrAgzg/Wunuj7jZb9nmUNQsL
         3D9A==
X-Gm-Message-State: AOJu0Yym90JVpwXJ1EIMBLrpvP8zjDtA4plweElvVRgFvIZ3B6KcW+HO
	vN9c29bepWXCtj2E2dlJU/lA2evYeCVgSXddAnjVbi1sokIGnPODR0DHcLGWlRNGhss=
X-Gm-Gg: ATEYQzxb7+Oy6w52LqC13iIZpIUCUn/yUuMWCCdTTx1ye518UEjbqfQEg5GgXqkeRHx
	0MW6zk/2ZUSAV7eGNkUYOcUOfREUjtiBpTr8cXIF92pRfytBSFf+m+YDq+bkudC+2EMHntwGYsf
	A16wW4QfJxPh/p542kVEUzmiTiwMz+LlmHOCpFQoSDnm+0/a5RQNLbIpY9y7/tULl0tg6Zev3OO
	CF+/0jQMi+mkke4DdcH17PC+oISbdr1+putPGxq7HmLxHMo/XiUkUUlonlts/bDQKfrnIKK3KYU
	P1JwWvSSRA7RfBYxfMQCr9XnbeAGQmSBEtR1amTbo6VOUhpsHYOOmF9XtIdeGqzmR+wZndt8B/O
	Nvw+lFZ4ZOiF1irenBvhGrgD9xBsEPcbRGXzHfarTTF/oM7FU82DkyL0nfjjmj+SRx8t9FPYe5F
	C9jnuck+3KwFbSPlzsN8ckFco+TnObzOzepTGP9VacTGbnRIW0TiJBWI4OIBIfZO0eITloKgDSa
	wVf7Hu84Y2HwmP6GXm1
X-Received: by 2002:a05:600c:45cc:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-483a95f554amr244376705e9.23.1772003140189;
        Tue, 24 Feb 2026 23:05:40 -0800 (PST)
Received: from u94a (2001-b011-fa04-7b92-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:7b92:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ee179sm12219386b3a.61.2026.02.24.23.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:05:39 -0800 (PST)
Date: Wed, 25 Feb 2026 15:05:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc1 review
Message-ID: <mybfdcdw2sckodsnqhplmjr2om5is46olusfdfetk6piwpd6og@pplcuojmdcso>
References: <20260225012348.915798704@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219567-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: A21EC192EF1
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:15:26PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.14 release.
> There are 641 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Feb 2026 01:22:34 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/22381308704/job/64792250146

[...]

