Return-Path: <stable+bounces-179262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA1B53325
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D106A7B2DC7
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC5324B2A;
	Thu, 11 Sep 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/RqLoLg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97521320CC7;
	Thu, 11 Sep 2025 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595842; cv=none; b=f0t/WKTkqYjoffyOIbKwaNG6dJ4dY4gCEtvlaGfiu2fgB1SNB9WCNQr9NAICqLEKlVxXtw+iVPq8dOrEzJzEjBQbxwWMcMXNvgpJjgDVprGawg4/nwBLprJWBdMhwMSGPO3L7iyuidOz0Zz+1RQGnRo4YclRa1VLRuJd9ZnUuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595842; c=relaxed/simple;
	bh=GwqAHVRPsszIE7g35d/vmUuyVRMTwBHaHgAjeOkpHK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TbVLX6ksC/eIzF/9ldXsgkf3KA2YCh3uiDjTmEU/0kx3IzbTpCQsdOBj4KloT5JX9OLL7VkqvCjs/nw19/oZYGuKxSitG3BJzdPq2W8y8zJiYowf6sfw0yll0UFqUzK1c5gDDEay98GZjKugmTS5mASyvLY7ovi0rwVwhoVbv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/RqLoLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D88C4CEF0;
	Thu, 11 Sep 2025 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595842;
	bh=GwqAHVRPsszIE7g35d/vmUuyVRMTwBHaHgAjeOkpHK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b/RqLoLgtL3sgmIEZ1Vld4VoMBD9bicGqKbkFUhP4M/7ZzlxS2U+K3cS+udDxmCLQ
	 RJ6bzdG4i5o0cQp/b0Vbv44OXcEhW87PiaCKxPen2uxh2Vr5cYcirgUl5n9j0HuaKR
	 A/9iTmMryZRKPBUD++2wtt4LeTRYshF3/tmZNVRybSROgOK9mDg/WTgLVAAOc4JHnV
	 o8ah2TicKR/FyOaZ3W0lC+PJO0fYXIEKMcaSUSldVZeGsk/AMoLfy08PaMg8Vzdnrw
	 ew5Si9T1xsPX6M6IgdaEs6RkYbKTe66jt9HAD82onoPrRKtHL6U+NKSAXl/i7PBxoU
	 2Fb5jROE0frIg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,  Santhosh Kumar K
 <s-k6@ti.com>,  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org,  Daniel Golle
 <daniel@makrotopia.org>
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
In-Reply-To: <a208824c-acf6-4a48-8fde-f9926a6e4db5@gmail.com>
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
	<175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
	<454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com> <87348tbeqg.fsf@bootlin.com>
	<a208824c-acf6-4a48-8fde-f9926a6e4db5@gmail.com>
Date: Thu, 11 Sep 2025 15:03:58 +0200
Message-ID: <mafs0v7lpi1j5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11 2025, Gabor Juhos wrote:

> Hi Miquel, Santhosh,
>
> 2025. 09. 11. 10:00 keltez=C3=A9ssel, Miquel Raynal =C3=ADrta:
>> Hello,
>>=20
>> On 11/09/2025 at 11:52:27 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>>=20
>>> Hello,
>>>
>>> On 05/09/25 20:25, Miquel Raynal wrote:
>>>> On Mon, 01 Sep 2025 16:24:35 +0200, Gabor Juhos wrote:
>>>>> Using an OOB offset past end of the available OOB data is invalid,
>>>>> irregardless of whether the 'ooblen' is set in the ops or not. Move
>>>>> the relevant check out from the if statement to always verify that.
>>>>>
>>>>> The 'oobtest' module executes four tests to verify how reading/writing
>>>>> OOB data past end of the devices is handled. It expects errors in case
>>>>> of these tests, but this expectation fails in the last two tests on
>>>>> MTD devices, which have no OOB bytes available.
>>>>>
>>>>> [...]
>>>> Applied to mtd/next, thanks!
>>>> [1/1] mtd: core: always verify OOB offset in mtd_check_oob_ops()
>>>>        commit: bf7d0543b2602be5cb450d8ec5a8710787806f88
>>>
>>> I'm seeing a failure in SPI NOR flashes due to this patch:
>>> (Tested on AM62x SK with S28HS512T OSPI NOR flash)
>
> Sorry for the inconvenience.
>
>> Gabor, can you check what happens with mtdblock?

My guess from a quick look at the code is that NOR devices have
mtd->oobsize =3D=3D 0 and mtd_read() sets ops->ooboffs and ops->ooblen to 0.
So now that this check is not guarded by if (ops->ooblen), it gets
triggered for NOR devices on the mtd_read() path and essentially turns
into an if (0 >=3D 0), returning -EINVAL.

Maybe a better check is if ((ops->ooboffs + ops->ooblen) > mtd_oobavail())?

Note that the equality is not an error in this case. I haven't worked
with the OOB code much so I am not sure if this condition makes sense,
but seems to do so at first glance at least.

[...]

--=20
Regards,
Pratyush Yadav

