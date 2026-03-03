Return-Path: <stable+bounces-222823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCswAaGapmnfRgAAu9opvQ
	(envelope-from <stable+bounces-222823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:24:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C41EABC0
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31CE43033D5A
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3486386C34;
	Tue,  3 Mar 2026 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WFYZ+rOj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24815386C3C
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526169; cv=none; b=A3QlfuGabtnTj1ym/8jG5gwewIW7tzzJIoZxk6i8Lrv8iDK2JQNleOLxMd3b8d2LdwDRl+2qWEsyKsc7WdFu6wj8K4hFnekBOjrwyVpDJ4adHvCAEz+rH8LCH8CeMIjN3LeXkURgSACGgd908hGd4cfS2rWEsHzlR3+npWEiiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526169; c=relaxed/simple;
	bh=2pzfiEvembVWOd2rmjbpprYL5xAVtPtFsQbmAaS8XgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKV4OEAim/MkBe/fA78FHlVVtFxoOjJb8gF8X92Vs2GGUsh6lZcNi+0Yc5D1f/2Cv9YsJ7ErypxiQWV4sHWjjbL1mlOyyT6oy04FKIWLDYx4Dwngjh0o2DHEPMnUaoK8OMpdn+OvBj4EiH9NgGiMRW5HdjP7SIueFKGsZWXuhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WFYZ+rOj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so32298795e9.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 00:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772526164; x=1773130964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mvi0nR4T/PJtTXiEjnIGfh777g0CKHWsBdC1JuohcwI=;
        b=WFYZ+rOjT7bc8QRayRgH08r2sK66gUhLrRUt71ccFmHEKyG8uZvxuD+9P260hO2P32
         F1S2aPHkv930KScsdeb8TlotZ65Vx3NLHoLFi4VNo6ryTByQ3YPyhdsnSnD/eZtNSUwI
         udeX9aqnAksscGElcCBuGmaEsw7GvldaZPDICKJULYtrf1JKnU+nqXCXovFn3Ly1cd9w
         oHwRVyuGqaREwHu2/yv5cxsk/t7QIW1Heb0sr/d6hBCeMoDL002sSSSn/gIjxxyC4dvM
         sTk5ij7vpY6+I2/JWCJBu0NNIMGJREXQl7LbY6E7z+fO9hpI1po8OxlZ4ITuTaps5KXB
         LYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772526164; x=1773130964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvi0nR4T/PJtTXiEjnIGfh777g0CKHWsBdC1JuohcwI=;
        b=WxdQWUxPNpwKoS+fTZYK9QSa0I0U4m/DWuuUqyxqj+nrRecPLbE57SAf282nrXfk9f
         VUJxtUm/hbJuSi+krM/mwfy9FtOUvCloFVGMRzt94VHiRgLjgeiGfUUdzjai6ycQOIbv
         dj06pFcImhSJ3dPuN9PUFRfNhzoYMPMWycMALUXK9vSiDbmWaEMvl+VLWtNA9vuH4IOo
         fiaeCmjL7FH/XxhQQ1gFyWaReUpwFFotNEJ6JYkQC9A8MJ8Lv/CTcHGHusky8xOdmb6G
         0UClcFdCdx25rJqNxFq03aqutE0JcpEDHjvFdylmSYelFFguisxBnMskZU/QVlRGE5I6
         nnIA==
X-Forwarded-Encrypted: i=1; AJvYcCXWb3Med1xFJkwu8yQfSiLC5PaODdms5k5QQVaCSsSFTI+Rl0fOHY8awpn6ApPvCWkyPvjYZjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohpZSakmUuVg89t292+8kZwDmUYH3lD1xR0nxJF2K9iRZKEW8
	AUIZa1uGL4uzsnM+k4HBmj6SaF1TIF4n+IKDTxPAX0NolDNPjwOwB2ORP4dS/GGmZLo=
X-Gm-Gg: ATEYQzxSNl1e8LRu2whex9W5cDnrjLzafbfhIAL0fvPlQWQPZTaBo3d41bLRevFkXYl
	di4BiEZT7xFdJvKBAqm/IFOIyXif53dItT/ZKn5t74Nfaix6qKwC7UuhkvejbKmn+FBwWIg74Jo
	S/5f6yHaYbCY3tJMcCDFPFnfu3zcrC6DCxYVJyBsMDTtvExe1ujnnzEGCueYW4XMMUtnSnTsqSa
	SB2e7jSfwyJhjkT5mOH6eMpOljAC63RIXpLe6gs+AzV/MJcnlnxkMzXQeeBg8h9HlnV/vCZbQ1e
	bhcrOdJ4UlDI7zJiztk2+6sq4lS0evEDgqNK+1oMQTl9WebGstZ1/THf4aBmMnuUrNUyS0dWNjJ
	dPrAeel0dhAE8ioSNgAVurnTXYrKH0aaWbhXFtBgnl3T+2bmtyjwzJl6+Cfo7eVZDoN+XFIX0so
	6Z4Hw3IQH4V8pP/9DJZBw=
X-Received: by 2002:a05:600c:a085:b0:483:badb:618f with SMTP id 5b1f17b1804b1-483c9bc5b7dmr254857295e9.25.1772526164364;
        Tue, 03 Mar 2026 00:22:44 -0800 (PST)
Received: from u94a ([2401:e180:88b0:32b4:4c71:af95:b813:9623])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa6203a6sm13792189a12.8.2026.03.03.00.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:22:43 -0800 (PST)
Date: Tue, 3 Mar 2026 16:22:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/684] 6.6.128-rc2 review
Message-ID: <h2yeyybqfi35jnjft3d4urdh3e3z7ua4nrvgniqnsmajxg3ofz@bpzx7f5dih3l>
References: <20260302160934.2521545-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160934.2521545-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 9B2C41EABC0
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
	TAGGED_FROM(0.00)[bounces-222823-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim,suse.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:09:34AM -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.6.128 release.
> There are 684 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:32 PM UTC 2026.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/22590800040/job/65447954942

[...]

