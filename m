Return-Path: <stable+bounces-45526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C68CB1FA
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA9283974
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749981CD11;
	Tue, 21 May 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOIkckH2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4A1C68C
	for <stable@vger.kernel.org>; Tue, 21 May 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307970; cv=none; b=by4C6muFrl7vUJfJA/8vRPSqGwIvPkB9qHFWZ8SqY7tcsIWQqukJttKy/u3xxWMwhOsk9iMjyzv90q8vQeju6MILHULcB/j0u96XYqJqaxyEQt7kZlEO3PNM/OkIorxKYWeLlz880RVPgJmtCytVwC7ZdW1lg5GRDkO/XczfaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307970; c=relaxed/simple;
	bh=16LUPK2BDH83+ZeUEibqD0CSXfCzHgidoB/WLnqChcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5ZHhCYrz084wbwViNSgOb0zd71XexXuo3N0pY/xkArcsm83ci61Sgt/TPly/6jBeiPehqxYlU/aUti1XfMWouaarfKWKdC4nLR4HVoZWyaYGzD+G4nyc7QiRwPLiJxXrV84YX341rsITxo6Eb0GKd+7eQN5DYrk35Gou9Xa4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOIkckH2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso1517239a12.1
        for <stable@vger.kernel.org>; Tue, 21 May 2024 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716307968; x=1716912768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCvtAT9yL4bsyunfEMr4mUSenqzklzI9+JXqeALbOyQ=;
        b=gOIkckH2wQOY/bNjAWlbU0YbQ/qPsMWNVbu7hKjrUetaGorKJSsSHxPnZ3Tq6nmSBZ
         +wux19+x5s6MLcjLZs+hYQ5IfLqVQwH9KWeNkKKYAEf/KbHwu7wwina8E4fwCb5MXi3G
         D20Aiod+twgYjcGMFAdJwaRIqXNMFsnm5vta8yid6WIQlPC0TIMTWOlin/4E0eS54Eps
         gN0kJLO0H7zRbf8jItwabd8XeJcH3yq3uYTvRXKgpvPJXiTKP5pckfRU6lzwq7yu/n5V
         VxowJ5sISWxuDKOaYVAeL5A3+CUqEJi9rxtkxZSmg82FZVCa4R9VDru6j656AmSw69ZK
         0SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307968; x=1716912768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCvtAT9yL4bsyunfEMr4mUSenqzklzI9+JXqeALbOyQ=;
        b=ePY3ENi+diaFK0zyoDWbF2bev1XEdZTyejsGfvU5dq3z6Hoz7YTdM8hdaOKUOxbCeV
         tUAvJLSoJij4GnxkW+zaQWb5McWZmpIZWt9bwIzfjx+ras/Lt9borcJP4NSvqIEVAgp8
         HOhAM6uRgT0cV707yuVtiLYaPUQ14nmESRF0wYlBc4VswmypojNhoOCJS7Y8VvcaZoNs
         StJk6Hvn3TK/2Xome8XVH4EeOYZJ602HtXAwmmFmbsSl669ihuvE426UacdZptrCMBEu
         qqpLIwDLGkt4q6GjGurjdVLfli+l//ZSJAWmMhUId4Xll4/wTQpoe5gnS7R3qFrubg7r
         jbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Tjr8UJ9xxVMSkQLEH7KXJTGjlDhC6ij2qllWJUAv5+k3y8M2T0bNQUq7ouf880kj4P3TekoRQLE7U6Eu5ssRvg+vyFuX
X-Gm-Message-State: AOJu0Yz2Id9dLcoECQmx+SWnDYLvyr7/EjzPHlorRfx9xvUNJVfWFHII
	saE5PSy5/i0ls5hk2nzRatM4RwFeSkKgbmLa7+0WAUEgYiK6ZlYYYQlSouJPrzHPHZ5iI+CqQ29
	sq/QK/Er5uicX6x4sm7EcYRgNTWE=
X-Google-Smtp-Source: AGHT+IHAP3KDnJJS0O7SkGfKIP7uk1EKp+f8X1mluB24KubBN9tLU3rOHMtfN8y0ky6xkTXQo2yflL/anOYUpzKLWLA=
X-Received: by 2002:a17:90a:eb07:b0:2a3:10d3:239d with SMTP id
 98e67ed59e1d1-2b6ccd6bbbdmr28841420a91.32.1716307967824; Tue, 21 May 2024
 09:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307062957.2323620-1-Wayne.Lin@amd.com> <0847dc03-c7db-47d7-998b-bda2e82ed442@amd.com>
 <41b87510-7abf-47e8-b28a-9ccc91bbd3c1@leemhuis.info> <177cfae4-b2b5-4e2c-9f1e-9ebe262ce48c@amd.com>
 <CO6PR12MB5489FA9307280A4442BAD51DFCE72@CO6PR12MB5489.namprd12.prod.outlook.com>
 <87wmo2hver.fsf@intel.com> <6f66e479-2f5a-477a-9705-dca4a3606760@amd.com> <83df4e94-e1ec-42f6-8a15-6439ef4a25b7@leemhuis.info>
