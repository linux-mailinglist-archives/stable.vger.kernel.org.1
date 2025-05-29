Return-Path: <stable+bounces-148047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED182AC758E
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 03:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A9B1C04542
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 01:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31136221DA5;
	Thu, 29 May 2025 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwch8cnm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6515A864;
	Thu, 29 May 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483628; cv=none; b=bAokiDKjoxf9X5JGB/cviG0zlljS3rQ5+S4Skz+cdC1mTAgbMo2pPVfDuWSr1ekFZontq2YCENUkXKyEAyD6x2eNinfwXTgYqQRJt2mJeR8FW1GWX1aFligqOL+sg1Bypa3rUhZrpsORb59ZqAcbdbKYNLQTiZS5xdzagCyjIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483628; c=relaxed/simple;
	bh=KbS5YpI6Hxz3Dv49Grl7b1ocLTnHAPwnQ/RggobBFJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUWC8rMcpgJBkcxY9jQFqHaZQem9GNFEv0ZnhIl7gacp9Vpyc3/fYVWoCT4WITeJ2NmB95XuQm+QeQC7RnihhuOLXkQy1vCusX5rKMebttX4m9sM72wSRzuGA9JvqujBWFSFeIPl5BAtSbm62d6oWYQnR8LfYwnoY04Bpx33ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwch8cnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE40EC4CEED;
	Thu, 29 May 2025 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748483627;
	bh=KbS5YpI6Hxz3Dv49Grl7b1ocLTnHAPwnQ/RggobBFJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gwch8cnmsBUOlC9WkCTTd1Pd09oywUw889rUW6Xma9vK8UL8+LUYQCQLMVaEwp8++
	 8cc6bTEB0H3eyRuluHG62LuuRGljgHX16TS4TYhpa2Puz3hItqNJ9RmkUdaS1XSDiN
	 9KheFvV3QdXiul88MSr5tTTsGrHyBMhTcJH6pVNQmaaSwLDSiQK+cZoLAcVUNGpNAo
	 IGnz9HW+P5k7R/jyKwO8/E0tRspNlbmbx/vVH+G4zzxfzPbctJSxzqHdi2mvbx5NQf
	 9ElQmH/1gEE5wlFXM3EjzpFu8eC/EXExdvmvTl+6XT2gAwJYtB7llRR7JN/P333bkN
	 DwyjkMD/HuZOQ==
Date: Wed, 28 May 2025 18:53:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: af_key: Add error check in set_sadb_address()
Message-ID: <20250528185346.4eebf434@kernel.org>
In-Reply-To: <20250525155350.1948-1-vulab@iscas.ac.cn>
References: <20250525155350.1948-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 23:53:50 +0800 Wentao Liang wrote:
> The function set_sadb_address() calls the function
> pfkey_sockaddr_fill(), but does not check its return value.
> A proper implementation can be found in set_sadb_kmaddress().
> 
> Add an error check for set_sadb_address(), return error code
> if the function fails.

Please look at the callers, and you'll find out that the family has
already been validated.
-- 
pw-bot: reject

