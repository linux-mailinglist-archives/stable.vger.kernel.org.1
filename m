Return-Path: <stable+bounces-171825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857EB2C9F2
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDA3B17B1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839028135B;
	Tue, 19 Aug 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ZIi7HtUf"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8A28466A;
	Tue, 19 Aug 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621917; cv=none; b=UNbNxIw6IKBe+Z5LHjCP/7vwU5d1CKlvpINKAXzi5KwWLq27yzz1heC1oaqJzjTB5RJN2u5cDgTCTLNYZ0l1FukvM4EtE8sptIxF9y6FYfd+0Dd/x3EgHokJUalt7Sc2tVjZbrju/vU+s4VNoDnJpmpN65sfntD6dXHAPe22qP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621917; c=relaxed/simple;
	bh=0W242zKCGO+KojvawkV50MvWjehAdpvYo9nlMbvRUKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFSoc1qbEz+ntdLHJ/XtiIoSv/XvmfFxy3vLkBsLxd1iC/blpXra3+SkroOdaSiGvB6vfAnah1Hn6EoeY107hAtdrAJzlc7xT21j8RjO9yM4nJfw4ZScwxHNTfhSfEUGDuSCVj0PB7M903N/bST+bIvrUASVP43E4Ay1PHkXjq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ZIi7HtUf; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.20])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6A5694028386;
	Tue, 19 Aug 2025 16:45:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6A5694028386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755621904;
	bh=1337loEO8MUNn10D9XiV0gPwVxSGBJFo6tLNowKy9l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIi7HtUf2AYTzpnLPyFJ0jL/5fXHjBwCmp7PTX2ACycfnWVPVQWcmjClstpECC9hf
	 a9fVAeAkwY0YTowUxvIsZFgb4VWCpHymTyl+uBa4yfsTnCIxT94YNREH1VnH/qyoLi
	 kSAcg7SVlF0FphB+EWojZU+1ym48Api4UaMw+//g=
Date: Tue, 19 Aug 2025 19:45:04 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	Melissa Wen <mwen@igalia.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hans de Goede <hansg@kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: fix leak of probed modes
Message-ID: <bbur73jxf7kubbtgdieflkjw5q4rxw5w4ztkgrozq3i4mrdjxh@r352gbxsso3s>
References: <20250817094346.15740-1-pchelkin@ispras.ru>
 <79a7f64c-4afa-441d-b1be-bab489174c7e@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79a7f64c-4afa-441d-b1be-bab489174c7e@amd.com>

On Mon, 18. Aug 21:17, Limonciello, Mario wrote:
> On 8/17/25 4:43 AM, Fedor Pchelkin wrote:
> > For what the patch does there exists a drm_mode_remove() helper but it's
> > static at drivers/gpu/drm/drm_connector.c and requires to be exported
> > first. This probably looks like a subject for an independent for-next
> > patch, if needed.
> 
> So you're saying this change will take two iterations of patches to ping 
> pong the code?
> 
> Why not just send this as a two patch series?
> 
> 1) Export the symbol drm_mode_remove()
> 2) This patch, but use the symbol.
> 

Initially I wasn't sure if the exporting patch was worth moving the code
around and in the end decided to make the current patch with a minimum of
prerequisites.

But giving this a second glance, I see exporting the symbol would be
technically better. I'll send out v2.

Thanks!

