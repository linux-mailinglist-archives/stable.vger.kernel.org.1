Return-Path: <stable+bounces-150702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 285ABACC5B2
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE904162D64
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8118C91F;
	Tue,  3 Jun 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lIhrbO0/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C12C327E
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951160; cv=none; b=SK/2gpYfdMrYoM+F3V41D/61CnR6ZGm12JC5HwdnE1Z2Fmlyl/c3gu97c/mRB9aJMyVdYJUoJ53cG94+T/5eem+Sv4PRHZAjI2waYMrzpMmf/NyhzzQ1dTHGXYgoJM2iSP8/+0vv1t0QxiTFzzUFBG6Vi9cdL5hM11FHyZQg0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951160; c=relaxed/simple;
	bh=W46jAY8DvFTlxLUKlqbalfmzAmQGw+lUgSp1JCGBacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL5Oo7ZLOfA/UNEKgyX8rgtflipOtUx0yriCgO4CafVQX8kT75zQrtNC315e5sMbSP+o3SvKwYsaQELBZQjgXKfu3h0P++ZI25RMTZ1hAXdIqIiDru2mrXHU+GI5DBWcPETctIpRP42rqFTGPKp92+3na26zcM/GG2jRN+sBGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lIhrbO0/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so12398636a12.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1748951157; x=1749555957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfazfPYNHju0jH7hIPSEI9ULtmklFpa91hwq4k84SSc=;
        b=lIhrbO0/Lt8FtkYFvu5VwQMbMS+0LISKPRcGqmFfpYYdV7FfsfrrQN+oP6cVtk6Z34
         1DqFPI15Qz0tcrldUYq5SLez85hT8q4zzDZ0sEzV7mueaEgPZ3JT+7kVlzZa5asrR0XU
         z6N1F+tutU6RjNzRiVXkllIk+LVkSfO5IomHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748951157; x=1749555957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfazfPYNHju0jH7hIPSEI9ULtmklFpa91hwq4k84SSc=;
        b=Gb7bg9p7g5Fa+9ezaEaWI1MgkTb6O6L36H56Nz91nXEUen85Wkz5euwYikc+QFzCwM
         5FYyaf6VYKOFSpZ+C5jlFFLS42Jzc4bJwwwxUVwNvGqjNm5o2lxn+9YV8zfBfmC18oue
         j+CYWsLCjnsMQ52Q5t9P92+GKzmBeR7d7hH45lrEBp6LFqdP8EKaexpQ1PjTlDK2vx1R
         eb8o0XIkRqpLiQy/2NE9YZhcSLv0yHmtBkhIiwSSbbnIbAzpEfQGEZbrTaniVYPujZNJ
         1FGCrQIxoRq7yEaALaZ6qf6bZXUQfRfaFLiNskrdBBrPdLuGlk97MbZ6LpplWRemRgnb
         nxBg==
X-Forwarded-Encrypted: i=1; AJvYcCXHwIkCZeT+24qk+mtw4lCFk+lNNtcYXxN8EwL3IlQ7n/F1Cvw57pnVLP/fmTmGJ1R3AGad6AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHeTbcHmFFGr4Yhd3CYMHgpn8+FL2E+Udn8O6OdQZFcb1DFMd
	Eiq0TVOXykFhzMTCmKf+V/TZbxboP2NqAWJMRSpq/k1LreBCmqz+RtbDwcSKeoU3cEs=
X-Gm-Gg: ASbGncumBh4n7pyVrifp0tWNVX/L/l87GEozGowGzmcryRyx4et36oJd7Zjue1DGRIP
	7WnNcenVAQi8ygm29Nx4eYd2l8jRsfmi8tehrp2snhU28rpYGWHFIodMODnivSrItwOzGPWMf0m
	1iY9KxfM7KAIX/gsd5qFsyWs4ov2Y9h24uWpBgLaXsZ2oil+WjvlsBM3788U5VogroOcocaqpDO
	1HapIDx8k+aUY60JozpCNQKwoOCyZO7r8kzHGIqj/9vU+P0LNeBUlgoIDmBLwQG60JYNecWBy7i
	LPf1wJnXEUPFffXFVltRZ1o6ZabUEcSbkzwdZHjpfZPiAf+Fg8Hga93+ZPUnuqU=
