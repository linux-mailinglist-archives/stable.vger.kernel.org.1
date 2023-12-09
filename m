Return-Path: <stable+bounces-5115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B850780B413
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C4E281026
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72414273;
	Sat,  9 Dec 2023 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SrySE21X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEF748C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 11:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF8FC433C8;
	Sat,  9 Dec 2023 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702123116;
	bh=bUkcbYm3WxckF21AIuPjIRLSkA5yfXmJno+EKnsiAfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrySE21XH8rQ/QG0wSUdjiCugzs39zZOj3cxkHO2ma4qAEy1X9ocv9rICCfIoJQUV
	 vzHN0n6Z6zP5teEThatUsvnNE4mjhRzHaOpqokZbkqEOBsO+YD2hoM1jSbS44U2C5E
	 MrEmJCvdPSpT35uImmqqQOEY8NALK0RSZ9/ocmsU=
Date: Sat, 9 Dec 2023 12:58:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kovalev@altlinux.org
Cc: devel-kernel@lists.altlinux.org,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 1/1] Revert "drm/edid: Fix csync detailed mode parsing"
Message-ID: <2023120959-unloader-empower-4dc2@gregkh>
References: <20231206084946.111835-1-kovalev@altlinux.org>
 <20231206084946.111835-2-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206084946.111835-2-kovalev@altlinux.org>

On Wed, Dec 06, 2023 at 11:49:46AM +0300, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> This reverts commit 5a46dc8e4a064769e916d87bf9bccae75afc7289.
> 
> Commit 50b6f2c8297793f7f3315623db78dcff85158e96 upstream.
> 
> Commit 5a46dc8e4a0647 ("drm/edid: Fix csync detailed mode parsing") fixed
> EDID detailed mode sync parsing. Unfortunately, there are quite a few
> displays out there that have bogus (zero) sync field that are broken by
> the change. Zero means analog composite sync, which is not right for
> digital displays, and the modes get rejected. Regardless, it used to
> work, and it needs to continue to work. Revert the change.
> 
> Rejecting modes with analog composite sync was the part that fixed the
> gitlab issue 8146 [1]. We'll need to get back to the drawing board with
> that.
> 
> [1] https://gitlab.freedesktop.org/drm/intel/-/issues/8146
> 
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8789
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8930
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9044
> Fixes: 5a46dc8e4a0647 ("drm/edid: Fix csync detailed mode parsing")
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.4+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20230815101907.2900768-1-jani.nikula@intel.com
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
>  drivers/gpu/drm/drm_edid.c | 26 +++++++-------------------
>  include/drm/drm_edid.h     | 12 +++---------
>  2 files changed, 10 insertions(+), 28 deletions(-)

You sent this 3 times, why?  And what tree is this backport for?  It's
already in the respective stable releases, right?

confused,

greg k-h

