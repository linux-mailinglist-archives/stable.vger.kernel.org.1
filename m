Return-Path: <stable+bounces-73069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BAA96C0A3
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5BE28AF31
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F31D9333;
	Wed,  4 Sep 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDG8MBK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE95C96;
	Wed,  4 Sep 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460299; cv=none; b=b2NcQ082cfE5Jfam1ByGlOSOYAJ0U4rWpt/VBbBuor6OK+a5DiEJ9RAFVshdfBuc3rQsQFN7FWXe8SSBbZNRO/fxPAVZXjhF0JlZLY0JAMIXffsgXkVzjrK6cD9UWAQrMO46WQxu0m5b2x2QNnNYL6jDjZYjpYG5d4GqO9sgjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460299; c=relaxed/simple;
	bh=6pWz89gPOGurkljqbR07bbUOtzO8rhm0Go2YrhJWUH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPPCVwncdslYY0oEIGd5z3aT1CknFO6SzPx2OHEpTxEyWKjR7xl2dKkNJExJ3Nm7Zr3FUHhG9jSQCl6GlyPbc0WeDLGfbLUnaiIByiGaGWG52Iqz4yR+2SRZ7YDEC+Xti+YzaL117buqvwIWiaW+gFEGKar9TV3KVsjY2LcptyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDG8MBK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051D8C4CEC2;
	Wed,  4 Sep 2024 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460298;
	bh=6pWz89gPOGurkljqbR07bbUOtzO8rhm0Go2YrhJWUH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDG8MBK1YhQZ8ohEaAYI3rbTEWeUQguRaf5Fd9dZeMj3ypZMhDJOXxTAJD6My3E1k
	 8OXiXSlAUh9J4SaJzUNTSGVBr8HkrhxJPzl/t18IjMeVozbtLgFlSfLmIQ6UyzTYsy
	 KucYuUB+5E983mu0ligjR8F5H1jmnhiDx3ObsUqQ=
Date: Wed, 4 Sep 2024 16:31:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: validate fullmesh endp on
 1st sf
Message-ID: <2024090431-shrewdly-plaything-fb44@gregkh>
References: <2024082645-hurled-surprise-0a7c@gregkh>
 <20240904110430.4084188-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110430.4084188-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:04:31PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 4878f9f8421f4587bee7b232c1c8a9d3a7d4d782 upstream.
> 

Applied.

