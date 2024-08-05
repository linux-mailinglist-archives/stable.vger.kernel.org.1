Return-Path: <stable+bounces-65374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A50947A55
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88A41C21287
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4906F1547E0;
	Mon,  5 Aug 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaAo72g4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02411311AC;
	Mon,  5 Aug 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857048; cv=none; b=oZPiIYY0xPdpiQ1RB7/Fyb3i/z8/g57DIGlcz15jeixMTfM6JK8VK83bG9H+SFA1/xVLkJSCXwOS2Lt9+RvfaUiV8+fa8fs7umb/CfGW5SFJzhM2myAYXouVU9fHYKnAmiBtjVv8iTNYGC1w5TfMpy54BPc1wTze+wHvvz+Zqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857048; c=relaxed/simple;
	bh=p/frup+udAqQkQeYSiiiwNw37v9VGmao5sFjuiWT6Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVg3SrhKs1UomDE3Hco8UOXxqHnVf6ArfzS5VDk9ApiiwI3TNRHyvyOOLJJG2bSONRViZT1zziVF4lSOWukTS0THnbFb6Gue98Wz8mJPWXbsRtVgc5zXeTjmrdZvp2/5eheLDyL1O0rw3G+bcmaxvF1tS0ICjg47at9mGaBX2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaAo72g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC97C32782;
	Mon,  5 Aug 2024 11:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722857047;
	bh=p/frup+udAqQkQeYSiiiwNw37v9VGmao5sFjuiWT6Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uaAo72g40LW4FUQ/hk7n/W5ymwcEOz/JiKnPZo5wPBI5Snj5y7SxlRGVtFTzdYgjP
	 eRxen4pbtOiAdiarvDb791OY8mKeuTpkD/gXtvxzFW/rGEkYqBSHv90JLFpoHfPbri
	 wnc2tTr/m3q9kVY+3ua7YANpbhEKFcF9txJXfuNashjO+FiM0jl4WK742gz3/DsHtf
	 AIAqPXEgqlkIFiWR+q5lyRY3JnIRqweWpBQXeArq058pWPMYVv4YIMGebyUmeSlOoN
	 j5JHQiDzVNIsSrjrRx5TM2zgBC/3GsnpfIvAymm37LkLAWEgprZiIW5huMLvLjD1IZ
	 gI8291vR4iUyQ==
Date: Mon, 5 Aug 2024 07:24:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "ipv4: fix source address selection with route leak" has
 been added to the 5.15-stable tree
Message-ID: <ZrC2VY4GfDRv5T5i@sashalap>
References: <20240803145547.888173-1-sashal@kernel.org>
 <fa631c09-60e4-4fec-98ce-3f02fd412408@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa631c09-60e4-4fec-98ce-3f02fd412408@6wind.com>

On Mon, Aug 05, 2024 at 09:43:53AM +0200, Nicolas Dichtel wrote:
>Le 03/08/2024 à 16:55, Sasha Levin a écrit :
>> This is a note to let you know that I've just added the patch titled
>>
>>     ipv4: fix source address selection with route leak
>>
>> to the 5.15-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      ipv4-fix-source-address-selection-with-route-leak.patch
>> and it can be found in the queue-5.15 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>I'm not sure I fully understand the process, but Greg already sent a mail
>because this patch doesn't compile on the 5.15 stable branch.
>
>I sent a backport:
>https://lore.kernel.org/stable/20240802085305.2749750-1-nicolas.dichtel@6wind.com/

Appologies, I haven't seen your backport, but instead I've picked up
40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset
for port devices") as a dependency to address the build failure.

-- 
Thanks,
Sasha

