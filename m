Return-Path: <stable+bounces-62592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B444893FC83
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61591C22112
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B6D156F20;
	Mon, 29 Jul 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HuWBQ8zm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A080633
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274694; cv=none; b=UezWu5gV4aI2rxvgWgILGmBilDHCCa53KJIBjFTp7pp8uzrnuyfwS6RZidXIk+4JbVB21GsHjUZQFP47xLNquQ5WJLR7RqTvkd7epsQlcYYJxHzqMrlIFnDMjX5JKmw3DbHPIxsf0jBhacCLPZgFOQn1ISdeYolw6U8eeRHQfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274694; c=relaxed/simple;
	bh=lrQUj45PU/ls4ySYAQalAsCJhi6rhFnSGaYwiAyyd18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk6f5pqOGobEOqUjcR6stxz1FiPJWqH/7yC0VV6pde4982C9gtUVhFYHqmkWm3t5iTMm3uw9FUVycfuGo5og/lC9YSSUUqtxSZMkymO5ke5uMm6kwbEUuhLrbPaVesX32OqzPo+AAbDBG81g7dbOonBxIslveACoycI2ay/c9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HuWBQ8zm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cdba658093so686933a91.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722274689; x=1722879489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4WJMktWDI9qPad9yp3OlgPvU2iQU1YUl0EKhVTYltA=;
        b=HuWBQ8zmOogtCIgr+NAtoggje2luotamXEEk3SHWHMXzK5BvXmjVeIWxGNck5piROH
         DKJh5Qy5oBpC/2U6mNER1nNH0bBYvJpjZnj1sJaE7LP67m7R9oHIkmJbpccxtweObWQv
         9cWwEz/O3C8bMlf6xUjwiKtaMCSd51gq6HDqz77JKA6w3nAGV3qwsP0tjoen0AAxqajQ
         AMswM0617rRuPFbVtOJQ0MyvBrPRL3KWfj1SjDiIitVZZ1szHISRBAlDQ0GxCi5V9Cl1
         V1QRFZ09JsTbkt/WtXNyzuPqZ7KSG1pFIXw6SE+z/INQAp3K2tcnbxCc3dtioac0CDIP
         /FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722274689; x=1722879489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4WJMktWDI9qPad9yp3OlgPvU2iQU1YUl0EKhVTYltA=;
        b=CuBzUYaelpbiow3vCfgl4y2FNueqMiebRKGIKl4Z47avrcZ0e79f14fnjqBENj8OKc
         KWpXHq6aOJxz23+6t/UWwMgVJJID2QU06t4NQND6ZJKJblTbXjv0nt1E0oAWiDISx294
         yPQO/YqADgiSz5MSwkK2MFToWC4ocTV85C0oEsnvrMOyMBX6A3TW6Bma04CCQFTxmK/T
         Nqd0amCx2zQgSMTR/6T6nSRv2yIDI526Iv3VjfZEGGHEeQ4guDgyR5g36qG3h6TEEBkV
         uJbPu94dzbE7aoomvMML3rIYodt03P3tHUVP9qpcDZ4p6GKHqfLm2NKRLzoGukzkB3wV
         Rbng==
X-Gm-Message-State: AOJu0YwvPOu1xbxhDlmQhnXFHzxRbqL4DDKASCEjEacDj+5cniB5/QFg
	L6TiecaWJzl1O8quhUto3ndbODpBUU7PSqL3pjhn/0/Je0ZoHZyBNQnxEhIJeR4dyabQnyRFo01
	c
X-Google-Smtp-Source: AGHT+IH/zJd+ATgzwBrQDq0FFuWGBzswXlJ/LkTyf9CPnyw0Jf5PZgop+qZWIMQqGuhtDNl4apR86g==
X-Received: by 2002:a17:90a:910d:b0:2cb:4382:9eff with SMTP id 98e67ed59e1d1-2cf262d7a1bmr10321666a91.6.1722274688635;
        Mon, 29 Jul 2024 10:38:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb7608b88sm10857600a91.56.2024.07.29.10.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 10:38:08 -0700 (PDT)
Message-ID: <90dbc129-922e-41fd-b813-5d547a34bc1b@kernel.dk>
Date: Mon, 29 Jul 2024 11:38:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fix lost getsockopt completions"
 failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, leitao@debian.org
Cc: stable@vger.kernel.org
References: <2024072931-sarcastic-coagulant-6821@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024072931-sarcastic-coagulant-6821@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/24 4:13 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 24dce1c538a7ceac43f2f97aae8dfd4bb93ea9b9
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072931-sarcastic-coagulant-6821@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Not needed for 6.6-stable as it turns out, this one can get dropped.

-- 
Jens Axboe



