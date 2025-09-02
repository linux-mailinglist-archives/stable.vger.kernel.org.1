Return-Path: <stable+bounces-176998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8169B3FDFB
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6263E4874F2
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F82E716F;
	Tue,  2 Sep 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGIBSJG5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F8269B0D
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813327; cv=none; b=nBgV8xHqFxMJom3ogTtzaSblmvklFZ3+lyWcRHmcTZ63dEW0Tl/Iuhu/9A6HPlLg4fBmtvTCL9rb+E1YcQcTTk/bnsKfFRTVhcEbKKzh+RodxNl1dV0Pahu+9WjkFxZziqtzOKHYyfLuTGUEclapbIDZ6RHAhCWVbBN04oW2ff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813327; c=relaxed/simple;
	bh=ueWrWfHXjNNujyXkN4kxVGscDSsQ7zmk5MQKJHflWRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIy1tZhnV/AJpNYB5bVDq05NOnN9oBR7vULNjRslJgaoS75yl2Ixx3fXAqFXawdpbpTjRf9n+/nTSFjFl/Dl2Mvbk9GyLIBO1uV5aLYOwCoJxCOsqBONVCR6Ag1liYMlCNco7gnu9dCVKfhGq4JPIhYtNwN4wHOXDxX28koFMD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGIBSJG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D12BC4CEED;
	Tue,  2 Sep 2025 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756813327;
	bh=ueWrWfHXjNNujyXkN4kxVGscDSsQ7zmk5MQKJHflWRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGIBSJG5XDdhMHfn48eh3vuAOgp4a/mGuYTd3VFJDy862yEcrTdReFhQ2NKhCrBwF
	 wi2YXPC5XGYyOeK/19q8ortJoVaCjSiAM22qiOb3/QMm6kq0/nukfuBW2YiwkMVU05
	 yYDsbdV+0Fyi3q3UQ7MKpw93wZqdWfUoOkhWp8YI=
Date: Tue, 2 Sep 2025 13:42:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
Subject: Re: [PATCH 5.15.y 2/2] KVM: SVM:  Properly advertise TSA CPUID bits
 to guests
Message-ID: <2025090235-washroom-twine-5683@gregkh>
References: <20250827181524.2089159-1-boris.ostrovsky@oracle.com>
 <20250827181524.2089159-3-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827181524.2089159-3-boris.ostrovsky@oracle.com>

On Wed, Aug 27, 2025 at 02:15:24PM -0400, Boris Ostrovsky wrote:
> Commit 31272abd5974b38ba312e9cf2ec2f09f9dd7dcba upstream.
> Commit f3f9deccfc68a6b7c8c1cc51e902edba23d309d4 LTS

How about you just backport both of these independently, as this change
now looks nothing like either of those commits :(

thanks,

greg k-h

