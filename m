Return-Path: <stable+bounces-110243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F3A19D74
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 05:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12499188E5DB
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 04:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720B6535DC;
	Thu, 23 Jan 2025 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvV/Lbey"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234C2F5E;
	Thu, 23 Jan 2025 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737604997; cv=none; b=fOZx+T4s7PbcsDI7CjMUuxQ+q6x4xXnGavjim0BzTMcKtAvyoSkpeT5ohzlETVsx3I3oivxkRXdwKeNJEA/gUJ+2MIRMpvNh+dG3lgUm74eHP0cBHey9+So+9ZjX4HrNSW4vmhIA41sawVAQ5AfrATVcz0VWZafJxNiTfElP3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737604997; c=relaxed/simple;
	bh=PUsf3mkBtw8lNYVBUMSTvVXQsT5rrcSBeQbRmwx/OFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ielBPe83C+/oLHWU8IPCoa4oYY7frs5+7CYplH6eynuWk7+C9KhbB2rR0YJqbMODmEiBSLDYvfqtQ3BsMuHNrF0dYGRJMbZ5JtMXiwkdptmp+nvVeZncsUxiML50GN6SFcNHWazx4Jdxv5jDVPRdQDWzShHaCACDzqzFFwolzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvV/Lbey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234C1C4CEDD;
	Thu, 23 Jan 2025 04:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737604994;
	bh=PUsf3mkBtw8lNYVBUMSTvVXQsT5rrcSBeQbRmwx/OFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DvV/Lbeye4NfPoIGdrT/5y3tHAsyjPkUKYw0TUU89Tan2TR53BSndwL6+YPOXaJMS
	 osx/rN9mYv5N4PPmPplGyFJi4/qWN8V87GxE4JEU7UIbYyy2JAxB/A3/vsW5PdqHjm
	 eGh+LXV4I2+V3E/PqTFYkCM9K34PaHvsqEdFrWjaliZ3IIItrLJjXrmAx7EE8l5zBL
	 tl6FZykE3ewjGbIlb7nzZ0q+PloqD6mFtB2ay4fi1qDJps3a0cIlUjeFxgrs7VulNR
	 H8MbaOyAY7OiKR4pRTci/IkWqupN0+w6JTG7tPPlqUGvnTdJdq/x+q5SbILzm7y6c0
	 BcBL5Av0uEpHw==
Date: Wed, 22 Jan 2025 20:03:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, John Stultz
 <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ptp: Ensure info->enable callback is always set
Message-ID: <20250122200313.4134a542@kernel.org>
In-Reply-To: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>
References: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 19:39:31 +0100 Thomas Wei=C3=9Fschuh wrote:
> Subject: [PATCH net] ptp: Ensure info->enable callback is always set

The CI says this didn't apply to net/main at the time of posting.
It applies now, since we forward the trees. Could you repost, please?
We don't have a way to re-ingest the patch once it fails on the first
try, unfortunately.
--=20
pw-bot: cr

