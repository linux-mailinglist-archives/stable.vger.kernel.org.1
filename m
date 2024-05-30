Return-Path: <stable+bounces-47737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE508D5272
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 21:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D043A1F24D78
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB3158874;
	Thu, 30 May 2024 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IA0Od9z1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB112E6D
	for <stable@vger.kernel.org>; Thu, 30 May 2024 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098152; cv=none; b=gYD8jvLrCP4Ctp7/Wig2R7Nx0z9oUiMgKfXZKjvfbKtdjBK0c/goKSNfdXzF/FllDON2vu7ZK4vURBW3jP0sc9zND5MBZj5lE/YhbHNb4kHhH1VK0E0SDIHPAQqGJGGGfpZ+2JsbNoFdxVDUvPsZU5MyEJ+0hbFyYiGCyupkONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098152; c=relaxed/simple;
	bh=q3bf3RlEQ7Z94EL98F0V240LErTB0/iKv8bz7fEIipU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjD9tVmXxFkyGvtXgn0N0Fr73EnJY8+Mf5R1vhe4SZvMt6W+wwpWCyTlxxVwLmHOf6W1j6ECW5DSTsQCfMO6Qghmn2M1WnCLrzJ8WgYSkvGER/hdERvftM0hWBp0gNTAxhmljjl191NLpX5LyJGP1/0/eLxFYnoReaezBMx4VG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IA0Od9z1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022F8C2BBFC;
	Thu, 30 May 2024 19:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717098152;
	bh=q3bf3RlEQ7Z94EL98F0V240LErTB0/iKv8bz7fEIipU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IA0Od9z1JbFohw6P9c2ei3/NtB3minYoNIXIjd3mLG6J3YWvqczJsU++fkrhDkkE6
	 +2ZJlA6hDgFttHLScfsHJgH7a8ZpcvcSmpuTDNVir2LKjo8uO9A3YBqZkECPy+u0gs
	 zWG8/dchFBa7tf8VDSbLDvDKlRYZPp7zshQizpOg=
Date: Thu, 30 May 2024 21:42:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mohammad Hosain <mh3marefat@yahoo.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: AM5 big performance reduction with CSM boot mode and Wi-Fi
 disabled.
Message-ID: <2024053003-unbutton-stadium-2a2b@gregkh>
References: <321337111.6017022.1717061838476.ref@mail.yahoo.com>
 <321337111.6017022.1717061838476@mail.yahoo.com>
 <2024053032-squeeze-such-dd29@gregkh>
 <1591472096.6190967.1717088352009@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591472096.6190967.1717088352009@mail.yahoo.com>

On Thu, May 30, 2024 at 04:59:12PM +0000, Mohammad Hosain wrote:
> I think it has never worked (I remember as back as 6.7 it behaved like this but only recently I discovered it). If you enable CSM and disable Wi-Fi using BIOS, gaming performance is massively reduced on AM5 boards... This only happens on Linux.
> 
> I don't know who are the developers involved that is why I emailed stable@vger.kernel.org.

stable@vger is not the correct place for generic bug reports like this,
sorry.  Please try reporting this on the linux wifi mailing list, the
developers there should be able to help you out more.

good luck!

greg k-h

