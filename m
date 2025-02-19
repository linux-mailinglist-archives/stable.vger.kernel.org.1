Return-Path: <stable+bounces-118251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D3A3BDDD
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B832A188878C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BAE1CAA86;
	Wed, 19 Feb 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je8u4u4q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D928629B
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967358; cv=none; b=TKZVujXCDQZPf3Me1Od415X6VWeoIuR35hub1bSLdItdhSvXo9AJgd6hAwUq06jftyLwhSus0qZPr/kSZRq5bNCdaXjo1HYzey0a7fOvkapWq0XS3LcTb4+tom37mlIJTmRxMIxDEKCuAHVb2lBU9QwQd10btZGf5lJDN6PbYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967358; c=relaxed/simple;
	bh=o+OQy4IVdaP9o1XtSSdSww9LM9CBNbm0SgxFoAc56tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSAi2PTQVD0CTVkYqb4CXXArMXwf3zmGU1CNb5mX94W4kfvRQB6+87HrH+FP+rEeS0uQBMGE0bb+5j7MIWiKCHj1/jp+Asv4/7vdnWnGTqCElHZK77UWIU9pFNKOF4jSp5Vicll9hiOa7/ptSElTspXZdm0HOj/Erc/6IpO4498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je8u4u4q; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so834361466b.1
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 04:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739967355; x=1740572155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgBK5JZlsJzwHy+75TiFWel0pxBXcErRRS/3b/HB2Ak=;
        b=je8u4u4q4e7jQphlRXQEPR15dP1OoDhA0DlAZW0mP7Bmd5dfIZQaCEHQuIJhezcOB3
         VRe3gFv3h3OEzHBSqdtouJKw/vyqRa7NayOP2Eamr511aqv6UqVIk/oVaFHlJQo/ewJU
         lWItFHh8jatOT4nTKx45+5gBDVU7tLJ2Kj2UfMeW6ES3BAFQsb1BJR2TfCW9zQjLzsHp
         nMlQCfe9Y4+21mRUQDc84JaMQCZDTAQ9upuEeROQ0N+l1gik7Au21Dh3Zn1oyYtr6ysQ
         EXLcok2RHTc9x6G6nTgDMQ3W8oOOVJ4i1QYZ5RCVSA7fhtdQWQ5Aq7QGG31eK2Zx3KpC
         Spbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739967355; x=1740572155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgBK5JZlsJzwHy+75TiFWel0pxBXcErRRS/3b/HB2Ak=;
        b=oYz8SAZXqbLmZnLVMNtMSuXlunxaudE18Jn4kRJkEXFb4fV3cvYW5dCjSpEq+dGzEx
         elItlL+1vYKS1XY/WYAu588hYLZmnFzuWhzETzDGC8GR8xip6B6GepuYf+fN/HEEKlgs
         drdc0pIk82Yf5nuNrv2+qgrMhgXsHAY6jgUlTyG3aF/hZ2A9WL2d0Vf6F/1lsOzmqss6
         LfKhkGG6HGVclWNqIUgc+ts7QwB2M80ZHz8r3fUYbrCTQq5HbiMNRdIYHYwdAaixP2QE
         s7/bLxLLamQCuhWsB6ndEpS+RmcCqz2b2YmsW65cDtEFobuYMC+s7dKM1CAhZAKfYnnn
         aVuQ==
X-Gm-Message-State: AOJu0YxiLmsjr8ZmOKFoDKfOoSroG59UKyXt4N6YxHCfWJyMixpqnC2L
	QT3avsrc4qVBxwFvzj2HhnqqDwkQDjO0hEkcbT56+GtvQLLaUbts
X-Gm-Gg: ASbGncvu+bRkDIhspL5RygIShr5AQnU+k27YKXQiEFsM7TSXxKyYGCJNk9+B2LIm2YG
	Qhumi75EXfRelTwq+VUmHO8RKatkVtGVfuTJngMjSyrKIYpMJcyrlfi0/Lm1wAxu0jqznHSHon1
	sQ/2GVi64aiP6ZrMaPE87T0gl/ZtbbYaFOZmTQQj62s84dM1gNng1XtMLQahNZBht3Q5ZSXSuJc
	8NT1jRFBeHUPPpIOtmcSy64XMhXDPQpj1TL86z2plW7u21NbZ+7+C7LLV50Rse4b3SyoLWGRzhS
	VymSTQA3l7Pr4zbPBDIWiKgLlkvnolrMtRKEz+6gPLnUG0od
X-Google-Smtp-Source: AGHT+IHMYx3GV/ANUu7wd3QHZo6xQq3DhUtJPiUwseN/ny0d1Tdzj5FrYqGN4FqCSTXOEX10XbIhpQ==
X-Received: by 2002:a17:906:7312:b0:ab7:ed56:a780 with SMTP id a640c23a62f3a-abb70bbe11cmr1702576566b.27.1739967355290;
        Wed, 19 Feb 2025 04:15:55 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:cfff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8915db0dsm734243566b.145.2025.02.19.04.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:15:54 -0800 (PST)
Message-ID: <ff5aa148-0d32-4c64-8473-40afb56860a4@gmail.com>
Date: Wed, 19 Feb 2025 12:17:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: reallocate buf lists on
 upgrade" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, axboe@kernel.dk, pumpkin@devco.re
Cc: stable@vger.kernel.org
References: <2025021801-splinter-sappy-56b3@gregkh>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <2025021801-splinter-sappy-56b3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/25 11:29, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:

FWIW, 6.1 doesn't need it as it doesn't support pbuf mmap(),
the "Fixes" tag wasn't entirely precise.

-- 
Pavel Begunkov


