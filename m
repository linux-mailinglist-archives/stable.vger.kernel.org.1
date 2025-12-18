Return-Path: <stable+bounces-203013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF9CCCA7A
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD7F3026AFD
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1838258E;
	Thu, 18 Dec 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO8qvjSj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90358382588;
	Thu, 18 Dec 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073993; cv=none; b=JPIyGW3r+Ak5ut4DalAYH81vPFmrVJGzgUjTht/hyxx6VkVYX6nJwZvRrV6smTKqQwqqIhgL7peJn7i//JWZ6N3zbUBXJqz5lN9fqxVETtPzqed7pfVn7l2eNFLn3NPENdccxqbQ7GB33p9fjh9KH2bde5m7ya8QLQzH0L2O7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073993; c=relaxed/simple;
	bh=3j2pXJo7FhgX3qJ5BcR7GaFeucTZyFzRz/m+Vr000vA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sdH2gcKtRBciWRM0t8NJTb6tvzQn3aLeI6NVMZ9xHSnHwgy/MmADDTmGQv4QuWXt7JyVeKYaG5m6uBZzMRVjUkg+B0aSXZx0xnTa3Uqwz3PlML3Xha6un2bKr1GYS/Ysrxi0qbNjsizcE0A7/fwFgyYUKFDqzhoXPOh4oaeJH/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO8qvjSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBFCC4CEFB;
	Thu, 18 Dec 2025 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073993;
	bh=3j2pXJo7FhgX3qJ5BcR7GaFeucTZyFzRz/m+Vr000vA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vO8qvjSjCnXDzzUA9kFNGQRYPg4btxW1tF3eJOdUJsi826dS0ynO/6DxvNpaqP0dW
	 +sRn68xvh7Sm5qvLD04ITM5gBTq8SaTlLYMWTPybauxA2Ip520jkmTZiq16+EiMKXp
	 Bmk18egc/MO1rqHaTvGH7MLhPmZv0DFrgI0Wxgap5kQ7DUbsvfs2XF42bGDP6PTy8i
	 xw8B3jbmIRm6VwmXWP+notJFha+D5kXs0gJbIUYZUzCEvkpNKhWYh6sdjFoCvsPUc2
	 oMTbdT7QyTIIo4jQxvAIiOEyg0+l6m4BnMKSTPNyc7KO5GezpG7E2/gyCiZx0ExnkO
	 aj6PaeC56TuvA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Laight <david.laight.linux@gmail.com>, 
 Huisong Li <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251216145007.44328-2-thorsten.blum@linux.dev>
References: <20251216145007.44328-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH v5] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
Message-Id: <176607399046.16637.3813737221857423754.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 17:06:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 16 Dec 2025 15:50:03 +0100, Thorsten Blum wrote:
> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
> bytes and a NUL terminator is appended. However, the 'size' argument
> does not account for this extra byte. The original code then allocated
> 'size' bytes and used strcpy() to copy 'buf', which always writes one
> byte past the allocated buffer since strcpy() copies until the NUL
> terminator at index 'size'.
> 
> [...]

Applied, thanks!

[1/1] w1: therm: Fix off-by-one buffer overflow in alarms_store
      https://git.kernel.org/krzk/linux-w1/c/761fcf46a1bd797bd32d23f3ea0141ffd437668a

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


