Return-Path: <stable+bounces-151310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB90ACDA79
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 11:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAF5173D89
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD628C849;
	Wed,  4 Jun 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GDL3iS1j"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2A28C5A1
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027782; cv=none; b=MuGpJrXPrnclbVWmKgnoT3RACGhEVjT7ha+9sDHAEtUsOiG/vU4nF+zr2C3h38vthjxWdsh+kRqsPmvlrEj5wqolt3mX4mQhx15AFs8+BvoqTyQb15WAuGCLAJAnPwJAI6xJy+OVs6EFJWQrOpx3pmR0p5OjfUeMw0rf7tJrOxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027782; c=relaxed/simple;
	bh=CoQ2oPycx3vh52+agnKYGvJyBR+SJ/Eg1jXsNpHVIyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEWPJF+oRpJiio71CgP1+edR98xH2NWR7hS/f4QecfuhsAweCHu8GP2mBdBIsc/B/nEigiaQM+FGgGk3iKpfuUM2Xoomar78/PPeuapFxCPUpkpCfdaebYmZjZfccVpn+sxSxfj2TRWwjnJ56D9EPy1vEbFekewDmSUk6jWYBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=GDL3iS1j; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad51ba0af48so135489066b.0
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1749027779; x=1749632579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWXCxfPn5mxMyAc/RvJYvkJY+WkXczRM7a4xRFzAqfc=;
        b=GDL3iS1jlIihoXGzQ2/CNjs4Vn1Bq4QhfHzEezc9nPV61fKkSkdgD/wGU/4o/vpzuR
         zhYXdGD2t7coTqvn1W3RHsYeb1SXBprDFqXFQt15K5rKEPdB3XkQz0O9U9RP/p82vDdI
         8SqilzKdT+X7NJqYIKeZzbdXlMHtt9B1QXRGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027779; x=1749632579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWXCxfPn5mxMyAc/RvJYvkJY+WkXczRM7a4xRFzAqfc=;
        b=XuAlhR/uPhcYiu6t38nhztYo9ReMGrNnX54oB9cdHGL+dLDGNKEQowy0I57s3LzvIs
         FcTet8pihvgpCAA1wCPz+1gbsyaTkgKN/Jh0YyzotAXLIeIQBYLd6yyfBDFrxxOapvNQ
         FGpKsPSoTz93XFB5tFE73MpdF/0cfIRKRTI8KqllWOJJILR/FFDxn2U8CDYhS0di/q3f
         gnmlVTwIE8VvRYkdkDext8BPVpsLWAA6osrmEUM+ZJrN0n2xy/RFGIl25uFiJx2sRWt1
         DzfeiFg0tJ/577doIqwefwNmcPPFGmpBvV9Iawbj+mxeGyZxszwRDwkEpzG6kz+bA1PR
         BJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkEz68IcJ2mQAn/lfxoLYV5YYKuTRMG77FfXan3dcCbZMDwirkhMEUkMnvTUScOobSUcqBr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhcu/7JrBSM1Xc8Ml+ky1OT6ytVkqrUuO+m5zE/kla1c95GEDR
	JeDnDdyNfU6j6dv0jB9ccL93s2i6zHi2695I63ZUx4cGmi5aLhe2A0g0v+Rlie9V5RI=
X-Gm-Gg: ASbGncveY/9xDf8vKAs6XsUxTFjdE9TUftxMY/ggliJP/4E6+DO0KA6XEroHe7vXe/e
	Vp9jf7xr6J0fLGHxqIWmE2xOqsZOnC2YQ/HWJFMZns15ixkMSI2tDjwXUJ0n5wbuoAD2wBGmdtC
	FKeQXxG4S0IEQOpwlNhzeK0TjPIbbnfAgpFYkMj/wuzg8dOHwCmXuVxvhIPh0uk+jQMrN49nsrz
	4OIaixJenYJxEFrgqgg5rj+oatkBrNmFueCYuWKfLjQMQm71puZtYxiOrB0X2Eq8arYkJXL+v4u
	p+D6rFCRKcTYiDnq76Bhij4rSg7QsPFmLmGS1gtUm06ps+CCiR1Gnl3uXSExq54=
