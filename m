Return-Path: <stable+bounces-164361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C20B0E902
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 05:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA3C4E41EF
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 03:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4B23815B;
	Wed, 23 Jul 2025 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcWUccFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75B237707;
	Wed, 23 Jul 2025 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753240937; cv=none; b=uWFKKnOHXa9XEQpHEYaYaTJR8Zq49hWKu3mQmbyfgTV1BUAQvr/dwYNjv1bgu9OYKZCsflIFoEL+0L7zkezIJGiESOaOnds0km8BTUnHadWFP2NgOimWqp3Gw9cU98dKTZ1gofllYYlzfrANYMrg+RCEBLmc2A/HiBAkGVM84AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753240937; c=relaxed/simple;
	bh=8ZPHKXUZwTgMgbdOqdiAjxFLqFgYc72eV+fcpQmOQjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtuXLCKcaypVutBQ1/2DrEKLr77vXdUIu96zwivQkkEcx0NFORucYD6+spdmr7ta1lQ+jF6n4eJ2aA9lpI/7kCtlsSeks/hA7EKhnuT0C2I48vSfE4uRvI49PlUn81Jt4309hSXYPqUxoSqC3oYboqzmvMaoRO9G1FIi2wZWKMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcWUccFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4601AC4CEE7;
	Wed, 23 Jul 2025 03:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753240936;
	bh=8ZPHKXUZwTgMgbdOqdiAjxFLqFgYc72eV+fcpQmOQjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcWUccFFKwhwN5o9LlJ+G1kHFCy67rleOxU+LZz/Vfnl3N/AmqyW1p3gFIc3x183c
	 V39+XppTWYPuKrweZvUd2ujgP+Ev/inzNJgQIoxBxHqCjkmNGyTN1mwuoeRPITLpR2
	 +edePO/1/sEFcY7h7nPICDIHcKXN/AT3rGNxQDBdb8UaWxIqfoPZXpsDi098kVInjL
	 m3IkaSwgbbdaV7NwwSk1CjIGnyEEqd2JVbqUnaq5Vb3cUxFOUy/a0ahQtvuXgLqmFh
	 lMb/7ypEWJZasZAsVz09FfbZx8FAv7RYOiddKnl173ZjLfcMTmwi+nYSOtFMzZV7hF
	 zBV5O6JW2+WvA==
Date: Wed, 23 Jul 2025 03:22:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org
Cc: gregkh@linuxfoundation.org, chrome-platform@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec: Unregister notifier in
 cros_ec_unregister()
Message-ID: <aIBVZScy0T45rXol@google.com>
References: <20250722120513.234031-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722120513.234031-1-tzungbi@kernel.org>

On Tue, Jul 22, 2025 at 12:05:13PM +0000, Tzung-Bi Shih wrote:
> The blocking notifier is registered in cros_ec_register(); however, it
> isn't unregistered in cros_ec_unregister().
> 
> Fix it.

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()
      commit: e2374953461947eee49f69b3e3204ff080ef31b1

Thanks!

