Return-Path: <stable+bounces-132176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B044A84A51
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 815087A5367
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13321EC00C;
	Thu, 10 Apr 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDwZUTLw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625171A5B9B
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303410; cv=none; b=hznePkjWhKKa3h2Y88D4fI+8Q0pkWYMV+UCCE3JfdBWHAldeRJ9Atk3in7yXoA1aeYi9G1aRZoyMHp/YX2WH+U7nMSvZ/fAPdKatsz7RT1V6/Sx5a7IxThQszvC50tpqSa6scYFgwW5lXyUjufjWjehacUuCU5GzcRq/Tfc61RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303410; c=relaxed/simple;
	bh=MfAYaRtWEzj38fEvee+fPX8hQn6zOJcFKRMPRirVqcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVHrwJLw+gzydSoxQVyxu3KgJ1X5PEx+LAKjUobvH0/D80/ftxLvBEFY7UnhemhBL+Y62gVC5ooEQC9UxRmbZ1Z1yZ09e0TIuwf6cH0cbtjq2aIKnnInszDzhVKPDxKVChwvUra2buzTSp7mWNZNSe7WZ2H9MLh7gIYZwQbhJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDwZUTLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFA6C4CEDD;
	Thu, 10 Apr 2025 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744303410;
	bh=MfAYaRtWEzj38fEvee+fPX8hQn6zOJcFKRMPRirVqcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDwZUTLw8S16R/jFWH9N3PmeLengoTHUC3Q8XvAX9odPAcQbHsvfgvIBdnippZUia
	 OTd9ypPSmcg7xzQcePKVG+UalyblSzQs1bWOyQ56cqidZjO5II/eeVmcxp+0FcMTX4
	 pLLgurz8CD48Slmli8zZh7VNHI1EQ2oiYoEmii9vEwqre2VhrMcaekj6kqWZgR99+d
	 n/5HNZz9znIKBGwhGZ1JrpEFlUy6xIf7HBs6ewZiI/aJfIoFsUOmN8Q/uHNYfzy0TR
	 av/KmKNuLob0k0e4NU/F5aXoS+BEQE2XZR74xTIx5zYNj0PCXGOFw6FNzwRdUWYQmj
	 g3/M12nb3dajw==
Date: Thu, 10 Apr 2025 12:43:28 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 v3 02/11] KVM: arm64: Always start with clearing SVE
 flag on load
Message-ID: <Z_f1MGoJ6T4m77wY@lappy>
References: <20250408-stable-sve-5-15-v3-2-ca9a6b850f55@kernel.org>
 <20250410112437-6c51badd1fa7bb35@stable.kernel.org>
 <05817c61-13dd-42d4-86f8-4cf76ba1df4b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05817c61-13dd-42d4-86f8-4cf76ba1df4b@sirena.org.uk>

On Thu, Apr 10, 2025 at 05:11:06PM +0100, Mark Brown wrote:
>On Thu, Apr 10, 2025 at 11:53:32AM -0400, Sasha Levin wrote:
>
>> Summary of potential issues:
>> ℹ️ This is part 02/11 of a series
>> ❌ Build failures detected
>
>> Build Errors:
>> Build error:
>>     Segmentation fault
>>     make: *** [Makefile:1231: vmlinux] Error 139
>>     make: Target '__all' not remade because of errors.
>
>This looks like some sort of infrastructure issue with the linker
>crashing?  What configuration was this trying to build and with what
>toolchain?  My own per-patch build tests were successful.

You're right - sorry about that.

The cooling setup on my build server started to fail, which caused
sporadic failures during heavy load.

-- 
Thanks,
Sasha

