Return-Path: <stable+bounces-87615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B609A71B1
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 20:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C2B1F214C2
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E131F7080;
	Mon, 21 Oct 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zt0UuxWm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFD1F4FA6
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533781; cv=none; b=lJryd55vktHLxew1+TE1Aj44D6vYps3fwBaq24hNpDY3qrnmbOjLAf9XDVYn+q334DryJ8THJ7BXRZVNLJleAfUXaLIkrHMpJ/xbQvtVXs84KHIKumLqGyMHWshL7ozicy5ROMVtwfFmDwRWaL72JzHjqrpqEDf3FZERmLEhE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533781; c=relaxed/simple;
	bh=J19MNiUHxjz09NagV6grcNTkv8J39PZzUSF6p8+6fn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUsPi2bANYWhUUz34vWmX16xL0qgNpRza0JWyGyMd+6yebK3pvUncVMkTl1uo1oRMr3Gx5l/LO5nyR0XQZM9kPu4Fsfp9iz6XgO8pysz2C85jd0uBqkBxH6pJnimK8h5rj6qv2/fJLYtVnP5K5RoWBGXqNphmszeAz5eSx3+ww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zt0UuxWm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca4877690so21865ad.1
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729533779; x=1730138579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J19MNiUHxjz09NagV6grcNTkv8J39PZzUSF6p8+6fn4=;
        b=Zt0UuxWmA46CBxUoYAfA+t7dClYfiRnNgFqaBdjpewDyaxhmtacZAn6LwUu6LWQaDl
         Y/Sccuc/djwpQO6I3FvccDwJlMbM/2KIjZG/uQy0b/z+N0wsdFFMpIMMJzdmHuLDNSPN
         mxqt3KhD098+mTz44JsghXA2ntu+i6ORE6qgnvXiM8w78emdH/ShIfNV/aou/2EieSGE
         odDllJU33whYlvElH7lLrjSwQJK7UYwZeGGR7pbR5Qi18gbfS7xjIL6lT/vmbR5iBVpf
         2oUavKMyjS+ABp+PlFkqOHU1KqW4tMlhKa/f8wE+VoHvoPhrRjwoBZ1xsO2+X4dxkPBU
         ieIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729533779; x=1730138579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J19MNiUHxjz09NagV6grcNTkv8J39PZzUSF6p8+6fn4=;
        b=TNPUmK9XfK7RoU8dx/eyRcbkGh9/7e3+YtyXKKfzBz55PyFMsMwGyYqzX69fMa/m2K
         Hcs9I6X36YAMgjN4za/e76W+as0wTRoGMO0RC3LKIp0Xv26SP+AIR0uQxMCt5tloAnjW
         dFLJ2o5tkZGDCZ4WzwaosgXIgen3c+vfDFt5NeQh0a6jRGWGji2NbGIvPGScJyYH7iIx
         w5YJqz5r4udp71e9z8PVwCyd4KVrhjPTLsBPK5DVmB+JmtaQCFZQcoUpE7P/1nC5osjb
         1joyNMyQcJlBcBdj2xoeCnnUKaPqXK6Yk4A0nksewOkdOms7MbLhQHpgr5Fm5Xt2uUw6
         x4Og==
X-Forwarded-Encrypted: i=1; AJvYcCUjMsyoQvUa1zzttPy9tNopwwIsqcga2Weelp4V3xH7YqUGCSpsukZy6Aq//S/SbBxqyyOxGtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoA3jzQJ2MdeN+HKgF8E3mI8lnZ0zGhYFdoIZ9QPImGRKGBvC5
	/XgTo+jxQglPwI14uvTLPP07bPRt3lLwc4rpGJmlCfOhBBeSkcSIdEQXFOYu1UH74/58ohIo6+f
	eGafGx9WpXXSxrfs4j3n+ZdTVSW/xIhOAiAq2Iigbyufd2caSFQ==
X-Google-Smtp-Source: AGHT+IFmFhNHZRSDbSAMKnQuKoWQssmM8a8RblG05nG5RF0TSMjryrP+J2Dt9pQ+iUKjrbbqDcnp+2Y0mWlDGvok5/s=
X-Received: by 2002:a05:622a:586:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-46100b99091mr204681cf.26.1729533766832; Mon, 21 Oct 2024
 11:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021171003.2907935-1-surenb@google.com> <20241021171003.2907935-2-surenb@google.com>
 <2024102104-paralyze-voting-973a@gregkh>
In-Reply-To: <2024102104-paralyze-voting-973a@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 11:02:35 -0700
Message-ID: <CAJuCfpGY+yucNvqoqebQX+oOMqCgN7T5EOGh6KWTbf5+95P7bQ@mail.gmail.com>
Subject: Re: [PATCH 6.11.y 2/2] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, stable@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Oct 21, 2024 at 10:10:03AM -0700, Suren Baghdasaryan wrote:
> > From: Florian Westphal <fw@strlen.de>
> >
> > From: Florian Westphal <fw@strlen.de>
>
> Any reason for the duplicated "From:" lines?

No, just me incorrectly formatting the patches. Please feel free to
remove the duplicates. Thanks!

>
> thanks,
>
> greg k-h

