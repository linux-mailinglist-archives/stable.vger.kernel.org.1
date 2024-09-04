Return-Path: <stable+bounces-73082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323396C0C1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E3C1C2526C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6FC1D014A;
	Wed,  4 Sep 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YvYtZdFi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF463D;
	Wed,  4 Sep 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460576; cv=none; b=SxVqiDAGhrhyxWhhfovD3XpYXEZO6gLmkTaHCKgUP2ZEKFs81NYZ4Wvdlv1mKBCWT0xUef9uOjAsYBvQ1xSQtCasPZhKxYRFanrPLhYXJeK2VVsq0YFf6jdI6rvdtBRYeBeazRHfZblm4/yKl35DI8ik/llrvVUIcrcQeb4iTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460576; c=relaxed/simple;
	bh=9ixwuu6wBRkIckFLNZCWRTRo0B5HAUeq4nt82Yn5jQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpsYTV4zsEbfWssow89tTAY5qjikkg69fggBD4K6sIOyX0OW+K10dBkCWdvm3cuxK/lnUGBF91c0E9qKeU3Uwgxf431dw1r35taOntARPeicjWbykNV5bfxVWbVl1TPBAkNJKoylaG5tzPGYJVA4Wt+yd0frMlv7WfquFj0JDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YvYtZdFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D362FC4CEC3;
	Wed,  4 Sep 2024 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460575;
	bh=9ixwuu6wBRkIckFLNZCWRTRo0B5HAUeq4nt82Yn5jQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvYtZdFiYfeuJNKPNoVLl2y2Va8YoCILyV/kdk/BdoWNHWPO7RbUm3Aft6s3juMLn
	 tqCvIbU6SM0aapeLShdYiSISD4VvbGmgps9ZPuPw3ukgrR65rBuazEgKr6XchXELuA
	 vQxJDbaLsYwWCRuUfEiiCIuA7+KQuuWJu0s6av8Q=
Date: Wed, 4 Sep 2024 16:36:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: no extra msg if no counter
Message-ID: <2024090408-mortify-yearly-c5ef@gregkh>
References: <2024083033-mounting-headsman-336e@gregkh>
 <20240904111233.4094425-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111233.4094425-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:12:34PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 76a2d8394cc183df872adf04bf636eaf42746449 upstream.

Applied

