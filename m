Return-Path: <stable+bounces-132065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA6CA83BEF
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AAC1897C98
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4D1F2BA7;
	Thu, 10 Apr 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCrf2TZx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D91552FA;
	Thu, 10 Apr 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271960; cv=none; b=BXSLCvMGf3tC2cbL0Oz8jaScBJh6YbVVSi09G1VHFu/FxCe4Iw+mt+hX0jbv2asP7rTi5ZhhY/gU+wNTJlr5vRtFLNvgzxVvSNEasRuT7M9d/LBGWUGq0+eksLQs9b1JJjcKMuBjOprgifgwnHZWnoWqE71LtR7xdQbrQq93tNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271960; c=relaxed/simple;
	bh=b1PN+I/M0/lIShuUTza3W983gyrPy404n6n3jDGAWBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xld9ZQXEQkHurI6VUsh2Q4OAF3qeXpqZHSfsc1fJr7Ryb3RO61pKNREfLcUDSSb7QZMkO0RUBvVkZEhQpvM6/hsr3WTTdSmYaQ1n8Ec9pJ5Ur1RHH4YYJsNgsWW5NeXEIvw5eBfDmnTYAclAqQTo+8eZEEhH3z8browutK7e1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCrf2TZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3764FC4CEDD;
	Thu, 10 Apr 2025 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744271959;
	bh=b1PN+I/M0/lIShuUTza3W983gyrPy404n6n3jDGAWBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCrf2TZx28Eg0mxOMXCDWkWDnzwMbwubPBlqFJn8wQczA+ZgMijtgByzoqCsPrKaX
	 oV3Rjxy+gFD8uHIL+Rib/tMiHkt/LkDe5uLpeXd6AHnK3or8g7YA4nJkPaO1zppDti
	 qx6zbSN00Da2pp6IFztz0bUuc9LuLK7rI2c+2o6M=
Date: Thu, 10 Apr 2025 09:57:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: Re: [PATCH] pps: fix poll support
Message-ID: <2025041031-agreement-hardener-0f9f@gregkh>
References: <0231dfc22dd34a5aaee09a6a19074de1@diehl.com>
 <636c5ad9-25ad-44f7-9454-a7787de7a6aa@enneenne.com>
 <df3dd18b292941a1aaf3bd04f3df6bf3@diehl.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df3dd18b292941a1aaf3bd04f3df6bf3@diehl.com>

On Thu, Apr 10, 2025 at 07:42:32AM +0000, Denis OSTERLAND-HEIM wrote:
> Before printing, think about environmental responsibility.This message may contain confidential information. If you are not authorized to receive this information please advise the sender immediately by reply e-mail and delete this message without making any copies. Any form of unauthorized use, publication, reproduction, copying or disclosure of the e-mail is not permitted. Information about data protection can be found on our homepage<https://www.diehl.com/metering/en/data-protection/>.

Now deleted.

