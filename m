Return-Path: <stable+bounces-215742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIpcAVEFjGkeewAAu9opvQ
	(envelope-from <stable+bounces-215742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:28:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD012135B
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7CC0300B110
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1F34B1A8;
	Wed, 11 Feb 2026 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OPZFgxuF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4096353EE6
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783989; cv=none; b=uX3Cz8hR5d3WpdONMQwRqBm9n0LYXWEp1+VAC83cM+GcBtVkgWvoQ71evd7ntgtFNfBZxb8sNPSILZMhoEjoVFZq2PIoaGdrHAPcOrlJ9kJLWp9LPINRR5FKl+5dw0V6gorBSdb0TJc0nOucjLHUEZbX5cF6rQATt9w99fgxfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783989; c=relaxed/simple;
	bh=aUATCmUK+ImgQyyZDRNe3IkksmdtwUU4keHLmfDrwOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjssDYBFDR17mLaUP3hQnsenvxrYfG+1VBgtkWZxh/J2Wrw/FjuKVUebxs+s3b7fKMGQfK3qYUorA1mSgcLo9sDV9nQ8FwnOKpoxysCOiLhDjHVvrkl7GU3YWQ2KfjWPsgNltRygcStT5Hj8T2lvIdwFGI0uIF6HWbd9nyTdJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OPZFgxuF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4377174e1ebso1891316f8f.3
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 20:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770783985; x=1771388785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M27ieyh6BJjIYTvtp5y/r9tffMjQn+yYc+9hsKGR2Vo=;
        b=OPZFgxuFjB2RF/sGXkJWrx9MVTlSFi4Sz16o4cPi4soJWWDcZ97IauokuKYHYMm1Ee
         K8H4v20tQkDf/qYqIVPkc3kA2yV8K9fdUGhyIEXUJFHLOKYoaJ6RgsT5lyO1JGwX8WgM
         RrAzDQvIy3QBomzMDrA6Lmoz/jtaGuaLxPW6qz8GBoYPJfcnjsMHYtkS27Q4LBPtF3V3
         u4uzzs6vPqDzrygIEim1kKvzaBp0n9tUgHfqXsna+xIxgwbx2jWevmowIABROxNUNajA
         LeKc3KPiIK9zB1bxi5oz22Gj+3Isq1amCnROBR7lT9SwNS+DJGuQr7u0AhggH47ZeOiQ
         qmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783985; x=1771388785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M27ieyh6BJjIYTvtp5y/r9tffMjQn+yYc+9hsKGR2Vo=;
        b=sSgYTz1zlpjWxmy6WUxIoBnip11kj9VGEy+k2U42Kqq2lNIGa5M+iYGE5kA+uKX0xD
         tXf/uBJMzzcd2Qo43Un7u2cQGhPYSLTtqXs9NcNCYS7DEVj+bbl5sJ2Ecb8RuxDY/mi7
         1vgEa3RxyKWIXy72JIMe0I5TOMJkZhHUKqV52bXgNrKNR5/6xC49WKeMj9w7JiKsvIjG
         ejv2ULIXaFv3P00vrVLXfnMDUFxHaRcSEiQJAnHbISsCvAMasyziWZNIeKWsHJKJJTn1
         M8/rrhoq0vGv7IRXlOGeCOr45TSoVuQkXjRxbPC1O2yvI35nPbWZe+gZlxHaZjbGs++Z
         VgLQ==
X-Gm-Message-State: AOJu0YxvdS8elukYoh7VfH+pyfuEr/75/b+u2qKTvZwU2ksUZGPnJF9u
	0V5MEwLlL2mqa176cztE+AFS4YEEecA87fNdVbjAyYHgC9Nsxan3fO9kBn+aT7738b4=
X-Gm-Gg: AZuq6aKOUvcvVsacNlsO4Y+03UCWTcaB1xjZC9h6H5SbUM5KcH7I2BTpQsessL0LcS6
	AJ0sXQE6eAoUsSR6c1edFH6MbxVv4l4R1fjIrNyVOLXc+mGgTV4FxwY/OSkEKZcOzQDrEKN+Sui
	e5+kJ4Bvl9IaPSzvatP6Fs7jv9y0IH/0rD+8CHchv/2tIfWArSqL08E8WfisX84CAAzZsMtqCDZ
	0DEiwylVQQk/4+tDhvxn3WgNlaIVL7KRMS2whgATBxDgtkcF4UR+dodIUPLIzeC3yw62B4PDW4C
	AjWkYF1kTP8su0zR03pYGToUe9/etw5Ylk8Vwzb58O4WiJPpNPHZEVI2M58Xnfv6IFEkF+rK3nv
	FPiJJ4t60I0ZqSmvDLlZ52arnGp7cEd87qcbAPJstTIGafOge/LOBHt5Vmk7vZZfPGysHBvhV37
	DWwTyA8UZ+Lu5NVASaEdqDN2tWtBzj7rbwQKoumhRJmG0=
X-Received: by 2002:a05:6000:2486:b0:436:42cc:25ef with SMTP id ffacd0b85a97d-43784521a35mr771156f8f.13.1770783985293;
        Tue, 10 Feb 2026 20:26:25 -0800 (PST)
Received: from u94a (110-28-16-35.adsl.fetnet.net. [110.28.16.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d30d9csm1543986f8f.1.2026.02.10.20.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 20:26:25 -0800 (PST)
Date: Wed, 11 Feb 2026 12:26:11 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/113] 6.12.70-rc1 review
Message-ID: <3jvhhq4ve5uj6im4lc4evewjfw366uskajazh5f3e4wvoc7ssi@velf7j3daxup>
References: <20260209142310.204833231@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215742-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 5ACD012135B
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:22:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.70 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21880634049/job/63161819208

