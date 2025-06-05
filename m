Return-Path: <stable+bounces-151524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38B4ACEE9C
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085A63AC3F3
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48D20D517;
	Thu,  5 Jun 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Am1q0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AE1C27
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123502; cv=none; b=ocwpdQ5rnV0TEZ8eLoZ+ohz9Fh+yYckKjn6VSmJZHl/Q1MSxlndbtCfhGHElzZSIvp0hTa/86UC8QkI6raAToMjeDhGzPtqau8J6pMwfnUpDySY5r75Lz6ivaYwP6NNToJ1FUJVpNZi2t1Tabt3/1oqItQ8Bd0zi8wPGOJZorUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123502; c=relaxed/simple;
	bh=lIb0jfAObaB5dNIo2rUyYWR/iyhbU1Fo0x6bq/t5iyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kZ4Q+jYGSYjuNegFz20Kay0W9j4r3yi8wSQtd0the5CpCE6CatSG6oK6gA+mzuv7Uvnfxo6H+NJqHzVhusNlzmDCN3/IsqrFE3E+28gzHRStpp4x1CI43HC6SKK8zmYFwWaIbTUsziG2Eg/n6AifRfd+9PVBJrvBjaC75B3/jq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Am1q0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FB8C4CEE7;
	Thu,  5 Jun 2025 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749123502;
	bh=lIb0jfAObaB5dNIo2rUyYWR/iyhbU1Fo0x6bq/t5iyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k+Am1q0t6P6/W9PecX+/w5If3APc5iBk7kNUrrfCLcc45Hm04y3LBbCTKXrk1WcHU
	 AjK+4WYH0pWi6ONstjGl7G0lHS+gEUpSYRIj5Z7vlhLG2/80a/lHEIIsL9lUaAs/U5
	 K/vfP+HQXdEY10hgtldFuP3932ARU23ch7viiNIx/O7SaQRkvwKFCGYptWXibvgGAI
	 V9qQxdmsN5CIHTZH7VFhdU8EFu6eoqvoiEqFTzCiSelNQvLWuBzNoJOuLRVrsTQa6r
	 /pc4y9OCnZxpBWpdz3qFH3SdTknzFBf5S1HhourGKwmmWhQoQSH1e2u9VIEryBhWfN
	 Lk+dNT8Fd443A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: <stable@vger.kernel.org>,  Peter Xu <peterx@redhat.com>,  Mark Rutland
 <mark.rutland@arm.com>,  Lorenzo Stoakes <lstoakes@gmail.com>,  "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,  "Mike Rapoport (IBM)"
 <rppt@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Jakub Acs
 <acsjakub@amazon.com>,  <linux-mm@kvack.org>
Subject: Re: [PATCH 6.1] Mm/uffd: fix vma operation where start addr cuts
 part of vma
In-Reply-To: <20250604123830.61771-1-acsjakub@amazon.de>
References: <20250604123830.61771-1-acsjakub@amazon.de>
Date: Thu, 05 Jun 2025 13:38:19 +0200
Message-ID: <mafs0bjr2to44.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jakub,

> Subject: [PATCH 6.1] Mm/uffd: fix vma operation where start addr cuts part of vma

Nit: upstream commit has "mm/uffd...". The 'M' should be lowercase.
Maybe your email client mangled the subject? Some of my tooling scans
for commit subjects to track stable patches. So it would be nice to not
change the subject without need.

On Wed, Jun 04 2025, Jakub Acs wrote:

> commit 270aa010620697fb27b8f892cc4e194bc2b7d134 upstream.

[...]

-- 
Regards,
Pratyush Yadav

