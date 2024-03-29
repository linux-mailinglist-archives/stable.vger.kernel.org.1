Return-Path: <stable+bounces-33447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AD4891C5C
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAC2288D1B
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF98185236;
	Fri, 29 Mar 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/Aa3pIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042D185230
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716124; cv=none; b=W+f/SKYkKWoQvfrJNZEL8iK08dEyBgkY0omSWH2Kb06sUMrg2rfzMwyVPNMyQh8e/rvFWGDnXSy/NhgNNeDRAjo5zU3dfN6LpQovH5UA8ap4SoRseMIda8SPx/9ObS7xg85kfTe1GI+0yPm8UWLKwhgyCosvIgEw77n0EaXyn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716124; c=relaxed/simple;
	bh=8dDsvaWmejQv5mi73WI03Xf5IEP7Y0Cx8SLYl4dh3OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4bYHk5Gb6ebSG3vOMlazt7vO84a5elyTCcxXTDsIvqQarfQiDZjQc9ctZPs/waSUVoFCgR4QkYTVrn1YAxPnF0gAaBjQGkqJB0fDhyVqmUP28TrHXkQzJZ87WWOog+W2He84SYIlGq19xWGXXR2C/+I0cTbQ2pT4G63f6Aa9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/Aa3pIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173D9C43394;
	Fri, 29 Mar 2024 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711716124;
	bh=8dDsvaWmejQv5mi73WI03Xf5IEP7Y0Cx8SLYl4dh3OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y/Aa3pIJ6JIElHaYRPW6zWwRaw6XqEInNfF05/8pxp4WaukrZSIdkFH7mtZH7tAGy
	 0urNN5y6TYrP0bQgrtt9A3OmaFVs0LgCcU+0VpPez3PEry8g1EAZ0f6F++a19jTG/i
	 b2q6nBRCZSsua8tWn3BMEkbacRchFAJZ0I3qsD8I=
Date: Fri, 29 Mar 2024 13:41:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 5.15.y v2 00/11] Delay VERW + RFDS 5.15.y backport
Message-ID: <2024032923-casket-registrar-a962@gregkh>
References: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>

On Tue, Mar 12, 2024 at 02:10:34PM -0700, Pawan Gupta wrote:
> v2:
> - This includes the backport of recently upstreamed mitigation of a CPU
>   vulnerability Register File Data Sampling (RFDS) (CVE-2023-28746).
>   This is because RFDS has a dependency on "Delay VERW" series, and it
>   is convenient to merge them together.
> - rebased to v5.15.151

Now queued up, thanks.

greg k-h

