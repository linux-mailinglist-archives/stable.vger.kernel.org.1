Return-Path: <stable+bounces-194703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271FC58919
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB06234D404
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D502F6162;
	Thu, 13 Nov 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGo27SBF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFDA2F60B6;
	Thu, 13 Nov 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048864; cv=none; b=YFlcW1ecQlwePfhbNbhT/oz60swibvkC51lsOAtkdrgbRfIoZpTSCclmSLLI18OvqUgiLGoGa1m6Gee4AAfkl+rjome+HGlaRLN860AZpDrieDxZaiyObM0/D9Bheiz4rtSDg4jkIXTXwA+HkdLuysjJujofvR8cKsnD0lqxKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048864; c=relaxed/simple;
	bh=cG9hBJEBN8DnERl9DpO2cswwVm/n8xEWtCEa4sUGlEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0HhKBpc72/ZNPRnRvRzbj28CAFUAr+RzYM7o3yfZwhmIIHG0QRg3WnflR6/Px0OliNM7+xwnvJH31XFSw9aGeYz5Jxn9KKAHZeMoRyUB/33U6tLd55OIL+429jtx40dHDCOQNEEn47uX0BsL+t6jskH1iuuNrw3vUQG1epQY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGo27SBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26087C4CEF1;
	Thu, 13 Nov 2025 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763048863;
	bh=cG9hBJEBN8DnERl9DpO2cswwVm/n8xEWtCEa4sUGlEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGo27SBFHsRToadSwWx0BWjGeMWmtCoHv4PmPw6q3D0KGAC+ITztLBcbgzy/9RGFB
	 z3cbuT19OH1K6QzPt9kokAwKp55jradM3Fag/Oozdx9Tw7aV6DhB3gwZM1diu1u4tn
	 DT53TPvqOekeRU49oZSW6ov586fZ5Es0fZLeV+EGOmDrUYVMbhB4zkwu2yXNiSQ8PQ
	 V4xtfxReOAnDuHvyrcpA6ICD5i1/u8Xkptq/euQj6oNREEuCmd5YHg0H08rrZcXDyx
	 AHxfHRg4acwAPIHrW/WNJ8mzQXcbX/N89nE8KIAdxaCEZ1kC+XoOzUxFDjHik6hDwR
	 pqC3YNH9mXp5A==
Date: Thu, 13 Nov 2025 10:47:41 -0500
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: gregkh@linuxfoundation.org, stable-commits@vger.kernel.org,
	geliang@kernel.org, kuba@kernel.org, martineau@kernel.org,
	pabeni@redhat.com,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: Patch "mptcp: drop bogus optimization in __mptcp_check_push()"
 has been added to the 5.15-stable tree
Message-ID: <aRX9nX8aN5iZ4IpL@laps>
References: <2025110310-scapegoat-magnetic-3cf8@gregkh>
 <48bbe998-982c-4dbd-b261-83c076ebcb7a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <48bbe998-982c-4dbd-b261-83c076ebcb7a@kernel.org>

On Thu, Nov 13, 2025 at 04:19:56PM +0100, Matthieu Baerts wrote:
>Hi Greg, Sasha,
>
>On 03/11/2025 02:38, gregkh@linuxfoundation.org wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     mptcp: drop bogus optimization in __mptcp_check_push()
>>
>> to the 5.15-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      mptcp-drop-bogus-optimization-in-__mptcp_check_push.patch
>> and it can be found in the queue-5.15 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Can you please drop this patch from v5.15? It looks like it is causing
>some issues with MP_PRIO tests. I think that's because back then, the
>path is selected differently, with the use of 'msk->last_snd' which will
>bypass some decisions to where to send the next data.
>
>I will try to check if another version of this patch is needed for v5.15.

Sure, now dropped from 5.15.

-- 
Thanks,
Sasha

