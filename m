Return-Path: <stable+bounces-160130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF6AF8344
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB09583486
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 22:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98728EA4D;
	Thu,  3 Jul 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBVvrw9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCF2DE6EE;
	Thu,  3 Jul 2025 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581399; cv=none; b=BF0MukctHwO30UcfTxMV+EPjrAJWs+LaFnFu3GzUM2H0KoJNIbKvcFvxxlZDWPaH/7AQi87iCOie9Kuw7SfEj8IhOp1hjvPTjTX7jEK6zhmfCky4eSWtrpiI5qk5/SDB4afWbAm4JWFhk4wmhz1ove2eb1s9hp2djqCcL223Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581399; c=relaxed/simple;
	bh=ULixMqe8zE18HaiGA3kO5pNPj1XU+rSCwUPkclXG43k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ola8df50vimjadG0Pfn4+jxGOzzgc5UcjKgk/Al7JGW2reakpZ8AB3efBKUTJONRlQAzzq49thOl7e/BLEBUKxWorBVpkFjkONqJvntw+uQiwRAhwi3JEXTRZWhtAbf9tUeu99Gx6FmK5hxlXvdAsFcE/a9dU2KOQoYrblqV1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBVvrw9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40521C4CEE3;
	Thu,  3 Jul 2025 22:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751581396;
	bh=ULixMqe8zE18HaiGA3kO5pNPj1XU+rSCwUPkclXG43k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QBVvrw9Wlj0JgDqMN4Yx6QiAdGpEgKi5x0GTUq5wrEcQLvgnK+0jGE4dFwvuPpDqq
	 6qU8YvcQ+lB+xU/mROMwmrF1o1KTNceLWA5olddXOrwmSKpoWTDzJrZWqVqSNfzKFu
	 f3TeSpq/F6O3UqwE6W6b0YNxgXNZED0bxGqdlnvFZ5+JZv8IeyHpRJwj051VUZtx6z
	 TFK9Ju8KHAqB0GpoDQgatgSWDcilBt9dbtLAk9eiMvs60HoJlEgIXkQrBewCGafCCa
	 cyjLSezn9mL4t+Ed3Qee33NgxYNExKhKDNsNxGNv1yO7U7e87KAVv95+6lAdVVktGy
	 cO9dVgAYqqq+w==
Date: Fri, 4 Jul 2025 00:23:11 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Aaron Thompson <dev@aaront.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Timur Tabi <ttabi@nvidia.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: Do not fail module init on debugfs errors
Message-ID: <aGcCz5VU1lbi_ZxD@pollux>
References: <20250703211949.9916-1-dev@aaront.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703211949.9916-1-dev@aaront.org>

On Thu, Jul 03, 2025 at 09:19:49PM +0000, Aaron Thompson wrote:
> From: Aaron Thompson <dev@aaront.org>
> 
> If CONFIG_DEBUG_FS is enabled, nouveau_drm_init() returns an error if it
> fails to create the "nouveau" directory in debugfs. One case where that
> will happen is when debugfs access is restricted by
> CONFIG_DEBUG_FS_ALLOW_NONE or by the boot parameter debugfs=off, which
> cause the debugfs APIs to return -EPERM.
> 
> So just ignore errors from debugfs. Note that nouveau_debugfs_root may
> be an error now, but that is a standard pattern for debugfs. From
> include/linux/debugfs.h:
> 
> "NOTE: it's expected that most callers should _ignore_ the errors
> returned by this function. Other debugfs functions handle the fact that
> the "dentry" passed to them could be an error and they don't crash in
> that case. Drivers should generally work fine even if debugfs fails to
> init anyway."
> 
> Fixes: 97118a1816d2 ("drm/nouveau: create module debugfs root")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Thompson <dev@aaront.org>

Applied to drm-misc-fixes, thanks!

