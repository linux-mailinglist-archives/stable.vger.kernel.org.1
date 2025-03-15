Return-Path: <stable+bounces-124497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFFDA62401
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 02:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F339A8806C3
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 01:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0CF170A13;
	Sat, 15 Mar 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIrG5u4f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799716DEB3;
	Sat, 15 Mar 2025 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002160; cv=none; b=UIJ3e5nE0xWQh8unX9K/ZXBO0HPh3uMfW2xu54OEBg4C/tw15UE8bp22gNVXJSp/V36o9ExLoJBpXHwlMZtsK4ZICL7xxdH2E9WuXf/xkHFb6xVM5aeCz+FFKUOgc1SaU4UoF2/FCSThkCUOO2l/gxlQAzBjlclEQySl7R9Y944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002160; c=relaxed/simple;
	bh=8a6cudezYN/0qR1pL7XJ08PJlQfplrgDXzVya/SnALQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4Rs5ruTH1pqXPVhnGtzIAGni2UZ6Rf/+7zAgzZvPNE+FIqJXQdzUk939YSN1b21Ox60BOM8Iw7/RNGHKvDDqrtaUtac405nDkJAFhBUg/JueuAr6yjQKy9gLSq8TEF4caq1ziFeTSsayAPQ369xpO61rlQBjyj/8ZVhDwbAleE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIrG5u4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD195C4CEE3;
	Sat, 15 Mar 2025 01:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742002160;
	bh=8a6cudezYN/0qR1pL7XJ08PJlQfplrgDXzVya/SnALQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIrG5u4ftpB176s1kEmxAORX/BkabYCDhX5MqOyQLYgBDE/NcSyWbDJusUpkEUH7O
	 aD4buzVX0OxT5jm7zTuEMiPKG9UaZGZpEy05zyjr5ytRHEOmFN3BtFsFP7WC7RMt+d
	 ku0zJ9gNCxwarMhceDv4A1oPw8PPQy2URSbv9nS6FRhQdgjOsRyc+swIuehKzyMluz
	 xDD+fPwPQo7xOeYy1n/OLPZWWh9BJSSGTcApvCVe/kDIHUHHO5qlO9joPc1+QcLaH+
	 SLNoMCKec75dCA+tIY+sLRp4OrjNuoPCR2hF6p5VIZPKLwLTHjFYPCOSIuZGvlFoyG
	 XEIqcriCcjEnA==
Date: Fri, 14 Mar 2025 21:29:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	anton.ivanov@cambridgegreys.com, mst@redhat.com, jiri@resnulli.us,
	tglx@linutronix.de, viro@zeniv.linux.org.uk,
	krzysztof.kozlowski@linaro.org, herve.codina@bootlin.com,
	linux-um@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.6 14/17] um: virt-pci: don't use kmalloc()
Message-ID: <Z9TX7vadBvxcrbf9@lappy>
References: <20250218202743.3593296-1-sashal@kernel.org>
 <20250218202743.3593296-14-sashal@kernel.org>
 <c993aa3a8e86e429d2135974929283a33d0f34ca.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c993aa3a8e86e429d2135974929283a33d0f34ca.camel@sipsolutions.net>

On Wed, Feb 19, 2025 at 08:42:01AM +0100, Johannes Berg wrote:
>On Tue, 2025-02-18 at 15:27 -0500, Sasha Levin wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> [ Upstream commit 5b166b782d327f4b66190cc43afd3be36f2b3b7a ]
>>
>> This code can be called deep in the IRQ handling, for
>> example, and then cannot normally use kmalloc(). Have
>> its own pre-allocated memory and use from there instead
>> so this doesn't occur. Only in the (very rare) case of
>> memcpy_toio() we'd still need to allocate memory.
>
>I don't believe this patch, "um: convert irq_lock to raw spinlock" and
>"um: virtio_uml: use raw spinlock", are relevant to anything older than
>6.12. I don't see how applying them would _hurt_, but I didn't have them
>before 6.12 and had no lockdep complaints about it; I believe some other
>internal IRQ rework caused the issues to pop up.
>
>Never mind that we (Intel WiFi stuff) are probably the only ones ever
>running this virtio_uml/virt-pci with lockdep :)

I'll drop it, thanks!

-- 
Thanks,
Sasha

