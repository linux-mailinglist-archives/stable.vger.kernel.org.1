Return-Path: <stable+bounces-165149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB98B1556B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 00:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C756128A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C88622068F;
	Tue, 29 Jul 2025 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dicgyboa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E41D54F7
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829185; cv=none; b=tyy9zZTpbv28aAmLruGkhWv9A6u+m8ejVCsLMelXWon+CCh7hNPgd5FegTqR+xGBwKjkqKEsmq6QhqEkP4qreMj2Y9qDYar6YAE9w0oqQHl/XgEtttdBqBdyyehDeaJedW4LxM+9eo0iXqsUY1FbfaCejoO5pzINMRPhTF6+tTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829185; c=relaxed/simple;
	bh=ducTvnBKsOxCwRVhgtcrDUFKKFNCxXs3IfugB3GoW/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd6HJ98h7uhqhpy+LK8F0De0YXFjdrVLM6rxaVFcl/88xGCQZR2CkZAOBQlbAk2urPFUvu8u+0qC3v66qjekHPQsaA2poxOFAfgWN89l/fCKhlgS+6c0ia1WhNatNnERZOxqlgvdwR9M0ihvZwqq+uC/M+Su+w3+6pB8ESv9PNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dicgyboa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EDDC4CEEF;
	Tue, 29 Jul 2025 22:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829184;
	bh=ducTvnBKsOxCwRVhgtcrDUFKKFNCxXs3IfugB3GoW/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dicgyboaP2VKDo2HYClBSPhmIwcaLbLg+CgtfGyLGo1muTDKVotXlIX1107IjySSX
	 TLsIPVKOwE4X1sC1enPlKgnGg0NqYY+Zn3ZmmAzCCXCGUC1PTXrsKx7So31aZevWJe
	 8iz01iVKLqik3iBO0iZz4nl7GrYoEJ9Yy1qCJxEIiObYCUN1H+sGHv5BhKWMaQy/dk
	 wJ/pehrdHa0Y1cTKKMxVYYkXl+mlEh9/ljkG7gpm7nvnI4Fpt8dZG8Pl+QDnq1i+n8
	 H3iN2lYZ1TCpuwD7wFkMnlc75iyXi/wCsr0GTOUJHB0YooZJkjIhCBHenldpCRWSST
	 v4FGQqP3VzPtQ==
Date: Tue, 29 Jul 2025 18:46:22 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 6.12.y 1/2] xfrm: delete x->tunnel as we delete x
Message-ID: <aIlPPoxBqsYNus5y@lappy>
References: <2025072924-postbox-exorcism-f636@gregkh>
 <20250729211153.2893984-1-sashal@kernel.org>
 <aIk9Zl0Fy4x8Z768@krikkit>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aIk9Zl0Fy4x8Z768@krikkit>

On Tue, Jul 29, 2025 at 11:30:14PM +0200, Sabrina Dubroca wrote:
>Hi Sasha/Greg,
>
>2025-07-29, 17:11:52 -0400, Sasha Levin wrote:
>> From: Sabrina Dubroca <sd@queasysnail.net>
>>
>> [ Upstream commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd ]
>
>
>2025-07-29, 17:11:53 -0400, Sasha Levin wrote:
>> From: Sabrina Dubroca <sd@queasysnail.net>
>>
>> [ Upstream commit 2a198bbec6913ae1c90ec963750003c6213668c7 ]
>
>
>Can you wait a bit before taking those 2 patches into stable? A couple
>of syzbot reports landed today, one is definitely related to this
>series [1], the others probably are as well [2][3]. The patches should
>be dropped from all stable branches for now.

I've dropped both from 6.15.

-- 
Thanks,
Sasha

