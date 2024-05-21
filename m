Return-Path: <stable+bounces-45528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8942D8CB30A
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 19:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF77FB20D16
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E026147C94;
	Tue, 21 May 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSos9+NK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA07F48D
	for <stable@vger.kernel.org>; Tue, 21 May 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313198; cv=none; b=uxsHIEdRTXbmI0XCrGTKvDxCjoqHv9CnGsUuyezV8wdJayHpt+WvrDnfmz40wrWvQ7BHVxWWoQB6dSHd4J/1QMh+siPYNftUoKAAIKvRDpwgOtV0x1LfRB6ngWwdMgSfhOQrQIRWzu4ueYjgtdUUY/qc76141pIIFBKK02UnvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313198; c=relaxed/simple;
	bh=W1k/b9TMg5vla0eOH4Ow5cEjMyecb29EOdgXPHJp1FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmWJcpTepuuv2m2YDxMeJq1UHI6D1p38BcmQBxNAglugqYRMWf69c1UrmGqTzEI5RipnV2urMF6y0PJgpFDsrCA0Y/kxMhE6oMwn2HXxLLNmEAPfWrOiDSMRGL9W3e0aZ+eZOfHNzqvdxmcWEfAmABCMnpnXy4692FIzEqDK8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSos9+NK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1188391a12.2
        for <stable@vger.kernel.org>; Tue, 21 May 2024 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716313196; x=1716917996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6naY1ebYgtBqBr6FtFx0JuqKFL0i54ZhF9HoediEIY=;
        b=cSos9+NKzacJ7J6AfTKmggPFwQGeKdBwV13DY+a4RUAvntefcCIq0eRHxvzQeYgob3
         +ZFQITYSvQ1aQnEvY0YWrQNz/IV3vOt2KXiJdPajb1IlX4bkMSPBgfe3VN4ndV9kPAod
         lHXUelzNi7e0b5kzOsxpWFgn1bjNGJhtNvKDdgSzeU0G0Nj9EsZos5O8W/ongstzSoK/
         4nrtdjQLLveULzwULOGZ9xufmHAcqSxgER4Bw44/CE0CLTrs2ObjuA4JeopcKxSgBIKs
         U1RwrUucUsV5gpQThQBFtK1oPWByo4fecAqod8YTeHWbdxstLsXIxS/ElES+ElfTYP+g
         b1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716313196; x=1716917996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6naY1ebYgtBqBr6FtFx0JuqKFL0i54ZhF9HoediEIY=;
        b=e+Qk9oSfNvWcbvaLFODaFcbPxdtBHGiLHzmpWkpMDhc2N1X3TVhdQljEU8N4DGERtZ
         m2GO16uPODanGKW2Vr9HJ004+CBUIPDRe2O4/d8hr4YPcC0le1HWvGZZPPQWbN9fvXWX
         oxmWUOnfUxc1qc+n6oDUFDSWqLx7oxBA2u6J0Kv+Rkh8LQjhEN6t4QBSZQ/age//sv54
         UxZ7KxmlrPYqqJbXGsaOTa2MV9h6lIE8TZ+fseyPokSPPihMTSIzsffMvIfu13qDU0I0
         +D1d+0akS26rArPLARPgF/PQePSQDCvmYluRXk2FcRlNBCuXREKrIh4niN86HfXmOiRn
         QODQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdqFbsrVlpIYJWhri89lR1gJzKR7f0BvjKtAdEvzbwlWy/aj0eC1oa7THBffw9umgGGUYUg6iT37sd1mUSmY2pv9sGCImz
X-Gm-Message-State: AOJu0YxOO8AJK0C16o8hRRiY/J2xgMbk+0468BpMwbkH6E7jy28ogYrD
	8CPZ4FJ9I7bBWl62JHv/euCoEhiX4KWk1V71zNTAMBSA0U6B5ww+FgbA1D/Fh/bCjPmkJkn/hk5
	dYJG3mWrhrAM9WXGWFQ2U4aJslRc=
X-Google-Smtp-Source: AGHT+IEtIwnLHEJom7EzPs7RT34MstjtZMfmyW9DXLDXYepTOE0snpQgoUF0SiAcYhvLERYK6iuAIEpcIVtspvvn1Wc=
X-Received: by 2002:a17:90a:fd8a:b0:2bc:9bce:19c3 with SMTP id
 98e67ed59e1d1-2bc9bce1df0mr12631794a91.43.1716313195890; Tue, 21 May 2024
 10:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307062957.2323620-1-Wayne.Lin@amd.com> <0847dc03-c7db-47d7-998b-bda2e82ed442@amd.com>
 <41b87510-7abf-47e8-b28a-9ccc91bbd3c1@leemhuis.info> <177cfae4-b2b5-4e2c-9f1e-9ebe262ce48c@amd.com>
 <CO6PR12MB5489FA9307280A4442BAD51DFCE72@CO6PR12MB5489.namprd12.prod.outlook.com>
 <87wmo2hver.fsf@intel.com> <6f66e479-2f5a-477a-9705-dca4a3606760@amd.com>
 <83df4e94-e1ec-42f6-8a15-6439ef4a25b7@leemhuis.info> <CADnq5_P+WsL8B6B2vK5ENe8VWdvheoHyxoUfgF3Oex8Gvp7Lbg@mail.gmail.com>
