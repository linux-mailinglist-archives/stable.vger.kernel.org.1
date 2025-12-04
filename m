Return-Path: <stable+bounces-199949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF65CA2063
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 01:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79A81300C5D6
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 00:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94D74A21;
	Thu,  4 Dec 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0WgOBpQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BA3FCC
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764807236; cv=none; b=gQvtQ7P3nr9vflkWcNArzI7z0ED1vIbvQW+LCPo+QUwArBI8wmA0z8FevUqCeEE2JeETTjmq5S/E2BJevZxqHaK6p7L/kT1ZwxdkWCIhqb0Bn/z/hUnLIZ4ojlktCsxeBlRdYOsMzExPFpD27drKqrPgqj57W3YKq8c/EmTXeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764807236; c=relaxed/simple;
	bh=QYBp7Dgo/eb9G8/N3QqB+6w0/y1YhATq/0UvwBEb9pk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aPn5VpZt4cZWxkdxWvGdQyUSFtV8XjwG2RJEuKsnPenv4BT7zmP4vxjR3tVniRlk1IyRV7hP7xt5zahvZLwLdUaLZUNMKY+kPS+emDfxZGaAjOQ2CTDyxKC4YasLDD51BXh4G02WOlUdpMxgQkmYkcbJJpVWgnY8TuoVvFFaNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0WgOBpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A84AC4CEF5;
	Thu,  4 Dec 2025 00:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764807236;
	bh=QYBp7Dgo/eb9G8/N3QqB+6w0/y1YhATq/0UvwBEb9pk=;
	h=Date:From:To:Cc:Subject:From;
	b=G0WgOBpQQkfGSXUnNZwXlUtoZITjX2U1D1+s8TQc2QxgPf+ciYP8xD0OOTFFw9afj
	 HeyjIskoUSgQrEThfyG/BtHqXTCtRJZHSWJJsNpHf9EdCJtagJJi8DuvQr3dPuzscE
	 F874D9CWWZ4EbdeuEHAirpfl/ciTtY2BrcMfdX3afo1beHyFHDuWl/mrsp/DZpAL0U
	 OZ8AhAnQe9AAoHbLPFcPiE7emY8d/BLbfcYXhjmZWQjOLQ4rqLSBowdx4Riv+nTWRr
	 n8h66Q1NowTXiBbDsyHB3Osd+c59A0/Sk/ysnUgvpWhSvgi6cU9ebXxQ0sFY7GRIsU
	 ittQP5p08UIpA==
Date: Wed, 3 Dec 2025 17:13:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Apply fc7bf4c0d65a342b29fe38c332db3fe900b481b9 to 5.15
Message-ID: <20251204001352.GB468348@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable folks,

Please apply commit fc7bf4c0d65a ("drm/i915/selftests: Fix inconsistent
IS_ERR and PTR_ERR") to 5.15, where it resolves a couple of instances of
-Wuninitialized with clang-21 or newer that were introduced by commit
cdb35d1ed6d2 ("drm/i915/gem: Migrate to system at dma-buf attach time
(v7)") in 5.15.

  In file included from drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c:329:
  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:105:18: error: variable 'dmabuf' is uninitialized when used here [-Werror,-Wuninitialized]
    105 |                        PTR_ERR(dmabuf));
        |                                ^~~~~~
  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:94:24: note: initialize the variable 'dmabuf' to silence this warning
     94 |         struct dma_buf *dmabuf;
        |                               ^
        |                                = NULL
  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:161:18: error: variable 'dmabuf' is uninitialized when used here [-Werror,-Wuninitialized]
    161 |                        PTR_ERR(dmabuf));
        |                                ^~~~~~
  drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c:149:24: note: initialize the variable 'dmabuf' to silence this warning
    149 |         struct dma_buf *dmabuf;
        |                               ^
        |                                = NULL

It applies and builds cleanly for me. If there are any issues, please
let me know.

Cheers,
Nathan

