Return-Path: <stable+bounces-91905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6779C183C
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 09:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A8282ADF
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717E1DF271;
	Fri,  8 Nov 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="d0LMu0C3"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719631401B;
	Fri,  8 Nov 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055295; cv=none; b=ZNN9mIxJCpb1MGQebs/91EaMt14qF2EJ0qI+t5dlzNiUBfro/qOFThnEHRDe8P5UGaZDeHG+2rfqX9Do7mGgzJm0lMmkbie2bf+VrKPBgeF9AdGs8vCMoM45KWyt8bETG4jJgVuYDy4Kp5+FHkd0fw7K1rtIPgCa27btmDZAFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055295; c=relaxed/simple;
	bh=OsFRds6OPpoG8AA7rFEzaKv1H/MG7E4kD2sLMLACbRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu7PwcW2p/ulIbeeDfI75QYHLnVBWAxiaoRQ6ROeTir0QYHu89ldDH4qNaZMibtaj2Ec+x/0hBgMGlag7xoGdu6WazYdIMnrSkCxwsUaM44zFKgBZABL0NYjh4r84eObm/ACyuexs+JOPm9uZ3Pns7p9u4+MqJRSnWLHshmxihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=d0LMu0C3; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6EE4440777D1;
	Fri,  8 Nov 2024 08:41:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6EE4440777D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731055282;
	bh=Uk80vGjgWp6Fxep+YeO772imLKH4td0IcPsl8vw7KAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0LMu0C3eBPV8ZPaCpCjBnvgJlwo0yDarLXsnswskz4BDfMTQCn6q8+4zx2fsnE3m
	 wxEJ7s6HsIn2zmQW9uw0wI0wvnluMUkN7R/u+4Xq4R52obqrQj4FZHDw7QiMiNEqeR
	 QIK+lxvTMkjBamAUHslZdW2CSKnjEajbmdlwceDo=
Date: Fri, 8 Nov 2024 11:41:18 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>, Wayne Lin <wayne.lin@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jonathan Gray <jsg@jsg.id.au>
Subject: Re: [PATCH 0/1] On DRM -> stable process
Message-ID: <20241108-267fb65587d32642092cea40-pchelkin@ispras.ru>
References: <20241029133141.45335-1-pchelkin@ispras.ru>
 <ZyDvOdEuxYh7jK5l@sashalap>
 <20241029-3ca95c1f41e96c39faf2e49a-pchelkin@ispras.ru>
 <20241104-61da90a19c561bb5ed63141b-pchelkin@ispras.ru>
 <2024110521-mummify-unloved-4f5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024110521-mummify-unloved-4f5d@gregkh>

On Tue, 05. Nov 07:57, Greg Kroah-Hartman wrote:
> On Mon, Nov 04, 2024 at 05:55:28PM +0300, Fedor Pchelkin wrote:
> > It is just strange that the (exact same) change made by the commits is
> > duplicated by backporting tools. As it is not the first case where DRM
> > patches are involved per Greg's statement [1], I wonder if something can be
> > done on stable-team's side to avoid such odd behavior in future.
> 
> No, all of this mess needs to be fixed up on the drm developer's side,
> they are the ones doing this type of crazy "let's commit the same patch
> to multiple branches and then reference a commit that will show up at an
> unknown time in the future and hope for the best!" workflow.
> 
> I'm amazed it works at all, they get to keep fixing up this mess as this
> is entirely self-inflicted.

Thanks for reply, I get your remark. DRM people are mostly CC'ed here,
hopefully it won't be that difficult to tune their established workflow to
make the stable process easier and more straightforward.

As of now, would you mind to take the revert for 6.1? It's [PATCH 1/1] in
this thread. No point to keep it there, and the duplicated commits were
already reverted from the fresher stable kernels.

