Return-Path: <stable+bounces-73087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD7496C0E4
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38248282C2F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AC61D04A1;
	Wed,  4 Sep 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RBrBjyh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4B29402;
	Wed,  4 Sep 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460728; cv=none; b=OkM5NIU6tt2ad5TOg7W6PRnz/+cS77a9RomUcZDQpLEdGhC5azekeExtTXqr2F88gTJaqFwrMRjB42PsSdIk68G/lcMKHOnlADVRv7NnAhCZ/xog2OlmpoPBCt//NLI8KPNF00LmAP0cnQj29EgfOnJ8j28T0BTRtGA2XLEje0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460728; c=relaxed/simple;
	bh=9g4bcMefx4VsRdPiJTfFO6ZuTbj1DZwo2hj9Ax6QLM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITIQ4gXY2T874kTeU4jzGgzjsS6DJMtTn+iH6rrdRRqPy550RfHOUH3UjK2oLgk5aRVitkRG0O79CiWGU4ksux2Sb6j6lMqL/NKlTj2FzKv3p6L+YuOK6VsOzToDcbmCkUDPWTZNi+SfS8gBkyYG1kxIRPhpgcP0CvZtk83Y1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RBrBjyh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E96C4CEC2;
	Wed,  4 Sep 2024 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460728;
	bh=9g4bcMefx4VsRdPiJTfFO6ZuTbj1DZwo2hj9Ax6QLM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBrBjyh08Wzp+hex91O3p0ELH4SLaumyVzpKuoFP5v0+M9hNql293QcKQnJHkls9W
	 ogpdYxNe8mf9Upihv17W16er3fFpXyvl50/x0k/JcmJYHovKYGkpNZrkDFym0aVskk
	 WMbzxCYlSfv/jZrGlZyEsSb03mACZJ5gLa5raN6w=
Date: Wed, 4 Sep 2024 16:38:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: validate event numbers
Message-ID: <2024090420-passivism-garage-f753@gregkh>
References: <2024083026-attire-hassle-e670@gregkh>
 <20240904111338.4095848-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111338.4095848-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:13:39PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 20ccc7c5f7a3aa48092441a4b182f9f40418392e upstream.
> 

This did not apply either.

I think I've gone through all of the 6.1 patches now.  If I've missed
anything, please let me know.

thanks,

greg k-h