X-Google-Smtp-Source: AGHT+IG/yc1I09xXOpkrWC6fXgtwTaHTRCmhg1Bxq/oy8J2wc7t8jcYMlZLv+2Y63auTPM2uqnqVUQ==
X-Received: by 2002:a17:907:2d0e:b0:adb:4085:fb88 with SMTP id a640c23a62f3a-adde5e98e24mr233475866b.1.1748951156582;
        Tue, 03 Jun 2025 04:45:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad3a6ccsm934847366b.156.2025.06.03.04.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:45:56 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:45:54 +0200
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
Message-ID: <aD7gcvEaZzoDRRc1@phenom.ffwll.local>
References: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
 <20250528091307.1894940-2-simona.vetter@ffwll.ch>
 <2e60074d-8efd-4880-8620-9d9572583c88@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e60074d-8efd-4880-8620-9d9572583c88@suse.de>
X-Operating-System: Linux phenom 6.12.25-amd64 

On Mon, Jun 02, 2025 at 05:15:58PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 28.05.25 um 11:12 schrieb Simona Vetter:
> > Object creation is a careful dance where we must guarantee that the
> > object is fully constructed before it is visible to other threads, and
> > GEM buffer objects are no difference.
> > 
> > Final publishing happens by calling drm_gem_handle_create(). After
> > that the only allowed thing to do is call drm_gem_object_put() because
> > a concurrent call to the GEM_CLOSE ioctl with a correctly guessed id
> > (which is trivial since we have a linear allocator) can already tear
> > down the object again.
> > 
> > Luckily most drivers get this right, the very few exceptions I've
> > pinged the relevant maintainers for. Unfortunately we also need
> > drm_gem_handle_create() when creating additional handles for an
> > already existing object (e.g. GETFB ioctl or the various bo import
> > ioctl), and hence we cannot have a drm_gem_handle_create_and_put() as
> > the only exported function to stop these issues from happening.
> > 
> > Now unfortunately the implementation of drm_gem_handle_create() isn't
> > living up to standards: It does correctly finishe object
> > initialization at the global level, and hence is safe against a
> > concurrent tear down. But it also sets up the file-private aspects of
> > the handle, and that part goes wrong: We fully register the object in
> > the drm_file.object_idr before calling drm_vma_node_allow() or
> > obj->funcs->open, which opens up races against concurrent removal of
> > that handle in drm_gem_handle_delete().
> > 
> > Fix this with the usual two-stage approach of first reserving the
> > handle id, and then only registering the object after we've completed
> > the file-private setup.
> > 
> > Jacek reported this with a testcase of concurrently calling GEM_CLOSE
> > on a freshly-created object (which also destroys the object), but it
> > should be possible to hit this with just additional handles created
> > through import or GETFB without completed destroying the underlying
> > object with the concurrent GEM_CLOSE ioctl calls.
> > 
> > Note that the close-side of this race was fixed in f6cd7daecff5 ("drm:
> > Release driver references to handle before making it available
> > again"), which means a cool 9 years have passed until someone noticed
> > that we need to make this symmetry or there's still gaps left :-/
> > Without the 2-stage close approach we'd still have a race, therefore
> > that's an integral part of this bugfix.
> > 
> > More importantly, this means we can have NULL pointers behind
> > allocated id in our drm_file.object_idr. We need to check for that
> > now:
> > 
> > - drm_gem_handle_delete() checks for ERR_OR_NULL already
> > 
> > - drm_gem.c:object_lookup() also chekcs for NULL
> > 
> > - drm_gem_release() should never be called if there's another thread
> >    still existing that could call into an IOCTL that creates a new
> >    handle, so cannot race. For paranoia I added a NULL check to
> >    drm_gem_object_release_handle() though.
> > 
> > - most drivers (etnaviv, i915, msm) are find because they use
> >    idr_find, which maps both ENOENT and NULL to NULL.
> > 
> > - vmgfx is already broken vmw_debugfs_gem_info_show() because NULL
> >    pointers might exist due to drm_gem_handle_delete(). This needs a
> >    separate patch. This is because idr_for_each_entry terminates on the
> >    first NULL entry and so might not iterate over everything.
> > 
> > - similar for amd in amdgpu_debugfs_gem_info_show() and
> >    amdgpu_gem_force_release(). The latter is really questionable though
> >    since it's a best effort hack and there's no way to close all the
> >    races. Needs separate patches.
> > 
> > - xe is really broken because it not uses idr_for_each_entry() but
> >    also drops the drm_file.table_lock, which can wreak the idr iterator
> >    state if you're unlucky enough. Maybe another reason to look into
> >    the drm fdinfo memory stats instead of hand-rolling too much.
> > 
> > - drm_show_memory_stats() is also broken since it uses
> >    idr_for_each_entry. But since that's a preexisting bug I'll follow
> >    up with a separate patch.
> > 
> > Reported-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Signed-off-by: Simona Vetter <simona.vetter@intel.com>
> > Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
> > ---
> >   drivers/gpu/drm/drm_gem.c | 10 +++++++++-
> >   include/drm/drm_file.h    |  3 +++
> >   2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index 1e659d2660f7..e4e20dda47b1 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -279,6 +279,9 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
> >   	struct drm_file *file_priv = data;
> >   	struct drm_gem_object *obj = ptr;
> > +	if (WARN_ON(!data))
> > +		return 0;
> > +
> >   	if (obj->funcs->close)
> >   		obj->funcs->close(obj, file_priv);
> > @@ -399,7 +402,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
> >   	idr_preload(GFP_KERNEL);
> >   	spin_lock(&file_priv->table_lock);
> > -	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
> > +	ret = idr_alloc(&file_priv->object_idr, NULL, 1, 0, GFP_NOWAIT);
> >   	spin_unlock(&file_priv->table_lock);
> >   	idr_preload_end();
> > @@ -420,6 +423,11 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
> >   			goto err_revoke;
> >   	}
> > +	/* mirrors drm_gem_handle_delete to avoid races */
> > +	spin_lock(&file_priv->table_lock);
> > +	obj = idr_replace(&file_priv->object_idr, obj, handle);
> > +	WARN_ON(obj != NULL);
> 
> A DRM print function would be preferable. The obj here is an errno pointer.
> Should the errno code be part of the error message?
> 
> If it fails, why does the function still succeed?

This is an internal error that should never happen, at that point just
bailing out is the way to go.

Also note that the error code here is just to satisfy the function
signature that id_for_each expects, we don't look at it ever (since if
there's no bugs, it should never fail). I learned this because I actually
removed the int return value and stuff didn't compile :-)

I can use drm_WARN_ON if you want me to though?

I'll also explain this in the commit message for the next round.
-Sima

> 
> Best regards
> Thomas
> 
> > +	spin_unlock(&file_priv->table_lock);
> >   	*handlep = handle;
> >   	return 0;
> > diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> > index 5c3b2aa3e69d..d344d41e6cfe 100644
> > --- a/include/drm/drm_file.h
> > +++ b/include/drm/drm_file.h
> > @@ -300,6 +300,9 @@ struct drm_file {
> >   	 *
> >   	 * Mapping of mm object handles to object pointers. Used by the GEM
> >   	 * subsystem. Protected by @table_lock.
> > +	 *
> > +	 * Note that allocated entries might be NULL as a transient state when
> > +	 * creating or deleting a handle.
> >   	 */
> >   	struct idr object_idr;
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

