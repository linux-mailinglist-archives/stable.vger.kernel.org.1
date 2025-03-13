Return-Path: <stable+bounces-124308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C20A5F4DB
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7113AC870
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052E22673B3;
	Thu, 13 Mar 2025 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6itznTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F442052;
	Thu, 13 Mar 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870117; cv=none; b=YS/5UWkwUi2Kw0Fg1Vd7dmUITzn0kX1cGmDsrxYY1Vww7jGhNqDWaLMpsoW8XV0Xv29lNy7RI9fkXeY+elOmU0lX6h3usfth+EdcKZyf2rtOmfxu/x/sKkU/1V2BP7ouyYiG7cstigMiRqFX9k+cluQ54lk8bpEgm6UBRlvKC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870117; c=relaxed/simple;
	bh=UNE+vU3R9oLbhE4BG8lFJqiNkX+7iAaAVQvqiE7RCwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYerXc/XQGILRbWOh3nZe//S6ss78Dd57XI5s4bxkvhEqwT5SMqVCW+adNFCAecYDA22yOdSFDWSiyhQUcdq0LPYWdT+Lm9sWQIcPIPQ7sEkxeUh5SgnVMMnPmhM2qLLmVHxl5SHbsPq5SeVUHMILMtG+dJTaFvSfnSxGDVo9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6itznTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8348EC4CEE5;
	Thu, 13 Mar 2025 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741870117;
	bh=UNE+vU3R9oLbhE4BG8lFJqiNkX+7iAaAVQvqiE7RCwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6itznTcpLqcC5Z2YYE9Yl6RW89lSt0Be8C91ZCIZwZZlIQDdXcBy/Zu/AbJ4vvfH
	 a1XFMWBa0Y4PMuBxPaguS+vuz2BUjLMw6hMakVk6wdzywSKnR1ryrUWs5OeFIuGwvr
	 t8pwikkak4CYIAzx06MEhi2xyrjXBGYVjSZ0hFMBEWqo9UqZ2BRQi95xIqBZDjIMzU
	 NWwfKSGaTFW5p0xHQQo1GizC6V7K3OMgwQVgdTMipNEPoJZfYHBhGqCQFeAY/WtyEA
	 tslADMiBEKaKU7F/5zpQCHQmkiJc7uDJL1esr0kWAlBCXGqHob0Zz9ZezF0RAJ/0ha
	 cgScLLSFoFW7A==
Date: Thu, 13 Mar 2025 13:48:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jian-Hong Pan <jhp@endlessos.org>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-ide@vger.kernel.org,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <Z9LUH2IkwoMElSDg@ryzen>
References: <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen>
 <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
 <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen>
 <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen>
 <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>

Hello Hans,

On Thu, Mar 13, 2025 at 11:04:13AM +0100, Hans de Goede wrote:
> 
> I do agree with you that it is a question if this is another bad
> interaction with Samsung SATA SSDs, or if it is a general ATI SATA
> controller problem, but see below.

(snip)

> Right in the mean time Eric has reported back that the above patch fixes
> this. Thank you for testing this Eric,
> 
> One reason why ATA_QUIRK_NO_NCQ_ON_ATI was introduced is because
> disabling NCQ has severe performance impacts for SSDs, so we did not want
> to do this for all ATI controllers; or for all Samsung drives. Given that
> until the recent LPM default change we did not use DIPM on ATI chipsets
> the above fix IMHO is a good fix, which even keeps the rest of the LPM
> power-savings.

One slightly interesting thing was that neither the Maxtor or the Samsung
drive reported support for Host-Initiated Power Management (HIPM).

Both drives supported Device-Initiated Power Management (DIPM), and we
could see that DIPM was enabled on both drives.

We already know that LPM works on the Samsung drive with an Intel AHCI
controller. (But since the device does not report support for HIPM, even
on Intel, only DIPM will be used/enabled.)


> 
> Right I think it is safe to assume that this is not a Samsung drive problem
> it is an ATI controller problem. The only question is if this only impacts
> ATI <-> Samsung SSD combinations or if it is a general issue with ATI
> controllers. But given the combination of DIPM not having been enabled
> on these controllers by default anyways, combined with the age of these
> motherboards (*) I believe that the above patch is a good compromise to
> fix the regression without needing to wait for more data.
> 
> Regards,
> 
> Hans
> 
> *) And there thus being less users making getting more data hard. And
> alo meaning not having DIPM will impact only the relatively few remaining
> users

I'm still not 100% sure with the best way forward.

The ATI SATA controller reports that it supports ALPM (i.e. also HIPM).
It also reports support for slumber and partial, which means that it must
support both host initiated and device initiated requests to these states.
(See AHCI spec 3.1.1 - Offset 00h: CAP – HBA Capabilities,
CAP.PSC and CAP.SSC fields.)

Considering that DIPM seems to work fine on the Maxtor drive, I guess your
initial suggestion of a Samsung only quirk which only disables LPM on ATI
is the best way?

It seems that ATI and Samsung must have interpreted some spec differently
from each other, otherwise, I don't understand why this combination
specificially seems to be so extremely bad, ATI + anything other than
Samsung, or Samsung + anything other than ATI seems to work.


Kind regards,
Niklas