X-Google-Smtp-Source: AGHT+IEsJ97eDX1ULIm8eXkHndMHDh6m9SOTcFVQvV2ShGufPJtYbcCaZ0sz612r1GZStWeNAsIcRg==
X-Received: by 2002:a17:907:7284:b0:ad5:7048:5177 with SMTP id a640c23a62f3a-adde5fe14camr526806866b.23.1749027777891;
        Wed, 04 Jun 2025 02:02:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd045c8sm1074517766b.103.2025.06.04.02.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:02:57 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:02:55 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	intel-xe@lists.freedesktop.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@intel.com>
Subject: Re: [PATCH 1/8] drm/gem: Fix race in drm_gem_handle_create_tail()
Message-ID: <aEALvw-H8OmCnNWD@phenom.ffwll.local>
References: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
 <20250528091307.1894940-2-simona.vetter@ffwll.ch>
 <2e60074d-8efd-4880-8620-9d9572583c88@suse.de>
 <aD7gcvEaZzoDRRc1@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD7gcvEaZzoDRRc1@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.12.25-amd64 

On Tue, Jun 03, 2025 at 01:45:54PM +0200, Simona Vetter wrote:
> On Mon, Jun 02, 2025 at 05:15:58PM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 28.05.25 um 11:12 schrieb Simona Vetter:
> > > Object creation is a careful dance where we must guarantee that the
> > > object is fully constructed before it is visible to other threads, and
> > > GEM buffer objects are no difference.
> > > 
> > > Final publishing happens by calling drm_gem_handle_create(). After
> > > that the only allowed thing to do is call drm_gem_object_put() because
> > > a concurrent call to the GEM_CLOSE ioctl with a correctly guessed id
> > > (which is trivial since we have a linear allocator) can already tear
> > > down the object again.
> > > 
> > > Luckily most drivers get this right, the very few exceptions I've
> > > pinged the relevant maintainers for. Unfortunately we also need
> > > drm_gem_handle_create() when creating additional handles for an
> > > already existing object (e.g. GETFB ioctl or the various bo import
> > > ioctl), and hence we cannot have a drm_gem_handle_create_and_put() as
> > > the only exported function to stop these issues from happening.
> > > 
> > > Now unfortunately the implementation of drm_gem_handle_create() isn't
> > > living up to standards: It does correctly finishe object
> > > initialization at the global level, and hence is safe against a
> > > concurrent tear down. But it also sets up the file-private aspects of
> > > the handle, and that part goes wrong: We fully register the object in
> > > the drm_file.object_idr before calling drm_vma_node_allow() or
> > > obj->funcs->open, which opens up races against concurrent removal of
> > > that handle in drm_gem_handle_delete().
> > > 
> > > Fix this with the usual two-stage approach of first reserving the
> > > handle id, and then only registering the object after we've completed
> > > the file-private setup.
> > > 
> > > Jacek reported this with a testcase of concurrently calling GEM_CLOSE
> > > on a freshly-created object (which also destroys the object), but it
> > > should be possible to hit this with just additional handles created
> > > through import or GETFB without completed destroying the underlying
> > > object with the concurrent GEM_CLOSE ioctl calls.
> > > 
> > > Note that the close-side of this race was fixed in f6cd7daecff5 ("drm:
> > > Release driver references to handle before making it available
> > > again"), which means a cool 9 years have passed until someone noticed
> > > that we need to make this symmetry or there's still gaps left :-/
> > > Without the 2-stage close approach we'd still have a race, therefore
> > > that's an integral part of this bugfix.
> > > 
> > > More importantly, this means we can have NULL pointers behind
> > > allocated id in our drm_file.object_idr. We need to check for that
> > > now:
> > > 
> > > - drm_gem_handle_delete() checks for ERR_OR_NULL already
> > > 
> > > - drm_gem.c:object_lookup() also chekcs for NULL
> > > 
> > > - drm_gem_release() should never be called if there's another thread
> > >    still existing that could call into an IOCTL that creates a new
> > >    handle, so cannot race. For paranoia I added a NULL check to
> > >    drm_gem_object_release_handle() though.
> > > 
> > > - most drivers (etnaviv, i915, msm) are find because they use
> > >    idr_find, which maps both ENOENT and NULL to NULL.
> > > 
> > > - vmgfx is already broken vmw_debugfs_gem_info_show() because NULL
> > >    pointers might exist due to drm_gem_handle_delete(). This needs a
> > >    separate patch. This is because idr_for_each_entry terminates on the
> > >    first NULL entry and so might not iterate over everything.
> > > 
> > > - similar for amd in amdgpu_debugfs_gem_info_show() and
> > >    amdgpu_gem_force_release(). The latter is really questionable though
> > >    since it's a best effort hack and there's no way to close all the
> > >    races. Needs separate patches.
> > > 
> > > - xe is really broken because it not uses idr_for_each_entry() but
> > >    also drops the drm_file.table_lock, which can wreak the idr iterator
> > >    state if you're unlucky enough. Maybe another reason to look into
> > >    the drm fdinfo memory stats instead of hand-rolling too much.
> > > 
> > > - drm_show_memory_stats() is also broken since it uses
> > >    idr_for_each_entry. But since that's a preexisting bug I'll follow
> > >    up with a separate patch.
> > > 
> > > Reported-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> > > Cc: stable@vger.kernel.org
> > > Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Simona Vetter <simona@ffwll.ch>
> > > Signed-off-by: Simona Vetter <simona.vetter@intel.com>
> > > Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
> > > ---
> > >   drivers/gpu/drm/drm_gem.c | 10 +++++++++-
> > >   include/drm/drm_file.h    |  3 +++
> > >   2 files changed, 12 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > > index 1e659d2660f7..e4e20dda47b1 100644
> > > --- a/drivers/gpu/drm/drm_gem.c
> > > +++ b/drivers/gpu/drm/drm_gem.c
> > > @@ -279,6 +279,9 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
> > >   	struct drm_file *file_priv = data;
> > >   	struct drm_gem_object *obj = ptr;
> > > +	if (WARN_ON(!data))
> > > +		return 0;
> > > +
> > >   	if (obj->funcs->close)
> > >   		obj->funcs->close(obj, file_priv);
> > > @@ -399,7 +402,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
> > >   	idr_preload(GFP_KERNEL);
> > >   	spin_lock(&file_priv->table_lock);
> > > -	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
> > > +	ret = idr_alloc(&file_priv->object_idr, NULL, 1, 0, GFP_NOWAIT);
> > >   	spin_unlock(&file_priv->table_lock);
> > >   	idr_preload_end();
> > > @@ -420,6 +423,11 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
> > >   			goto err_revoke;
> > >   	}
> > > +	/* mirrors drm_gem_handle_delete to avoid races */
> > > +	spin_lock(&file_priv->table_lock);
> > > +	obj = idr_replace(&file_priv->object_idr, obj, handle);
> > > +	WARN_ON(obj != NULL);
> > 
> > A DRM print function would be preferable. The obj here is an errno pointer.
> > Should the errno code be part of the error message?
> > 
> > If it fails, why does the function still succeed?
> 
> This is an internal error that should never happen, at that point just
> bailing out is the way to go.
> 
> Also note that the error code here is just to satisfy the function
> signature that id_for_each expects, we don't look at it ever (since if
> there's no bugs, it should never fail). I learned this because I actually
> removed the int return value and stuff didn't compile :-)

