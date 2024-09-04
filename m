Return-Path: <stable+bounces-72996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CF996B7B1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53EE1C2464A
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3121CF280;
	Wed,  4 Sep 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QaZwV9f4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C311CEEA2
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444095; cv=none; b=CWvNfvylVxqpFry8C4EYKEWsvDkiVHkmv1Jz22+lpigXy5bumx4SNmzTKWoxXnPpgmzmNqchaZB4NhW8b8S9Dwh6UzAW4HBD/VZQWFQmQpt+6oQRCp3xjbGICU1uRUUTlRcMP7/X12JPoZWu/cvtXZkRUyNAX7NoN9PBGUw9IjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444095; c=relaxed/simple;
	bh=KnXoUFnbmtVGeb+/YzBMWQhhcNaO4mVHeFPNi3EiX5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMo3SrLdUc/z0c3g4pL2/5sBdZtyBuhS+x91Ygxo8FPsQDwZ46/bMWIufoePdUcN7ak+Hz+XJAWANbB8DfZsPcxsUPLdQzzlGSE3rq9gnf0O2stw8c8zrN3aLP6/FraRp89++f1j8Ek+2MzCO/mD5Tp8ypHPg1uB6gHiznxARew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QaZwV9f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F68C4CEC2;
	Wed,  4 Sep 2024 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725444095;
	bh=KnXoUFnbmtVGeb+/YzBMWQhhcNaO4mVHeFPNi3EiX5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaZwV9f4E0rk/k4mTiAo477LlvZIRCM3PWAOFXDTy3CaylwTdiyiOZV+kkBjb0lAu
	 tVLAJRJ4hALnn3LxPljG0xWcmjJhRGNFrzrfFTE/CkhohdUBfO7G9wCqnrK6m/9H9v
	 6xBVR0xyaMPpyjO+RK0PC7Uke9feTOF5GNuCWZtY=
Date: Wed, 4 Sep 2024 12:01:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org, jslaby@suse.cz, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH stable 4.19.y] ALSA: usb-audio: Sanity checks for pipes
Message-ID: <2024090408-trustless-carload-35fe@gregkh>
References: <2024081929-scoreless-cedar-6ad7@gregkh>
 <7656cec0-3e12-47cf-af5c-178b7103ef17@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7656cec0-3e12-47cf-af5c-178b7103ef17@stanley.mountain>

On Wed, Sep 04, 2024 at 12:17:37PM +0300, Dan Carpenter wrote:
> We back ported these two commits:
> 
> 801ebf1043ae ("ALSA: usb-audio: Sanity checks for each pipe and EP types").

That commit is not in 4.19.y, it only is in the 5.2.8 and 5.3 releases.

> fcc2cc1f3561 ("USB: move snd_usb_pipe_sanity_check into the USB core")

Same here, not in 4.19.y, it's only in the 5.4.282 and 5.10 releases.

> However, some chunks were accidentally dropped.  Backport those chunks as
> well.

Perhaps those commits were never applied to 4.19.y and you should just
backport them instead?  :)

thanks,

greg k-h

