Return-Path: <stable+bounces-165178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C33B1575A
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41177A61F6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C9B1A0711;
	Wed, 30 Jul 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Zmm8Zsa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD07E1
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840801; cv=none; b=rnMkNBvVW3bK1lbEtxj/RKHuh3Lac2ppObeCmBFJ6vaVDgSAVTZtwQ60AZGVfqh9sxEBbQ/XgmlMobHtbnsspeNmocevd/AO10rIgaF6QIfgltx6DVpEfSUCmvbXe9ZQjnaTQtxwGjtop/iB3khu+m1CvyEBE3n/wieEY/pGL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840801; c=relaxed/simple;
	bh=HyB44ZZ6pk8w3wAojyfFHRz7MWKPiai1SP+6ZMkt1/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGqx//t4h81pvrgc14b7cE9368EWuaQTFyln8dAwznuE3nnBD3MPC5AjR2/UPMk9N/Yneg/CuCT/aI8+Be61X8x9gCxsCLelBCzNVgIsk/xWcp7k06LO/6UbjVKKrWsgsbeZx23xX8mcvQaFAXNIRufkpOMYocdKqL3Axz91yoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Zmm8Zsa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24070dd87e4so69275ad.0
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840799; x=1754445599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcSJTaElVVvYYo9nNi0EOGtYaOjMylV8RmeZ1BcyB1k=;
        b=3Zmm8ZsaFw+q7/hudtGqMVJ3EHGaNNjx1r3tqyYMDGtazw7PAWqJw8Cvs1e9lkl85Y
         XuPjaPckxwepCb3GKNsuh5yjJnIXo3v06ZZVzIEIlfYyljzjNqC7f2GCiHMvW/z1+XiL
         xxpgmFJE0oRpiKFPjL4bNhopGJapmNEEtTatJwIC3z8Mvb9zvCUrOIpJLVBpgo+iq/5c
         B5MKFOle8rYqWy5hFb+/P9m6XCA63+LG4dA0qNBm8ZWgE4X5dG3TiUC4RTfM5YNHL+qy
         vTnNEf2r/x0KgsNgKCM3uaU85PB6bLLLmtuZuS2tsaDmiBsW7/0sX/wndYpAh8qu7twT
         IsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840799; x=1754445599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcSJTaElVVvYYo9nNi0EOGtYaOjMylV8RmeZ1BcyB1k=;
        b=FlRlp+sXUoIWC+glljXqurT2eQMMMcNlIhOwJAyg7p9DjsZpQii6CUZfyUmUWX/szE
         8mZVuovi/AFQvvYroGCu/wQUT6W+QddO2Hr4jDEkHMPNrd8xoIYAi5ZpLB5FujNx9ecw
         vkpgwK6maokOOF1T5yVR/aWV8BmEnneaMWimMYmeF7m0OVjseUiuGjKimUKzgdPbMKjc
         N7dtkFd60iRVmCZs01oeQshY2XtQtzVhFu93tg+XvCssLJpx+Cqlf4ghODsXvVwqzRAM
         +oSNMK/DEfXsVUEtMFpS5uhbDEZdF5hHJW60sA+SQQxO9+pdlXVPEQNjz8R5jp9ukZeq
         xUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQyEIcacfP3CdUiR4w0Wc7HMfMnR1mDUt4dHi05Iox8B3zW47KMzeEYJxODtmViXUIHNcY5kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyJdxK0OSC78yaAqnKRG+u722FMdCaiirCS+FMf57MTbQ2Eds
	/cADLbADHTfihJD7VCF1NMzp99G6R151J98fwZf4FEi0N6UHwo7ImHWH0H7C8l6c7A==
X-Gm-Gg: ASbGncul5p6qvRJp7jAI6yMdofEdvKgghdHqw181fMrND9WYyAtcvWyxv9sO427OwUW
	dRlFV5iSz98RZGMLiGIZnJOLAYguzSVcktp8TiJWuXcgIwa7rErnNBmFVlvO7n820D7Bi7PVN6j
	M+L9SgBSgemUPGDtj63WIujJinVXMcv8uvG0Yi+Mm7bDU2QDxVwWdqWwmBN/M5YQNeTzvx4tnHj
	0XOXPSvymCFAWsP/44ugWl0xFvhdWM0eJlW6ZQSLhNpYvGElXY1gfcmKPidqCjHan60UTGJsQPd
	I3UpLNq7/bTbjsDzv349OA5bzDYnK6vrElJLHBZqbaB0Z5oWoP+p6t/JR1f1eZZc+/MURA+dzA1
	ZqQaaMq+Usv3FJn/fY/O7a0TzV537j+wr7EDZxpBkSca0JLs5t3m8NIw2C/2TDs4=
X-Google-Smtp-Source: AGHT+IGjlp72ezcaslBe/4Wam1DWdKTtFPAg2RfpZpa/ZWAp7fRLm64jv1x6op5wLdcpNXOdDDpIQg==
X-Received: by 2002:a17:902:cf42:b0:240:5c75:4d29 with SMTP id d9443c01a7336-24099e4ecc0mr2140635ad.0.1753840798874;
        Tue, 29 Jul 2025 18:59:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9606:2f93:add0:9255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408def71csm9185669b3a.56.2025.07.29.18.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 18:59:58 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:59:51 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, aliceryhl@google.com,
	stable@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5.4.y 0/3] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <aIl8lyrHJ4DAQkxg@google.com>
References: <20250730005818.2793577-1-isaacmanjarres@google.com>
 <aIl1AbmESlTruw7K@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIl1AbmESlTruw7K@casper.infradead.org>

On Wed, Jul 30, 2025 at 02:27:29AM +0100, Matthew Wilcox wrote:
> On Tue, Jul 29, 2025 at 05:58:05PM -0700, Isaac J. Manjarres wrote:
> > Lorenzo's series [2] fixed that issue and was merged in kernel version
> > 6.7, but was not backported to older kernels. So, this issue is still
> > present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.
> > 
> > This series backports Lorenzo's series to the 5.4 kernel.
> 
> That's not how this works.  First you do 6.6, then 6.1, then 5.15 ...

Hey Matthew,

Thanks for pointing that out. I'm sorry about the confusion. I did
prepare backports for the other kernel versions too, and the intent
was to send them together. However, my machine only sent the 5.4
version of the patches and not the rest.

I sent the patches for each kernel version and here are the relevant
links:

6.6: https://lore.kernel.org/all/20250730015152.29758-1-isaacmanjarres@google.com/
6.1: https://lore.kernel.org/all/20250730015247.30827-1-isaacmanjarres@google.com/
5.15: https://lore.kernel.org/all/20250730015337.31730-1-isaacmanjarres@google.com/
5.10: https://lore.kernel.org/all/20250730015406.32569-1-isaacmanjarres@google.com/

> Otherwise somebody might upgrade from 5.4 to 6.1 and see a regression.

Understood; sorry again for the confusion.

Thanks,
Isaac

