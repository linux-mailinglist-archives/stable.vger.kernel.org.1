Return-Path: <stable+bounces-146445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E07AC5141
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896E01BA2138
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7765E27AC3A;
	Tue, 27 May 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2ikbRu0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421F27A445;
	Tue, 27 May 2025 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357228; cv=none; b=IXW+cnOFIqCyYddeao0koMkOTOGQKPXcm6d9WNh9rkNJ7RdnHyScxswWyLoGjawOdaf4bdrJ8QgSPolvEfxDWPd6r0+9PwuLUUt78C3Pknsu/7WWe42PchyADPykaZLKU4pV+K17qbpqGrRHGBOtmY3vNCyoQTYaHg+9cMLp0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357228; c=relaxed/simple;
	bh=XHiQNryj9BFMoumMwUMPDSLBU9xZL9NqwRMbbTEPV6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKn1TZ52xqYThh7CZ4Hb17cG0vUgrKO8y7yJ4+QYpfx9m/WwvL9yhyySx4YOo1hIrVHaffYBeGYuQ+lQwXU3yYuulTw18xqzKkA1l2uYD4M8JYWGeN45gMDTeusNFcfp18KZOulRTzKd9SxiSmMqaDDtTKQtSVvPdcAabzSAagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2ikbRu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79845C4CEE9;
	Tue, 27 May 2025 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748357227;
	bh=XHiQNryj9BFMoumMwUMPDSLBU9xZL9NqwRMbbTEPV6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2ikbRu0h+FE2ziSXK1ro9BV9F9IizP78bgaiECnmIliQJGBHXG88+zTZDNb3tpdA
	 w9SQrFH5CYFKcAB/BU7fLk6jV0dGvAZ6soH9aZ6gfe0qT/kNNag4SId+Qe2LMaoab3
	 zmjnP3nAFbaJZ1uNZ7Y4hZGycwrOlt/yyZJd/trkmCleevdS7kMLZWh4NOL/QlnNm8
	 VlqHOBBV3mEB/rBfFN23aazgyXpEYRCuCJztMNVozA77DGW2rQfA97/2iIu0BY5CTT
	 Y4k4yYCa63d68uVItWnFnpv1ncWsjtTs8NIa1yM4EVIbxgILsZKSnKigqdt48xKIuB
	 Dko1SVrd9g2Vw==
Date: Tue, 27 May 2025 10:47:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [ANNOUNCE] AUTOSEL: Modern AI-powered Linux Kernel Stable
 Backport Classifier
Message-ID: <aDXQaq-bq5BMMlce@lappy>
References: <aBj_SEgFTXfrPVuj@lappy>
 <20250506072159.520ff0d5@kernel.org>
 <aBt3D3z0Ayn6R_YO@lappy>
 <20250507085421.7fefd093@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250507085421.7fefd093@kernel.org>

On Wed, May 07, 2025 at 08:54:21AM -0700, Jakub Kicinski wrote:
>On Wed, 7 May 2025 11:06:55 -0400 Sasha Levin wrote:
>> On Tue, May 06, 2025 at 07:21:59AM -0700, Jakub Kicinski wrote:
>> >On Mon, 5 May 2025 14:11:20 -0400 Sasha Levin wrote:
>> >> - Detailed explanations of backporting decisions
>> >
>> >Are those available publicly or just to the person running the tool?
>> >I was scratching my hard quite a bit on the latest batch.
>>
>> Yup, it presents it to the person running the tool. In theory you can
>> always go back and re-run whatever commit you'd like with the same query
>> and get a very similar explanation, so I didn't consider storing the
>> results.
>
>Injecting the explanation under the --- separator in the AUTOSEL email
>would be ideal, but not sure how hard that is to arrange.

This made a lot of sense, and so I've improved my scripts to do that.

You should see the AUTOSEL review series starting with the 6.16 merge
window material coming out with the explanation injected under the
seperator line.

Thanks!

-- 
Thanks,
Sasha

