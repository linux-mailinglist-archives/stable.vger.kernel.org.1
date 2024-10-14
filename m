Return-Path: <stable+bounces-83658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ABB99BE42
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D903B23112
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8FA7DA9F;
	Mon, 14 Oct 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA8rWCov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57473446;
	Mon, 14 Oct 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877076; cv=none; b=OjAoBkHf1ef40hEvGLJcCgda+p3CwnV8DQBrQOolYSem9pZIBGLf/izct3iBuNJBhsa5xni1bTeL87k8jNCZ0T/v9jgUc3YANWueBzEERO2XxJhvaVPY58yui9or7A0/HaJMTx8aO3d1Wg/QKP7nPzwku9ItmaXGIjVDdaW/l6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877076; c=relaxed/simple;
	bh=xhmR/EtjBRU+x6+aFJWz0m1jZtBzaJ0sMvWzxNLG2i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWhtUXvHRPUsKMlwrKpad0soZ02mHYWIMWZoVtuGMvg6eLXI5Jk9V5X7zGt5kfCyGyhnBmw9dHfz1mKbSAldH+7NqBcslySquALZp3DV1sEXdtBMHqSsDQ552YFN3G5HzvnByLSmlz6RaB5HTDCjoC9tkNVzT1JcfHBbTM8C2PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA8rWCov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1290EC4CEC3;
	Mon, 14 Oct 2024 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728877076;
	bh=xhmR/EtjBRU+x6+aFJWz0m1jZtBzaJ0sMvWzxNLG2i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA8rWCovQVkmTrUpyyzmxsY/jfo9GoIhGI/YorwQCYvjZ3VhuriXztPtMsKc/4mt7
	 JHQE7HmpMxnkcIRt/NHeP7pUEaBE4Zkm/OuvMmb6tS9Ru9kIAy6WUYUFs+ca5gk8hG
	 Gc4x1DmELZ34WY7n5l4WbvrzAfd7v7SZQj2SCXnqUGLsvNOBrVhtqpb8X30LD0HzeK
	 fUFLH56EN6SBEigQg7GH80DfEzqY9Sh9GbGCOfLcSgBoJMdW+3JKgGV2qU6q0ILsnX
	 ll/mE3kvpf+iYpx87fqpTLmz0JnzVFS9XAT128FshERdgnV2s2q9m+f5ij4Ubo4nIG
	 uruYehD/uXClA==
Date: Mon, 14 Oct 2024 03:37:53 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Prashant Malani <pmalani@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: fix missing fwnode
 reference decrement
Message-ID: <ZwySEQj8x5lhE9Nj@google.com>
References: <20241013-cross_ec_typec_fwnode_handle_put-v2-1-9182b2cd7767@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013-cross_ec_typec_fwnode_handle_put-v2-1-9182b2cd7767@gmail.com>

On Sun, Oct 13, 2024 at 03:20:24PM +0200, Javier Carrasco wrote:
> The device_for_each_child_node() macro requires explicit calls to
> fwnode_handle_put() upon early exits (return, break, goto) to decrement
> the fwnode's refcount, and avoid levaing a node reference behind.
> 
> Add the missing fwnode_handle_put() after the common label for all error
> paths.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec_typec: fix missing fwnode reference decrement
      commit: 9c41f371457bd9a24874e3c7934d9745e87fbc58

Thanks!

