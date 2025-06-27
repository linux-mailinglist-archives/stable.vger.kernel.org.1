Return-Path: <stable+bounces-158778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527DAEB761
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 14:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6F14A52E9
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD12DF3F1;
	Fri, 27 Jun 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAtxF+lW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329A2DF3EF;
	Fri, 27 Jun 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026273; cv=none; b=RiIbEoicKt/ffY0ypZrH0o+MWDRi990H617iA3e8/i/D1jKfenofdkoQiIx6QnpwscVjwHSgAnfkbC+jk5xBwxH7Kb20D6GwgTko1+eN//0IkJTBSOn7Ybqw9uEYW6OfhZrctOf3KizzCC4EjuY3TD9ywGgCIgTLcqrHiMoVXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026273; c=relaxed/simple;
	bh=l5hncX5Pei/wMm+XCQBZN29zErm9w2hlUXLVIsrd1M4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g6r5VGbnviRzb8vjf1Tk9HcGwyZvxdUzpsvvWQ3kTi7B6OR3Ojai0lRW4V2JVlOCo/QvxHUQ7n1O9ezcI8gqREP9OxmPZyCyPemYZW8rnrs1fDEUIciOOQ6X5NN0+hSCQIRPdzB4H3On8J4fS9gDLbu/BrCKzOrbSdOqFcwvH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAtxF+lW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1987C4CEE3;
	Fri, 27 Jun 2025 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751026273;
	bh=l5hncX5Pei/wMm+XCQBZN29zErm9w2hlUXLVIsrd1M4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pAtxF+lW+jv71YUEnMXcj/PP1ULjtyiOL/V1wZJYCLAU9tj9upcrG70ttuYL5qgDu
	 ZdVoLNFeXHMkUVc5x+Js3P6ToFTADiS1AIZ1MXr+HyBjKRZEAm1vaqk2uef7HnJw6+
	 en7YjhpaTghFiPwuU4FVRgvYDz8XcCpyDowx25SSkNAtv8FYBT9iSguFEYy32Ps1vX
	 /Y79rAV59LzVnQHrJqIjeH5CBChDP/iQV+G8IUpikCODJvwKw2ZD5zNkpTdIZcx76p
	 QIdqI2ieclKUR5Iven7n+W+TTBIikj7P2WiDZ/3FMovIoh7gvBBlslAsoIkDDayGJ+
	 spa9i1vf8mpug==
From: Srinivas Kandagatla <srini@kernel.org>
To: "Michael C. Pratt" <mcpratt@pm.me>
Cc: Christian Lamparter <chunkeey@gmail.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 linux-kernel@vger.kernel.org, INAGAKI Hiroshi <musashino.open@gmail.com>, 
 stable@vger.kernel.org
In-Reply-To: <20250527163123.9201-1-mcpratt@pm.me>
References: <20250527163123.9201-1-mcpratt@pm.me>
Subject: Re: [PATCH v1 RESEND stable tags] nvmem: layouts: u-boot-env:
 remove crc32 endianness conversion
Message-Id: <175102627149.7053.13424609554265671501.b4-ty@kernel.org>
Date: Fri, 27 Jun 2025 13:11:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 27 May 2025 16:32:11 +0000, Michael C. Pratt wrote:
> On 11 Oct 2022, it was reported that the crc32 verification
> of the u-boot environment failed only on big-endian systems
> for the u-boot-env nvmem layout driver with the following error.
> 
>   Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> 
> This problem has been present since the driver was introduced,
> and before it was made into a layout driver.
> 
> [...]

Applied, thanks!

[1/1] nvmem: layouts: u-boot-env: remove crc32 endianness conversion
      commit: 573afda830f301320d22ad4154e32414254f7449

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


