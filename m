Return-Path: <stable+bounces-166803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59FB1DDAE
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 21:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DF81AA3687
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7676F223705;
	Thu,  7 Aug 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZsfzoeH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341401DB546;
	Thu,  7 Aug 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596269; cv=none; b=r+MIE/mOT7qv8RZr3YYw8oPpJi6cjxni3yu9szGy8uku6d7zfXOoCM1Ssh8PPfb+0+NgxbmvrLoZY1qFcSFLvzz2UmKTWlTvgmJhyYeUmbaMvRmpce7O9EBtgs0HIE70L9SGfEIci41tpYuCMhmF7d+CD5Ng+U4Of4m7zLS1W6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596269; c=relaxed/simple;
	bh=smOPrnKQVzz1Nb6jzpFDay11u+YhZ6AU1L30Dn5yflY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQVvQ5RO1Vo7xPEGoM9ODcHzDVwuK1U8nhV0/1WMmXsWup54xnIzdNr8HBl5jBmIV/hgVOo3uld4ncOMJqQeskrWe+QAmlC/2jgSUbMIG+QQ92IhWYhDNiq25LldlbY1htTSxd+jJwJDXowYTljaxVZrQqE1FTq+j0J9zUqv10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZsfzoeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79747C4CEEB;
	Thu,  7 Aug 2025 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754596268;
	bh=smOPrnKQVzz1Nb6jzpFDay11u+YhZ6AU1L30Dn5yflY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZsfzoeHrQSWBcuqqrRByFUrNh3Q527uhDK+tAixACbLioF69+YAmEYtzyXu268jG
	 GxpKVLgwWJ6zShg8FRJl6fxfAL2IHFCd3O9ANMQd0A6CYD8QqB8lbV6FEwG8gZuWny
	 giqu6Yk2RykWnp+uUOAxt41yDhxfxznVYtkt+lcUGjDNltZQaIHDQ8kwtzShOUQ/i7
	 XRjzvoITgXHQVAtbvtGa9aZcwqcgUyW8fOaVtqSlZUJgq7dcF/ko/DiseMvp+DFYtv
	 Gwyo8gVFcGqb95QM3n6Jgqaj2TkKcz3dFJCwMskGnSbvqg2TQbvLeoAFKSS9UwLkDT
	 6md7AvIf7WLUw==
Date: Thu, 7 Aug 2025 15:51:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
	aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
Message-ID: <aJUDqqjCycGDn1Wg@lappy>
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
 <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com>
 <aItjffoR7molh3QF@lappy>
 <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
 <aIzAj9xUOPCsmZEG@lappy>
 <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>
 <aIzPPWTaf_88i8-a@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aIzPPWTaf_88i8-a@lappy>

On Fri, Aug 01, 2025 at 10:29:17AM -0400, Sasha Levin wrote:
>On Fri, Aug 01, 2025 at 04:06:14PM +0200, David Hildenbrand wrote:
>>Sure, if it's prechecked by you no problem.
>
>Yup. Though I definitely learned a thing or two about Coccinelle patches
>during this experiment.

Appologies if it isn't the case, but the two patches were attached to
the previous mail and I suspect they might have been missed :)

-- 
Thanks,
Sasha

