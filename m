Return-Path: <stable+bounces-12461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA6836875
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 16:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA0AB2BA35
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86547A4D;
	Mon, 22 Jan 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SAcmZxfx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FD47A48
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935818; cv=none; b=foti/cHaDeProWxKxNoB2zACT6a18PGfqqCrChB321Nufw0HQQW8PIPuDmtz+P/SqZ5prg9K/o1KSfDcu19w1VeXjlzzHIATYeaoq0eAMTHSFLzMV7DVPTxWFFU80oO1Wg428UhdtfpGI9Zc6nF0Ss+BwardD47B0+GuDSXXRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935818; c=relaxed/simple;
	bh=PA4e0SLz1rgwyvmNffmUASMKElthouXdbqptqInDN5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+Qbk8vZxJ82jFC2B9Ao9XoR/bvifmn+PQL9X9JhGaMJtbyz3ymlNfSFDvSlaWLASwjbMwCmhtAl2Spsfph9wx/utMtE9GnsCkql+2DKJdRpqbyP0OC/qCVNsnySysh5fgYiCIMwPBaxPN/mdEAkMBvSw7oIBW6yQ303GezDvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SAcmZxfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B0EC43399;
	Mon, 22 Jan 2024 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705935817;
	bh=PA4e0SLz1rgwyvmNffmUASMKElthouXdbqptqInDN5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAcmZxfxq8QH7fEz6PBfuRLL+Qcnlycr8A2dyI5qJXIZydcW+cyN/ZyzSTHLyVb3D
	 RWgeOFDAtukCCCQBqA9hXPfntBem4qePXHBAJTScO7QpNCLgcrI1wVjyyRxDYF+yL9
	 q/SE/dAKnFTjTrjhqOnZsiNI4aI0aBW9boZ7C0Dw=
Date: Mon, 22 Jan 2024 07:03:27 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
Message-ID: <2024012246-rematch-magnify-ec8b@gregkh>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121143038.10589-1-linkinjeon@kernel.org>

On Sun, Jan 21, 2024 at 11:30:27PM +0900, Namjae Jeon wrote:
> This patchset is backport patches from 6.8-rc1.

Nice, but we obviously can not take patches only to 5.15.y as that would
be a regression when people upgrade to a newer kernel.  Can you also
provide the needed backports for 6.1.y and 6.6.y and 6.7.y?

thanks,

greg k-h

