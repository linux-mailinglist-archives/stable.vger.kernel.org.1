Return-Path: <stable+bounces-232704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K5PBB3BzGkWWgYAu9opvQ
	(envelope-from <stable+bounces-232704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:54:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70053375716
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877B930A3275
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9486033BBC0;
	Wed,  1 Apr 2026 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EE2PLJLv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DD33858B
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026031; cv=none; b=RiTUffhLVc0s3JKMBSl3MYG9UoXavA/HKdbH7tcT27cE6j1dEZUqnELuJY2LW62fOK9GP4NDcFtyiFS/RTcrW4JD1xvMg3nE2JDeipx38QQcH9xIc4K+Kf70w9pt6V0A5dTSWK1M3wTOZOD0J1tW+ipkeqJ0IUmFrXiBaTpgYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026031; c=relaxed/simple;
	bh=UqoyPliMaMdSHv8DK+7++XKYMq8t2mkIP2rLc7gqs2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihl+U/LmRgHmQkEeDJ1xI6LTcGZFtFoQIznd0LKRg7SrZPl8Aiq3+qwbhge4607WSdErFRwNRwJCYZUx5nt2Cp6kBCz7dWyN2yo0BTAIFIZODAxPXMahQkjgYhKbRnsBOyJo5LxrCYHUu0RY6XTRuiBgIeov5Oi0ItKChyHceto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EE2PLJLv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso19327515e9.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775026028; x=1775630828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/tm6tqKd3qg60EDr4n1hLuiBlwSSsb1IKbos10KJFQ=;
        b=EE2PLJLvRd9rAmY91V8rYyKOhkA1+iu/0br0N14tbgzwClKVyH6FJuEsMy6Rtc+lMy
         Dcuns2AK6rv23rzAFRW1Li4W0qZSS9Y5zzcT++dZyzl+WeYVdGaD7sPjEpCdN/e0QhM8
         mQ21z8FKdOwqh/8QXjBxBe9CPnZORWHSAnF/Ps2+svlI9ZZEbCrTU6pXF4CBNIwbMzNU
         LEFzLM6nROyfSN4SgFay9CNhRu7DbWOBVURs4zD/TsRgACuqbyh1ZNrwE6GHqg7tAeyy
         lcytU+zD/Teci1OW08vCw1NIFd1d09ZgW4gaynN31yp9fheVdm4m/5VtcMnmOA3PXnNm
         w+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775026028; x=1775630828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/tm6tqKd3qg60EDr4n1hLuiBlwSSsb1IKbos10KJFQ=;
        b=IS8AdF7ATAzWjmPrn1tFNXXOwkFUsX7YXhjsEgtahxWFIk/jRQmofSA9jbUs8sMBmm
         II2AWOVo9FUxSkCDY8lnHlk5XTA7t7IsOwV3bbaUflwcdr2/3FiMshbvhnN1VqGmCnW2
         VeVwXx1HMdUQQht/i60PyCw5iFc6gIw0NKKyr8hG16DMWk7NYMG2YitDpFCE/uQ5pVud
         ygfKvPADgGWVvPTzzAyblbQr83W2KX2IVlnWFMM4atryoh5xoq3kOyW47mC7Zdr6Mc1Y
         oOl7NMe4JNo5IsIaM2bdF2CFdEzc5T3+3sKVvDlNMXE46nWtfxCf/cvgQ3swiYfE2q6B
         7aMg==
X-Gm-Message-State: AOJu0YzNa0cz0/5cM7sIIqxP+UnhFKMIUctslIQpDAt73LR2bnUD2pxk
	Wj01GrtBFnpdrPNohHdo8bdze5T9rLhDVMpd7vwp6DiHVElir8nRG+pP8n2EI+nERl4=
X-Gm-Gg: ATEYQzyg1d3L4UKEfWZP8508n/mVF8lSahKfK0KyMkzFM8HrUVBSrOgXfNH0ttHQ5qz
	FG221wBb/1GZPL4YfUfyCtJ2jk+DoJmXoC+vH3QLnZg2vtA+fAwqdYSxS6jUPrmupZIvH++acLe
	IiKw3isDGqFTFmSo70IdcA8My1dTHlTEsGmkUwVtBnRC+4nMbxDuJDCJA7PK8hjqWHn8kiqMeNf
	g95ugtyPU6hwOu868WYgXnnXwuNhCBxuM8FXlxG8YRAKX1usj9B/VIfj7KrdsB/uVGZAZxCIoOd
	dOrecIi1+0WIracTCJcmWlQkDYyRzLe6sM63ve+iQYhOvAKyGZlfmgJJjei6AC+gT+jFc1T6KEn
	CveegsZwFtopDzjhKqH4B7cp1DJKxayZCu6v1D46jpRZ3AkBlwY5azgdyBthTzxKf0WmJLOg1ap
	vMMLILxhSiXYYM8wJs5NenibYibyM5fWDUDOhTGMSPvXka3nAx
X-Received: by 2002:a05:600c:4f12:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-488835a1820mr35451775e9.29.1775026028532;
        Tue, 31 Mar 2026 23:47:08 -0700 (PDT)
Received: from u94a (114-140-80-217.adsl.fetnet.net. [114.140.80.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427af930sm172438715ad.70.2026.03.31.23.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:47:07 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:46:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/175] 6.6.131-rc1 review
Message-ID: <ji4rnjri3sl4zxg4qgw7vnirtpiammpjv5asfmmc4p7hl32g7j@icoqifw4vuxj>
References: <20260331161729.779738837@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-232704-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 70053375716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:19:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.131 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23814574909/job/69410511554

[...]

