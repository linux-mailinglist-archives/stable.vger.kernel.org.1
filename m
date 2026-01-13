Return-Path: <stable+bounces-208294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F9D1B215
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 21:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FC78300EE48
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C211318B9F;
	Tue, 13 Jan 2026 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDjkcVDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A71A5B84;
	Tue, 13 Jan 2026 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334515; cv=none; b=Zm4+KTDQJyhdtibFOpgSQ4KEve3Qx6bnL4YCET1oX/YrvBV0Z/8Jf3L/G4dxBJBhXR8FmJK+2vjbSjhgv4H/23U9yyekeoVqGitsNXHWUyBnmchGYgWv4XNPyJub3mHlyB5CMhPbLGtoMJyyn4ZqWTPSMoF/WS9qO0Z4ovQmyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334515; c=relaxed/simple;
	bh=M4uUyEp62gWWD4OOHFLprekCcfTdrbBnebmztF3mh64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGF0qlxjYqszVrHt3cHPMiclrIk9yfRLXpWYMeVPQmMvIZQpIz8BsLv4LdV3QquyzFuhaLMroH5pxfw5eLvzTj5POJfdQe6FJK+O3TpKz6OPEtmb5qHgawKsKqMprbfkiJjfPZmitdjBUdx6HZwUNo19sF8Veb4h4GXIPr8plaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDjkcVDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7647DC116C6;
	Tue, 13 Jan 2026 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768334514;
	bh=M4uUyEp62gWWD4OOHFLprekCcfTdrbBnebmztF3mh64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDjkcVDc8fy2JPLPcxCXi+cKEji/LSh7u5E4loJIV8SBUN9ksk9z8X4YQLRBQEYvk
	 cH0NpPRL+2VmpppDijtqgINcFyY+bBSOLbbD6l9Cvfimky5Gz170JWS+J8n31NBoyp
	 WMVpGOL/tiBpGy6uTLEFfJic4cIUYMlRP77Vpv+Z2A2IOdOA7OhPLgtNbam30fTbhZ
	 TIWv3Bb0h74UQlZlJMcitgfHi9qtiURXDQnWiJumppZaKYlY0MjiyeBoh2lHu7IodA
	 CSnI01WN3g5I/C3vHP+QbWZxBEYb2xCvZUlPvNqbZGjaD0K6nevM4fSq7XmwtlyjsH
	 0ToWKe84JxRnQ==
Date: Tue, 13 Jan 2026 15:01:53 -0500
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Apply 70740454377f1ba3ff32f5df4acd965db99d055b to linux-6.12.y
Message-ID: <aWaksWlyB-5k58G8@laps>
References: <20260113005327.GA2283840@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260113005327.GA2283840@ax162>

On Mon, Jan 12, 2026 at 05:53:27PM -0700, Nathan Chancellor wrote:
>Hi Greg and Sasha,
>
>Commit 70740454377f ("drm/amd/display: Apply e4479aecf658 to dml") was
>recently queued up for 6.18. This same change will be needed in 6.12 but
>it will need commit 820ccf8cb2b1 ("drm/amd/display: Respect user's
>CONFIG_FRAME_WARN more for dml files") applied first for it to apply
>cleanly. Please let me know if there are any problems with this.

Queued up, thanks!

-- 
Thanks,
Sasha

