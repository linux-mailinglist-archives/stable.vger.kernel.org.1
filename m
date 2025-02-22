Return-Path: <stable+bounces-118659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C09A4097D
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619B23B3602
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC91422D8;
	Sat, 22 Feb 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CVeJvsvu"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402118D620
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237737; cv=none; b=WdSx9VlMLLHG3of3WpysrkSTx/Emn7u/tcphqA4Svt+vQFW3nd1TK8ojS9CsjegkaQRFo36qP1u91Wf0Q8LzTu1U4SQqVbGWF1qJtUHl9jVS/5RWeSE65l9xYGH/hCTxkYpKALXL7boPjWX7/YiVKElk9qjiabRphlV/kSyZhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237737; c=relaxed/simple;
	bh=82JgoAufjsT7ZPVBgyuCx2yf7tiWH6vnRVIm2tSlrSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fo7Q58SywKks4GNFb6JOyM2zguSm/dNimpyG1Ig7Wb+eqsMI+J7Oz4Y2p9tQhR4vJHcgOFLJgBZ8PgnJJETELQFFoWaq7kOz5/+7C5GstiHgLTOtxHnxZ9+68Ha2NpIOupqszRzG/4aq2vhIZ8iY0CAi2AE3WPeb9GMc2suY1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CVeJvsvu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E663025CB8;
	Sat, 22 Feb 2025 16:22:11 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YyZrCv3U9clO; Sat, 22 Feb 2025 16:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740237727; bh=82JgoAufjsT7ZPVBgyuCx2yf7tiWH6vnRVIm2tSlrSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CVeJvsvuN1BdjWQAAr7YoZmRmaSvys42lBOZ8XYK71QcJ271rAkNHBKSTdk3WLlph
	 Nb8sSQi3bciv2vnnHWJnPyD3dVmSCMAiMfgNIfqaPnfEx0+4lcJIcz8uJYNvN/9zsd
	 khD5BHIsMnEzH5z4gCbsThM3r78//GFe0GOdcuw8JtNjz4D/9/GqBCxYVh8fN7Gsho
	 wZ9FOFR7MB3ng4xWMx0yruVM4Tmky6tkVAKVjdkHgzJJ1R72K+LwQQFKZTB0xvsCxa
	 YAbqZewv4MrlSF3roKeZlukyIY4AMP6/9wqTYBUDR6Azyty4P+9886/UdVBGJ4nZxp
	 uDrXo4V1AonVg==
Message-ID: <ea21c953-36b4-4cf2-8d29-0acfdd7acf4c@disroot.org>
Date: Sat, 22 Feb 2025 16:22:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Apply 3 commits for 6.13.y
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, j@jannau.net,
 neal@gompa.dev, jcalligeros99@gmail.com
References: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>
Content-Language: en-US
From: NoisyCoil <noisycoil@disroot.org>
In-Reply-To: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/02/25 16:12, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider applying the following commits for 6.13.y:
> 
>      27c7518e7f1c ("rust: finish using custom FFI integer types")
>      1bae8729e50a ("rust: map `long` to `isize` and `char` to `u8`")
>      9b98be76855f ("rust: cleanup unnecessary casts")
> 
> They should apply cleanly.
> 
> This backports the custom FFI integer types, which in turn solves a
> build failure under `CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y`.
> 
> I will have to send something similar to 6.12.y, but it requires more
> commits -- I may do the `alloc` backport first we discussed the other
> day.
> 
> Thanks!
> 
> Cheers,
> Miguel

Thanks a lot!

Cc'ing the Asahi devs so they are aware of this for related downstream 
issues.

