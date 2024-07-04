Return-Path: <stable+bounces-58052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B18927733
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E2CB2170A
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2231AC22F;
	Thu,  4 Jul 2024 13:32:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAD4C70
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099939; cv=none; b=gAhnpPM10uEtkRub0YnOo1QPiy9kP+4B7qtym3XYlNCinX1ce5PDjWUKUbj3yCNs2L2lrrCPVKIKgz4aFiWFcs4a5X0b4atywGEkeBTi2kKQww//Dz2pA8l0NZzWv4gexTUznMoNEWU6kXoHQeqk0P09SnsMpMCKvPJwOHVfvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099939; c=relaxed/simple;
	bh=0IefXHJNwXD4sgzRP0wgSarT4YNUjI+HCkwoXaqc8d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki1NPIORwxk3QQUv2B+4syeT0rncHgywl3GTGOpYaA36bsG+kmV6obt/uwnKtdMAOBDsWAoyNiGVYPnwMlI/ifyn11oo0yMKv3jP0s0vFMmhofEXBrCLWEK58pLbHXcOh1NtA62AF+I4dZHhPNySUorq9HJ+neBnPaqLwBB/8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 346062F20246; Thu,  4 Jul 2024 13:32:13 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.128.156] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 03CD22F20244;
	Thu,  4 Jul 2024 13:32:13 +0000 (UTC)
Message-ID: <6698afac-80c1-db37-ff97-7d11f7d4ef15@basealt.ru>
Date: Thu, 4 Jul 2024 16:32:12 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.6.y] ALSA: hda: i915: Allow override of gpu binding.
To: stable@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>
References: <20240704132757.120509-1-kovalev@altlinux.org>
Content-Language: en-US
From: kovalev@altlinux.org
In-Reply-To: <20240704132757.120509-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

04.07.2024 16:27, kovalev@altlinux.org wrote:
> From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> 
> commit 2e8c90386db48e425997ca644fa40876b2058b30 upstream.
> 

This patch does not fix anything, but it allows you to have a working 
sound with a normal initialization time on newer chips.
On machines whose video chips are not fully supported by the i915 
driver, running with KMS disabled, a binding error occurs for future 
hdmi codec settings:

snd_hda_intel: couldn't find with audio component

This leads either to a long delay in initializing the rest of the audio 
(codec 0), or to an error and a complete lack of sound.
There are no such problems with this patch if you add the "nomodeset" 
kernel parameter.

-- 
Thanks,
Vasiliy Kovalev

