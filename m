Return-Path: <stable+bounces-124499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CAA62422
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 02:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A26A883026
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 01:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7426B176AA1;
	Sat, 15 Mar 2025 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfF8+zAN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503D78F5F;
	Sat, 15 Mar 2025 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742002767; cv=none; b=EIExNeNGBdJOFng5JaVqJmINug7DQ+yrn0z9DAyNimOhjyT7XdcwdcM9e4XyeOoZhbGnBa0kWMJAA+yNAJyk3un7qam9TXVQYv+N8XtH9XUBxKTYEzl4f1OGo1iSui5UrwlvfZoYqAhZ7n4t2u9P3ZE2BPIQqHFRzSt3BUhb2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742002767; c=relaxed/simple;
	bh=TYDriDV6Hem3RlevujvNnrbRBOPfoqUXzyBsIJLgED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoPzTRly6lkhWa1aIKnNYv5AtROxDbF6HIaX2PiAteG9XJUPJg1xQW9aC76FcurU0WGQsFApmV3+pMCOzaC5ea3/MAh+nQv3nIRc06jVhb7mfBUi2VfEBEBdqNLRhCQM97ER8ZnMhMWaTLFoMtChk+VDUPHG6Qc0DGpX2IQFozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfF8+zAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B3FC4CEE3;
	Sat, 15 Mar 2025 01:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742002766;
	bh=TYDriDV6Hem3RlevujvNnrbRBOPfoqUXzyBsIJLgED4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfF8+zANYFf8oHoOttF68SUoCZzc8543Af8DuwNHwv23B58sjOZbdlFdyAye/EuNj
	 EPe8Gv/JhbVbX1cHuNXkvRn+XemIVEuwrwn20TCbdDJR45KjVTdR/JVv1HzvaNQC+D
	 YglmvMWy/cPsD4wXQiQwlDAFiqEW9T1ja4LTFg15QOQPVrZdBqzC065l1eEzvB9PAr
	 rVzy6LohogEJqwIuw9r6t1yKsHyxmqXzgwGskPUw3Fb48L/fKlAZGia/byl2CoZF1F
	 Es69gSdqqmvJjWW8aAQbmx67fxdRD7+plt9D+qj9DTQhJybJf0a6POvcg0zVmcVSNy
	 UQqfOS2Uub7cg==
Date: Fri, 14 Mar 2025 21:39:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	martineau@kernel.org, davem@davemloft.net, edumazet@google.com,
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.13 13/17] mptcp: safety check before fallback
Message-ID: <Z9TaTcOL1ZkccXr7@lappy>
References: <20250303162951.3763346-1-sashal@kernel.org>
 <20250303162951.3763346-13-sashal@kernel.org>
 <262b5990-47e8-44f9-a2af-ca9c389e34fd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <262b5990-47e8-44f9-a2af-ca9c389e34fd@kernel.org>

On Mon, Mar 03, 2025 at 06:05:12PM +0100, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 03/03/2025 17:29, Sasha Levin wrote:
>> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
>>
>> [ Upstream commit db75a16813aabae3b78c06b1b99f5e314c1f55d3 ]
>>
>> Recently, some fallback have been initiated, while the connection was
>> not supposed to fallback.
>>
>> Add a safety check with a warning to detect when an wrong attempt to
>> fallback is being done. This should help detecting any future issues
>> quicker.
>>
>> Acked-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Link: https://patch.msgid.link/20250224-net-mptcp-misc-fixes-v1-3-f550f636b435@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Thank you for backporting this patch, but is it OK to delay it a bit on
>v6.13 and older please?
>
>This patch depends on its parent commit, commit 8668860b0ad3 ("mptcp:
>reset when MPTCP opts are dropped after join"), on kernels >=v5.19, to
>avoid a WARN().

Waited a bit, looks ok to pull in now :)

-- 
Thanks,
Sasha

