Return-Path: <stable+bounces-195418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4CC76237
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AD21B290A8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F62FB094;
	Thu, 20 Nov 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUgR5We2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56E1E7C34
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669286; cv=none; b=S7Osv1Ye3bGac3NMhc5Ran/F2a7sp164mcvBwjpKvcsXSbmx0Ho8c8ORuQzIdtrUBWk5mJX1T72H9/iLdP23B94P5Jct7dTjErqw5f/d85cv2LB43Eq/WlUbK7CwAk8sYXzqmiGrtzPDz7KyIcsLruJsETjIfgqA3/8ieJi14uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669286; c=relaxed/simple;
	bh=VVP8DdbSUeK/J4HV2SMoyh6buJCbiFpKSw4KcUAUqQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cB0fBycIsTLsE7Tipau0rsY/0MyadXLMxR8oS2oqcWxinyTU/pKFdzk3RAg+voMC7f5VT+4beVzRAOoZecjwtJoJeq4dgoWrkw9OZnqIqwhSgT0ChLAqiph3bX7xP8WgcgY+2CE1AVAoTxKt1xLJTq62P5kGeRAGQqn31uP5yUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUgR5We2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFE1C4CEF1;
	Thu, 20 Nov 2025 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763669285;
	bh=VVP8DdbSUeK/J4HV2SMoyh6buJCbiFpKSw4KcUAUqQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FUgR5We2tVWz3KOYVUlN9XBm2aT9NIJuOBtVwZlHkIk4HijQ9xaoL+hJIAJzVu+1+
	 kldFCboZhalUhd1A6glgmSWS/am1dk6WrKFWuw3nWY/EqbPTlBjKcfpoJ8EbqdFi3g
	 O+NozSCVx3VB+rhgZnQj4yJT6++vwZZFZ2iN7liJIq42i19RJ9GsWPvnneOVvnmkEP
	 YVnYefGXWT/BwT5aKviXdVcq3J5EWu/bsgSaZiwmY1rL2ykMW8tSzOpU52YpNL1g1p
	 +s2vMiv7ehxSoD/sOABpJbOO/joYPl6Dou5XevL7Zm/WpOcVu4c53FBlovBXLvWOCJ
	 6rkhH4KPoRbGg==
Message-ID: <7fae20ca-d7b0-4786-8c31-288648db8ad0@kernel.org>
Date: Thu, 20 Nov 2025 21:08:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: rename AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM to
 AS_WRITEBACK_MAY_HANG
To: Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, shakeel.butt@linux.dev,
 athul.krishna.kr@protonmail.com, miklos@szeredi.hu, stable@vger.kernel.org
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-2-joannelkoong@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251120184211.2379439-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 19:42, Joanne Koong wrote:
> AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM was added to avoid waiting on
> writeback during reclaim for inodes belonging to filesystems where
> a) waiting on writeback in reclaim may lead to a deadlock or
> b) a writeback request may never complete due to the nature of the
> filesystem (unrelated to reclaim)
> 
> Rename AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM to the more generic
> AS_WRITEBACK_MAY_HANG to reflect mappings where writeback may hang where
> the cause could be unrelated to reclaim.
> 
> This allows us to later use AS_WRITEBACK_MAY_HANG to mitigate other
> scenarios such as possible hangs when sync waits on writeback.

Hmm, there is a difference whether writeback may hang or whether 
writeback may deadlock.

In particular, isn't it the case that writeback on any filesystem might 
effectively hang forever on I/O errors etc?

Is this going back to the previous flag semantics before we decided on 
AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM? (I'd have to look at the previous 
discussions, but "writeback may take an indefinite amount" in patch #2 
pretty much looks like what I remember there)

-- 
Cheers

David

