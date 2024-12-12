Return-Path: <stable+bounces-100929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079649EE95C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D719161866
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B6215764;
	Thu, 12 Dec 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSdXoiju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E22153C3;
	Thu, 12 Dec 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015046; cv=none; b=A5xOGBXhz+Wtl2f3UMZjYa2y9mIK5I89Q4ZQ3UJ0bip7VibdvqaD2isVInsEiEXYWoJ2xWgZjq0BQcij9/M4cqlSLZRQyZcKSfv1eMd8Y1r9SPYqUJPM8izByJXPBeGPujZGaPd7UKWTna4NqsN28CxN5tu269cRyyp6hop+kQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015046; c=relaxed/simple;
	bh=V/D333GEnAXR6TKatHVFatYZi2rCIDF/Ea/kA02M6pM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSz2XfizcFL0JlnyR+Kw5QVeZwqsT4E4lnvFKmRpmR2/OzGJokJIZe8yPOGtnhPktFFytAg5YI5iK9zflBrGK/bCHu/O34SKWEh30h0+TRuagLY99f3H4M9WAR58N+SVFOW/qwuOWXUeSE8OKSEbSbRfR1CVt9MRjmOc0RTS/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSdXoiju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78602C4CECE;
	Thu, 12 Dec 2024 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734015046;
	bh=V/D333GEnAXR6TKatHVFatYZi2rCIDF/Ea/kA02M6pM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BSdXoijuwcRCkFR3ocvCl1oONKTr80TQeHpVRLgIGf6kx6vvk2yO/yl2ooWPMgEFp
	 bR5UXF50RJgyOBDVvfht7UBXLHDRnxuvCMzSfJWLfs+QOKUe/o3OEWsuZV3l5U7EEW
	 PouE/wL9vOUt5O7cQhPK2SQH6ROojebRmUsl85sLfTcUsSCqjfkJf83k4g6zK9S1si
	 7IpncSShyUR24QXDWsY8zpveuY/x+Si6paDlU1sd9TVmQ9aXW9CMi5LnA+KbdRMoBr
	 TPfzjVA9MLWaX40gFgCevVwapf2r/LfhN0tkykt5NYSYSrneLyoEutRS56KrDigj37
	 vc6uRtDwCAWDQ==
Date: Thu, 12 Dec 2024 06:50:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>, cve@kernel.org
Cc: jianqi.ren.cn@windriver.com, stable@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 sashal@kernel.org, jamie.bainbridge@gmail.com, jdamato@fastly.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] net: napi: Prevent overflow of
 napi_defer_hard_irqs
Message-ID: <20241212065044.09d7b377@kernel.org>
In-Reply-To: <2024121250-preschool-napping-502e@gregkh>
References: <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>
	<2024121250-preschool-napping-502e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 12:41:08 +0100 Greg KH wrote:
> On Wed, Dec 11, 2024 at 12:03:04PM +0800, jianqi.ren.cn@windriver.com wrote:
> > From: Joe Damato <jdamato@fastly.com>
> > 
> > [ Upstream commit 08062af0a52107a243f7608fd972edb54ca5b7f8 ]  
> 
> You can't ignore the 6.6.y tree :(
> 
> Dropping from my review queue now.

Is it possible to instead mark CVE-2024-50018 as invalid, please?
The change is cosmetic.

