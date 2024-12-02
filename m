Return-Path: <stable+bounces-96159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F99E0C0D
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAFB6095F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021AA1DE3C4;
	Mon,  2 Dec 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNVETN1N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE01DACA7
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166967; cv=none; b=EXqIN7TBE8qgmCXdpgBWqmZKvhI5JNLgG586chqO5tlAhyd28uXVe7dKl0yXRUkCCisiV6U3B82Lzd7pkYhkjftu0HN8YghuEd7moecZ9FN64szRhKaV06PDKz4wi7SAduLtNGGpNVfnM0scWKelZapylI6jI10kVx3uU0+SdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166967; c=relaxed/simple;
	bh=hxnUm/j0nhk6tjiUgYpCJgKggKo1qSZ4bYT3GQ9rZKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcwqB2VT/Jl+7NekHh1LqEwP4LByBzdb1Hke5g8ot2xN/NQiKxQq5gOi/YN95THpT/dWVa8TdkfqnaFACt6WfFdaH9ZQnhQybO4YoRYgylv4KJq+iCk26L6+kSIjiq1u1w7FYW5zrnpyUvjEK1h6Q+N9tWJj/5UIcOXExC/Bv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNVETN1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30139C4CED1;
	Mon,  2 Dec 2024 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166967;
	bh=hxnUm/j0nhk6tjiUgYpCJgKggKo1qSZ4bYT3GQ9rZKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNVETN1Nj0WaTs9QR5MwOlYZQCFcWnWLeMOGfuPidQ+2pbZ4UFIW4+PcHbXoMUdW6
	 CbuQQDes0uHDkX+ODw+d3eBQimT9rIb4ExGQ+D0e3NcWN4UVXyck/56gBsbDbsdt/x
	 BXs6w5fGkIHGGR85YFYLqrSF31yR9cb+KbQxDYpI9Uvcu2wSgs9A8s/LesPoP1dwkC
	 tGodhY0tt+Ew62v3towRR90Wn2vQbWiE6/p0Vg4Nfy+ZBh21iA1gygyXwgecKQ7WNB
	 WLGo/gG609jBZMcbwsDp9GqHZ5e8p1ja6oYOmAtYEg9ASZEqrBFJ99GPqygeL01dPd
	 bfBCLaAVrIRKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v3 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon,  2 Dec 2024 14:16:05 -0500
Message-ID: <20241202124104-7afaadbc4cd7d174@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155713.3564460-2-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a ! 1:  15b5ce86bd18b dt-bindings: net: fec: add pps channel property
    @@ Commit message
         Acked-by: Conor Dooley <conor.dooley@microchip.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
     
    +    (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
    +
      ## Documentation/devicetree/bindings/net/fsl,fec.yaml ##
     @@ Documentation/devicetree/bindings/net/fsl,fec.yaml: properties:
          description:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