Ok this part was nonsense, I mixed it up with handle_delete(). I still
don't think we should return an error code here, because we've
successfully installed the handle. It's just that something happened with
the idr that should be impossible, so all bets are off.
-Sima

> I can use drm_WARN_ON if you want me to though?
> 
> I'll also explain this in the commit message for the next round.
> -Sima
> 
> > 
> > Best regards
> > Thomas
> > 
> > > +	spin_unlock(&file_priv->table_lock);
> > >   	*handlep = handle;
> > >   	return 0;
> > > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > > index 5c3b2aa3e69d..d344d41e6cfe 100644
> > > --- a/include/drm/drm_file.h
> > > +++ b/include/drm/drm_file.h
> > > @@ -300,6 +300,9 @@ struct drm_file {
> > >   	 *
> > >   	 * Mapping of mm object handles to object pointers. Used by the GEM
> > >   	 * subsystem. Protected by @table_lock.
> > > +	 *
> > > +	 * Note that allocated entries might be NULL as a transient state when
> > > +	 * creating or deleting a handle.
> > >   	 */
> > >   	struct idr object_idr;
> > 
> > -- 
> > --
> > Thomas Zimmermann
> > Graphics Driver Developer
> > SUSE Software Solutions Germany GmbH
> > Frankenstrasse 146, 90461 Nuernberg, Germany
> > GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> > HRB 36809 (AG Nuernberg)
> > 
> 
> -- 
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

