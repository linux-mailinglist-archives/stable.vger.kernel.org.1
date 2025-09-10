Return-Path: <stable+bounces-179190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7741B514B2
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 13:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684CD4E39AB
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29B270568;
	Wed, 10 Sep 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5kWhs7u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCD25FA29;
	Wed, 10 Sep 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502101; cv=none; b=Joavq/7F01k2PAeG7omGQ6jgYqkRXVZJ6YHOr4iGJiwgKNJLl1vitvRAriQbQldc+Pe+p/3Jnj6AekSu0MdyMLrxLsAbdkZGLOb86vQbzZWEwRHdlisLqwHniqBiAmXX5ShI/ha2l08l+HlCGXaQOCZ/zvTjWm0eIF8KzPGSZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502101; c=relaxed/simple;
	bh=qRp4pA5nON73sZoZuwHZjsYpT6fTz3KV68ATUmBpd0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxrhaaWwplIzaNAlfSmFn2tR1flYQ5gUPjr0wqTkjN9w5UEWUe/a2455XSYzT/tr1VVJqeZ46rn/CCN+NBwH37YmjiAB/7AxTGOgFxflS/lwL0h6FwN0L55YMR3t6C2tP9G12CNw07fK1GqfmoeH7rbpnxFzqj/jjYE3coYYG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5kWhs7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DD8C4CEF0;
	Wed, 10 Sep 2025 11:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757502101;
	bh=qRp4pA5nON73sZoZuwHZjsYpT6fTz3KV68ATUmBpd0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5kWhs7uRbjrhU3OblOuu5C+TfXSxcOCdkT2WiL7/QOf10JWmfTDYDvKqDID/E1yy
	 ObPvEzotdtt+kzCI07FWfjVc5bENBjAEYF47BTwcwUPdOLS51ONtOUPERTIQF5cJ4i
	 UOrJcm13TF+HKb1Cag/puKy+j3v1y5kkMIhdcmtAs4K/oo/vxkFp1ZCbMD9PGxrET3
	 AJCQ91v492I5Z7Rtf+AScc9wSZgq3j0j2JzxY/UDZ1ZIUFdYG3eizBf/onQXnF/iuU
	 lZveG9hX3odkpQV8Ky5yihZAhVkmeUjDAZF+nA1swi+rITQEHFFrGh2X6YmoiUUUR+
	 77W9FN90hx9Ew==
Date: Wed, 10 Sep 2025 07:01:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: Javier Martinez Canillas <javierm@redhat.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration
 when removing conflicting FBs"
Message-ID: <aMFak8Oj-UoCrgBH@laps>
References: <20250910095124.6213-3-bacs@librecast.net>
 <20250910095124.6213-5-bacs@librecast.net>
 <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>
 <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aMFYeV4UdD7NnrSC@karahi.gladserv.com>

On Wed, Sep 10, 2025 at 12:52:41PM +0200, Brett A C Sheffield wrote:
>On 2025-09-10 12:46, Javier Martinez Canillas wrote:
>> Brett A C Sheffield <bacs@librecast.net> writes:
>>
>> Hello Brett,
>>
>> > This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.
>> >
>> > Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
>> > removing conflicting FBs") was backported to 5.15.y LTS. This causes a
>> > regression where all virtual consoles stop responding during boot at:
>> >
>> > "Populating /dev with existing devices through uevents ..."
>> >
>> > Reverting the commit fixes the regression.
>> >
>> > Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
>> > ---
>>
>> In the other email you said:
>>
>> > Newer stable kernels with this
>> > patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.
>>
>> But are you proposing to revert the mentioned commit in mainline too
>> or just in the 5.15.y LTS tree ?
>
>Only the 5.15.y tree. Sorry - that could have been clearer.  There's no
>regression anywhere else. Mainline and other stable kernels are all ok.

Thanks for investigating this! I'll queue it up for 5.15.

-- 
Thanks,
Sasha

