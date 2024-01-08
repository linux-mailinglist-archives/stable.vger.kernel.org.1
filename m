Return-Path: <stable+bounces-10167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBA82732D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF311F23AC8
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8066A4C3DC;
	Mon,  8 Jan 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXcvlkNt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A651015
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 15:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F97C433C7;
	Mon,  8 Jan 2024 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704727848;
	bh=KE+WEEZC9VymQrOLjX9MUUNAOVLMHUKFAP37bGrHoKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gXcvlkNta5UioJaCeUGXI1tfL7F7eueO/0HdxCQPUgJ1XNw3FWYWBb7QtPlSA862t
	 D1irFBmDU22aAQTGF+qbswRSsFCeMTDBmOlLZfQwjTTxD6lC830NzquuzowIjiGMl5
	 6l/bRZap1X3gw7MK+CGOVN2y8xCCScLNUiWzLQgxd6FYWAEXeLjUtH83QoDuKZrv7U
	 1HJ7zp7rKotleYupfTiCY1E3VRHh1vEHes2D0PPc7W8oDGDxR6s+WIG3+RHv8Ang0+
	 RlY3eNp1G9FxDFU2C9Hbe7AorWo2LmAL2y8NTLB1iVEU/GokEq7B5xrq8Uhcd7clQy
	 601RlRgXKHZmw==
Message-ID: <cb5046e1-7184-4be8-8ce2-01b96be1533c@kernel.org>
Date: Mon, 8 Jan 2024 16:30:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.1.y] Revert "interconnect: qcom: sm8250: Enable
 sync_state"
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Amit Pundir <amit.pundir@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Stable <stable@vger.kernel.org>, Yongqin Liu <yongqin.liu@linaro.org>
References: <20240107155702.3395873-1-amit.pundir@linaro.org>
 <2024010850-latch-occupancy-e727@gregkh>
 <CAMi1Hd37L6NYKNpGOUnT7EO8kfc-HVQUqnoTTARA5gTpTc2wXQ@mail.gmail.com>
 <2024010845-widget-ether-ccd9@gregkh>
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <2024010845-widget-ether-ccd9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8.01.2024 16:19, Greg KH wrote:
> On Mon, Jan 08, 2024 at 08:33:00PM +0530, Amit Pundir wrote:
>> On Mon, 8 Jan 2024 at 19:42, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Sun, Jan 07, 2024 at 09:27:02PM +0530, Amit Pundir wrote:
>>>> This reverts commit 3637f6bdfe2ccd53c493836b6e43c9a73e4513b3 which is
>>>> commit bfc7db1cb94ad664546d70212699f8cc6c539e8c upstream.
>>>>
>>>> This resulted in boot regression on RB5 (sm8250), causing the device
>>>> to hard crash into USB crash dump mode everytime.
>>>>
>>>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>>>
>>> Any link to that report?  Is this also an issue in 6.7 and/or 6.6.y?
>>
>> Here is a fresh RB5 crash report running AOSP with upstream v6.1.71
>> https://lkft.validation.linaro.org/scheduler/job/7151629#L4239
>>
>> I do not see this crash on v6.7.
> 
> So does that mean we are instead missing something here for this tree?

Yes, however I'm not sure anybody is keen on tracking that down, as
(in short) for the platform to work correctly (.sync_state on
interconnect not crashing the thing into oblivion is one of the
signs), a lot of things need to be in place. And some developers
never validated that properly..

Removing .sync_state from the SoC interconnect driver translates
into "keep the power flowing on all data buses", which helps avoid
crashes that are mainly caused by unclocked accesses and alike.

Konrad

