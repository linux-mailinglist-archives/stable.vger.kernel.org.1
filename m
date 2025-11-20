Return-Path: <stable+bounces-195241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34EC731D3
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A6EC351236
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B130C373;
	Thu, 20 Nov 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNK9vddX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649F2FF645;
	Thu, 20 Nov 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630737; cv=none; b=pUzl0CH7E/tkuPRh5IgNzKE1OgQeUaqDZNWL82kIY6ju+Bfh3Amf36Bj3kJQy/HOTSBcqfrHu6vtIMAYSiV2H6l78HfQuyordVWnFs6uXy1X3McZWTdrg2iMrDhegm1htrT9cVUYe17371dQXa0SBadoy4n8ZffaivmeNsVIXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630737; c=relaxed/simple;
	bh=evjGnIEpXhARTPmoO/cs1I6ssBqa6z251Ea4MgH+LQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T4jEkxfwO2zPe08UPeZr5Y2w1B8oxzCPkWV5t1UurQXzgewCn2zUO32iVTouCWSF2wFRbjga0OcY4wQV8S/amBK0DzVR0AAvMcQO3IkIynUyK2K5lG68eWo0B8B/1O9DAQrcFSdy2HBYnf/efGp6sRuUHQoVUMpoZKK7DaOliaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNK9vddX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109C2C4CEF1;
	Thu, 20 Nov 2025 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763630737;
	bh=evjGnIEpXhARTPmoO/cs1I6ssBqa6z251Ea4MgH+LQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FNK9vddXtCXrTVzMyiR2HxiHbuMADQ+WlZBq9mC2fCoJRg4vxHKB00hiwoIdlap7D
	 ncqc3fjzIGcBOTVaFUQrnXwJG24cD9mYLD/RvqVcnaucDRl0dDIPHmv1Rs9C0IwqVw
	 s7+c3N4FOk1KTTX99A9jjZwC3qHcvY5iLBrgEQPOsGxXrk1mtM0jfm/6JDLI5Qi6+z
	 /TZt7Ev5zh9kGnqUhkWRjoBdf1vgO6jiUHQe+HwET90FCgxYwHcvztM1shPH/HhBc+
	 V/XfajD1W9gE/o5+4CzWKlvEzdm98ZirchTgFzeZIbuFPJ86z0jfXVil2Tzx9gkcLq
	 bzCkwzRc9QBYQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
In-Reply-To: <2025111944-bullpen-slinging-dcdc@gregkh> (Greg KH's message of
	"Wed, 19 Nov 2025 17:02:49 +0100")
References: <20251118182416.70660-1-pratyush@kernel.org>
	<2025111944-tracing-unwieldy-1769@gregkh> <mafs0wm3m2f1h.fsf@kernel.org>
	<2025111944-bullpen-slinging-dcdc@gregkh>
Date: Thu, 20 Nov 2025 10:25:34 +0100
Message-ID: <mafs0ms4h2gz5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 19 2025, Greg KH wrote:

> On Wed, Nov 19, 2025 at 04:55:06PM +0100, Pratyush Yadav wrote:
>> On Wed, Nov 19 2025, Greg KH wrote:
>> 
>> > On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
>> >> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
>> >> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
>> >> KHO maintainers can get patches for its test.
>> >> 
>> >> Cc: stable@vger.kernel.org
>> >
>> > Why is this a patch for stable trees?
>> 
>> If someone finds a problem with this test in a stable kernel, they will
>> know who to contact.
>
> Contacting developers/maintainers should always be done on the latest
> kernel release, not on older stable kernels as fixes need to ALWAYS be
> done on Linus's tree first.
>
> Please don't force us to attempt to keep MAINTAINERS changes in sync in
> stable kernel trees, that way lies madness and even more patches that
> you would be forcing me to handle :)

Okay, my bad. Feel free to ignore this patch then. And I will keep that
in mind the next time around.

Andrew, can you please drop the "Cc: stable@vger.kernel.org" when you
apply?

-- 
Regards,
Pratyush Yadav

