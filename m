Return-Path: <stable+bounces-238022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPrCJeQL32n3NwAAu9opvQ
	(envelope-from <stable+bounces-238022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:54:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC68A40026C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87654306CD2F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED231F98B;
	Wed, 15 Apr 2026 03:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KPTi+Bcs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351B31E82A
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224925; cv=none; b=b3ZKaZfLbigLraCvlT7OnW7sjYXR7qetKVBnqdlRs1gPMGoeevnkQDPs9l7HqOZWoo6qbWDsl/iEf0gP+m+01gYt9ztyvWoHPmD4mSJW3YDuaJWhIZlqUljl7yEPW2rus+7+cMBq0r7jJQfdhtKs6qWY3ep4aUED5x2+xzls9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224925; c=relaxed/simple;
	bh=xmpNKr3sZuNm1DpxCF6va8lyNv0z5vBmJL4GoSKGiUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkSYVcHR8vPbnDwn1yEe8WWCTA/JiK0MF3HebDfs5cP+MI1NOx4Mxm9vlb9cb5zLBu1Er7FaPvox4wsXmIRSODILQa2zfoOPmObIDKyyACsb7PHddaZAKGobB4mSnrKGK6toUDYZGQ/3jLe5APEOkzSfrScZxFELwjFbADPGEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KPTi+Bcs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so98001495e9.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776224919; x=1776829719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbVbyOkSh2lyvTzg2JMw4q6y5V7NZGtrZdqzKB2plGE=;
        b=KPTi+BcsjX015uKaWPAi/MWAPmbdyQrpoErVQKVaNd8KguucIaWZSaWNevzZ3ygUa/
         q4K98lSoRA8fTGcWe3QdnklK2oqdYldHcuGkXOMwuVhTLs7HWRqFEtSQpct5XlcEEDB/
         xOHRI9ahqbrllYWjo51acDd3vcUeyCJvlh9f+vbaN5ZcoIKH+4imfi7AxeJmz6xBpbnJ
         UeKlR+Ibm/72V4ZtR9PITUbQQ1YgeEM5zSumpvbGNUGHvWT0vblU7RRZhmqRq9pcnXRJ
         nqrhrrHD8V95uIyJkgrri+tsEDDpd59kMC+UL4IIYW5GvO8MJW27rqdUeXQlEbhOlUrB
         Mpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776224919; x=1776829719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbVbyOkSh2lyvTzg2JMw4q6y5V7NZGtrZdqzKB2plGE=;
        b=CABnCI93dFZDzeU99g0DFTJGzC4Ul1NwGZuO32Q/AqRzzJYiRX3QPA91er9hyXwFZr
         IbV3hwy2Z58zIvwBVduOqBVgPezkzCa9vxoMtdtxrR5274JcLkhMaywb8DGucqfrJi1y
         6pEN7iy5J2qXBGj+lh3s+nUv6boe2b9qlayxK4m8FNj4c7I/Oh0gq+rfzbLL5VmOsTV3
         YBajDgwZIypkNNoSuvxGHPBgJEL8V9IdpwJ1JrqW/ZfJoZ2L5L0O6X4m6rEoFibzMJyh
         QX68rDQjZAJQIfUSmgGH0FjxTmNPJ2VhykEpqJagTro52o2MhYNdEGkf0ESp5sxwbMuG
         p70w==
X-Gm-Message-State: AOJu0YzBJT1f7DZdyhcBBe7EYqD+flMlxxZs142ihMaZKBd6Eg/ynp8V
	FvaDE+2oA97dcyF9tUlIxeGqd9WlaVbLMrRzkZD0/8BWmIFXQHESFLCUk32Wm3wDy4Q=
X-Gm-Gg: AeBDievHDE9/rFtAU06ViOVsg/T/Q+wtTaZ6Lbxdlt2PI+Qx47X01f38e+ZqCXA6bjr
	XsKEQ56/V69AHToLvgvMjrlbPEJgEpiqm6AAzQ2EKSWAWIhY3xQZRwAtcgN/B8nQeZtVzwpE05c
	ianTXv4NYa/Y5cRPKq6z60VJ6a2yH8zqWXZ52NvR/ivJPKAevscOwlW5aqsX5G+NMhDh+9TpUWH
	iDQgxouhhdlb/ZnOu4pFQvCkOWubcI4UdT4HBSghxBwhhcApa3jKd/mrg19M4d5xpDmklolArgZ
	IZj1WQhXUYj+9L7G4UUKU0tVpWQrUBD3yz/yDrOqLPWcY1696+otv2jlesnrFcgFVHL6k2KxZeU
	3x7AGu9VfDDG3sVlevBEEPLb0nAJRryYFNGPkHrMQoSdB/3hANKryz2QZuVGUFaNre1Ej8A19AY
	eXTNQQhzN7abX+7hXUNPgwzLA84yHLi/LhCE/vlcSqG2/T0HrvQgI=
X-Received: by 2002:a05:600c:8883:b0:488:a82f:bb95 with SMTP id 5b1f17b1804b1-488d689c18fmr207549915e9.29.1776224919347;
        Tue, 14 Apr 2026 20:48:39 -0700 (PDT)
Received: from u94a (27-51-0-223.adsl.fetnet.net. [27.51.0.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb848b8sm893258eec.16.2026.04.14.20.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:48:38 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:48:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 00/83] 6.18.23-rc1 review
Message-ID: <f3m5vrsdq7avvqxhn23ghxn7itpxt65ydfvnduwguu4uze2lpu@xjzcfitxjg23>
References: <20260413155731.019638460@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238022-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: EC68A40026C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:59:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.23 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24418242274/job/71333106647

[...]

