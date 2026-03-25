Return-Path: <stable+bounces-230315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LLVDgjBw2kRtwQAu9opvQ
	(envelope-from <stable+bounces-230315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:03:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5DB323729
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82FC301DCFB
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E523B0AFC;
	Wed, 25 Mar 2026 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H95muBZM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834513C4579
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436281; cv=none; b=gfp86PXSGuNPVINO671T5VjXr/BOl3c+7atyD4QbsNz6Wx+Yoxn0kEanqR63gDSOPK+9SCGtDtBD0AccszrW1mhON4AdESHYQS0AWeXKwlrVVCTnjdH41AfkMPYTaGWrWdRyUSXhe2OMwSNt2kMqBwjCFfIEn8xzbK0w1TcCYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436281; c=relaxed/simple;
	bh=2i2zBV9L9/qV6AGrjVDSWPWPK8DLvyBNXgOJJh006E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWFVv3Xs475XDAUFHDKCjY41JlS8RZlEumE2qQVymOCI8QuZJKlwFNwbrc5Pm4/y298s9Z6XnGw7DJCigsRKUUKGk1C3bha5zu0w0OC6jm9gnI85vJFw8adAxlLCd8qnjIx2P7foB/dm1PWY/v43cgZ6HlWb69Rtcy2qv3kdLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H95muBZM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486b9675d36so52906195e9.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774436275; x=1775041075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tr+DPBLNHUTma6B3EgTqBqGFQCe6XWaXcahqS5DXuc=;
        b=H95muBZMIt2ISw7FGfri/nT4FHBpajpWaAY/J2hsvp9tQ5PINFZoeuqSO2LZPZPGt3
         0ljYTRbMGoew5FfGb9wnXNdT5+z9uSJP6HYSHH5c1aNaajdPYOCQmoQeZoBIqe9abS3s
         a5CxljNYqT6DQe5cB+rgeZf1W5VNYONkgVNrHsxb26PQ+0qc4Pxsd6NddjW1kZKfR8T/
         dwOVS60GBu/05BeZdSG0qgd5tk1hWtbc98EL9YocvDz3smewE/kPpfT4pKkH3fuWTvDM
         B7KMjHWDVNWAUW/4dLcPrZwfa2lPfk9e24o3iZaid7adpDTUBUajcC9fHN/Mr9R5P+0F
         sNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436275; x=1775041075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tr+DPBLNHUTma6B3EgTqBqGFQCe6XWaXcahqS5DXuc=;
        b=sgu3NGTf22h5TqAjgN7ccCHoYSz18kcoa37Ja8WgRoq8MQJcRY+WwlQyZU3xXlpGvc
         IOetrqRBK1T7pSowGIMIqYcbiFhNU5uPUUf9b+Y/SUs9GOEmdh2QAzfV885hZURY1qZE
         w48akn0wE1w0lBLbGEWeWOQh9qGHJA3PTzCokQ5ME9tgDgCGWkhveoBkZFcd69ibn3MO
         2gY8K++/DSBxIAUxfvIdTNR1UOHlbZ/7YeXKLiQpCJI4STTk5uSqGgrLne4vvRAc2B7K
         QTqEeNY/vob1uAT82gMOcNKgeYb6BXbqTCTRPzCVb47APf1NihCO1hEbHUo+XtIhqNYU
         an+A==
X-Gm-Message-State: AOJu0Yyr60IAForwX/WnhZPavWi0DWHSjrPNk9hhiSxj+nF5BfuQft02
	9wGs2w1Sada6mTB0iCG2YQxoHxRacL5VjCKM7hzOUlHrrANVpr4vo9gNv9ESNTH9h6I=
X-Gm-Gg: ATEYQzzUW9AfW6z1cM64kp6hCa4v7hErFSp9iQwsIqIvtJhTuhngnjYbxKCi6QFol8l
	petXAOpDBKO4MNpIA+saYXqccJqVJkWBCPt9BPiYM/qyiVwpiquuum2ByEnRgEX2EPjPxSdoK75
	7ccGYgsKktt2jfpTNLTOtUr7RcPELKILFZdYiQ/9mQP6kw9qAEekvYX+nP2qNk/mdKrxYdZ4xxS
	I3fCnQ9P1SGdELIVpxdAJa1SuAWRbLwdF7OM0akvqu/jJ/IntjkQuV/dV9YIwQKRkbZeKCIILWT
	w2BKBcueQClQJwKfOUpDeD94rlY6Q23rov/pmYfTKxTfy+KIOqHOOASz2urG4xZtYBH23IAo2rT
	UIF+7FhKYnMey3V3m2eC7/0AxuOcqxztb/2pQqhGnKqbyvEnV4tkCpVoSwZVVHQVm/cM/EJzD/v
	FZNSyX3XaYmt+cZh5f9Wdq6hMbsSYQ
X-Received: by 2002:a05:600c:8886:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-4871606dd88mr30844415e9.29.1774436275247;
        Wed, 25 Mar 2026 03:57:55 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:92ee:b67c:a5bb:13e0:f6f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c56bsm258439545ad.57.2026.03.25.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:57:54 -0700 (PDT)
Date: Wed, 25 Mar 2026 18:57:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/567] 6.6.130-rc1 review
Message-ID: <mujla3hhjkr2qm3vydifnafnnuhgjje2woh233qle64srxudm4@cabmtcmjnj2v>
References: <20260323134533.749096647@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-230315-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B5DB323729
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:38:40PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.130 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23507388452/job/68418868950

[...]

