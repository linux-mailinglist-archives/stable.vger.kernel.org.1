Return-Path: <stable+bounces-206327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D51D03F4C
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25ED5301B88C
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684147B825;
	Thu,  8 Jan 2026 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaCf0T4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119747B82F;
	Thu,  8 Jan 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873571; cv=none; b=iVuqt4d3XzA5iif7Xp5NgcJTsTKg/H3D1Z1FFRxLfeWPixNQpjJV6nQRjtwXjxvVxaPFS2unAkK63sT/GedkNhUZ2jW3hBgoVJ4NDGvbyY7Z0kAPQmMaPfAIUo4+oiMSdBRzod0U5DqoP1CV05Ui8s8LD4HF40F5M4Ys7O0aLvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873571; c=relaxed/simple;
	bh=xIDPGYD6gphF/HnVbmjZOkj1zq9sW0JrYS8EORe8w30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=exLkidURxktQoEWPMDTjKUWqmO494cHcpdy+sXODHujzwqeXfvIGRdsMinV24GBaXpSYvH7f5FiBlPUSjLLLKCe6Xkr7DiG3Wy21j7L4XqD2S77PZNlfmhbhwqS8htIU4qXQBY2d/Gt0d72p4DFAQld8buaMECddcJ9q7LCxBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaCf0T4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589ACC116C6;
	Thu,  8 Jan 2026 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767873570;
	bh=xIDPGYD6gphF/HnVbmjZOkj1zq9sW0JrYS8EORe8w30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kaCf0T4bo0brYGQhBd75snVUGHFjsEjOzYChBPMAu+hPDiAcQreyWZ2TGIgEVUqh0
	 W+0j20V5lmC7pc+HajkJ9i/+U+maigp/BgudjNkyvf1IyyxYWeURD+9sE+2jtQZN9Y
	 L4kDiteS4kP3jwjm//NyDbeVomRmENQB64tb/rJNtfvF8in9RMtVgpszLGakWgQdlb
	 rZPYgbMOlQ/QN2rNAxA9dbY5I3eOZl61+DJTPyrpa4in+rbPXQCfUP+PODKHZXu8ki
	 I2BjwhayyJOoszpOya8Ikmkagsvz7V+xa3+0/+WcyMMyPTwhruoj1tqjfxO7ZK1znU
	 hg4MK2jZEmcxQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Douglas Anderson <dianders@chromium.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210113002.1.I6ceaca2cfb7eb25737012b166671f516696be4fd@changeid>
References: <20251210113002.1.I6ceaca2cfb7eb25737012b166671f516696be4fd@changeid>
Subject: Re: (subset) [PATCH] mfd: core: Add locking around
 `mfd_of_node_list`
Message-Id: <176787356909.903532.13506820629482222413.b4-ty@kernel.org>
Date: Thu, 08 Jan 2026 11:59:29 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Wed, 10 Dec 2025 11:30:03 -0800, Douglas Anderson wrote:
> Manipulating a list in the kernel isn't safe without some sort of
> mutual exclusion. Add a mutex any time we access / modify
> `mfd_of_node_list` to prevent possible crashes.
> 
> 

Applied, thanks!

[1/1] mfd: core: Add locking around `mfd_of_node_list`
      commit: b7c72be160385730cfcc3991178ba7867fe0b018

--
Lee Jones [李琼斯]


