Return-Path: <stable+bounces-139093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE18AA4132
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF86921796
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFB01C6FFB;
	Wed, 30 Apr 2025 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZOQpPFt/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E62D023
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745981997; cv=none; b=ii2ZoA3a2sqwJp+F/GH/LtdQZ8e8+NK4VDwC9ZmPPnissk6YKQPmNizIcCfFMcQwAZVKlanAg3hfbVb1G4etk93xDtkx3/2q6Qbz10Sthg6OD1qiTW2hKSvNyI3uyV+Uer5GT3oa4S/GmII3Y3nRN0D6xx1ecYut+9W31BtKQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745981997; c=relaxed/simple;
	bh=GHQkc3FXloqlNAuYTzeb0ZL6MOxgugaK43eAMibLWeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FclIcn7k2mAXwINTpmt3xeHYFi+H5G+BzUgWgN67h2M4S3HQHFSxpHWlqluA3MvX8K8QNKspl7ovd9zW1o+OlaSMpcerKHQbHqxsv+OPpYW1jexoaJjd4ARTzPR8KR0Ky+/v71P2hmlhWe/bSix+UlAvm2rd0ZdGJoMZK19KaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZOQpPFt/; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac289147833so1211884966b.2
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745981994; x=1746586794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pG6I5vWSFedJSkBxsNAzdBugXyUbw1kRyptLvd0MY2k=;
        b=ZOQpPFt/oMzzUEEooKejV5PCwi6hNtlyMn/Nl/+6rmChUSc6jRD1dbwsfKxaZWzTTL
         deLUIz6SBLGzP7UW+BUjiQMlDr4yy6j70yBLmzkFV9YMWVN+Tp9RJf6zszzbBmxI8cMJ
         XM3BmVimYaRAc9zWSnfyKecKwiULS3mnPh6OpxGpCXC/uT+faJQJnLQznp0KsOpAus32
         mqtMA9FSwaz7A4tbJnPYRNRs7A6i/gwuK0zNoZy1rUTDP4/2l4nS+ZiqOyXt9TVairFs
         GJDEe2c/TsawLpjtOa1TcV3idFNkt0I47yUQ9XcHZqPYicNqXOSeLlLmtk+eidARlciI
         HeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745981994; x=1746586794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG6I5vWSFedJSkBxsNAzdBugXyUbw1kRyptLvd0MY2k=;
        b=RgCOdojUcB7MEi+jnH9M7DaOFkWoY17IyqPbYsZC2wAfeE5CXwBBCCfFnW2BbO9t9g
         x15/ngAH7a9q90v9/M32od3VZnH45x0pMHs5K/ZXb1torNaTrN8lXpKy8/2VtCrja262
         HKjj4nEUEXyzsPtkmf8eRF6kpylPK04YtTnmYZuThzRsuZEKE6VvYjGP6jUi2hTa2Xxg
         tZqI98g54B46axFOfKIO+avbhfFV6PDafAKhmSdxF9tG9KMp9BC9I+AADLrrG2gg6V3G
         IDwIY04m2fXlJMM0PH0QQWmZ964OtSoR41D6KaM2RXHongqpi78Fua/4665jJeMljepw
         TqMA==
X-Gm-Message-State: AOJu0YwhdfKEAHHJjqWImtDg8PhzSDLqWJMstpXvPLeta8K4srQvxRr7
	lnGWPMkbhKRMRSFR5cYtxXR9GsDtFY11I6+i77Sx1eZGeWovXUsQvXzj11FBNBA=
X-Gm-Gg: ASbGncsjpMRs6C3ncQySCses9deyWgzntHaIvk+5a2Qp3MOX2rkqsRoyDyGV0LzXAjK
	d95znEdH+sqZE1adbSeFMYglgG0xVMzBBeAUIHq+bS2/GA0vumdxmMh3uC8B5/F3816wnJMp77k
	W/4N+AdlJSPlWczC8lUkQroESyeNsKJFxHk9YLyExg8I47BWVs/l5ZEevHKeVPpwNP6MRIGSnUo
	X/k6rZzSxGi6/3fWgekkpW8MJ1pEzQPggZqJUGlh/K9T/cK735MUhlmmWT/X58FYzFFvQFyFsJF
	FS8DJTxupleSc4pBefMP842qAuoRmA1XwxklP+PlrywCZC9T/JCakEnzyE01Zpo61A==
X-Google-Smtp-Source: AGHT+IH2cNTkQBzyqfuqh97tDzMgDA/fmKHw+4HpNwa25q5IavYcAeKgdHYsqOCmKNZQVXcjThwZng==
X-Received: by 2002:a17:907:3f1f:b0:acb:4de7:14d8 with SMTP id a640c23a62f3a-acee21a69b6mr84838666b.14.1745981994039;
        Tue, 29 Apr 2025 19:59:54 -0700 (PDT)
Received: from u94a (27-240-163-208.adsl.fetnet.net. [27.240.163.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1580sm875529266b.175.2025.04.29.19.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 19:59:53 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:59:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/280] 6.12.26-rc1 review
Message-ID: <dbif2hqcfe6oz2zziy5e2anzdvi7swbrb3xqcmdxobmj3fczrn@le5rlwynle6y>
References: <20250429161115.008747050@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>

On Tue, Apr 29, 2025 at 06:39:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.26 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes (with 82303a059aab
cherry-picked from bpf tree to deal with sockmap_ktls failure, it will
be sent to stable once it made its way to Linus' tree).

Link: https://github.com/shunghsiyu/libbpf/actions/runs/14738691393/job/41371100896
Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

...

