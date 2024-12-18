Return-Path: <stable+bounces-105244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB199F6FEA
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 23:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF911893CDD
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25551FBE8B;
	Wed, 18 Dec 2024 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjrY2RSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E286198845
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560000; cv=none; b=tsqVYbJ+0EV/YvnBxhfGDTRXU5wMT1B/hKyZwZddtJceHLPasFH7MvEO+YOcwKQQ/tTiFeiYskkHdCtlYx+FKmd/RSOmyvViEpY8tWp4r0meBNPO0DclK12cZxVdxgfPVhw/uT59Up/QJSrxZ4dZWZtovxrrelAGUlJDw0+cjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560000; c=relaxed/simple;
	bh=IKUB97eWrE+zI+iG7Tcq4ySSgK6N3rqYe/eVHI+eiU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVmOYSU5SgCriPq7DoKF1pEjWV4htRQ/YgnfGipgaExJSDxpBVn/8MWRpgJkdf/nj7vKiPtf6WOhPltPrrpKy0mKGbhavbhV7CTLsiPpfc25QvYY/GJJ9DNNsu56iAEdSN0crdkcWZKUYf+PLxJKxLOqemJYZcgC119mdyF876A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjrY2RSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD106C4CECD;
	Wed, 18 Dec 2024 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734559999;
	bh=IKUB97eWrE+zI+iG7Tcq4ySSgK6N3rqYe/eVHI+eiU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjrY2RSKN2M3xGlq1ds/PnIY/1qHNAu3kGlxCq6UQTxhLmYVyTMuiOr+nqFDVB9XH
	 wNOyQbeaJk8uipUYZ6EJ8chs6HECNjA2wH7fBGjdzYXaRLI9wOYpm0DsnvwITIcfrM
	 ehbzA2BrwnjAMRH7J1zch2Xtlw1adW9GMF0rlFxEu4Cg3eJjiH/mwy3WfoqXOkqDHS
	 147pGdlyeHw5F82y0OP3fJ44EbCgNJIRsWXwFPiE7vMo3ihvzM7zwRR7OYo2Z+F0Pe
	 m+dsOGWC4cQeamtAbeUjUtJggovyZzsMFss1rOjwg654CXRjFHp5+AM2nEwFygEVuS
	 u80V2HLz4cPhg==
Date: Wed, 18 Dec 2024 17:13:18 -0500
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>
Subject: Re: [PATCH 6.6 12/17] xfs: attr forks require attr, not attr2
Message-ID: <Z2NI_gDmfMNqHJh6@lappy>
References: <20241218191725.63098-13-catherine.hoang@oracle.com>
 <20241218155157-b0c79d27d96c74eb@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241218155157-b0c79d27d96c74eb@stable.kernel.org>

On Wed, Dec 18, 2024 at 04:01:11PM -0500, Sasha Levin wrote:
>[ Sasha's backport helper bot ]
>
>Hi,
>
>The upstream commit SHA1 provided is correct: 73c34b0b85d46bf9c2c0b367aeaffa1e2481b136
>
>WARNING: Author mismatch between patch and upstream commit:
>Backport author: Catherine Hoang <catherine.hoang@oracle.com>
>Commit author: Darrick J. Wong <djwong@kernel.org>
>
>
>Status in newer kernel trees:
>6.12.y | Present (exact SHA1)
>
>Note: The patch differs from the upstream commit:
>---
>Failed to apply patch cleanly, falling back to interdiff...
>
>interdiff error output:
>/home/sasha/stable/mailbot.sh: line 525: interdiff: command not found
>interdiff failed, falling back to standard diff...
>---
>
>Results of testing on various branches:
>
>| Branch                    | Patch Apply | Build Test |
>|---------------------------|-------------|------------|
>| stable/linux-6.12.y       |  Failed (series apply)  |  N/A       |
>| stable/linux-6.6.y        |  Success    |  Success   |

I'll figure out what went wrong here, please ignore...

-- 
Thanks,
Sasha

