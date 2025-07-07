Return-Path: <stable+bounces-160378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E458AAFB7EA
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D1E1895E5C
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A81211491;
	Mon,  7 Jul 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFwgLutw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9D199252;
	Mon,  7 Jul 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903438; cv=none; b=fl0DAPBiT0/APyPWAWABKgJee4pONt5sH9sYP/30S7OhFEu1d8bqzinz6VT56KlTzAZCWq5jHETkNJ5SenexDRENsfrm2eK9UBNrWdic2assL85vi2e3oWE9bwqexWtuHJL3WmZD/o8Fp89QcEanwUPU0geKWNnLaQqEII8E5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903438; c=relaxed/simple;
	bh=OE6ekrnC4M0MwVxy/wI21VNyfuRcjDfh+dlzwyWinDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQZaw4ajyGEbtwuXGOoZHxKLBxYQwPS6fw+/z+XY8EbhaIqP/R+U/PMroOEmP9CbvXl9B76cJywi0u/5ztLA4G+hsFLqIMgtw6BAvY1XxmFduW4qAmlSumbuL3YOy4oltxnigi1n4ASbZN7k9n8ymEkx7CHo0V6rpHikb/4Nfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFwgLutw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748feca4a61so1792895b3a.3;
        Mon, 07 Jul 2025 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751903436; x=1752508236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZ6Mv0OEaOEWA+/kiIxbnT++kjT9MBnuUPvznp0dthI=;
        b=RFwgLutwgr/C0Ht8j6CnP0rocsidYBQAzEfpy0CG06vgRMBd6FJbaOiIMHpEFFVqkk
         yNYpzmgBie/RNZoXO8MZc/JCm5+CwVh62COHtKEmXGcgTlbbX0+BE6ZK6cUPFNy30ajJ
         uQgmqnAU0CedFH3dfiLwtCCq2ekA8XNU6V89yqcQWNWXgAOh/BOG5sAobgZM8h3mVXOt
         vb+SYcBUkwV40I9dwpDAEzNitnM2vFHl3uFMEiFpJYNJfB+RXBSmBCeyJNfZj1uXI7yD
         YP46aiIMbSr69lGmza6GOCOHjMyrjaKZaHO7prR4aURDIg6TsgZz/CPzxEFAGvFqy+8n
         erNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903436; x=1752508236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ6Mv0OEaOEWA+/kiIxbnT++kjT9MBnuUPvznp0dthI=;
        b=wQOfhJZ3lmf44+QUskArOi1hfhtMhoduUyxkvGFacfz6L1nU2oW+9wdV1AEH3AU0kF
         vqvV1sgIvyzXI9riN9QxZbhO0IkBmSrrcKyrhuiIziP5RvRz7b9hRWkVnKzJDsDLDS+J
         sZW4gppyWvqEcABK5WuzUuphHewjhXQpMIsVc5o56IBt2KIGzDEtB1UgeXGm/gEE+et1
         99h2utpmerKj1Eb5tk5VBY9BpiFVTbD/YBdXByRumQ8nLN/g75BMjYI/9PmNQ+O+xhF3
         vBDEcLM2EU2KsM5Nz2J1iHobHhJKYNw2F5byrswVVWKBRQjvH/mO4uF8NlwzCNU7FjKB
         q0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWvPTNdmeDDfVf+CFb6A5QuNQEV7dB2HxAp1Xs175vBDZLPRoqlYLH9b33AKXV6acLggrmDivqH3VOsyQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyLgnoXWxlkOFRpRz6xDDFlYroHTDm9SYq38gBDNIMI8sfKhCG
	mIm5bD91o2XpCOPpAHdeYwbgKJ4hNAi3V9X6r1nGqdI0mWDw3HDXkxe3
X-Gm-Gg: ASbGncvVTFFoFykz4bZTEpSVcBcM0NqBIvcqNQxzMzif1UE0iEyg8+VBSV0Q02TNsNZ
	HIAumwjPRYHiPzxJ9RnXt+LCPNibjzcTI00q53C2LHdKCFHtrP9cxxqWeHl5x6nM3UC11TIBmhV
	0004FMBAPkQcI/dZVYvE2hiUIdFRgwab/55cCJ3I90azY1EOmtLb5GKr5uZdNNUVCnytI9+BJvl
	stcjUkD1IbjjhPQAtCf7l0rfNOUthU6Dgr0QGNBwmlPOJsAkw4hVP/ack1UKDxSBlVeNjFGwN0o
	44RFF+2swtPU3rGTGL/Zja+2lpRIv0sxGxfX4vq6lUnEesblQHpi37lTBilF8fO8vvQT8dVE39r
	d2PiR/DikYg==
X-Google-Smtp-Source: AGHT+IGgkpmjbxpxYXCE/TsDZmOdCnZuD6FKwplAAj1F8D7VIhBlJe3WEWwr2tw871m5IwR8avA+vg==
X-Received: by 2002:a05:6a00:17a5:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74ce86d45b6mr17451540b3a.0.1751903436355;
        Mon, 07 Jul 2025 08:50:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429f5adsm9598045b3a.132.2025.07.07.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:50:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 7 Jul 2025 08:50:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.4 000/215] 5.4.295-rc2 review
Message-ID: <b648e51d-2244-4295-a917-fe1b0f391074@roeck-us.net>
References: <20250625085227.279764371@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625085227.279764371@linuxfoundation.org>

On Wed, Jun 25, 2025 at 09:53:55AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.295 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Jun 2025 08:52:04 +0000.
> Anything received after that time might be too late.
> 

Building nios2:allnoconfig ... failed
Building nios2:tinyconfig ... failed
Building nios2:3c120_defconfig ... failed
--------------
Error log:
In file included from include/linux/mm.h:102,
                 from include/linux/pid_namespace.h:7,
                 from include/linux/ptrace.h:10,
                 from arch/nios2/kernel/asm-offsets.c:9:
arch/nios2/include/asm/pgtable.h:303:19: error: static declaration of 'ptep_set_access_flags' follows non-static declaration

In file included from include/linux/mm.h:102,
                 from include/linux/pid_namespace.h:7,
                 from include/linux/ptrace.h:10,
                 from arch/nios2/kernel/asm-offsets.c:9:
arch/nios2/include/asm/pgtable.h: In function 'ptep_set_access_flags':
arch/nios2/include/asm/pgtable.h:308:17: error: implicit declaration of function 'set_ptes'; did you mean 'set_pte'?

The problem also affects v5.10.y and v5.15.y. It is caused by the backport
of "nios2: force update_mmu_cache on spurious tlb-permission--related
pagefaults".

Guenter

