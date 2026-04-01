Return-Path: <stable+bounces-232702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oODfF1m/zGmYWQYAu9opvQ
	(envelope-from <stable+bounces-232702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:46:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC93755FF
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 000603093849
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2232FA2E;
	Wed,  1 Apr 2026 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eSZftST0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03826C3BD
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025951; cv=none; b=XkhC/jb8jiroe3B6U+a3qOx6e9wjbMrAuspeCGvtrK7Q97xjpE5rDFTG+detJXMzeeQNuHrl1xcvKvjkQBgYPc7k9tLgIDCPvRB0zFJWy9VCJ9kEDrwZBIOI/VVw2BJBwo6dGuXd1XSk/+KA80dQVJE9SfrvEVvgA+6mbGd21As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025951; c=relaxed/simple;
	bh=Y9PsSAeF2VVTlv0gxp4NaYm6ElhgGVAYI2NCjV83v3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqmjiXvzxVbeqyC3fTL+4kvVIrxoE5Ut7qAJqw71O2pP5ZPdg2MDESVr0dboKLYh7SSKo8Rv3cT1yiP019SkkO7krG4dq//1DPzykng+BBGpZIkVqI5cD5PXURJU8jYfzJoHhbIzBr7H1qEGQpZ2CqY6YbMGZthghEhGX/ElWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eSZftST0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso58935555e9.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775025948; x=1775630748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eXLAnhmwdFqoYouk9YANXlnI2O5gIXzF7yJsegLE3E=;
        b=eSZftST0jVudoUxUY9Di8vxe2rolVD7So7xJXTzujE1d9O5Hyc5Zhhrem6JX83nXDc
         aI2fPjIUAhsVl2m3p6WA0uQTKEXgqB9iWoXvu+cqD91p1kkbd8K5VeeOuTEsJzEnMx62
         ZyrxVxh6C05Mys2Dz1abwwZcAC7lJ+9chKkZSLZ2cYgrrJtL2FvKoBYezql0Xv4oqMqf
         +G1EopIC0Y3N+79lAG40wpU+nGsn+uuj8DQBqTY4mHmy0O/RgRvzflQmXwZA5TRqPF3K
         WZ9Cw0ETkROEPcI6kaO23TeoukUJAlUmDnIF+6AWdV7YAszdGYj2KSjraCAlNGh5+E/l
         mTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775025948; x=1775630748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eXLAnhmwdFqoYouk9YANXlnI2O5gIXzF7yJsegLE3E=;
        b=hFIg7xNk7Lycd5/9NRzDqGlhdGhuOBLwvkmUBkQjLhjAKsX1t/jPuCrzpf1lNi3dnm
         80Vy08odTcs0NZVoizkvG7a1fNhDBRhkV3xPHpcOFGg8B3vWOwpH3zMSeaJQfzNrYp38
         TwcPXjvVcEcY1milebNMpLFn5fKAsIWy25juSJFYt9Zo2UCB389CaL7g8AuQqPpRI9pR
         LNs7cNehzbZ6wYh6DnDyonu924o5+YPwLp3sHQ/a1HgHwKODSxZqxbLXh/+YmwgajZ7i
         qW1jf7/yAOUp9eLLd4cimEo0dBrnd1NAfAmcDDl1VhmYpk3/Jzlakj+XyC7jZI/hIeIV
         EkRg==
X-Gm-Message-State: AOJu0YxRTE9G12X6IRh9LK9NcGiwWnWuDwFafdy3DkQniFdVS/TbQIkK
	SCyNLeDVlLzFpBmNlBeuCfOeatmknUPoqEZISTswjvxzUKWP1xLCzqvq9GxaLSdkpY2bIxOu7AW
	c1I6OIkYgsA==
X-Gm-Gg: ATEYQzzkpgvaspr0JGWN0elbXH1lYTzOvVGESoacJOno/ZJ6A7NA40zqFUuDfzl27Oq
	dcBGkfoEQQ5V1PDX+boE0DtLzZ1sdzAAHDLWVPN1RyKqkDBVjJMf8O6QvJfYULhFTTqGYL7r3bH
	XvZlXk0xhaO9ppCGREbhhhVUqIxyol9GG/jsJWsqyWlbBetH58h5r85wXWphjCXuGB3bhS3+oiU
	wQI7VV6GzA3i7kgw3kHtcStga5ZNPRqwbKlMZo2zfH/aSjcc4Aus0VtrLTjZaxvWX4Y1htOQxS3
	2uHtceFE8HqtwqoxMzBrse6GoSIiRXshzhM6T1ect3xVceJuAvMAFMF5ALKEDk9O1RL3+eQ0gj3
	06ovaGKJ/Efh7qUo4fvzWhoDfD6pRpLQ/4bI+GcgEMeZnG27DtwEliGhkFyZrJDUQ1deoI5dC4R
	VDWAMuavzFHZUwz6pKaRFf0g7HgsAJBXm3/nhAUAZ4llRWHs1E
X-Received: by 2002:a05:600c:4e0d:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488835b76a0mr36100545e9.22.1775025947841;
        Tue, 31 Mar 2026 23:45:47 -0700 (PDT)
Received: from u94a (114-140-80-217.adsl.fetnet.net. [114.140.80.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e1b9esm3873321a91.3.2026.03.31.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:45:46 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:45:38 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
Message-ID: <pejzbrndilvhthlxa676kwrf4ftlxxvebb5sz3mod3caa7j5m7@v5n5wx7ic2c4>
References: <20260331161758.909578033@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-232702-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: CADC93755FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:17:13PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23814574909/job/69410511598

[...]