In-Reply-To: <83df4e94-e1ec-42f6-8a15-6439ef4a25b7@leemhuis.info>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 May 2024 12:12:36 -0400
Message-ID: <CADnq5_P+WsL8B6B2vK5ENe8VWdvheoHyxoUfgF3Oex8Gvp7Lbg@mail.gmail.com>
Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference at drm_dp_add_payload_part2
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	"Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
	"lyude@redhat.com" <lyude@redhat.com>, "imre.deak@intel.com" <imre.deak@intel.com>, 
	=?UTF-8?Q?Leon_Wei=C3=9F?= <leon.weiss@ruhr-uni-bochum.de>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've got it teed up.  Is drm-misc-fixes the right branch since we are
in the merge window?

Alex

On Tue, May 21, 2024 at 7:20=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> Hmm, from here it looks like the patch now that it was reviewed more
> that a week ago is still not even in -next. Is there a reason?
>
> I know, we are in the merge window. But at the same time this is a fix
> (that already lingered on the lists for way too long before it was
> reviewed) for a regression in a somewhat recent kernel, so it in Linus
> own words should be "expedited"[1].
>
> Or are we again just missing a right person for the job in the CC?
> Adding Dave and Sima just in case.
>
> Ciao, Thorsten
>
> [1]
> https://lore.kernel.org/all/CAHk-=3Dwis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6=
SRUwQUBQ@mail.gmail.com/
>
> On 12.05.24 18:11, Limonciello, Mario wrote:
> > On 5/10/2024 4:24 AM, Jani Nikula wrote:
> >> On Fri, 10 May 2024, "Lin, Wayne" <Wayne.Lin@amd.com> wrote:
> >>>> -----Original Message-----
> >>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>> Sent: Friday, May 10, 2024 3:18 AM
> >>>> To: Linux regressions mailing list <regressions@lists.linux.dev>;
> >>>> Wentland, Harry
> >>>> <Harry.Wentland@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
> >>>> Cc: lyude@redhat.com; imre.deak@intel.com; Leon Wei=C3=9F
> >>>> <leon.weiss@ruhr-uni-
> >>>> bochum.de>; stable@vger.kernel.org; dri-devel@lists.freedesktop.org;
> >>>> amd-
> >>>> gfx@lists.freedesktop.org; intel-gfx@lists.freedesktop.org
> >>>> Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference at
> >>>> drm_dp_add_payload_part2
> >>>>
> >>>> On 5/9/2024 07:43, Linux regression tracking (Thorsten Leemhuis) wro=
te:
> >>>>> On 18.04.24 21:43, Harry Wentland wrote:
> >>>>>> On 2024-03-07 01:29, Wayne Lin wrote:
> >>>>>>> [Why]
> >>>>>>> Commit:
> >>>>>>> - commit 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
> >>>>>>> allocation/removement") accidently overwrite the commit
> >>>>>>> - commit 54d217406afe ("drm: use mgr->dev in drm_dbg_kms in
> >>>>>>> drm_dp_add_payload_part2") which cause regression.
> >>>>>>>
> >>>>>>> [How]
> >>>>>>> Recover the original NULL fix and remove the unnecessary input
> >>>>>>> parameter 'state' for drm_dp_add_payload_part2().
> >>>>>>>
> >>>>>>> Fixes: 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
> >>>>>>> allocation/removement")
> >>>>>>> Reported-by: Leon Wei=C3=9F <leon.weiss@ruhr-uni-bochum.de>
> >>>>>>> Link:
> >>>>>>> https://lore.kernel.org/r/38c253ea42072cc825dc969ac4e6b9b600371cc=
8.c
> >>>>>>> amel@ruhr-uni-bochum.de/
> >>>>>>> Cc: lyude@redhat.com
> >>>>>>> Cc: imre.deak@intel.com
> >>>>>>> Cc: stable@vger.kernel.org
> >>>>>>> Cc: regressions@lists.linux.dev
> >>>>>>> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> >>>>>>
> >>>>>> I haven't been deep in MST code in a while but this all looks pret=
ty
> >>>>>> straightforward and good.
> >>>>>>
> >>>>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >>>>>
> >>>>> Hmmm, that was three weeks ago, but it seems since then nothing
> >>>>> happened to fix the linked regression through this or some other
> >>>>> patch. Is there a reason? The build failure report from the CI mayb=
e?
> >>>>
> >>>> It touches files outside of amd but only has an ack from AMD.  I
> >>>> think we
> >>>> /probably/ want an ack from i915 and nouveau to take it through.
> >>>
> >>> Thanks, Mario!
> >>>
> >>> Hi Thorsten,
> >>> Yeah, like what Mario said. Would also like to have ack from i915 and
> >>> nouveau.
> >>
> >> It usually works better if you Cc the folks you want an ack from! ;)
> >>
> >> Acked-by: Jani Nikula <jani.nikula@intel.com>
> >>
> >
> > Thanks! Can someone with commit permissions take this to drm-misc?
> >
> >
> >

