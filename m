Return-Path: <stable+bounces-181731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE6BA0105
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AEC7B1415
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8B2E091D;
	Thu, 25 Sep 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUDOirGF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D2C2DCF77
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811650; cv=none; b=XLDccaWGOjLepLX5vAL+zYfi2hift5eLgKouDDxbcK/bEu87+fnRbNTc6d6sE+/9Ur1BWNOKnry8KoxAQm6wdP1SHGI8aBJqtmoZYuGHVmU2uSNHy3dK/w0Hf7WmbZBB6mLoAapurevx/WHFoAW1hNKGtHJcrj/j37hDQ1DvxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811650; c=relaxed/simple;
	bh=DDH7YZGi6I0fIBPeo7G6VG0nKehMehbpuTLepBL+qfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piZ7vBx9+aqTQ7vBU3wfILoV0DdevgTYLYMAdnZQigMQY8BPZ7Kps7fg+/z0lh5+fSAa5vDjeRT1IbTt+Xk41AIghCErX7uStBsO9bEv0cYQkhYTAyu0aAaGK+zcr7+NF4CofJv+/9/TIOqxrfzG+VhdxgGEzhoqxB0c66gIiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUDOirGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138A9C4CEF0;
	Thu, 25 Sep 2025 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758811650;
	bh=DDH7YZGi6I0fIBPeo7G6VG0nKehMehbpuTLepBL+qfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUDOirGFpzhy6zt7BZo2xIzDnkR2O1qR48TClDIZt4uXKkZ799XiN8ElYXcNj+3d4
	 iiueSdQtfvdpigS1vX/rdHPNBlXQJM5mJxcQM7YTHT/jJJwFxcKQILF5UfwxR5LtSU
	 Q06DlCreeP+JGGhXNR5qX9Z1e1Et7YONhMd9p9ZQGegPH5eOTIeHWbYJ6M8+uW/MK6
	 zIgIesWo96D1Tnch4y/1AQ8DAzOvTcezFjf5pPfGhe1mdNCO9j0shLP6Odrq+QGpXC
	 jOBx6Ka1CBCoHFy7VbJqHOG+xFZ5nrvihAreIaLAdCCNF6LFjsWaLTEcjOdzZ2lxt3
	 WwTPI7DKYWfxg==
Date: Thu, 25 Sep 2025 10:47:28 -0400
From: Sasha Levin <sashal@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: stable@vger.kernel.org
Subject: Re: Patch "firewire: core: fix overlooked update of subsystem ABI
 version" has been added to the 6.1/5.15/5.10/5.4-stable tree
Message-ID: <aNVWAHnX0KrUdNXV@laps>
References: <20250925113324.365642-1-sashal@kernel.org>
 <20250925140126.GA330521@workstation.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250925140126.GA330521@workstation.local>

On Thu, Sep 25, 2025 at 11:01:26PM +0900, Takashi Sakamoto wrote:
>Hi Sasha,
>
>As the commit message notice, this patch should not be applied to kernel
>v6.4 or before. I would like you to exclude this from your queue for the
>following versions:
>
>* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 5.4-stable tree
>* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 5.10-stable tree
>* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 5.15-stable tree
>* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 6.1-stable tree

Now dropped, thanks!

-- 
Thanks,
Sasha

