Return-Path: <stable+bounces-132367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD2BA874F9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 02:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9457A24A3
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 00:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997F33FC2;
	Mon, 14 Apr 2025 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwyGRfIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7464D;
	Mon, 14 Apr 2025 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744589572; cv=none; b=KFItb10f+RFYVLD5neVRdskoe4xfXRaDbqJ+VX6ZQF+GOInuOaHJkiisoKsSmIKBuXE7vuZcL+e7jpnpcDFnER5lGYWE5J2S3qlV6083awpl4qt3vgLPRvdbxSq425sHcisDElvxt31w1j7dct65E78i4Wx/2m/GUTXXBv47Vlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744589572; c=relaxed/simple;
	bh=GfefQWRQXZCqdBsIuEMO+B77FeTgP8Ps2lR3cG/ocZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7toa53ApktxGxjW1lmQmrarKZ5TpjTVO3yJNzgwh14/Db5mT6J+L/CSVey96w4FrTAQP+bZE673fBXrdvpxuZ2+GBxWFJpbJr8NP71yivx0/LUeMU0arAljMWZaGIZjrcf+qJWv0a9DEun4IXQrzbqAOlE1lgiIkRc3frqTZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwyGRfIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10A1C4CEDD;
	Mon, 14 Apr 2025 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744589572;
	bh=GfefQWRQXZCqdBsIuEMO+B77FeTgP8Ps2lR3cG/ocZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwyGRfIpXOxKekX1rl9duX6KPjggAn9Hc2lGtsttAMjWo3sTw8sapqDT/ACGWKytd
	 JBs6B6+JnYfoI9QAcZ8VsVj+TaafIQC3b2LO6/Cf6tcXSoz4ZyeBYQbammQN1zwC82
	 1u5VfCVQFdrEaznKSr9YMvSlwxxQtj3BNp3K2nAswU6u1XHqdjXG73KsKcqn0yfa+j
	 neFU0u4cQRDK35nv9mFwcx/GXIi1OmTMlno/OYqd/wxBXFOpUnH7coeWUztPuWdMXc
	 ANTEq5bi0JOybszU2w5qvdAdhnP4F2HGxdGZRW1E7mT3MbEk4g8I1KQZrZnD7WU/Q6
	 UAAi6TU5qjqdg==
Date: Sun, 13 Apr 2025 20:12:50 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 20/54] mptcp: move the whole rx path under
 msk socket lock protection
Message-ID: <Z_xTAoFA8RskUjCz@lappy>
References: <20250403190209.2675485-1-sashal@kernel.org>
 <20250403190209.2675485-20-sashal@kernel.org>
 <efca2379-0474-4a02-8b3e-b4611f56bfcb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <efca2379-0474-4a02-8b3e-b4611f56bfcb@kernel.org>

On Thu, Apr 10, 2025 at 01:05:11PM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>Thank you for having suggested this patch.
>
>On 03/04/2025 21:01, Sasha Levin wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> [ Upstream commit bc68b0efa1bf923cef1294a631d8e7416c7e06e4 ]
>>
>> After commit c2e6048fa1cf ("mptcp: fix race in release_cb") we can
>> move the whole MPTCP rx path under the socket lock leveraging the
>> release_cb.
>>
>> We can drop a bunch of spin_lock pairs in the receive functions, use
>> a single receive queue and invoke __mptcp_move_skbs only when subflows
>> ask for it.
>>
>> This will allow more cleanup in the next patch.
>>
>> Some changes are worth specific mention:
>>
>> The msk rcvbuf update now always happens under both the msk and the
>> subflow socket lock: we can drop a bunch of ONCE annotation and
>> consolidate the checks.
>>
>> When the skbs move is delayed at msk release callback time, even the
>> msk rcvbuf update is delayed; additionally take care of such action in
>> __mptcp_move_skbs().
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-3-4a47d90d7998@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>With Mat, we are unsure why this patch has been selected to be
>backported up to v6.6. An AUTOSEL patch has been sent for v6.6, v6.12,
>v6.13 and v6.14. We think it would be better not to backport this patch:
>this is linked to a new feature, and it changes the way the MPTCP socket
>locks are handled.
>
>Could it then please be possible not to queue this patch to the stable
>queues?

I'll drop it, thanks!

-- 
Thanks,
Sasha

