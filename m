Return-Path: <stable+bounces-180647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB9B891BC
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2483A45FF
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839082FBE18;
	Fri, 19 Sep 2025 10:37:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B902EA47E
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278258; cv=none; b=PvqQ+csIYZJ7MOxx3RzxmyKWreSfAIuO1p42hpUd2Rfm8tQicK95nFLGe18KGydrMqtu4Y4DWf8kPaFepNcRNYVJLRouNOd3zpihMTSldpsQO+TUkTSR+Y627PnM/ftRqkByHREWJR1V5cS3ng4GYVOq6pbhjMkhqLZQmMdkgfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278258; c=relaxed/simple;
	bh=sSpLFT4U9OHuE2V29wbDu3tL+WcnIbqf/4zQvCmO6PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gihz2Z5OzVWf8BtUhNL88moaTfXmqQPNt4kTf254vKm/tCy98v1NsD1G24In/tj+5fdpUcoT8v1xf8lGaKxfiksXHu6Ljp109QWba4DxFS76Ih/d0/WBtxgso0vcNVKv5cVV1A+5oHBZpj0mWrqR9lBdXaXolJM/Yvl6w5kGmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so356501666b.0
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 03:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758278251; x=1758883051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9U9gZIYVtcJesnIs4Ndokeg4wnbvz5UlSNhlgDM20k=;
        b=rC9LXFZkRdPO7tREwuZuqHNfz8Xswz6G+QW7oqAhV/V6XoioETNWh9Dj2TxZ1GxomN
         gBRVqCYi9iCEKcts9gAWHylNAdDfQ0tkHnpgJOkQHz0j0bYgpEKeJzV3ys1raNFQCDo7
         bFm7XYyoXUOq7BhQY9xW8RDcLc/knV14kAC0DJ7ZLiRQkovsYr1cx1Tlrkh+ZDex1Pci
         tg1AvaHKIhJn8wLxTIJJd7IBzQ9RILJMDXMo1vutQ13ZOr64A1Cy1QstlZI0sAxYgi5E
         aWEFnWFdXOEI6yCkkpCnPEj64qP5RGD4OIrEcDJAcYqtXtoMvO8Br4AEL/Hd/UotlV99
         oNyw==
X-Forwarded-Encrypted: i=1; AJvYcCWHYYhS1TwbyUzEgsK5hQXnfOiLTkfdghxUOhnwChRhe0A5EEdLun8HKlbFEa6/3nrK302WsLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKM9jl4WD1YqnpPUnf86A1KqBs1BXZUAKIGDCzSrN6KldUoAWZ
	r7uhG5ZDvf2vU2oXK7K+Wm54dxTHaO6BCPBVUvg630vtBP3yTt9ZbKDx
X-Gm-Gg: ASbGncti9pAf/9Hap83xqcBrRlAvtuCAsiYFr5AeozFJnHo0zCT829a+wVmQlLwLer0
	Tb2m8xX51KV0aqcHvUnpWF7Kw4uC1lhtUsmGAOTZHOutzbpnC0zOvGPqjQ/PRmOF5KJoHrXkeRH
	k7YGQGHTFN9cqWOOWcgWXtz71vvWiHldbQrBknu1RNCClTHLKrrwVutYuT2lDWFXBBkNc0gkw8a
	0EV8o6KCWTe4Kams7dAdZGqrOzvAGJPiGNIyYL3+ETscvtsBWKXxT2Q5QmO0sXXaUS3BjAJK75/
	cbrHDMdPgRhRrWWdpSQyrItiPl4MALiQkUk/seTfGbXId2y8XJXqM5WcotRE5P62MVh0Kpb9UgN
	TVYHvvsO7Vrac1Q==
X-Google-Smtp-Source: AGHT+IFglqUodAXwS+ScFaUf0u5cK7hW01o3j0jrGwN7eAFMAQqVtLyd+PtU4bJWyqZbJ2fZ6V8QnQ==
X-Received: by 2002:a17:907:6eab:b0:b21:b4f6:d676 with SMTP id a640c23a62f3a-b24eedb9ee5mr318558466b.25.1758278250742;
        Fri, 19 Sep 2025 03:37:30 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890c608sm408296566b.45.2025.09.19.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:37:30 -0700 (PDT)
Date: Fri, 19 Sep 2025 03:37:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Gu Bowen <gubowen5@huawei.com>, catalin.marinas@arm.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Waiman Long <llong@redhat.com>, stable@vger.kernel.org, linux-mm@kvack.org, 
	John Ogness <john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
Message-ID: <5ohuscufoavyezhy6n5blotk4hovyd2e23pfqylrfwhpu45nby@jxwe6jmkwdzb>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822073541.1886469-1-gubowen5@huawei.com>

On Fri, Aug 22, 2025 at 03:35:41PM +0800, Gu Bowen wrote:
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided.

I am still thinking about this problem, given I got another deadlock
issue that I was not able to debug further given I do not have the
crashdump.

Should we have a wrapper around raw_spin_lock_irqsave(kmemleak_lock,
flags), that would defer printk at all? 

Then, we can simply replace the raw_spin_lock_irqsave() by the helper,
avoiding spreading these printk_deferred_enter() in the kmemleak code.

For instance, something as this completely untested code, just to show
the idea.

	void kmemleak_lock(unsigned long *flags) {
		printk_deferred_enter();
		raw_spin_lock_irqsave(&kmemleak_lock, flags);
	}

	void kmemleak_lock(unsigned long flags) {
		raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
		printk_deferred_exit();
	}

