Return-Path: <stable+bounces-114079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD913A2A7D4
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 12:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD677A198A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90822C352;
	Thu,  6 Feb 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTmmk2vd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780122B8AA;
	Thu,  6 Feb 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842293; cv=none; b=a2zJs0khvK0icq4QxmhqILE0LLRInFAW4DbbA0SFg5MdW150aVl6QBl/73MJB++nkBiJPYPAEsk2ev88DXXR382NqSQgrkZYUpVHOsnuD8AAUYw6frAs1dGSO1kDJkodYuY4O3XPugDtQWu5xhQgmKIWtDcOzPzAL8Fd0s/CS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842293; c=relaxed/simple;
	bh=aSqDY7MeIR2ROD5SSWiAK85zqCXJFueO//oxV9XtzN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MPGF9n0qkeU5Zt9hDTM9j8D7LnmmpNNCYsFWtp7Fybf2NuD6hEMiQMmyeHnJ3VZ0fPX1qwG8bOuVW0v2x//kxhf3XxGC/GFfxHXIrNwfHR9sFuqOMLLQwyWCw12zd+MpAhAKTWZmpgwoRMdfzvSiI4S7z2b94s6+zRgk93Y8Zfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTmmk2vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07E1C4CEE5;
	Thu,  6 Feb 2025 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842293;
	bh=aSqDY7MeIR2ROD5SSWiAK85zqCXJFueO//oxV9XtzN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VTmmk2vdZS905mYuKSBj9YDXYj0ARaBzbhLbf5XfyntoxjTRktZB8TZ1LgrvLpicG
	 4DSfUhFvlQcSoeIHQXXjx8PDSZ6EgijJsZ9GGozB8Iu829US4dnl0WnMQfLgjWSdLJ
	 HcaEyeae46k9i4KbsQ/KiUw4rV9z2NXtI/DC5Jmo13bifblBmJtpW27hOJz9QEJQDg
	 eOKNsXTsAI/K/ONcENnZHZ9YXjQtIoIVGfKHuStrR1O3+IdiDGxHI3GTgt/O+CvSTV
	 dYyaBDGBHf9Pyv+nwenQ9ip5+C1dvIO+9GRvzPgz3V70HyO4PkNAtDxnUdJZ2bBE0I
	 LzCLRVkur1eVA==
From: Mark Brown <broonie@kernel.org>
To: mazziesaccount@gmail.com, Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: dakr@kernel.org, gregkh@linuxfoundation.org, 
 linux-kernel@vger.kernel.org, rafael@kernel.org, stable@vger.kernel.org
In-Reply-To: <20250205004343.14413-1-jiashengjiangcool@gmail.com>
References: <27dd749e-712f-46eb-9630-660a8f8f490d@gmail.com>
 <20250205004343.14413-1-jiashengjiangcool@gmail.com>
Subject: Re: [PATCH v3] regmap-irq: Add missing kfree()
Message-Id: <173884229138.34610.11577082077011641694.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 11:44:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Feb 2025 00:43:43 +0000, Jiasheng Jiang wrote:
> Add kfree() for "d->main_status_buf" to the error-handling path to prevent
> a memory leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Add missing kfree()
      commit: 32ffed055dcee17f6705f545b069e44a66067808

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


