Return-Path: <stable+bounces-172937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7CB35A82
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75F0202DD5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A48301021;
	Tue, 26 Aug 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbs1hNS2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF92405E1;
	Tue, 26 Aug 2025 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205823; cv=none; b=Wn4wpQLxKXUcZ44jCNnGSa4stxUb2SnpJijDdpXuih8dkmH7FkoXRzdocUMvaOpLYjYfHrYzquuWLy+QSzDMJL/sp9l93l6WK5vElZTFMZShlMYdhSWRlH180QPqRRjTyQcys2GIhi8SxK6kOkjgMofWi6Aj+Z3S0eXMRUH4cUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205823; c=relaxed/simple;
	bh=s6AmvoIh6GZk18dhj42HyoNf61YvsmCr2wYgg283GB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gKdUHT0iLJ7X9FUKI4zX9o12jfTCCuqDfI0CfF4MB4ihy68wS1HUds2t6UgI2RdDchLRv+6dRhkPyzPwZpBEaDug7hitQ/L1NvQI/zk+TT8dk5Sbf0ydmUs5JOytJePJlM+sGOjw9O/+d6iD7Na9ReLkNgQc0Bv+AXcdTTbpQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbs1hNS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEFFC4CEF1;
	Tue, 26 Aug 2025 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756205822;
	bh=s6AmvoIh6GZk18dhj42HyoNf61YvsmCr2wYgg283GB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lbs1hNS2pPgLj8xJez2ycKWlUERMA6OWN4d/wi0IXqD3RhQOPsD+LL/wjTGJprM/0
	 sLmC7r1WMjodGjTS3mMm05IvIQj71web8s8GyidzjjDEg0dKUk8oJaxfAwKzNCXbXf
	 srra5oI6TEYCQwYWPGXNKS+hGYVJ9j6icE1EzUrkbj7adW1FxE+tAixQnT5E8IuOTF
	 MMivBgh+sNoQGQS1sHeb3df6+YECM9t9lHF12M7xBm6jM4sWJ4eREe/+LhyOfjjzPi
	 5/PWWBIYBSAEHfzH6gDd5C4PoHTfa0WnJ4PDV5R604U/Qz4FcgMQd4CdpA7g3XyzEl
	 Bzde0F5M/ntEQ==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Cc: Donald Douwsma <ddouwsma@redhat.com>, 
 Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
 Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org
In-Reply-To: <06c9617f-a753-40f3-a632-ab08fe0c4d4d@redhat.com>
References: <06c9617f-a753-40f3-a632-ab08fe0c4d4d@redhat.com>
Subject: Re: [PATCH V2] xfs: do not propagate ENODATA disk errors into
 xattr code
Message-Id: <175620582048.233053.18319927373713731388.b4-ty@kernel.org>
Date: Tue, 26 Aug 2025 12:57:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 22 Aug 2025 12:55:56 -0500, Eric Sandeen wrote:
> ENODATA (aka ENOATTR) has a very specific meaning in the xfs xattr code;
> namely, that the requested attribute name could not be found.
> 
> However, a medium error from disk may also return ENODATA. At best,
> this medium error may escape to userspace as "attribute not found"
> when in fact it's an IO (disk) error.
> 
> [...]

Applied to for-next, thanks!

[1/1] xfs: do not propagate ENODATA disk errors into xattr code
      commit: ae668cd567a6a7622bc813ee0bb61c42bed61ba7

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


