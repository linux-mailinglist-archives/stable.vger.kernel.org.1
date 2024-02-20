Return-Path: <stable+bounces-20873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51F85C4F0
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCA528651D
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4CE135A7F;
	Tue, 20 Feb 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwC0RuYv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869527459
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457808; cv=none; b=J9qFVIO0KQn2p3gg4PtY9H2da8wPoFWu95A3yAhDj01HnZZOwKCub2sV+azXkjjgky6PffKDfzQbh6IiwzuLLZN7Au+hi6txfaLPqJvEosJYYj20TYcHzfhzB8oD3FxvSoaTEC8Q2mljymue0IlDPpOhTR7w7gfmc72w7DyTU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457808; c=relaxed/simple;
	bh=WTRdxJFis5pr/voDuEX09ymslR0dbI8T8B2LTg4ldA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsrREJJXnPlENgSSGZBNVXsZ5KwsWxyPgBooNyY4hC9Wj02mmyrwcKa2KXt/H8VJSpSg8xNDrkPKViK5IXrB5VNLIPijwaejloi+918EQD7xb1QRuAq45iLVQqlQYRyGq+nq3cF/yZjzjN06peJkK6xum0fxfmtVvZT94gMcGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwC0RuYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C04C433C7;
	Tue, 20 Feb 2024 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708457807;
	bh=WTRdxJFis5pr/voDuEX09ymslR0dbI8T8B2LTg4ldA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwC0RuYvIlSipUZfCH+g3S1T6HNfBrdq7Q0zzQAvYvziWBVbQbe8k135GUfhGbmpU
	 OFulA16eW4lg53CuFb4eGTTC1n45j83GqQPi2RqweTaGHEgyEdfgLv3Bh8i4ZZfA6A
	 LlCY+DxCEQUWAfUA62Fhkv0i3uWxmPa6N7WbU6wI4vUW2bi1l8ttVpwlZAlDFYR6JE
	 Wrl281tCVNXA2e97ZA5dRqXUrc/hMsQg9VGDyECmn/Jr2opoC1ULQtauIkMvCYX6fJ
	 mVT7wN2TSAi9KqW6Hlet8HVVMF0KvpGylV6dulamVGmiz9ygnPt4NXvI79flYihtl9
	 z6q5wFlfUu4dQ==
Date: Tue, 20 Feb 2024 14:36:46 -0500
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <ZdT_Tmd6NF_NjIdl@sashalap>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>

On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
>On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
>> On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
>> > Hi stable team - please don't take patches for fs/bcachefs/ except from
>> > myself; I'll be doing backports and sending pull requests after stuff
>> > has been tested by my CI.
>> >
>> > Thanks, and let me know if there's any other workflow things I should
>> > know about
>>
>> Sure, we can ignore fs/bcachefs/ patches.
>
>I see that you even acked this.
>
>What the fuck?

Is this really how you communicate with other humans?


So what happened here is that my script apparently crashes on empty
"Fixes:" annotations (it can deal with invalid commits, various
combinations of sha1 and description, but apparently not with just
nothing at all).

And so I've fixed my scripts, so hopefully this shouldn't happen again,
but I'd ask for 2 things:

1. Next time you should mail me, could you try and be more civil?

2. Consider fixing your scripts
.https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
is pretty explicit as to how "Fixes:" tags are supposed to look like.


-- 
Thanks,
Sasha

