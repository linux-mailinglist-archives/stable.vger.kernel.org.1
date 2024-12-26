Return-Path: <stable+bounces-106175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F99FCF07
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 00:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0533A0339
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC51957E4;
	Thu, 26 Dec 2024 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C6yRUtKa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E1190077;
	Thu, 26 Dec 2024 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735254088; cv=none; b=ctCW3HvZwdf4MLJTFtls5qApWLfFdkBKXst6GH6Od9xoY+pymZx9i5c5mpBld1Qwa6SlKaEtboxT6PV1cnYjX1tVKhSOxLPXYN2wr3n6B1UfMcnrDjFBbnKSTAY2D4BRgAP/bD/VppnE0qykSMi2SoaXjkimFUvfAHeo6YpVfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735254088; c=relaxed/simple;
	bh=L8x/2+681ZdvroX6EgHgArPBlGaoRkAlTtICcFmeqvY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=stF//I3Wd7WGsQjtkmDF6LfXiSK6xtjA85iJZJZBb3sN0LESnVYFqRpvZ2vo+60g/O1xELX0JdFUDmwfuqdRjamuv65rJF0Up+vNdvSF5YWQ8oZJdFcUGaUQoagUnMPclQQcA5l4VuCFU0cQtMbgz3wR0bT+yN4Ek6oK9pJ3q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C6yRUtKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABFFC4CED3;
	Thu, 26 Dec 2024 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735254088;
	bh=L8x/2+681ZdvroX6EgHgArPBlGaoRkAlTtICcFmeqvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C6yRUtKainglgoeYlvvtQJHp8J/jkJrkuthx9uHUC4P3h7qPikKKwAnk1F96dqGCW
	 LWYLnVqGOP9pfvX5kCJoyJLToQkuSD4Iyk/N1GxDKDzG4ugb8rWwajnJJjk0ezElRo
	 SqiW5YNE+991xK381T+QkIdr5nXP6dyc+AzcRTps=
Date: Thu, 26 Dec 2024 15:01:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com,
 quic_zhenhuah@quicinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is
 disabled
Message-Id: <20241226150127.73d1b2a08cf31dac1a900c1e@linux-foundation.org>
In-Reply-To: <20241226211639.1357704-2-surenb@google.com>
References: <20241226211639.1357704-1-surenb@google.com>
	<20241226211639.1357704-2-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2024 13:16:39 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> When memory allocation profiling is disabled, there is no need to swap
> allocation tags during migration. Skip it to avoid unnecessary overhead.
> 
> Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org

Are these changes worth backporting?  Some indication of how much
difference the patches make would help people understand why we're
proposing a backport.


