Return-Path: <stable+bounces-74031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289AC971C14
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DAEB20B15
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A017A59B;
	Mon,  9 Sep 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WpIQXni/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BF22095
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890661; cv=none; b=YbU28jTSa5MRTBNpqLL5XLK4DOp0JtNWlLsKl5JEqhq9RGtv3xkt54p46n3VEGxQgbmqgr4DaEKgdLkoGZNDalP/gAfe22/W7FQTsuqO+q0e7UfVA/IUa2P1LT5H4DLxegjKMiIgyVXpVNqmMCgr67NWbCY3zJ7f1pZrRvbHTr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890661; c=relaxed/simple;
	bh=imMFojer9vm4ioUYSov1FWoVA3pqpFbP7tw40ECG2JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5nd5TeS5iSmPUa0qbs0qI6e7jqmrbMMButHK7bk5P0Eh5WXmVW6MxliVvkZDhCOwT2xW8PJGDJ/gDiWkt8TF1yfDRQSoQICcIbJ31AX08ATuGE0PUDiQ0plYWPdZrTqDMdtd4EJIIlZkJ4NE70l15E/5gv2f5aaJGJWXRiqZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpIQXni/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F20C4CEC5;
	Mon,  9 Sep 2024 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725890661;
	bh=imMFojer9vm4ioUYSov1FWoVA3pqpFbP7tw40ECG2JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpIQXni/lquu8R2QPcNaeYdTAga0J17BWA9GHQqHdxayhiVvvYzWIZvIxSxFpUk6f
	 X0ONyylOYajPDOns7JyhryMKaRUFgmQdDTqqRozUlj+GTjg97yNTYS/EK2CQNIXnfD
	 +jk6KK5CMnBqFDe1OfS0x5dySFcA3Ufc2epcZq90=
Date: Mon, 9 Sep 2024 16:04:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Krcka, Tomas" <krckatom@amazon.de>
Cc: Tomas Krcka <tomas.krcka@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <2024090904-unframed-immerse-6db8@gregkh>
References: <2024081218-demote-shakily-f31c@gregkh>
 <20240906154140.70821-1-krckatom@amazon.de>
 <2024090810-jailer-overeater-9253@gregkh>
 <E31564A0-FC73-4807-879F-DB5B3211C327@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E31564A0-FC73-4807-879F-DB5B3211C327@amazon.de>

On Mon, Sep 09, 2024 at 01:43:25PM +0000, Krcka, Tomas wrote:
> Hi Greg,
>   Got it, thanks.

Please do not top-post.

> Submitted 
> v6.1 - https://lore.kernel.org/stable/20240909134012.11944-1-krckatom@amazon.de/
> v5.15 - https://lore.kernel.org/stable/20240909134046.12713-1-krckatom@amazon.de/

No 5.10?