In-Reply-To: <CADnq5_P+WsL8B6B2vK5ENe8VWdvheoHyxoUfgF3Oex8Gvp7Lbg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 May 2024 13:39:44 -0400
Message-ID: <CADnq5_MYDNBpqXT8snztEGxqHh3N8_7wktNdjedkjnhe1Te6CQ@mail.gmail.com>
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

Applied and pushed out:
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3D8a0a7b98d4b6eeeab337=
ec25daa4bc0a5e710a15

Alex

On Tue, May 21, 2024 at 12:12=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> I've got it teed up.  Is drm-misc-fixes the right branch since we are
> in the merge window?
>
> Alex
>
> On Tue, May 21, 2024 at 7:20=E2=80=AFAM Linux regression tracking (Thorst=
en
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> > for once, to make this easily accessible to everyone.
> >
> > Hmm, from here it looks like the patch now that it was reviewed more
> > that a week ago is still not even in -next. Is there a reason?
> >
> > I know, we are in the merge window. But at the same time this is a fix
> > (that already lingered on the lists for way too long before it was
> > reviewed) for a regression in a somewhat recent kernel, so it in Linus
> > own words should be "expedited"[1].
> >
> > Or are we again just missing a right person for the job in the CC?
> > Adding Dave and Sima just in case.
> >
> > Ciao, Thorsten
> >
> > [1]
> > https://lore.kernel.org/all/CAHk-=3Dwis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wm=
B6SRUwQUBQ@mail.gmail.com/
> >
> > On 12.05.24 18:11, Limonciello, Mario wrote:
> > > On 5/10/2024 4:24 AM, Jani Nikula wrote:
> > >> On Fri, 10 May 2024, "Lin, Wayne" <Wayne.Lin@amd.com> wrote:
> > >>>> -----Original Message-----
> > >>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > >>>> Sent: Friday, May 10, 2024 3:18 AM
> > >>>> To: Linux regressions mailing list <regressions@lists.linux.dev>;
> > >>>> Wentland, Harry
> > >>>> <Harry.Wentland@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
> > >>>> Cc: lyude@redhat.com; imre.deak@intel.com; Leon Wei=C3=9F
> > >>>> <leon.weiss@ruhr-uni-
> > >>>> bochum.de>; stable@vger.kernel.org; dri-devel@lists.freedesktop.or=
g;
> > >>>> amd-
> > >>>> gfx@lists.freedesktop.org; intel-gfx@lists.freedesktop.org
> > >>>> Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference at
> > >>>> drm_dp_add_payload_part2
> > >>>>
> > >>>> On 5/9/2024 07:43, Linux regression tracking (Thorsten Leemhuis) w=
rote:
> > >>>>> On 18.04.24 21:43, Harry Wentland wrote:
> > >>>>>> On 2024-03-07 01:29, Wayne Lin wrote:
> > >>>>>>> [Why]
> > >>>>>>> Commit:
> > >>>>>>> - commit 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
> > >>>>>>> allocation/removement") accidently overwrite the commit
> > >>>>>>> - commit 54d217406afe ("drm: use mgr->dev in drm_dbg_kms in
> > >>>>>>> drm_dp_add_payload_part2") which cause regression.
> > >>>>>>>
> > >>>>>>> [How]
> > >>>>>>> Recover the original NULL fix and remove the unnecessary input
> > >>>>>>> parameter 'state' for drm_dp_add_payload_part2().
> > >>>>>>>
> > >>>>>>> Fixes: 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
> > >>>>>>> allocation/removement")
> > >>>>>>> Reported-by: Leon Wei=C3=9F <leon.weiss@ruhr-uni-bochum.de>
> > >>>>>>> Link:
> > >>>>>>> https://lore.kernel.org/r/38c253ea42072cc825dc969ac4e6b9b600371=
cc8.c
> > >>>>>>> amel@ruhr-uni-bochum.de/
> > >>>>>>> Cc: lyude@redhat.com
> > >>>>>>> Cc: imre.deak@intel.com
> > >>>>>>> Cc: stable@vger.kernel.org
> > >>>>>>> Cc: regressions@lists.linux.dev
> > >>>>>>> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> > >>>>>>
> > >>>>>> I haven't been deep in MST code in a while but this all looks pr=
etty
> > >>>>>> straightforward and good.
> > >>>>>>
> > >>>>>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> > >>>>>
> > >>>>> Hmmm, that was three weeks ago, but it seems since then nothing
> > >>>>> happened to fix the linked regression through this or some other
> > >>>>> patch. Is there a reason? The build failure report from the CI ma=
ybe?
> > >>>>
> > >>>> It touches files outside of amd but only has an ack from AMD.  I
> > >>>> think we
> > >>>> /probably/ want an ack from i915 and nouveau to take it through.
> > >>>
> > >>> Thanks, Mario!
> > >>>
> > >>> Hi Thorsten,
> > >>> Yeah, like what Mario said. Would also like to have ack from i915 a=
nd
> > >>> nouveau.
> > >>
> > >> It usually works better if you Cc the folks you want an ack from! ;)
> > >>
> > >> Acked-by: Jani Nikula <jani.nikula@intel.com>
> > >>
> > >
> > > Thanks! Can someone with commit permissions take this to drm-misc?
> > >
> > >
> > >

