Return-Path: <stable+bounces-176828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39473B3DFE8
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9CA16FC29
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063C301493;
	Mon,  1 Sep 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AU9UCskK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DED1AB6F1
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721816; cv=none; b=F57NCHOiE+f07atXwcenR4p8eA5oIoeY4yB2+iWQ3FeNji4jknzZBndO4Lvt4duo95He6/EOw8/uFHa+6mR6QUuQLjHO5v7wgMgGzMysvANdoB++4BVaHNHWTf6x2Yg+tjKGatawYP+pwVG495LkLlO2tmsE6Xl2shn+ZO4tjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721816; c=relaxed/simple;
	bh=B+1DlquKVk41/r6dL0vQTw41mvBrVwTTFhUlbS0w+mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5MmFcW0qktKuJMgqBCgDzt6iZYRY8ZM7ZHXrTQxjhfc4jg57Nr5Ng3kgi12MVUDOdk7Cc2nB4pH46pFNgoDe95QAX/BUOBOqTL6rIctopWp3+jHdHLLloMuIRM8fAP7oQbFeVOb05M7K2MzrqFBq9D+TKgyqi6gZxbOiFMXrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AU9UCskK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756721814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+1DlquKVk41/r6dL0vQTw41mvBrVwTTFhUlbS0w+mE=;
	b=AU9UCskKz54OXKUqfn+Nq709aRwwU5O/pFSv2Vat4PoAyusPUzbexODEUfE7vgupf1cASi
	t1MyA51SC2joN2BIuDBLOZNXipPhV2nHxUfIGrlM50FyfTCViCu8xFJzCPBZfV1oUmwyBJ
	YqSJk1HHu2e5MGSVdH4qxPkbfhlGKjo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-vz1nJLrVNeWLtfTda_JN2g-1; Mon,
 01 Sep 2025 06:16:53 -0400
X-MC-Unique: vz1nJLrVNeWLtfTda_JN2g-1
X-Mimecast-MFC-AGG-ID: vz1nJLrVNeWLtfTda_JN2g_1756721812
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96AA0180028D;
	Mon,  1 Sep 2025 10:16:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B0530001A2;
	Mon,  1 Sep 2025 10:16:50 +0000 (UTC)
Date: Mon, 1 Sep 2025 18:16:41 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
Message-ID: <aLVyia16eyoYftAw@MiWiFi-R3L-srv>
References: <20250831121058.92971-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831121058.92971-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Uladzislau,

On 08/31/25 at 02:10pm, Uladzislau Rezki (Sony) wrote:
> kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> and always allocate memory using the hardcoded GFP_KERNEL flag. This
> makes them inconsistent with vmalloc(), which was recently extended to
> support GFP_NOFS and GFP_NOIO allocations.

Is this patch on top of your patchset "[PATCH 0/8] __vmalloc() and no-block
support"? Or it is a replacement of "[PATCH 5/8] mm/kasan, mm/vmalloc: Respect
GFP flags in kasan_populate_vmalloc()" in the patchset?

I may not get their relationship clearly.

Thanks
Baoquan


