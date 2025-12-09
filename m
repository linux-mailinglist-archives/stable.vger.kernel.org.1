Return-Path: <stable+bounces-200490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DC3CB1399
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 22:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DF3A3009F65
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7810531AAA7;
	Tue,  9 Dec 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mrfviX+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241FF275105;
	Tue,  9 Dec 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765316664; cv=none; b=sj/ntxuYRoWOGFfi9sR0J/L2yt8G/t2fgdmj2fPD8rKt8InGbyd45puZo65hQiuQ0vGL5Zv36+TC7sbJnXOqKbcmSl585PmuMXgN+AvQRDpisvz5OCQtXKdiDni3P0PsyegmfCtKp+/Yany72obN18Ua+tFNacA/dOMQEe5UmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765316664; c=relaxed/simple;
	bh=QYuXgb9QpaUY8Ny41Jm0TheiQmYmaE34Qp6hdo0bC/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpTW7SRsEjcMpEYKNvI7si2yPsrUc0VYtZEGIqdPPcl/7q/IBCrQjrL6EhVSrDxBpB54YIeIKKvKUUkPKWTlUog0JNKtZ5lmGwGtpUsK28BINuOmxZYrFRhP8k84m8fy+RW46dNvLcgxXl4reoSelZIhHYOvA9dbHVve6GrySuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mrfviX+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B329C4CEF5;
	Tue,  9 Dec 2025 21:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765316663;
	bh=QYuXgb9QpaUY8Ny41Jm0TheiQmYmaE34Qp6hdo0bC/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrfviX+u4BJ1rBesfFG0frhCVNnSCl6q+m5re6W43dnhy6yF3GD+iJFhOpV9H0wxW
	 gJrouQKtwyRkfTiSOBYIU8Alnp5UBYm1ra1b8EJDmGIzEBsQLLULJ3084a/WFLWA6G
	 Kp5C4Tei6ICkWAi/kyKsQW4F8xmKJWw80BwWsZaQ=
Date: Wed, 10 Dec 2025 06:44:21 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Tejun Heo <tj@kernel.org>, stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.19-fixes] sched_ext: Fix bypass depth
 leak on scx_enable() failure
Message-ID: <2025121008-manned-savor-b518@gregkh>
References: <286e6f7787a81239e1ce2989b52391ce@kernel.org>
 <aTiRApl5-FFwVSVp@a281ed4ccb28>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTiRApl5-FFwVSVp@a281ed4ccb28>

On Wed, Dec 10, 2025 at 05:13:38AM +0800, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Something went wrong, this seemed correct :(

