Return-Path: <stable+bounces-73911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9D9707A4
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B3E1C21397
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76F165F04;
	Sun,  8 Sep 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZtBrN4Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3E165EE4;
	Sun,  8 Sep 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800391; cv=none; b=Thz7dtbw4FKjqtqxCKaEm96ldLiTlnHnKiPpxivwXK4B1FpzHzW6yfMrWqM1WCuMotTEoCsLw56SmMDXeJguDAgn0NYOaaaA6lMzvMZgPJo/RyLcuoo40/YC3CgbTjb5cbBWm13CAY52/F3xkHcPGI6P3YLj1kdS1GvqnlUsqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800391; c=relaxed/simple;
	bh=YhbRXnQ7EvIla3z4/eYbiKI7JBI6Gs+gMj9L+GFh4sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjKuNAnfZQkLK72VwKqTyYNChkt4RnPUbcktey3tZuTklKo2YXY3/hGLfi+xyZ5mJIDrfIiM3a01I4twc47bdJTk+YPcuK5h2OQxmIfQYXmeNsOYSMVdK9NIq35ql1mn0AtxtOdcgsTjNHSDEZEN0NmNWnSxd5vBIUX7rhNwD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZtBrN4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AEEC4CEC3;
	Sun,  8 Sep 2024 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800391;
	bh=YhbRXnQ7EvIla3z4/eYbiKI7JBI6Gs+gMj9L+GFh4sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZtBrN4ZrhaOMUqXBEWM6rYfy6dMhWXi5azbVVRiVwlh1Zbw43h9BiJOw72ZRrakL
	 772lKjiq+5QmvD52Xb/VaXt8yg07ykkGHgUXT0sSy1AcCntIIgRUHZVgMucm8CcYL8
	 Gqby4C6UQTM9gKycY8/qiwJumLsxImwofGL5+RCk=
Date: Sun, 8 Sep 2024 14:59:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mukul Sikka <mukul.sikka@broadcom.com>, stable@vger.kernel.org,
	evan.quan@amd.com, alexander.deucher@amd.com,
	christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
	Jun.Ma2@amd.com, kevinyang.wang@amd.com, sashal@kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Bob Zhou <bob.zhou@amd.com>, Tim Huang <Tim.Huang@amd.com>
Subject: Re: [PATCH v5.15-v5.10] drm/amd/pm: Fix the null pointer dereference
 for vega10_hwmgr
Message-ID: <2024090829-mutt-remold-6d2c@gregkh>
References: <20240903045809.5025-1-mukul.sikka@broadcom.com>
 <CADnq5_OVSD1DXgi_9f_H-uT7KSjMwz-FfhP=vRQvposSxv=BMw@mail.gmail.com>
 <CAG99D9Jss=h5aVLDq0tkDjfZgGUbrNV1gqwcw631RbwCiPVqNg@mail.gmail.com>
 <CADnq5_NWX7u=S+jrC8YA6fJxN7GXpSN+kqsQieqphdOz2HT6EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NWX7u=S+jrC8YA6fJxN7GXpSN+kqsQieqphdOz2HT6EA@mail.gmail.com>

On Fri, Sep 06, 2024 at 11:02:32AM -0400, Alex Deucher wrote:
> On Fri, Sep 6, 2024 at 4:50 AM Mukul Sikka <mukul.sikka@broadcom.com> wrote:
> >
> > On Fri, Sep 6, 2024 at 12:05 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > On Tue, Sep 3, 2024 at 5:53 AM sikkamukul <mukul.sikka@broadcom.com> wrote:
> > > >
> > > > From: Bob Zhou <bob.zhou@amd.com>
> > > >
> > > > [ Upstream commit 50151b7f1c79a09117837eb95b76c2de76841dab ]
> > > >
> > > > Check return value and conduct null pointer handling to avoid null pointer dereference.
> > > >
> > > > Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> > > > Reviewed-by: Tim Huang <Tim.Huang@amd.com>
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > Signed-off-by: Mukul Sikka <mukul.sikka@broadcom.com>
> > >
> > > Just out of curiosity, are you actually seeing an issue?  This and a
> > > lot of the other recent NULL check patches are just static checker
> > > fixes.  They don't actually fix a known issue.
> > >
> > No, according to the description of this patch and CVE-2024-43905.
> > It seems to be applicable to LTS.
> 
> I don't know that this is really CVE material, but oh well.  I'm not
> sure if it's actually possible to hit this in practice.

If it's not possible, there's no need to add the check.

thanks,

greg k-h

