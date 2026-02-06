Return-Path: <stable+bounces-214603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCpGFfuBhWnpCgQAu9opvQ
	(envelope-from <stable+bounces-214603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:54:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC596FA7A3
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BD1301AA60
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 05:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73582E54D3;
	Fri,  6 Feb 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eHz+BbrT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038C2E424F
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357223; cv=none; b=u/FWg4+oHbGc9iddEhV5USfGr4a1Eu9lJF+aV1aiUSwltWga97cB9+aRFKq3FPFq8vs14Jv7zx1m9sFrPW71btS8S4cPOjos9quW7q+KGj/bZ6ocoGVLLZCZ9oPcGZy4elcDB6Zdb4IiwCDM5FdFYa0N4WkI/36DmNE9S+DWlfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357223; c=relaxed/simple;
	bh=CpCoabRKPh4PQOEGC2+tUnh+EMTtnU1w4cwVugMieuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7mNTJQNZjMwBR8tI51GbR17XMMd380tDHaZ9vxlkPZgRJZhEzCUlcXARXAvaUOBrg/SEZCSV072y+H5OBSRcfFs2DNpiePfP62arDcREG/W12eJu7Nw6vxXLX6yQQa2zT2/pLK1hPaVFYYF460pPEwKX39Af2uXmIfdtYTfPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eHz+BbrT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806d23e9f1so19334615e9.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 21:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770357222; x=1770962022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4JtE3qnqshh2jJl6h63kPh5x+A4w2hQm6dtv26xRB0=;
        b=eHz+BbrTpC4n8AzxrOzvguczujFTHrmX5XCA4HkWziOGroeoObR+H0ghOFUw0JaR0M
         DcPqnce8/GA3xGdUUNMZzzgQYwXmsbjaZgG1PhdkrnnVWNU8ISsBcA0zl7jJeyL0vRXP
         00ZYkSThih2Xp+7+m9pm3gm1Ip8PQ8hduhad3xeEVVHURgPFLwYhFDSQhaLQ9LfzOq3e
         q6Q9LfrZqmsMgBhCIQoZVOk+GPIZxwAH0ClUGRt5GMz8UqYsG6YxDf9qCFsTklHbCmSc
         DnH2BnUj4eDDgb+/tWMTfk6WaMm4opg1PIN1oLkxrTdEAqAsF9UXr/wc5EGOOYRLI21U
         +ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770357222; x=1770962022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4JtE3qnqshh2jJl6h63kPh5x+A4w2hQm6dtv26xRB0=;
        b=MkEtf0Z+wMdNxgOcvqpIfL11a9UsH2t2sTVf5cZLXdeHVjUFa3CgdmXdNxU6BkyAfy
         qFD/mmYw3ewNj9zY05pllAdNG0Pnqs2gLMRoSKtlWG6ij1TBZOrJ6Fm7ntXiJIYZTM/5
         pTxo1jRxpTfA+onNDjRERAt4cZta59LmkcdBsQolGHUHXLmt72RNH4toZdUobFUddR6/
         Dnnyh4LtxL2CUIDmRNnVQGU9rDfKBoP2jF7y+vVnbfe7LmWPH0P4AXijDnJsWTbRkIKQ
         3jb+A02vFhe5RDoh9+PiTev2CiMBN7e5ephqwboPJWLHAkuolgXWho5wjTZ4vXrw1guV
         XjlA==
X-Gm-Message-State: AOJu0Yy0JMmy91Xx7j6bvNAjE1OCb+wGhQSHyh/UNnt21qTqNr7NIiVT
	1TtDdrSJYwc6gqaydo5r8hI5g8HE9yMeYI8DbjqGNjbsaAWKWIvfFZiptJE8wVSITNrso+UKIPW
	PVWi/
X-Gm-Gg: AZuq6aKw8ktErNCzk6u1SYFRmy6y3VTlo3WxBjyRtyAjLw2cF/REIw0JnapAz+yHovB
	hzxxYLyQ5P+HFN/3Zz79OQufx9nF1NRWv1uTbRF8Eml1MeOi1ad6gqHdI0J+lUMZBDWlAluti4C
	QkZMuRutZcoQMpQ0L5slH0Lq7ZzPM/o2Lnw1HU5eq+rVqMCUp/fVsVEdo/a1Udn3FCWsgzFJIph
	BpfeKbTYUB4mCKT9v9/wAiNb7HzjDbbyT4GSuUnpKDyy6ydGPj/7WNws2LybgQaMM/kwahktTvc
	Zqa4JCR2RxhE/7DokqNSbAHysmT2uqsnFSUaHl8vji/NWM0z15d/CcabLYTiL9GJMsax9gtPvxk
	yOpffy+79Gu/B2pJq+Glu7Or+CDKnGOvu2MDE+JztNzIs3pWk+gE0MwaGiGMPWTxfT0NTnNk3eo
	JDLeyWyDjVR1tseLb+qgrvNqxuYy/b77lU0w==
X-Received: by 2002:a05:600c:4f8a:b0:480:3230:6c9b with SMTP id 5b1f17b1804b1-483201dd004mr21171385e9.7.1770357221652;
        Thu, 05 Feb 2026 21:53:41 -0800 (PST)
Received: from u94a (110-28-26-119.adsl.fetnet.net. [110.28.26.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320728774sm26993835e9.14.2026.02.05.21.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:53:41 -0800 (PST)
Date: Fri, 6 Feb 2026 13:53:27 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/87] 6.12.69-rc1 review
Message-ID: <ea7clhl6deykiqn2klghwgt4jtcvyjoigv2oyvzqwzgrcnbks5@mpax7k4545e7>
References: <20260204143846.906385641@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214603-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC596FA7A3
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:39:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.69 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21724288947/job/62662113810

