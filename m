Return-Path: <stable+bounces-136545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C808A9A84E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E067AF40C
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020E2248B8;
	Thu, 24 Apr 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWCGj3TI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE592701AA;
	Thu, 24 Apr 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487123; cv=none; b=iMc5kQsv7arIvS3+n6u5v9F5liDwe/lnnAwt7t//qdMviRizhJv2LZTcgpAB5b+JC4nQt1c0DC9F1vTQNk9ZZ+HRz12imK93rftr4RaUZGmuGdI01s1wSJDcaDkpCxBlvXXRKh7D0Zx0sHwuwK2mWBVCbnNhbOUD8G4VaA1Pvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487123; c=relaxed/simple;
	bh=hopxTHnFC8sGN3zQvrY3HTYcpbxbAukg62AeOuCEZ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9eEFGiQwFjH+OtayrQTRsK3xpPSwFNdIKapRla8CPuKFpqbqC+yiLEeuQZeFAALSuir091HS56IwQlHfsYhs0YOvFA9lbM6OSuh1jlP2V7dPjDi22BJfq598Zx/CEG9LwO9dbNYGF5VhzigiPwQcHRkiFL+oTinM9Cr7l95SiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWCGj3TI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5313C4CEE3;
	Thu, 24 Apr 2025 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745487123;
	bh=hopxTHnFC8sGN3zQvrY3HTYcpbxbAukg62AeOuCEZ4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWCGj3TIPyNBpMDGAJMHzXrNpQhxmdhwS/2DBl4zHIEtt0p/5ZhRUXssoGo9W80xO
	 7U5gw0Te+xMI5UO65MRSUYnaEYjWF++3AcbclhZ/JvO3pLxRLdQ2K+gdnCgFJgIIlI
	 HYpN4PnC+2xuNyy+fi4FrvcMXSo0VFNyro/84LCE=
Date: Thu, 24 Apr 2025 11:32:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: ffhgfv <xnxc22xnxc22@qq.com>
Cc: stable <stable@vger.kernel.org>, peterz <peterz@infradead.org>,
	mingo <mingo@redhat.com>, acme <acme@kernel.org>,
	namhyung <namhyung@kernel.org>,
	"mark.rutland" <mark.rutland@arm.com>,
	"alexander.shishkin" <alexander.shishkin@linux.intel.com>,
	jolsa <jolsa@kernel.org>, irogers <irogers@google.com>,
	"adrian.hunter" <adrian.hunter@intel.com>,
	"kan.liang" <kan.liang@linux.intel.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Potential Linux Crash: WARNING in release_bp_slot  in
 linux6.12.24(longterm maintenance)
Message-ID: <2025042429-certainly-quarters-f699@gregkh>
References: <tencent_B50959BC76205E0AE666AE21F7A07D017306@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B50959BC76205E0AE666AE21F7A07D017306@qq.com>

On Thu, Apr 24, 2025 at 03:50:53AM -0400, ffhgfv wrote:
> Hello, I found a potential bug titled "  WARNING in release_bp_slot  " with modified syzkaller in the  Linux6.12.24(longterm maintenance, last updated on April 20, 2025).
> If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>,Penglei Jiang <superman.xpt@gmail.com>

As you have a reproducer, you are in the best position to create a fix
for this as you can test it.  Please do so, such that you can get credit
for resolving the issue.

thanks,

greg k-h

