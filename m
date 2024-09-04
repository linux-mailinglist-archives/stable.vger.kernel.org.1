Return-Path: <stable+bounces-73077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3596C0B7
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB291F21675
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F31E871;
	Wed,  4 Sep 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bizk5x63"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDC1DC195;
	Wed,  4 Sep 2024 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460426; cv=none; b=lg2hsYzp3nVjjpu85kIVEmnrhxU8ZeT0tcTndr97Svt5fSYb4FNnleoKaKtLLuiQ5BdWk5yZ2h8mI9hx1QhyATZ58V5b17PPIvPRv2vOMaVdJ4pxxtcWZ0ZNojG0qbRWMFzuYufZjWX87Oz1wQVgRAf/DSru1jAUFPznRxd/4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460426; c=relaxed/simple;
	bh=a5RZYCY4o6+wka4pwLRyGyNJmZM36bUGoF96kRnY3p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BorpSrIwezVyPivfcXthQHGVrFvs7nN7mR3dFH3eT/qz4P8IicPc8ChNlNHZsuuLHQmZyJLngewfZWjeFClPiyATQFszkXMtUMVuj0Ue+XDthDwF3AHYIAbbmKVzAI9e0eOIqWDTKs4dorlf4ePO8vh9KBWKYiX98/SJk7VUoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bizk5x63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE76C4CEC6;
	Wed,  4 Sep 2024 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460426;
	bh=a5RZYCY4o6+wka4pwLRyGyNJmZM36bUGoF96kRnY3p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bizk5x63FRWl/N4ft6kjYoAjk2bLMUeCWkcf8Qdvkgr7gM+C8hOZQWeHUbaGTtktS
	 aHooD+DAnDvFcfcXkMYMv7mANyvhFEC39BJ4g+nerThrrqz0fxZx1VlCh4yQT6R5rZ
	 DjNT2dtH/3TO38BtBbfeF3cNzFqEUMhpZEty4WiM=
Date: Wed, 4 Sep 2024 16:33:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.1.y 1/2] selftests: mptcp: add explicit test case for
 remove/readd
Message-ID: <2024090409-thrash-study-8fca@gregkh>
References: <2024082618-wilt-deafness-0a89@gregkh>
 <20240904110611.4086328-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110611.4086328-3-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:06:12PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit b5e2fb832f48bc01d937a053e0550a1465a2f05d upstream.
> 

Applied

