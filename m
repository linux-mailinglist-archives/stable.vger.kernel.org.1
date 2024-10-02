Return-Path: <stable+bounces-80571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B398DF22
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922DE284877
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179D1D0DD9;
	Wed,  2 Oct 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aQDBEUNC"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84BE1D0E1B
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882811; cv=none; b=E6SRFavb1zbNF1Md4z88C5PAEATggE9M9pWO2ROHCudmzbiQxjH1U1JQ8BpOXQVH6eGHoDVk9GBTzMGcPtX2E5WjEu+XDN5IACPFNZ7v7LksCNBPuTucCxQDwKMUPlya3MukRwTw4dnnmmuwmF6pJenQ2uYU9uH9Mj/NuY2ly84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882811; c=relaxed/simple;
	bh=E9FPr1fmew+vv88nS4gPGno8YHGcR2bZMdcEkb+fFJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpNPJONDYASrzZcglxSY3HxRVW/l27NT6i8hATepmwFwkH78HVC65LTQb1du4Af1MMbPjToMjTr58VPeqf+b7TTxOr/lhV4lK+LL2VG41amTpJ4ls5YLwZJgM4YAvEB2rVMaTueu0OjuyYTXRUTFR9pViJb+1RE+zeMgW+T0Lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aQDBEUNC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-831e62bfa98so290315139f.1
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727882809; x=1728487609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuD9wsxFbmeb2sqa0s9YVvzlPj/8ZpCvkW6qHLRigDY=;
        b=aQDBEUNC4eP6AVZKd7l8fgq6ylmkDXCEmXE9jUzC/MdaooZNQu7HDNiJs18fJPYp0V
         PoCiNL7CJ0/o3no0yTp4FANEl55rRZwCrUtWxwK+VmuCjp9OZB7xRhjP0kW6FgjFExGI
         Fv0OVGyXG9eQT3fTOHriKVnJGnFzQR8RnD5z6tTe3yr0psVWuPrB2Ti+sHSH6XcF/3V2
         KgsLcx3M1sM8JQFsb7x5pfOF7z446JFI+nK9US69DEeY0+52LsznYIfbreO4IhVnrWfh
         nLPVGQuohfLlP8qRNfxAA4K2ib8Sx5in3XqbaKJ9azg/DNA7PEuW24D8lNxR8Ejro7W6
         OrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882809; x=1728487609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuD9wsxFbmeb2sqa0s9YVvzlPj/8ZpCvkW6qHLRigDY=;
        b=wLZBgt8d7RDq9xiD3quyzggbRtpt5LbzSAG6iw1AA7sepzwNfQQpWeg9IFqng8B7X6
         gtwOI4koSOdhN7rbfv1Y84Ex0FZiz9MySRc2kPUWT4h7hCvLkXT1OpSUAzBNMhX4/eGT
         hNoZG4vmUJp1cwZJg0fJjRN5h8kOL5gBiw1KDqop1ZFatHCLwsedvnKPb6x9JspOmSNY
         lKlGwL0PdNZdHWlsUROXxc8uW5pH9cYgWP3lyJGR6J7VyG2VH0bY04lesQJk9/zmEvM5
         qgahvcnykxfIs4eNrTytT5fkoEgGV7aPc0HGe71dDJOQ0G0rBDo4zeVFghvd+h+YQFEe
         dOwg==
X-Gm-Message-State: AOJu0Yw+1w1W3DhQPiMdGl7wqM/nb4bxKiilB31Ytf0+frPGqqJ+CEGV
	nihcbkazfR7XSi2MSLQk1afTsROWWeKhmGicu/8GyIKwyxFNqB3c2RSGrOp4okI=
X-Google-Smtp-Source: AGHT+IGdJtmp+p8T2alQEBIYsyS/TOFpwXW9gJenIY1mIZilSOUetARDFhj60CnDzVxg8DeB+RNkhA==
X-Received: by 2002:a05:6602:2dc2:b0:81f:8f5d:6e19 with SMTP id ca18e2360f4ac-834d83de15cmr307643239f.2.1727882808750;
        Wed, 02 Oct 2024 08:26:48 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835103sm3161143173.21.2024.10.02.08.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:26:48 -0700 (PDT)
Message-ID: <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
Date: Wed, 2 Oct 2024 09:26:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
To: Vegard Nossum <vegard.nossum@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
 mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
 ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
 shivani.agarwal@broadcom.com, ahalaney@redhat.com, alsi@bang-olufsen.dk,
 ardb@kernel.org, benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
 chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr, ebiggers@kernel.org,
 edumazet@google.com, fancer.lancer@gmail.com, florian.fainelli@broadcom.com,
 harshit.m.mogalapalli@oracle.com, hdegoede@redhat.com, horms@kernel.org,
 hverkuil-cisco@xs4all.nl, ilpo.jarvinen@linux.intel.com, jgg@nvidia.com,
 kevin.tian@intel.com, kirill.shutemov@linux.intel.com, kuba@kernel.org,
 luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
 mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
 rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
 vladimir.oltean@nxp.com, xiaolei.wang@windriver.com, yanjun.zhu@linux.dev,
 yi.zhang@redhat.com, yu.c.chen@intel.com, yukuai3@huawei.com
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 9:05 AM, Vegard Nossum wrote:
> Christophe JAILLET (1):
>   null_blk: Remove usage of the deprecated ida_simple_xx() API
> 
> Yu Kuai (1):
>   null_blk: fix null-ptr-dereference while configuring 'power' and
>     'submit_queues'

I don't see how either of these are CVEs? Obviously not a problem to
backport either of them to stable, but I wonder what the reasoning for
that is. IOW, feels like those CVEs are bogus, which I guess is hardly
surprising :-)

-- 
Jens Axboe

