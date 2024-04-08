Return-Path: <stable+bounces-36394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07C89BD74
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C259E1F23052
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954DA59B6D;
	Mon,  8 Apr 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZzyoiEQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B714F60262
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572957; cv=none; b=IdDIvUT71AY8UT2vRz3TaXDZIo7Ytb7R10ZUiTJMN2ZQ9vLDG8Rqd6N5eYRLYD3nLOV2ur41YeTojfdUcLFxVYm8HRLhgov0kNtAEhxkwUcK/64NpFYmdb8C7KEI1kHLVArp2Qv0Wvzf7cqT5edcjDKc8JifUYozu2am+7gOJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572957; c=relaxed/simple;
	bh=ZZgZOsdnFnOOlcVSIRsHiQSOB43Z0PYmfTbcyFI2E64=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pn5UVCJzbXm7YYIZHnrH7HiAq8VoMrL91MvUyqVbbWfxV5FvCqGEb5eNaG29k3ap/v7vmyPi2PY4fUyOy8B7RgnsZkD6X5iRzOhPXDPhOZxpJSxep7p8fw6kpFPDRUk+B13uTtNm9kw2NyymxK3HCaPKllXK5WHzTUNskucr0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZzyoiEQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712572954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OU8DPy8eWREGAhudbhtCPT9MWbGypckitwhM+TpMeaQ=;
	b=BZzyoiEQ+Oe+8TPE3/28z34y9l1351meN5e+xDe+Z3MLyOqz6PNFtqcDs2rPhkop8C81ny
	svvEPUIxZsNhGZ/MPU+QRx9LnI6ffP34rzAs3LynHIC2PExwm80MUrbT7IQ2oI5eMuMgLL
	rzZmO3pACCWyfV0+DqmIFg7e+qTkBIY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-AjxzlOl2O0OTKnxdJJv0ug-1; Mon, 08 Apr 2024 06:42:33 -0400
X-MC-Unique: AjxzlOl2O0OTKnxdJJv0ug-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41485831b2dso32368215e9.3
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 03:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712572952; x=1713177752;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU8DPy8eWREGAhudbhtCPT9MWbGypckitwhM+TpMeaQ=;
        b=DyvAda+Gy3uc5uvKGEmIhw/PKcCPQuM42o4U7woqT7lJQiLoQS2dsJZsUUN55j0HdU
         N/j5A1OGtfRCPjTt/Jvwad4FZOwYozeofzDyXLpJJczLF8XkMTp1VZXJ1Ld95OvtpcVa
         hrwMZsy2JzrH6auHFAGfuCoErPcfaVcE1mB2LMRBZTZ0k856Y5zcJ8rEjoqelkBYbwBa
         l2FwHUgc8AVWBixU9vxlArUIH3FLmZBY+97adDGIJz+2jrCrgP0cdUK5PymtPYwImnrQ
         ggowsgUVQcTE0/0lEhpoILnk1uCCczzhPYtCazGwQOuQGODy9kbWERRrmqmyFqnXjTw0
         BjBw==
X-Forwarded-Encrypted: i=1; AJvYcCWT6FomTw61rIwvF29jWb9mr0YM4c/zkV90Fk1pQZz9dwqdOgRCGVMmxI8nNd8gxNlY2rHgfjA2/Kh2iUphWV2Yq6GXevLD
X-Gm-Message-State: AOJu0YyF26FzMdnRBTHSKcCQjOBLzoik2oo27tfLeL6kTLU7t3O568qD
	VFpKwMW+4b4tEk5QjMJ3Rn2yj1u47bAcYu7HBw07HO/TT8YVrSssJzDNqtFFl5AsGpCjmyNn+Qb
	HBNYGSgK2ZM/DreFig1R7vmA6mSLK3DNy29lRnFlKJs9NNwWmKZIBkQ==
X-Received: by 2002:a05:600c:5127:b0:416:927d:a840 with SMTP id o39-20020a05600c512700b00416927da840mr204700wms.12.1712572952220;
        Mon, 08 Apr 2024 03:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgYeEuI1JxT1zUIcmdwiySdGguKOfnhS/OkjQfSaJz1jOzafrQG3SRw1URetjkF1bMgtBMDA==
X-Received: by 2002:a05:600c:5127:b0:416:927d:a840 with SMTP id o39-20020a05600c512700b00416927da840mr204683wms.12.1712572951853;
        Mon, 08 Apr 2024 03:42:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id fm22-20020a05600c0c1600b004162c119b6esm14624891wmb.27.2024.04.08.03.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 03:42:31 -0700 (PDT)
Message-ID: <3524e6f2-ad50-47b5-85d4-107bd9821352@redhat.com>
Date: Mon, 8 Apr 2024 12:42:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm/secretmem: fix GUP-fast succeeding on
 secretmem folios" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 lstoakes@gmail.com, miklos@szeredi.hu, mszeredi@redhat.com, rppt@kernel.org,
 samsun1006219@gmail.com, stable@vger.kernel.org, xrivendell7@gmail.com
References: <2024040819-elf-bamboo-00f6@gregkh>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2024040819-elf-bamboo-00f6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.24 12:14, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 65291dcfcf8936e1b23cfd7718fdfde7cfaf7706
> # <resolve conflicts, build, test, etc.>
> git commit -s

Likely we want:
  git cherry-pick -sx

And then

(a) If cherry-picking failed
  # <resolve conflicts, build, test, etc.>
  git cherry-pick --continue

(b) If cherry-picking succeeded
  # <resolve issues, build, test, etc.>
  git commit --amend

-- 
Cheers,

David / dhildenb


