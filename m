Return-Path: <stable+bounces-212724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODR6DwzCemk3+QEAu9opvQ
	(envelope-from <stable+bounces-212724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:12:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 978D7AB0D1
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3AD3304CA49
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305E33123C;
	Thu, 29 Jan 2026 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c4lWHZlP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86634FF41
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652651; cv=none; b=tqvTJvQ0K6LuXxEmnli6MmHrLS73PuSmThdMFDxxmJN+7ZDKx/jxFGHwQMzzsHMAVt6Fl+yO9fqP/jEzPP+ZIMHl7T0+4Ux/fWn6A1bHeE9hcnpMi0Ku371SPPeqMheHRV2ojvr9G/HUcbMQ4Tvkd4GQCvcx77NTGLC5qr0K2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652651; c=relaxed/simple;
	bh=zFWk1e3r/M1fMXJm3gZiS7LuAom9jGmiJSVg7tfkmC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G48BPA9vKiqUP1dl3xPIfViiE1Tcn4LcgurhpiS8O9HX1NAUt1tJ9XTxkhyfbxzXayPXBo5DOM0LlBymxb0wPXfOZS+cJ6SzRH8ckzaHGITbTdmo65KKpKlGWSgHt1E7ok9qSPBgOLG9unAjR+yjcrek6zRiIoKzkpYeySXkQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c4lWHZlP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc305882so334257f8f.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769652644; x=1770257444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mdo4aXnLBT/iiMTMoK69hkdn68r1wpFyn2j8vkuRgng=;
        b=c4lWHZlPeN17is7qKVd7bEhPpP+uuUla4dmzQIOZen6uomK4qk0xQEdd1rs3eg0pVS
         OlfR0re+RHu97dgRxnGbMZOSm7m6/fydX1eRgAkgVLKnTaEwSnvkGEcqz9Rx3/0htOWn
         wlctpiN6CwKwGq1hLSLO+cfTVZyoZJrljGiz+Zj628Tczqq1fT9HPNGyO0nGl7O8W54A
         S/jo3aU2yMod1fL62V/RLHJpolZqh36Dpc1lCx+oCJbUfSaRCHKw0nW5fkmMkItipg2l
         UXQNle/Ked9OQl1ifoZ16Z6sHrsb7nfkK28crnGoKkpl83/vgNso7aO2HjEd0jTAojbj
         HqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769652644; x=1770257444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdo4aXnLBT/iiMTMoK69hkdn68r1wpFyn2j8vkuRgng=;
        b=spxOWJqPYX1dfp8vOATz5uTixwFeI+60+6eOHUolhl2JuXR7NbwBnGNW17QkLxYxAr
         bnL/c+o67ZltEOh9HcnaqcyKXqOnx2YQr0UGuOEB6NSorQyowE0au2cJhtfgIXhWxr5M
         SyTwL22DUG6vuPXuUvmEt3TrrvRzSLIKKG9WVsf7njJUKF+Y39QVIs5aMn0s8WLJgO2k
         mlPikoSya3Cn5DP2VkepQcMTXCnzdtbYs85wbg9PIpDcosB31/Oto02bnIsVfj3gFD1d
         /pZMvnwsxKm9FZrmhFHkDIQnlTnekOdKiCkMvYpO3JVSqpbqRFsHlurYR+y557WvaVkn
         pP4g==
X-Gm-Message-State: AOJu0YxsFIGJZnj7kiV6PYTsiM4sA9yYLx8h6bJsToXpuA1eUJvPuSpe
	5VhogPxcAdN52e9bVy3GqfYWW3SUvVumu9Yo98Qpvs4jIrU4f2uBCa/Xg5aB382SwB1Kztjxtui
	IdPpH
X-Gm-Gg: AZuq6aK3ppdR7CAnEwfYePGnP7BieETTzpnLQ/hP1KMSWGicW9foQiPvLhOMh81KOVi
	GLzxy5MKmFTLo+8BWawbltiOEBzNBJLQac+IuaDLGbuSElcnKdC/gxolcP/22riu12563nx5KbY
	9Z5fBdVvFA2rHE/69E0IAdf3TektGpa0k2nO/S3y0zQqVB5FQTO2yMoLa5vF5UkGVXUH4eKhMSk
	2MWsHtQV1j3wH2A5lvSGP8yXE3QZiAe9eI4UoqlxMeBWATyl/Ij+EWh015/jGb/NECQEsH+auN6
	pNQ5tIYZjKEpz7zyDT2kNF9jIwEgVBq6Zjyp7E2b5yV1dBJdJIWovCmUb0CohY/v9XmCJRaQ8zg
	BPdNtlQ/rvcJga/YVNjTVhj0EbDrc6vnegyfuBcAfTVr3eFQHj2FMqnsNSExDeeeZg4Wz6W6Ilr
	sUORO/pZwUDVPT1Ejk
X-Received: by 2002:a05:600c:8b2b:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-48069c73ce1mr90022925e9.36.1769652643751;
        Wed, 28 Jan 2026 18:10:43 -0800 (PST)
Received: from u94a ([2401:e180:8dfc:3cc3:8fe9:e99:6cdf:244e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c50fccsm3650437b3a.60.2026.01.28.18.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:10:43 -0800 (PST)
Date: Thu, 29 Jan 2026 10:10:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/254] 6.6.122-rc1 review
Message-ID: <potwu6hrwb2gnasbsl55jzamqrh5rieyld6xokftzhm2q6bhpn@i6wipgeac65k>
References: <20260128145344.698118637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-212724-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 978D7AB0D1
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:19:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.122 release.
> There are 254 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21450963930/job/61779347519

