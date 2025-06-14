Return-Path: <stable+bounces-152642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4022AD9D36
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3488E16A55D
	for <lists+stable@lfdr.de>; Sat, 14 Jun 2025 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC82D8DC5;
	Sat, 14 Jun 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI6mYWNe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8121E00A0
	for <stable@vger.kernel.org>; Sat, 14 Jun 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749909235; cv=none; b=ihz8ZwRdVrJH448rqkLHOkgTdMLZdX1IzzN5PUzuraZHmV4qd0OJAbrvtvo4JXCZvVEQkwK5af1es8JC9qWd9QyiLoCLgkAFxugGs7uvNu0UTsW0B9FEAPeVyJ1uptz5v46KyKkj8Q3IPBx5EuYqkhEskGf4a9WHWvcLItpjJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749909235; c=relaxed/simple;
	bh=nr8GZGxUolrGm4VQBSQYgdqufGepjs6X1fxqWJzUtWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehRgNIAq2XNmmVolnrrTRb9f7f+Rhh7tUUkmO0oYJC6bNX6zTJnYouBHZVKH42AQCN77bILxEwOwlXB8fL18Jk1Ed5+eUDJkOq2eoZ+IwWHdK/CuCAIf0EEVgps0mezco8MkJZeF584FvlUtqnjihsbeX7K5Ma6ZhDGQZx/Asos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI6mYWNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E727DC4CEEB;
	Sat, 14 Jun 2025 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749909235;
	bh=nr8GZGxUolrGm4VQBSQYgdqufGepjs6X1fxqWJzUtWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cI6mYWNec7F1o6kWPJQiOZ9fz0ZNdaUQhQ7EZcMBtslV/vmZCj1SZKp627kVokkeZ
	 bTnVPJjAAgce4SPp7Yv5Sf/c5aFtprO386UJLhlv+FUtWfj4IfdPXosswk9u+2Q8TJ
	 v4RNumV4Xm+mnG7fGIRThCeBsOLzKDmQAWQ7jQWf0/gIWvjr41vj1Nejoq49yB2l8z
	 WvCvJy4bQzolMW4xVxT1Gb5RnjAlXW9Q119UdpJkVDMTmY7yJAtnKLYPeG6QykYtlb
	 s0S9e2l81gCcrDRp7aP0bOA4lp81jAIv9myojGqiwzfqv3ZvLaR3e/7nusWbOtB/e6
	 TzJnIYH5qaChA==
Date: Sat, 14 Jun 2025 09:53:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-stable <stable@vger.kernel.org>
Subject: Re: Backport sh-sci fixes to 6.12.y
Message-ID: <aE1-8fVyamtJdQLt@lappy>
References: <6aa4a135-eb89-49e0-b450-7fa30d7684ee@tuxon.dev>
 <aEsqctMnzUfinUga@lappy>
 <43227f48-9d0f-4798-92d9-a1ccc497d37a@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43227f48-9d0f-4798-92d9-a1ccc497d37a@tuxon.dev>

On Fri, Jun 13, 2025 at 07:58:35AM +0300, Claudiu Beznea wrote:
>Hi, Sasha,
>
>On 12.06.2025 22:28, Sasha Levin wrote:
>> On Wed, Jun 11, 2025 at 08:23:54AM +0300, Claudiu Beznea wrote:
>>> Hi, stable team,
>>>
>>> Please backport the following commits to 6.12.y:
>>>
>>> 1/ 239f11209e5f ("serial: sh-sci: Move runtime PM enable to
>>>   sci_probe_single()")
>>> 2/ 5f1017069933 ("serial: sh-sci: Clean sci_ports[0] after at earlycon
>>>   exit")
>>> 3/ 651dee03696e ("serial: sh-sci: Increment the runtime usage counter for
>>>   the earlycon device")
>>>
>>> These applies cleanly on top of 6.12.y (if applied in the order provided
>>> above) and fix the debug console on Renesas devices.
>>
>> Could you please take another look at this? The first commit applies,
>> the second one is already in tree, and the third one conflicts.
>>
>
>I double checked it and applies clean on top of v6.12.33:
>
>039164b1a5e4 (HEAD) serial: sh-sci: Increment the runtime usage counter for
>the earlycon device
>6a0ed6d47c02 serial: sh-sci: Clean sci_ports[0] after at earlycon exit
>a25aa21fb6c3 serial: sh-sci: Move runtime PM enable to sci_probe_single()
>e03ced99c437 (tag: v6.12.33, linux-stable/linux-6.12.y) Linux 6.12.33
>80fe1ebc1fbc Revert "drm/amd/display: more liberal vmin/vmax update for
>freesync"
>d452b168da17 dt-bindings: phy: imx8mq-usb: fix
>fsl,phy-tx-vboost-level-microvolt property
>1ed84b17fa9b dt-bindings: usb: cypress,hx3: Add support for all variants
>
>Would there be a chance that you have searched the second commit in 6.12.y
>by its title? There was another approach for commit 2 which was integrated
>then reverted. The title was the same. Grepping on the current 6.12.y gives
>this output:
>
>> git log --oneline --grep="serial: sh-sci: Clean sci_ports\[0\] after at
>earlycon exit"
>fa0e202e23ff Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
>0ff91b3bf53e serial: sh-sci: Clean sci_ports[0] after at earlycon exit
>
>However, the content of the reverted patch and patch 2 is different.
>
>If commit 2 is not applied then commit 3 fails to apply.
>
>Could you please let me know?

You're right! The scripts got confused by the identical subject line
that was already in tree.

I've queued up the backports you've sent out, thanks!

-- 
Thanks,
Sasha

