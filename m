Return-Path: <stable+bounces-83217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A0996C4C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9FF2819E5
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133E198E7B;
	Wed,  9 Oct 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nsRoVCsk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A3194AE6
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481040; cv=none; b=iaskCvp07B1tQbCb7stAikqPAPV1n712oey2AOx8qtdEM2NqF/VB+cpoBcqx09td0Qa/bMhNo3W9tOVWoPjOjmttsvV8Vh8dcRaylYonIScVvc+Hawg7WBgPnjFmUZDe+R+EPB3Ilha2NgtJeHS21wBwHmQI9va1pf9wAZTvLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481040; c=relaxed/simple;
	bh=rHf4LbJE/9AUvUIEMS22AmRFc91+D48YaPbWkULlfQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn62pzmLQvURNzamDkrzSXCvopoHVjIyKGQlkjex5Kkd1reMWS60w1CB4lb7hr+oP5yGg/610au+UyZZz4vc+Mc4F4go6umCTB6jWt2AgwFfX2h/Vfj2GA+cm6rgfCuif50hoTIwnOiOcfOY1bWJF7NG3EwS2nG5Dqp3VBrw0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nsRoVCsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3B9C4CEC5;
	Wed,  9 Oct 2024 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728481039;
	bh=rHf4LbJE/9AUvUIEMS22AmRFc91+D48YaPbWkULlfQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsRoVCskiBoSPneGhLASeHY53xKW7gbmtg1jyrByPUOnHSamXpMd9D0TWWoPV7uu3
	 qLnx1DT/WGQkzibHlnSwbuZCi9OFpko0fA6ox3lBoCEvONi29B+X7TW+EWrq49HJOa
	 f0hyor1eWu3JOu/Y1fBcKvax7QrAULU1Xf+cy+nE=
Date: Wed, 9 Oct 2024 15:37:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: hsimeliere.opensource@witekio.com, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, Omar Sandoval <osandov@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5.10-v5.4] btrfs: get rid of warning on transaction
 commit when using flushoncommit
Message-ID: <2024100909-gullible-abridge-b8bc@gregkh>
References: <20241008105834.152591-1-hsimeliere.opensource@witekio.com>
 <2024100801-antics-bacterium-408d@gregkh>
 <20241008145802.GA1609@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008145802.GA1609@suse.cz>

On Tue, Oct 08, 2024 at 04:58:02PM +0200, David Sterba wrote:
> On Tue, Oct 08, 2024 at 01:06:10PM +0200, Greg KH wrote:
> > On Tue, Oct 08, 2024 at 12:58:34PM +0200, hsimeliere.opensource@witekio.com wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > > 
> > > commit a0f0cf8341e34e5d2265bfd3a7ad68342da1e2aa upstream.
> > 
> > Now queued up, thanks.
> 
> I haven't sent this patch to backport for < 5.15 because IIRC there were
> some other changes needed. I'm not sure this patch is on itself is
> sufficient to fix the warning and correct regarding the flushing logic.
> So this needs an analysis first, if someobdy really wants to get i to
> stable trees < 5.10. For now I suggest not to add it.
> 
> (For completeness, 5.15.27 and anything newer has the fix).
> 

Ok, now dropped, thanks.

greg k-h

