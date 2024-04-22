Return-Path: <stable+bounces-40410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8225C8AD787
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12C11C20BAD
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465A26AEB;
	Mon, 22 Apr 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX8w3x/q"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD121E862
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826176; cv=none; b=dvvy0u6Wb7SN74dqkrKXUoBAqhz8buJQfBsBaca9mHKYBl7f7swYwKROfT1uNiBZRVymTrBXsFMfcprfs8T/Calzo+lIwfglTO9FqQkeJjGTRGimXi9hBo1UthDL8kFpOkBnW8+t1XPPDCR/1KjZlF6xxnpKtWVwr0tWwsSBUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826176; c=relaxed/simple;
	bh=B3L3zEn6BiLKZYvpzycDpdmXcbV5Wr09ev43tjZpkdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ5kKhBD7LzFSm1kyUGKy7J2v48w0T7npt8C40+UTj8A77uFbwsXXZjlM4M7/HpqGn7omrJtA/b9ZzSrwVcKxqJkC0uGBBPvnFpdiZeFen/VdB46eGsuqHJPrc8ld/BFVc8M3tD05i+07ghetgsEAy9+9f4BOR2JLMJMN7hhjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qX8w3x/q; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da68b46b0dso135608639f.1
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 15:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713826172; x=1714430972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCKJmu5bl2+zxy0B9al546VeTzaNGWidDB8dfZXwONo=;
        b=qX8w3x/q723B/Z995aOzcvBMiKvLhQB8hsCOC4raQM19RRFSw34+goaSZL4TZfYppP
         gYjp/ZqIc1M5o7F4HwSc4CJf6WaHkfRkUb7G9SAPHlmcbZQpQ0kZZ4OMEJ6iE6t9n8+D
         ffHIT3p0qEjDCzLuhf2LAQS0z0oqg9d3LLDL9aLoa/UjTr/5tfyzUHUDZKuOSvk8WEk2
         BoeqPxyPBxZy8qa0piHcKzWhnvkuj7sEkwMY1KnDIufYKF9xIuZg/kEXTDLFe5U6udpV
         3/Ce48V0ZYniyBYkoUl8HMSyaqQUMqNYg+oYXdNL8zwkW46TUQmTuXmwqRG7Wz70WUtc
         1RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826172; x=1714430972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCKJmu5bl2+zxy0B9al546VeTzaNGWidDB8dfZXwONo=;
        b=hq7v+xtdZRq04d3p4Ahk0kov9BDimun/dqAjURNTscn86EzXOiYg5pmOsGg5w/krBl
         K9pRX5vTuf87iXCWNmnDDCjKoJs6fTNQ9AgnOTmBPI8IvyYEZKtEgU/gphh8tEI+VVz6
         hCH6Mb03JzKIrbVBDu7pNDoascxuqVFokh9crY5lfmh44gh94yoo+AX9VAyJ3hh7pPuf
         iGUA9Aq/WS2zuolt/NvKnU1+weRUuxA5huEIrWWiuoZqONrHoX8FoksbParxkptFoMoq
         i3JjZFHo4zBRMtsRT+Vk8L287tlnezjrqU6dwhfDEocXyaplPRpsR7BtDhlBSGUaO0Ce
         iheA==
X-Forwarded-Encrypted: i=1; AJvYcCXUB+aNzubd2qkriWVajllTRWdKGh/8+czX/s6AEhsYE7yOyjsEGS9lxteXLXhTu9aYhBO+EpWEbFL6+VGvwHYZWg86pcqC
X-Gm-Message-State: AOJu0YykA411DBhpezpSJNJodjhy69iUA4UbotnOQMVWBj2MP7Y3iA73
	sY2OHx2oR7AgqRkH7uwLrhfG5F8A07kXVl62GtoOn4EGW4o3r1sSfW5vG9FEXA==
X-Google-Smtp-Source: AGHT+IGD8E3UcrR5oTnyvVhpyX1RzPfTUHBhXeNY2iPixwVxtpyiWDPRP4/gkHWCWW3HKlkRlz40SA==
X-Received: by 2002:a5e:d718:0:b0:7de:49c:9d3e with SMTP id v24-20020a5ed718000000b007de049c9d3emr793297iom.21.1713826172599;
        Mon, 22 Apr 2024 15:49:32 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id u16-20020a056638305000b004830b70971asm3266609jak.122.2024.04.22.15.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:49:32 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:49:29 +0000
From: Justin Stitt <justinstitt@google.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Douglas Anderson <dianders@chromium.org>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/7] kdb: Refactor and fix bugs in kdb_read()
Message-ID: <kvmf4hcnoeuogggx5jmcqjch32shyswjv5cqvg4hwdg4g27rup@t4ddszao3354>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>

Hi,

On Mon, Apr 22, 2024 at 05:35:53PM +0100, Daniel Thompson wrote:
> Inspired by a patch from [Justin][1] I took a closer look at kdb_read().
> 
> Despite Justin's patch being a (correct) one-line manipulation it was a
> tough patch to review because the surrounding code was hard to read and
> it looked like there were unfixed problems.
> 
> This series isn't enough to make kdb_read() beautiful but it does make
> it shorter, easier to reason about and fixes two buffer overflows and a
> screen redraw problem!
> 
> [1]: https://lore.kernel.org/all/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com/
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Seems to work nicely.

There is some weird behavior which was present before your patch and is
still present with it (let >< represent cursor position):

[0]kdb> test_ap>< (now press TAB)

[0]kdb> test_aperfmperf>< (so far so good, we got our autocomplete)

[0]kdb> test_ap><erfmperf (now, let's move the cursor back and press TAB again)

[0]kdb> test_aperfmperf><erfmperf

This is because the autocomplete engine is not considering the
characters after the cursor position. To be clear, this isn't really a
bug but rather a decision to be made about which functionality is
desired.

For example, my shell (zsh) will just simply move the cursor back to
the end of the complete match instead of re-writing stuff.

At any rate,
Tested-by: Justin Stitt <justinstitt@google.com>

> ---
> Changes in v2:
> - No code changes!
> - I belatedly realized that one of the cleanups actually fixed a buffer
>   overflow so there are changes to Cc: (to add stable@...) and to one
>   of the patch descriptions.
> - Link to v1: https://lore.kernel.org/r/20240416-kgdb_read_refactor-v1-0-b18c2d01076d@linaro.org
> 
> ---
> Daniel Thompson (7):
>       kdb: Fix buffer overflow during tab-complete
>       kdb: Use format-strings rather than '\0' injection in kdb_read()
>       kdb: Fix console handling when editing and tab-completing commands
>       kdb: Merge identical case statements in kdb_read()
>       kdb: Use format-specifiers rather than memset() for padding in kdb_read()
>       kdb: Replace double memcpy() with memmove() in kdb_read()
>       kdb: Simplify management of tmpbuffer in kdb_read()
> 
>  kernel/debug/kdb/kdb_io.c | 133 ++++++++++++++++++++--------------------------
>  1 file changed, 58 insertions(+), 75 deletions(-)
> ---
> base-commit: dccce9b8780618986962ba37c373668bcf426866
> change-id: 20240415-kgdb_read_refactor-2ea2dfc15dbb
> 
> Best regards,
> -- 
> Daniel Thompson <daniel.thompson@linaro.org>
> 

Thanks
Justin

