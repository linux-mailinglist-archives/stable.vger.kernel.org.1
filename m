Return-Path: <stable+bounces-235315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKAxMbNE12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:18:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF983C6859
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC268300ADBB
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EB1313267;
	Thu,  9 Apr 2026 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CZcLIbEE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3C30F531
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715499; cv=none; b=Uxt5U7qShmBKfqGSv1cUJpX+cVlGAw0bC0CW/rdZuYILARzMwLqJOhuo/kga6FdTCGsQSipBteTg3GRciwg8uVq3lHWS8m1dWyGvbhS8suNzQN2Mnug9J0Q59abODGcmv7qQqQcN9kL8EWRnZT9yTov+IsXDtj1C2farqmthcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715499; c=relaxed/simple;
	bh=kVXvFGe9L6u46qed+MFtgkH6neBNgmagQjD88dYdKiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWP5RZJc7axG/O1pdvgv8JKwI4AHuaPDYwftICbIF8NY/m4OmQynJmG76d34ZIQftca3scSouHIPsdbu1VMpUhUsSRhoqQYMRdQE9N7XYzF0840jk7yJerK4z/zxAApny1moAwEARFax4k9i4SXyFQjptMrkmSoBLFL5R+jEmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CZcLIbEE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so4043535e9.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775715497; x=1776320297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNQFCDdUTA5OqcEojWYL88oTkm2Z4y0PLy60U0CSlxI=;
        b=CZcLIbEE0KO24c7PoUVL9G7gYmMMtumc6IM8z7ePtSAmxPMTAeNBPGbSdFR3wFx09k
         NPRf2dNiT1++aDrZDMZ4CnxqIBxJV+maJ+afZj55beUYEkN230nfgvZEQDpj9O+Cc0A5
         vlqbY86jxlfSm6bNHjPFCE2TaugpFGLkACbFwc+tdfhlKJdAyT57AodpwFIIKt0NiHFh
         txejPXx6FBrHk7b5Xiissyso/8CcYl21F29ed7doyLhT6wMkbh27eeqYxF0F/r4Hs4mi
         StJ3yyGMY58adK4g+8k7Ht0hFYKdkOzMUpaHwRzMbVBYhewClev58QtK4T74MFFVNMUh
         zENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775715497; x=1776320297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNQFCDdUTA5OqcEojWYL88oTkm2Z4y0PLy60U0CSlxI=;
        b=eq36IYjb4O/lfvj+tb6Gol4YiYx0Zhmb8rzcBfurbLM8IsG8E0aLy1V18JOq7NjR1H
         cpWE6lTQDkbEnPwtGwS21PGp1ZDNksdRw/gfPlFmz5lNUGkCiRw2eR61V2eVgM3/K1TH
         iGw1ibqX68mCnzkdOeMEF2Eo3rS47RZ0jY2tazkZMv/QeRnYXcW2F8fUCzn+vBmr58ii
         igmFOomPibCKay58vpQovsFxifcnnm7Wgwh92GgG0pwTuTqprVwcGS55c1/hMfdY26n1
         n9xDK0J5e6a13I4sqMsfPTJVZWUPIbTnp0K+ogh7zXwxhUR4ckooqGPpVqPwHYaVvwfw
         H4Tg==
X-Gm-Message-State: AOJu0Yz+TwANZPbkBh7+z0HqRizrlEXZkNmAPk3VCVaBts+Ob3URFMqN
	pQQahaZkWwTyb6vj5KeKmtPI1IG91paSARpqMoNs66gp5Op0ZjyJWjo3i6Q+Ncrykt0TJWitRAl
	rHIDLFYCepg==
X-Gm-Gg: AeBDiev8zKOjVu6BVe1ccVlnAVFxK0tlVlSW0kejRSA8S8omfOekiyOnEb2GgWjBnSI
	YXCQsLVtiW9pQXhBBJcUUdZ3P57UNSydQSP033qWeDfDh5aM2FGrCr3pR3GzFhEDLrpJLQKJvgJ
	0fShue+Bl3l14liJ4X3sKZ5D+hqnpSw7FIKp6d8dcTCc0JsYYinkJt0R2tOiBeczjEyBCBelfPH
	rxH4Q0PjtPsPenays55Fi3g12Fe5/KvYJKKq9J3wT3EfN5uBWkriCjWrbCcR4Oatck4Wel719vC
	pR86VJfP1nvr8GE2KHpn0b3ltrgQCDTfbOMN/P39rxwSDonNYT0tRcfZ/+B/i70CySQvDiQIJ2O
	4yC4oAsnOeiiP65YJS1PNnTPOo4f33CZzYCqZk3zKadVeKmahPEWGmNE8gQTZdSGPWzN2wMmgVC
	rqR6T9B6zcSnTfTd7U+ha9tTfN0x/sygAAyzqPdOP5mPkqLM26yf3x0GUs+CE=
X-Received: by 2002:a05:600c:a303:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488ccf3a65bmr23726995e9.4.1775715496799;
        Wed, 08 Apr 2026 23:18:16 -0700 (PDT)
Received: from u94a (114-140-130-35.adsl.fetnet.net. [114.140.130.35])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6da8bsm17516433241.10.2026.04.08.23.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:18:15 -0700 (PDT)
Date: Thu, 9 Apr 2026 14:17:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/160] 6.6.134-rc1 review
Message-ID: <dozxr24wmpnj4k72ojbvtnhdgi4ekkgkfjdf6xaj7eoupboyg4@vnefmfsdk35m>
References: <20260408175913.177092714@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235315-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCF983C6859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:01:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.134 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24153838933/job/70487760092

[...]

