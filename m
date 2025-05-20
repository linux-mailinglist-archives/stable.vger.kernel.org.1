Return-Path: <stable+bounces-145726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4CBABE7DE
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1960F4C1D29
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 23:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06A255F2C;
	Tue, 20 May 2025 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="RYxJl9Fy"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D451DB124;
	Tue, 20 May 2025 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747782275; cv=none; b=UGZYWEFdtfJpBtHHk3hFopir4Wtc7NypafjWAifa2nXK8qOIRdLRFrQ81liDGnI2L/TXxtpZMtluTaG0oufgt3sMiaa+Fvz5EAXzgo9xzyY1n1alK9do23mNZecWTs9rGpJ+yhXLasRQyRVglRj0hddqgygwRujyM/BzD+0fpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747782275; c=relaxed/simple;
	bh=tDXpZCUkQgjkO3Da/7gb1X4LzM5jPOJfjXS3DnjqAdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMFbYM8g5w2i2/PN01MgVyOCQLAv/skGo6E4t1qpLijF6x4LufRpVPeg+lk42tiPTqCvtG2B6qT+jT0fklUWi2z3DId98ouSl/SogYV5fg8DpyMrfzyVTLu41k5kU3Ytk+RQh4Zm7urlYZbD7NxpK/GTTtKn5djqPo9I1jkX0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=RYxJl9Fy; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=m1wT2+4NPiyGqRvjwqiA/rcJ7SWWNmJrvdmVEsEC2Mo=; b=RYxJl9FyRRAuveYI/V5D5+QxWp
	l5q5FKv7W0QvGyZYGVRhl7w4F/XL37gR1BLxUaV8IqIOwzT0ZUJwdGGD25NHe2DeSXqTUdhz1M0W9
	lbvYN5MYaFzKNUOLKuV4NGChz9iXxw/wf+8zJtbar4nRC0AHQIoPF7lpEMdptuSTLCS7PF3pSLcwL
	UrSS7zZla5MrTQHy0CxmXSjNuU1P/IrbseiRMjsvN3VlXRInTlvdfMouRa1hpoMHep1gLVP+DeNZT
	RYZ1hufc88zhL3KFleXQrLt+/rs2yXskPdwE38AqyXZeGr9p0pN+uy7/sljDMM8Dsuor1fQ7+ZOBr
	a7b4zuHQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uHW0S-007f5W-10;
	Wed, 21 May 2025 07:04:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 21 May 2025 07:04:20 +0800
Date: Wed, 21 May 2025 07:04:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: bbrezillon@kernel.org, schalla@marvell.com, davem@davemloft.net,
	giovanni.cabiddu@intel.com, linux@treblig.org,
	bharatb.linux@gmail.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/4 v2] crypto: octeontx2: Fix address alignment on CN10K
 A0/A1 and OcteonTX2
Message-ID: <aC0KdBdslZM8m2Ox@gondor.apana.org.au>
References: <20250520130737.4181994-1-bbhushan2@marvell.com>
 <20250520130737.4181994-4-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520130737.4181994-4-bbhushan2@marvell.com>

On Tue, May 20, 2025 at 06:37:36PM +0530, Bharat Bhushan wrote:
>
> +	info->in_buffer = PTR_ALIGN((u8 *)info + info_len,
> +				    OTX2_CPT_DPTR_RPTR_ALIGN);

Any address that's used for bidirectional or from-device DMA
needs to be aligned to ARCH_DMA_MINALIGN.

Sorry I missed this during the first round.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

