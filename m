Return-Path: <stable+bounces-128845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A337A7F8CB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1621681DA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80638264A87;
	Tue,  8 Apr 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf4y/zs9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE810E5;
	Tue,  8 Apr 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102522; cv=none; b=G77K4/De3OR7BFney8hXEMgx5La/Zwqb12iyNUpx8qYv0iy1PbNzoWf0j/tnOyl/kFVyQZRcnv7E9+MEXgXcCD5QDOjyeb48joiU4U6ELsReX0CtA/tqiqJpOK9w9wKwQfm3hD/ckBT3nReVL9x497GK2L3vmSd2IDuuMPB9nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102522; c=relaxed/simple;
	bh=blgOsfRX/LFtCx7lTi4ydy8ZfeyJtIsVl+u4MAbiuc8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r2lm7/hxn3V0BjgghUSX+IGvCB1Eco9Yky5EpI4gDqLwDL3PhhAMVXV6yx6YtBn9XQJlgXuCEg5IRO1nfPfKcVK1Z5SB2IsDh0EslpC6/e0jS6Cl7H9t7z15xsUF1b/GLgXqfIcENtaMwY1+kcvdL/Jux6HHviggsodUYTqWse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf4y/zs9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so35619815e9.1;
        Tue, 08 Apr 2025 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102519; x=1744707319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/G1hL+S6K4zn6J1sg+wQvqOsX+04vPVRCtFY1U67ao=;
        b=gf4y/zs9UwZtuKDasvjK66eRSwWBc3yw4EsCQ1aHIHl6IzmZ/Wx5YhHoSdBwhaxX/r
         4Lsx2rp5fc831fNeRG2RjPHZbO/99EmTnlmHfXXxFLuujTU/ujjpKC8WLAFNS25gFdCm
         VLRj9Z9ZfA7qFw1o2zQytfPVnvF/deuO0IumgBKdjJDLJtyN2DByotvjGBJECrIV1o0c
         zmfJb5GKUGL7t/7K7UWF7u1k+GzvPUhxmdHNxn4UJukI7ANFiq8TWd5jtqqFHgoBzx4w
         lw42Aq1Wo2QfhKNYfyX4mV1Bl4bX26mHJ0AMhx4lEVXvGar5yneLTxExrW9/9jM0zuV+
         zc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102519; x=1744707319;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/G1hL+S6K4zn6J1sg+wQvqOsX+04vPVRCtFY1U67ao=;
        b=Rkx/N1iWr8xjTk43xDM5+1tMnFqRHZZQ1zxsY7QuwegnjvXgqf5piJ8k4aoSvGYMNz
         QOdvSuWVSSto2DeTv18K1jO9ZeQxSYNxJ7rmIYQmUxx0d44zV1Y/xce5z+GBlichj9Tk
         SmbbgupERiTPX+Z+XvaY+tK13JaNHYZxVYxdai+iWY8eBOftllrv1LjGnRvc42XIiEGF
         FCWsqbJrY4G9G9rLHDCgFxFfDDoqwOhpePSWzH27+EiQIys4NLBgxbxTk07sUZkFXRRP
         S3A+n9ZWcMg1HmCYkPHMy25N8aEbtoV89u4dFkV6I4jsGdYzVnF4FyQHLHVjqiNROc1B
         gB0A==
X-Forwarded-Encrypted: i=1; AJvYcCUN8Hwp360W1xE4DG4eu46+xor9EEN6x8G1oGx0kljJ4hWBt/GsnAlm4UwysUsItUtVQw5tfB/OmEuZSmbnnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2+pMW3qvT/6o/BX96cIfOdl4Qjy0vVqP5ErMi205dPMjQsU2
	sPsB0m7yGZlM+48RHQ9FNETc2UHAANAw6cnbV8CYxIH7BOI4D2fQMStbMg==
X-Gm-Gg: ASbGnctY8QaNJGMt7RVtX9eTXIwNdghzE/XiPRJNBAdz8vMSUlU1/mnzz0dTONs06Ia
	RBbVMntynXFKyvBb+OFSxBh6SNOtXFUOV8SSgqI0XcMCkdSmYzNpUmVcIoTRQeItAvfqniyKkAZ
	3e2gopLus1sAo28k5GzAGhOV90PdRUlba+dMKSOKfjugLz4dmHC593b/0uCVFrtzKFcO0UrgYca
	Sv0f+vJr89NveK9Rddvfx7PyzD10SnJvO/M4vdAovC3SG7Co8lChF7Mnh/W4VbG90GzMoQn9kBn
	FEUP66upSVFi2o5NWkxnSQM9c//s5WHVSph6a+DYCtau7/RRndUOHcbXQ2PBuwndFrtuoPhk/A9
	3Vhfh5tPdAjkIji6jMqIS0+u0DR/ypdhv
X-Google-Smtp-Source: AGHT+IFDmnCcgm6hmqMfddlLujph19t2HIrMDl8HHtj57bk1TgyU4EM+dmjuRq5jMHIA3tGkBEJsVg==
X-Received: by 2002:a05:600c:1989:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-43ee0660a3cmr127609075e9.10.1744102518641;
        Tue, 08 Apr 2025 01:55:18 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm156588605e9.4.2025.04.08.01.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 01:55:18 -0700 (PDT)
Subject: Re: Patch "sfc: rip out MDIO support" has been added to the
 6.14-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250407145730.3116757-1-sashal@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f80c0ac2-d9dd-1828-1a53-8e6055cf837c@gmail.com>
Date: Tue, 8 Apr 2025 09:55:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250407145730.3116757-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 07/04/2025 15:57, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     sfc: rip out MDIO support
> 
> to the 6.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
...
>     Stable-dep-of: 8241ecec1cdc ("sfc: fix NULL dereferences in ef100_process_design_param()")

I wouldn't say it's really a dependency; it's completely unrelated, just
 happens to create a textual diff conflict which should be pretty trivial
 to resolve (it's only the contexts that overlap, not the actual changes).
Obviously you can take this in if you want but I would've said this was a
 bit big for -stable.

