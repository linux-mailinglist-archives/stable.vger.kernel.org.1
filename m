Return-Path: <stable+bounces-83622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED87999B9B2
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7472819DC
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90813D53F;
	Sun, 13 Oct 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z58M19WU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A85B231CA8
	for <stable@vger.kernel.org>; Sun, 13 Oct 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728829410; cv=none; b=fW2qLmzzUv2okNNZLXgJcFxDUPTT4PIh/G/APOkF4btUwgz3EggFvo/W/ElLraoZBNFtUYDHVP/4P6GsPnLEGq3U+ybm3V4Fb2Goi9iFzh+z0swarUaLRp0xYkOOU7d4ap9LQjZqGceX8zsOmbqUvzsqmVUywEu1Fs0f++CY7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728829410; c=relaxed/simple;
	bh=cL2Qyj9gV1gZ4gX65Ol6OfkqCpMbRMgaNM6R/fC4PyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxBmrjznBXNGlD+F4HES5a3xNc46YRF7CMGc1pYvXewQqdoW+XY9k44dcNaETZ1K7ofo0trKzuPJwXdDpBC4eR5vqo/OjPZ+UWM7VQkaUU8nkqgnwd/CPNfTykKKpR4O0Y8aragL8yZHBoQ4ESrR9VbVSIe7i9DsE83ZajCFp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z58M19WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B57C4CEC5;
	Sun, 13 Oct 2024 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728829409;
	bh=cL2Qyj9gV1gZ4gX65Ol6OfkqCpMbRMgaNM6R/fC4PyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z58M19WU5mkgrm2snTnQ3rbWgkX/85ZD8HCMQssfCocaJNMIgNtE6E/P2HTEdS3fS
	 H9Z3Cj1bPQudWVrgEdAcot2cWAkjHaiIwDmefLbjybqGPh313KlCXENzBOYGy7nGK6
	 GyEfbXdfFRAMZBnMW3GVk9xkvI7N5z5bmN00wNGUElS5maguyAogwxGNJgFxa0sqXM
	 Og4t+Uv8B+mHXrA85hXWUd8yUF3JD9XgSmi75aGCCxa8EIZHlicaY1ZvF8VUBwT6PP
	 k6I7bQf6qKkjJQgF18fz9ZLmD7A1Yksa/8+PWP4fx1nb15BFrcO7A8w63d+r+vyqak
	 b2EaB06b68ijA==
Date: Sun, 13 Oct 2024 10:23:26 -0400
From: Sasha Levin <sashal@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org, boqun.feng@gmail.com, bvanassche@acm.org,
	gregkh@linuxfoundation.org, longman@redhat.com, paulmck@kernel.org,
	xuewen.yan@unisoc.com, zhiguo.niu@unisoc.com,
	kernel-team@android.com, penguin-kernel@i-love.sakura.ne.jp,
	peterz@infradead.org
Subject: Re: [PATCH 5.4.y 0/4] lockdep: deadlock fix and dependencies
Message-ID: <ZwvX3kxg6OoarzW9@sashalap>
References: <20241012232244.2768048-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241012232244.2768048-1-cmllamas@google.com>

On Sat, Oct 12, 2024 at 11:22:40PM +0000, Carlos Llamas wrote:
>This patchset adds the dependencies to apply commit a6f88ac32c6e
>("lockdep: fix deadlock issue between lockdep and rcu") to the
>5.4-stable tree. See the "FAILED" report at [1].
>
>Note the dependencies actually fix a UAF and a bad recursion pattern.
>Thus it makes sense to also backport them.

Hm, it does not seem to apply on 5.4 for me. Could you please take a
look?

-- 
Thanks,
Sasha

