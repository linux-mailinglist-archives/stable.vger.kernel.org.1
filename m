Return-Path: <stable+bounces-111869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF79A247C1
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 09:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A1216701A
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528D13BAEE;
	Sat,  1 Feb 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9kqs/Mz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAA2F41
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738398590; cv=none; b=fdtzUqFPjlQo4D+/0g+lOqtad3wcJCTB0EblDs9+6yDOWOGF7eovUF8xNG9rIJWM5bmgmDX/etronoSjwGfNTjjPVdroOVUY/x1xGEgStIDFWHg6UglGdo08MILRLnBf0AK3aakKp9SzJOKBtHPP2H2XFo2rIeuYxQv5PFNy5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738398590; c=relaxed/simple;
	bh=65kO7QPd9U9LzEc99fr1oBn5JCwg1smBGhKRsTZq9rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFbFWiSnKdK2i9vvaxDwi8VGzMsWhNVQcJaQq8ysozedJ2y/oA4ipCokxkh2PwBSmf2yjJ93D0O8c8vHuSf+TNvqgrIvpGx7SjHrjba0/BiG2j3z+dudUJUohYIfaT1UgZKDxlTCBVSWPH7nSgzD70bxFLrXpkNIMFwFBTeAGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9kqs/Mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509A8C4CED3;
	Sat,  1 Feb 2025 08:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738398589;
	bh=65kO7QPd9U9LzEc99fr1oBn5JCwg1smBGhKRsTZq9rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9kqs/MzxCtMVepYqxFrVtlIwXQAST5Zm/jj7gRfj3+F+NCDO3pnc1XQ7LUE6iNi1
	 wdSZxKU4uScVKioBuPHRbRSu6fTIjbVGjKQ5inrF3TvRQy6k+J1PXiFGRs5pCoG1Ou
	 dpf5gyUAmajbjUx9lqlHdSKyqiFcFbhcXZ17OmK4=
Date: Sat, 1 Feb 2025 09:28:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Rosenberg <drosen@google.com>
Cc: stable <stable@vger.kernel.org>,
	Android Kernel Team <kernel-team@android.com>
Subject: Re: f2fs: Introduce linear search for dentries
Message-ID: <2025020118-flap-sandblast-6a48@gregkh>
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>

On Fri, Jan 31, 2025 at 01:49:16PM -0800, Daniel Rosenberg wrote:
> Commit 91b587ba79e1 ("f2fs: Introduce linear search for dentries")
> This is a follow up to a patch that previously merged in stable to restore
> access to files created with emojis under a different hashing scheme.
> 
> I believe it's relevant for all currently supported stable branches.

As the original commit that this says it fixes was reverted, should that
also be brought back everywhere also?  Or did that happen already and I
missed that?

thanks,

greg k-h

