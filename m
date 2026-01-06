Return-Path: <stable+bounces-205098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B5CF8F4B
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2C0C3010E4B
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9380432470D;
	Tue,  6 Jan 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yaNcAG8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4A324B10
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711448; cv=none; b=W7ms/y1NuazE5rkgUg7X7HD/tShf9/xxI8Ajil6BzNV2VVW5jrBrW9uDb6YCrFrDS6qMzjBDLHuInkDbWcj2c2FDTViC8P3PihuR0L6QE/W0iKHOaSiQiE65mtHpgMnPBG/wKYvg/8MEEAfj2GssBXkqPH641Z+nenQd85vhiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711448; c=relaxed/simple;
	bh=WfpVBCf45szuIzqVDLrzIlGbVc/JZamiEE00cfCy3Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxlyyXbG6ejaXPcU1rMcc5NyUmaGz0wGv8cUSSeGIJnZuWRO69lOBEQd7vSbRKs9GDAX3S1HNOTm1oW21Y50JJaiudgelDKfJ33eHBLBBFVkUuZFOK+Jt9ROybTBiV0gJTuJWvmv5h9h0iKDaAPCc6SNy65vMNXMmi28S9a3rAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yaNcAG8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8B6C116C6;
	Tue,  6 Jan 2026 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767711448;
	bh=WfpVBCf45szuIzqVDLrzIlGbVc/JZamiEE00cfCy3Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yaNcAG8O36EHlnD7qcmHfJ6dU1NNB88Wqvx/4vJOFphaM/FqntfAtXyfU0kCMOYkZ
	 sGqsh8DPlqaSPgJszn6ukw1JNJZBz5XBcRe9Grj9KHvK42wPbMlC7GmtRAuiY+NbFu
	 1HMMB6dBUkNJdI6+ZC96/psZBNHBiIxbzxBPUukQ=
Date: Tue, 6 Jan 2026 15:57:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: JP Dehollain <jpdehollain@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Fwd: Request to add mainline merged patch to stable kernels
Message-ID: <2026010604-craftsman-uniformed-029c@gregkh>
References: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
 <2025122303-widget-treachery-89d6@gregkh>
 <ME6PR01MB1055749AAAC6F2982C0718687AAB5A@ME6PR01MB10557.ausprd01.prod.outlook.com>
 <CAH1aAjJjxq-A2Oc_-7sQm6MzUDmBPcw5yycD1=8ey1gEr7YaxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1aAjJjxq-A2Oc_-7sQm6MzUDmBPcw5yycD1=8ey1gEr7YaxQ@mail.gmail.com>

On Thu, Dec 25, 2025 at 08:55:30AM +1100, JP Dehollain wrote:
> Hi Greg, thanks for looking into this..
> The full commit hash is 807221d3c5ff6e3c91ff57bc82a0b7a541462e20

That commit fails to build on the 6.12.y kernel tree, so how was this
tested?

thanks,

greg k-h

