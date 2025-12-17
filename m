Return-Path: <stable+bounces-202909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F861CC9C77
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 00:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C99302D29C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91593309EF9;
	Wed, 17 Dec 2025 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjLxeHyH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE431AF31;
	Wed, 17 Dec 2025 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013424; cv=none; b=ObPPFMD9lMzbMVauBszAoq0RTKkEeM60PazpfmDI8mr67Jdf+/HDLOvTVONU/ucGVL3vAVbi0MK+sCWm7orlKcoD6Y7/0zXWIUC9AyW5eaQtO/tDDpT+69hTlbcKueWiD0cnwgHOQYdCk7QNh0F55OSu95GdnC2obDSul/+gSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013424; c=relaxed/simple;
	bh=TBYGBE23AB+ktZkZ+/GsL8qK4XV+COseuwF2Zqf/1lY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6CGSa+aWlQLYnk2Ho2x8CggmZW/qNY5apcb3zf1qgvB24mTnkvpyxXx9f+CaXQ7Wm4AoPdAYQLBctAgyDORLFdVK3Y9RGXwXbhXAp3OaZQSapkMzErfLMQXdPoSkfpQXH03rJaJvUj0H3Jdh9btkrQYF7hGKkkuAXEkSDqp8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjLxeHyH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766013422; x=1797549422;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TBYGBE23AB+ktZkZ+/GsL8qK4XV+COseuwF2Zqf/1lY=;
  b=DjLxeHyHYkCONz20rqZ+FiEWezmMXb7u735II+n7qw3qw5dJps/NnSqj
   JwnGLGFbjIQmvPcD0sHQJZfYDpS+au46XkqxcgE19VbvCV/QgHrQtFBpc
   /1RWQ5I1J+epfwhXZTvRUiTOL+StmZ5HvkOO8LYDgWW5mDtS/MG2WYicW
   FqM9K5K4sEh9wPvhNbFUQjUQZVxkJV3ZM2JqjY2SMf8NfGm9GXxALz8sR
   6hGw3+1JGS7aEcOBNQTD86JEfVB+TDvkuP/oTnQMtyWVzz3m7QZu0fdRI
   1VYNIXx66NPqAVHWR7uFYIEW679+h5rlrngJ5t2GmlHH/O8HxkMv81Lil
   g==;
X-CSE-ConnectionGUID: N0JFn5MCQHeuxSnd18UxRg==
X-CSE-MsgGUID: GwFtdI3CSDa4pVLDuV1d1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="79085305"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="79085305"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 15:17:02 -0800
X-CSE-ConnectionGUID: idUwsNNqTKqOv9JMVyirVQ==
X-CSE-MsgGUID: fTsDsod0SAe5VgV7rze+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="235845715"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.244]) ([10.245.245.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 15:17:00 -0800
Message-ID: <1b991bc62464bee45298a084271ff09d4b677fb0.camel@linux.intel.com>
Subject: Re: Patch "drm/xe: Enforce correct user fence signaling order
 using" has been added to the 6.18-stable tree
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	matthew.brost@intel.com
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Rodrigo Vivi
	 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	 <simona@ffwll.ch>
Date: Thu, 18 Dec 2025 00:16:57 +0100
In-Reply-To: <20251213093825.4125326-1-sashal@kernel.org>
References: <20251213093825.4125326-1-sashal@kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Sat, 2025-12-13 at 04:38 -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
> =C2=A0=C2=A0=C2=A0 drm/xe: Enforce correct user fence signaling order usi=
ng
>=20
> to the 6.18-stable tree which can be found at:
> =C2=A0=C2=A0=C2=A0
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.git;a=
=3Dsummary
>=20
> The filename of the patch is:
> =C2=A0=C2=A0=C2=A0=C2=A0 drm-xe-enforce-correct-user-fence-signaling-orde=
r-us.patch
> and it can be found in the queue-6.18 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable
> tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20

(Already replied to a similar email from GregKH) Please skip this
patch. The patch looks already applied and appears to be the result of
an incorrect merge resolution.

Thanks,
Thomas


>=20
> commit e0d6df858765e6228a87c8559ccbe6826a1a6fef
> Author: Matthew Brost <matthew.brost@intel.com>
> Date:=C2=A0=C2=A0 Fri Oct 31 16:40:45 2025 -0700
>=20
> =C2=A0=C2=A0=C2=A0 drm/xe: Enforce correct user fence signaling order usi=
ng
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 [ Upstream commit adda4e855ab6409a3edaa585293f1f2069ab=
7299 ]
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Prevent application hangs caused by out-of-order fence=
 signaling
> when
> =C2=A0=C2=A0=C2=A0 user fences are attached. Use drm_syncobj (via dma-fen=
ce-chain)
> to
> =C2=A0=C2=A0=C2=A0 guarantee that each user fence signals in order, regar=
dless of
> the
> =C2=A0=C2=A0=C2=A0 signaling order of the attached fences. Ensure user fe=
nce
> writebacks to
> =C2=A0=C2=A0=C2=A0 user space occur in the correct sequence.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 v7:
> =C2=A0=C2=A0=C2=A0=C2=A0 - Skip drm_syncbj create of error (CI)
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driv=
er for
> Intel GPUs")
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@l=
inux.intel.com>
> =C2=A0=C2=A0=C2=A0 Link:
> https://patch.msgid.link/20251031234050.3043507-2-matthew.brost@intel.com
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c
> b/drivers/gpu/drm/xe/xe_exec_queue.c
> index cb5f204c08ed6..a6efe4e8ab556 100644
> --- a/drivers/gpu/drm/xe/xe_exec_queue.c
> +++ b/drivers/gpu/drm/xe/xe_exec_queue.c
> @@ -344,6 +344,9 @@ void xe_exec_queue_destroy(struct kref *ref)
> =C2=A0	struct xe_exec_queue *q =3D container_of(ref, struct
> xe_exec_queue, refcount);
> =C2=A0	struct xe_exec_queue *eq, *next;
> =C2=A0
> +	if (q->ufence_syncobj)
> +		drm_syncobj_put(q->ufence_syncobj);
> +
> =C2=A0	if (q->ufence_syncobj)
> =C2=A0		drm_syncobj_put(q->ufence_syncobj);
> =C2=A0


