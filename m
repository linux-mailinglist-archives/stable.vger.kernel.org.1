Return-Path: <stable+bounces-177741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D88B43FAE
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E9B18867C6
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38613002A8;
	Thu,  4 Sep 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CQGNHMv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236C20B1F5;
	Thu,  4 Sep 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997644; cv=none; b=q55RGzU8rXTtNPr2pW12DVqCN4Jpjh7og3nbh11v06oUSjUTmwzx980M79xmSgTg/2WpriTS5R0lsoYq6lX0qSm5sgd0dJNOOemqhNSQ8Qs2leVd0Pqi7bgwL8ZldEgJ0ZzRGlW5dIgRmfFDRzUkm51H1c61yN5NUDVXXEKtrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997644; c=relaxed/simple;
	bh=RI2yQ57CB6QB/+3SX//E7/NThA9cpWIY2eAjCWZ1XTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6Jpfs7pReiAHLmcojbUsFCLhD9OFc22dYQo613kaswQpRzUIs8GFncrfQpWIKquCD3TnfI1sfQs3BShrhPpbCND73IaKeD9s7xqEvRfBOTeLxJFyYaRHx4eqcYL4MyuiYUuBXWQZXiFaBzPMUEKyNwMjo64JvHC92gx6yWl1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CQGNHMv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F97C4CEF0;
	Thu,  4 Sep 2025 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756997640;
	bh=RI2yQ57CB6QB/+3SX//E7/NThA9cpWIY2eAjCWZ1XTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQGNHMv0fP0+ziM899i7HdVk9ES0am2pkNde+m6GIZzRqZBuzKQJ06/9mlURm/W5Q
	 JrctAt/3EZXRqEzNSY4yAWEZkRtWSMGcyEu9qzi51utgnnT6T+nf+cc9xsp7rQKav8
	 +QlqA1hA2B1gOGB60qH252zNO/+NrpK2+IBNvZvQ=
Date: Thu, 4 Sep 2025 16:53:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"Lazar, Lijo" <Lijo.Lazar@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: Patch "drm/amdgpu: Add more checks to PSP mailbox" has been
 added to the 6.16-stable tree
Message-ID: <2025090426-strongly-t-shirt-6c00@gregkh>
References: <20250817133749.2339174-1-sashal@kernel.org>
 <BL1PR12MB5144B138DAAF8ED71C913DE4F700A@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144B138DAAF8ED71C913DE4F700A@BL1PR12MB5144.namprd12.prod.outlook.com>

On Thu, Sep 04, 2025 at 01:26:38PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Sasha Levin <sashal@kernel.org>
> > Sent: Sunday, August 17, 2025 9:38 AM
> > To: stable-commits@vger.kernel.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter
> > <simona@ffwll.ch>
> > Subject: Patch "drm/amdgpu: Add more checks to PSP mailbox" has been added to
> > the 6.16-stable tree
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     drm/amdgpu: Add more checks to PSP mailbox
> >
> > to the 6.16-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      drm-amdgpu-add-more-checks-to-psp-mailbox.patch
> > and it can be found in the queue-6.16 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree, please let
> > <stable@vger.kernel.org> know about it.
> >
> 
> 
> Please drop this patch for 6.16.  It's not for stable and causes regressions on 6.16.

It was in the 6.16.2 release that happened on August 20.  Please send a
revert?

thanks,

greg k-h

