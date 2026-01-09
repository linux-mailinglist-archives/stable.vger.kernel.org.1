Return-Path: <stable+bounces-207894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264BD0BAC8
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 18:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A776830245FD
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CAA366DB6;
	Fri,  9 Jan 2026 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3Ryp5NZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80A2DC78D;
	Fri,  9 Jan 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979858; cv=none; b=YzJZ2LgO6HcSMMQZG20NflZ+7bqtaW5B7oguXBqNmt5zdHKXfri0Lhq0PQqp041XHL8rWaC5YuPNHR1BqbJXGHU4cG35/xx/lnFdW8+MQSncinyCBjdKUyGZTsyPBKLWyyIIh95Vv01ybj76BIX9QgYuRY03VGK4+bXkasJydPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979858; c=relaxed/simple;
	bh=qQo5tb5Ob84TKJjFuoYTgcpwOh1utsUrqKQbFrFKeio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kC+QeWmZvBzUucmH1qFVY9tPxqJKxYgGQrrjWGZpeOeH0tc/Hz0Kcm/3VRmB3dk1DFc2qDIOUwCBYlKm8Q6RkAGlYbsM5fNc1iVfBDMu8t+EEGYa2jUzMNOXDp7LVeLJydpQAWk+4wTy/WZNKIKhVdEomgqXsKf/sqS31lxHngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3Ryp5NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACA4C4CEF1;
	Fri,  9 Jan 2026 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767979858;
	bh=qQo5tb5Ob84TKJjFuoYTgcpwOh1utsUrqKQbFrFKeio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I3Ryp5NZ5NwQc0jHHpARcB+lImRXw9lebxUEmNyxuLRAokyuias/XXuzcztLz6nL5
	 qPBGfCxYP1UtwXjLxC/A2WowzGUaTVN23Udn3QeRnMJc9jkc0bAkGlw9to5sHajDH4
	 QT50CqGg8I3hvp/c6lo+TDvmTU1vLFVRWrED5PdxuS8oTbVnA53PrexDY0nWEHFmJy
	 EreNyPAa2BMoCAr7tCPq/sJzw0qeaQPTr3mJ+ZJM31WwnzyeF0L5wCCLUlvwqclEU9
	 JTSCNtG6xUX3kTv6HqFAhwDoSCFE7PNxsfzWWSNd7zOtxANEhQWP4k6cihifHNUyfb
	 aDBYANS6RI3yw==
From: Lee Jones <lee@kernel.org>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251231-macsmc-mutex_init-v2-1-5818c9dc9b29@jannau.net>
References: <20251231-macsmc-mutex_init-v2-1-5818c9dc9b29@jannau.net>
Subject: Re: (subset) [PATCH v2] mfd: macsmc: Initialize mutex
Message-Id: <176797985608.1888600.13705658897282916904.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 17:30:56 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Wed, 31 Dec 2025 10:42:12 +0100, Janne Grunau wrote:
> Initialize struct apple_smc's mutex in apple_smc_probe(). Using the
> mutex uninitialized surprisingly resulted only in occasional NULL
> pointer dereferences in apple_smc_read() calls from the probe()
> functions of sub devices.
> 
> 

Applied, thanks!

[1/1] mfd: macsmc: Initialize mutex
      commit: 9f7cd8015f588755ada102d400c58ed1ca28a63d

--
Lee Jones [李琼斯]


