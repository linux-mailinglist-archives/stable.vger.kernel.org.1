Return-Path: <stable+bounces-19745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9417F8533E6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5188C28594A
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310595DF3A;
	Tue, 13 Feb 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1w1D3P3V"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6F5DF28
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836250; cv=none; b=RuJ8skdoSKPny8TwCQqUYPqdGeIFKY8rOmvD7VbQAIqxROQkRXLGlol+4GDyA9zzsAO4YuXa8aWVP1xs9edXXk6zpvw/+6/2Y6euhbQtM5RUoSIgB5hBQ0gStXsyALbVJlo6exDzPst8lAgExUaYw/0Nadhs+ZR68r5XIjw5+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836250; c=relaxed/simple;
	bh=CjVfG8eWC7tKwA2jEz2VMp5kPGyZctdiNWrGAn2qzY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atQPubJl3mXTr3U4RpFpAeXh8HKZJtI/c6JHANgihNaPg+lFu0msQWMvKJAMRUaAcwVNKh1TLOHWHC7/ypsQ6iEfoGmpokQTwJA5zs7V0U3AreGGNeFpaYG5bfYHxO8LP8oEDUd4HP1Df81k43rb54J4Cje2jJfJWXkplVDwFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1w1D3P3V; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso38818239f.0
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707836246; x=1708441046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Os+w+30wm2W4q0/QefX8a7m9ywg+DRye3vRu+KJKVDQ=;
        b=1w1D3P3ViBeNP8ExCjUfoH6g3BCMvhTAhbf+t7Bei33ZdEY0Fu5ZuJbvD7ITUn1f3Q
         RjZ9Qn77qJdx76ZNEN7yXuGyCY1ScelC1OJLTCWVTo1WowsMuLkPVQKFsqf55hsJ/+1y
         nPo9cswU+voepQTE/cskeZpmD7R1VCj216F6Dyk0/ZNgSxlCdQLwp+J+WI9jMj3fB7Ie
         c809SDwTWvtzh/TowVGKVHZ+O8jhrvMDf/R8t44zZuuoJMJyejm8S+A6KW4oQishdLHG
         6XWzV2dmo5a6qoex8AfIwWLAVwnP4fo5c9P/eAHWmU5ixIth8aXx2Pzcgx/PCFdtC0dG
         aMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836246; x=1708441046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Os+w+30wm2W4q0/QefX8a7m9ywg+DRye3vRu+KJKVDQ=;
        b=DNM3fxdOTivBAPjS6HX3+owM4CJvefqWb2IzPpPGxQ3e9ExD3Zis2SbeQCb1wN3SyD
         oclBBmn9eB/w9WxzgW25EVdV1KoQ3P8putd510+tDwFKwqgp/0/duq7FMNRaPbY0SR6E
         JwxdgUr/UdE4t/w1Q/8oSxQ2Yv6KktR44Z075bvJiHpgCGqUubnUwwYKP4PvPGBma7vC
         tOJenj1/x0qkg3aGQ8BxfKXUOSpqkUXFMGHS/864Xq/Bc5EdZ6JUIKr/T6ytV5bIk+KF
         0gSpA2v+yaWeBCq/N1giALNmzow5oy1yYpyEK+PlDgC2QFnfGZ2RqZMozDXUprqxNZx6
         l6yw==
X-Gm-Message-State: AOJu0Yz/Xh1JJtvDWcpcFFEZD5MZcEjGZeNf68fNASFxtr/qqb88iC+9
	xv/BebxVEu7bGAlSxEuOy4kUQNcWYZy9BJtxTpL9FzIfepKJ2gHLHIgUj+ZxEsjGn32GHu2kmF6
	T
X-Google-Smtp-Source: AGHT+IEl7+rou1XRhqWcA2in++Y82uqd+ovAuRIpCWoBwGt3hxeRvigSBcOFT9dbSRsHHI9kvIq81A==
X-Received: by 2002:a05:6602:2c41:b0:7c4:5898:11d0 with SMTP id x1-20020a0566022c4100b007c4589811d0mr9221759iov.1.1707836246277;
        Tue, 13 Feb 2024 06:57:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a02cac6000000b0046eb587003dsm1900651jap.127.2024.02.13.06.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:57:25 -0800 (PST)
Message-ID: <22be60b9-f51f-44e5-9568-55e31954daa7@kernel.dk>
Date: Tue, 13 Feb 2024 07:57:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: fix sr->len for
 IORING_OP_RECV with MSG_WAITALL" failed to apply to 5.15-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024021339-flick-facsimile-65c3@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024021339-flick-facsimile-65c3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 6:16 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 72bd80252feeb3bef8724230ee15d9f7ab541c6e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021339-flick-facsimile-65c3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Turns out this issue doesn't exist in 5.10/5.15-stable, so you can ignore
those two failures.

-- 
Jens Axboe



