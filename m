Return-Path: <stable+bounces-214604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ5tMzOChWnpCgQAu9opvQ
	(envelope-from <stable+bounces-214604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:54:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA89FA7C0
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6509F303A3DC
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 05:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732912E7F25;
	Fri,  6 Feb 2026 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WfdSi1yI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730C2E5B27
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357269; cv=none; b=TkvULzh0JCayp7WVVl+zBL5cmKAkR0KvGGzAT4XbUvQrJDxUuiTTmH8Em8Vi1l99Izf19VZ6CmeLWvmeLLD7E+pmjeBhElpQ+p+J7gNf9X+OJQbL3b2UrahvVDzxZ29wty9xqKoR7ZGr7OokChxqqIQKqPrY4P+mvgByXdhBi9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357269; c=relaxed/simple;
	bh=EhdvDTYAc9Vo9BbpZbV5f63om+2W4+SbxXWPoj0RGqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoH0XvO4fapejDV7K2DZvkRC4kw612Z0VQ7NRB7qAaYef+PxuXA/Ake5NzyWOLSIvkcq4YiFFdqEgWQrYraK+Yl+oBNRyUG1L5mJdY22GRVjjFdFHjVPo8xus4wcUXf0N9HbUd3tEnG7Xvywt7/gg8/wCZCZ5FDOxtccWtUVrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WfdSi1yI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362c63531bso95259f8f.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 21:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770357267; x=1770962067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CFi/b2GYgN/Jcys2eNmSiZzHY0LBuG3MaUzD3mehVWg=;
        b=WfdSi1yISIUkJgvkEQoPcd60q5ykgFUw107C9TNSakLVHc/znYxakUMC2gN2dDosQG
         qm4cpu0hc6rGZNRg4y/aqT9J87SHTIuKLzQ7MXWCKakKTzy5DkvXHMjAcplwMMbL2rDb
         VNEryWFijyfnsdWANarKACr4d5IdJISh2+PrB8nLQuiwif24MI8oGkS6TWMKgOgPZ7Kn
         z11nv7qu1AT+mB5QZ2zzPXaQ0E44FsKq8xa/szNCD83TtTEQcRIZpBxAy4RsYElqg6ZJ
         ztYQZa9B+RbbUVuLjl+3CtlEuxGp/9boh3UxHvUlMQTBxWW/TNtlxeMPIoEe44HvAe5N
         laiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770357267; x=1770962067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFi/b2GYgN/Jcys2eNmSiZzHY0LBuG3MaUzD3mehVWg=;
        b=M0UNZOYQsMwcajXqjtqYk8ZeBqTDp1Mhzee6eeqGKDQgBtUgoS0nJRP4rcVYtlp1tz
         4IcOd9iZIZfDli/6FCT14trdtSMonwkvWR2IzdcFomthKLCXJYEzTFsgmVvGewhC8Cgi
         PM7kc6V4fnIrEMOM+fl59ucVyxXi+Xb+2llE7bWItz1rhbOF9IPGV0KIKeOlxuRJDtQt
         YdvSurS0DzSXp9tB5k1SMwoq3bJR/eeKr6v27Rd+252cepzuGCVHgKX4riuAiTu0QWyu
         TYd0C+BTftdrsa4ZQ4+CufmFKrZECEOkw6NqI7bzagZzPHRswhSlfbKGxn+/5ZawG68V
         qDTA==
X-Gm-Message-State: AOJu0YwU2YTabQtbnBKR1qD7xrFp9mr89MZudj9Jtt9IQu90g1P2bCN6
	7waJUDffzdyFIdB3a5BGz1jkmttapQTXpvhSUJVI7de0e7AKG64bys/KR7QAoHszO6E=
X-Gm-Gg: AZuq6aJh6kkvkcJiesne3SeF8xgwRrqQ37Ane1D7jg36HYyS3AMSqUDzw1E51zKn0Va
	yVDhs/NNtRY289lG9ThY/OrRDLFD2+C+Fy9m5K9NQt9MbWf6razocoABMOup5kEowr3hCbExSZE
	cqxYMICR7OT/jR9T8w0fHz/j17uD/NCCUn0SosOa5H3gtuwlReInfqGTZ7Mc3mrRfFdxBRbJeqS
	hAqKKQ5bSY71oX2wIbY8pKH/R8jx3oyXVNKKzoVaCdqpH668Bwfh+lsUBiMXQYwP6uA7xOhJjhu
	Jvmk4qPiiZEuEu9v1O7oOWDdOb+69laMFgSZl0wNklofBVbkDzoQHYonomjH3cjtXgsQ/EJGG8y
	w62oY7DM/Hgbs/NZzxqV2zfyqR2rV+Wt0c4tfYkJo3Mcf8vtUV/s2R60xnrJO0O6sv3TMVUx9ck
	GpwnCVlWhk9Nf2miuxBbf90Y52cYQHQ42/Gw==
X-Received: by 2002:a05:6000:2284:b0:42b:4247:b077 with SMTP id ffacd0b85a97d-43629378392mr2208437f8f.41.1770357267434;
        Thu, 05 Feb 2026 21:54:27 -0800 (PST)
Received: from u94a (110-28-26-119.adsl.fetnet.net. [110.28.26.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629744ec6sm3792776f8f.35.2026.02.05.21.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:54:27 -0800 (PST)
Date: Fri, 6 Feb 2026 13:54:13 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 00/72] 6.6.123-rc1 review
Message-ID: <4yvmrdeqjezzipmzcgqvqhjobdmuxlq36ofwtcjir3tymyl7cp@p22wphggeuqf>
References: <20260204143845.603454952@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-214604-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 4CA89FA7C0
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:40:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.123 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21724288947/job/62662113814


