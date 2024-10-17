Return-Path: <stable+bounces-86630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035A39A2437
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D3B2534C
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E11DE3BC;
	Thu, 17 Oct 2024 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=collabora.co.uk header.i=@collabora.co.uk header.b="XhGRtdwR"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB71DE2B6;
	Thu, 17 Oct 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172836; cv=none; b=h4HnEbMxo9/pYIWlnAPvTVh5hP+UtDQ3o/wJFKtWwu/JEwA+iFWWVR/6/QTpVc/2V7axnCiCosZtkJPX/1YDdhPT+uWz6RsSVOMKxng9j3nepfFgmifPQscwqkHNrXkAdG4m8/oBTBDgb9HEosunWOxBkN1ArHZYRTWE7JTGbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172836; c=relaxed/simple;
	bh=wAgx7NQSaDA+Q1cPdWZM+QeAuPDAlF1WphFS/446Co0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkt6vMBCcnHkqtV8/gWRku7hDgcNqI+ernYNdh0dEK7i3HYPYKCIykGDgT6uYg13JCzfXegR3kaWD5LmQV3noudkB5sDzEeLnuzyNR+CQnUbmq3Zgo1Vpr76S4x9Bi1WmRbU4AKFVp1yz34TTMyRRhi20gqUbb3Z/GIPSHp5iAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk; spf=pass smtp.mailfrom=collabora.co.uk; dkim=temperror (0-bit key) header.d=collabora.co.uk header.i=@collabora.co.uk header.b=XhGRtdwR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
	s=mail; t=1729172832;
	bh=wAgx7NQSaDA+Q1cPdWZM+QeAuPDAlF1WphFS/446Co0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XhGRtdwRZ5IUQb2vfklPHyssadN/SCuUfdizEBtt5teb/gmJ9ChSDF6VXDPzUMHij
	 kByvCO8cgEPvrpQEprqPznj5F4Pgl7/1Bq4hno/81kiIL8e8P4uaj+HxeJfpYxJcxL
	 t2FWKLQwSY/6LWillNzbj1pyo2Lc7cAyy93g0+upf55Gk8PgVUKNtctMcoyYIR2Rbu
	 MGnYy7YebSXiEutD0JxqkH/v55c8EQk/QDvIcp9W9996KojmlsnHnKR2UskAcDQ98g
	 70Jr0roaWm0UKmqG10iWlXyVm83T194lJQIQJD0zan8Ag8tUxAi09+r5hmQSnmJ2I+
	 QTUjQfOcLNHAQ==
Received: from nuevo (unknown [IPv6:2a01:c846:1a49:2b00:4bd7:ad27:a4f1:789c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrewsh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F18F317E360B;
	Thu, 17 Oct 2024 15:47:11 +0200 (CEST)
Date: Thu, 17 Oct 2024 15:46:54 +0200
From: Andrej Shadura <andrew.shadura@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Justin Stitt
 <justinstitt@google.com>, Aleksei Vetrov <vvvvvv@google.com>,
 llvm@lists.linux.dev, kernel@collabora.com, George Burgess
 <gbiv@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix type of len in
 rfcomm_sock_getsockopt{,_old}()
Message-ID: <1e450049-d173-4a6f-b857-71b7c6f50e6f@collabora.co.uk>
In-Reply-To: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
References: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 09/10/2024 14:14, Andrej Shadura wrote:
> Commit 9bf4e919ccad worked around an issue introduced after an
> innocuous optimisation change in LLVM main:
> 
>> len is defined as an 'int' because it is assigned from
>> '__user int *optlen'. However, it is clamped against the result of
>> sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
>> platforms). This is done with min_t() because min() requires
>> compatible types, which results in both len and the result of
>> sizeof() being casted to 'unsigned int', meaning len changes signs
>> and the result of sizeof() is truncated. From there, len is passed
>> to copy_to_user(), which has a third parameter type of 'unsigned
>> long', so it is widened and changes signs again. This excessive
>> casting in combination with the KCSAN instrumentation causes LLVM to
>> fail to eliminate the __bad_copy_from() call, failing the build.
> 
> The same issue occurs in rfcomm in functions rfcomm_sock_getsockopt
> and rfcomm_sock_getsockopt_old.
> 
> Change the type of len to size_t in both rfcomm_sock_getsockopt and
> rfcomm_sock_getsockopt_old and replace min_t() with min().

Any more reviews please? It would be great to have this fix merged :)

Thanks in advance.

-- 
Cheers,
   Andrej

