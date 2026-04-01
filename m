Return-Path: <stable+bounces-232823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEHNOSpPzWkWbwYAu9opvQ
	(envelope-from <stable+bounces-232823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:00:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED1D37E4F8
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA36F301DE22
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF439B951;
	Wed,  1 Apr 2026 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAN39xRH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371E3BF669
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061774; cv=none; b=Odih90NG8x2xcFtoVKKYRmavXwHijTjdEDlqdYY94aLF4zFVdQB7FMJcCUy2LnkxyiRYysU1PT9gv7tjgKNiv05ky8MENP5drrgtrVDnLpEw2DJdh9wyqtemr5g1sNkkKiOkNoZQeJWb8chWdrePg11LaIyR8OAiwbpfi226+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061774; c=relaxed/simple;
	bh=bK5VcBzFH7seN9+AMOZbQhRoAWaOmgP6bggqWtU0CKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5e4q0HtInEJzhmoLxrEdbTi2+HuX8uffiUIFTCJml5QYgSxiBuiduujNxKI3yPoEnuGsz1HQDucDyVywWf3+3aK+aoRKpUiz0UD5Vq1xepqwFrDAqkjQKmLuW0rVnG81nSrTLvVcIk0pbjXbWp6zIEKjPelOOeEoN6Eedd8A5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAN39xRH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fe655187so92864135e9.2
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775061772; x=1775666572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KV+tSC2Aqfk5AN8Gr0A0YOBmS6aIW69bjJ/AxSnLy9M=;
        b=sAN39xRHsT6gzTV4pTJhkLhpQ+BaHe1uz4+TSVXqxiD6IOv3rD19MoKI1TqEpxKcUG
         W7h3X3ANMAyW+o4EM/w4LL5hvIVsyFdzpFUtEYwWc/IPI8W0tYwmD44/zw8O+1cxENFc
         vV8yAwlsNb7tiFe640iaPggLsHN/NYqKDwKxH/eFYNcWRrBehsHSQjIXFKB/37euuW2s
         3DFk4I4eMLEtMM02UFKngMyH0pFoYiusK4TYoC+fK1FvdGDnhsc1Ag4czxS7Bdbq8HpJ
         Q6toUrg8ku5/UT2AA6/dHwlVMQ2YU+YSpuDttmkitoDvt5Lu+aJ2eXZ+xvJPVrF4GrYB
         SjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061772; x=1775666572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV+tSC2Aqfk5AN8Gr0A0YOBmS6aIW69bjJ/AxSnLy9M=;
        b=ETwkkoldLD/4fUcuD8XD1iaeUa4Tg2EIL+AgFNILS7AYoaOPqzJ/JM4WqSyQyGTJjw
         myzMewlyk/EzNM1l6qIxrk91UULo2Ai1PBUp0XhPjtddBRbMjn6xWLzgahxkVeb9pxU2
         7IjMRCdnQTG3BdL5KOCZKTPo6pExBIqOjWqIq70RQhERKvqGD2brpNuwlGPFfCGMbXNu
         oPcDRLvWU6iBQ6fyBmhHRZmaffAF0O1jFCRnjrL8oLOFV7vkkiOXwscrvHurYB+uG3JL
         NH2xcC9TqCqNJCXewccSCdiNBgyYU9zRDkpQ5D60FuQaLE5X/+TtpdB+OpcpiIwIkY+l
         sMIw==
X-Forwarded-Encrypted: i=1; AJvYcCXRJlwZds1dA95vXx9agDUzwWdFvdeuMxRzv9skLfQpuhqLdJJx0YUiQIK4m8mAXxyvHidM53A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIZT0B5I8z+wA8V8roaiJQcLfH8WhXUZEtGizxZwTRjihf4YT
	fHOyw1gmcvZIjBR1vVlfDMl9ssguMv1WcCrttpnt2FDvh2R5huGf8Ad0
X-Gm-Gg: ATEYQzykG3oeJER6uaFc036RkUejLap9rxIvvbsgNNAt1B3IDDdg8lKOXByRjPW/9lx
	hpqv8gNLRxb2EgwOmSwKah5wDVB3Iz1fawwQ9SyFwM3dub16mKbmS9hnEKBt33J5O5ZjKau6O0t
	Mmab0dAT+SC+zzveMptqNb8tKwn53l7M2Xvy1LGftBXcsJFwHLC0qqVauGMrqtvpXHdi73VMc8W
	d0m7WtoiTKOdUvEkE98gPle82glfC9Dt1R6glxja4f6QixHhNKbKZVE+v72cfxF7wStMI6+NlN5
	vr+WWRYN5/yyty6e+C7wzrIHDq3pnVaQhB8M8LnaZMGx+iNG7zEd8E4A+DEud25z+jJnlv+hYkk
	4cWzkSHlDpExPZcGSUB6t4CDJkcdoH+BqXgDrGVDqf2H3KSke8XJPgOKkEdodk6xpsGdM/AcuBE
	3cGPOqg5cHivuIU4z/o+NZBfX9OL65nPm0ij6/k7AE+B4OublhkNc2R45H5nLHmLua0BQUNm1Ab
	D19Lf6hvWxp8BOf0cgrRHDWhvVVRDrXJZ6NoECX/oW//t/IUyJEnBQpS1gpbRFQhjZ7KQ69fNmP
	Mw9+aoZACM4Isu3hUsAYMy3rG11Z/CCeLRDkhYYt+L0=
X-Received: by 2002:a05:600c:a4a:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-4888355e52cmr77059995e9.5.1775061771400;
        Wed, 01 Apr 2026 09:42:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077853c1cf79fe628.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7785:3c1c:f79f:e628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8b8e8asm44527295e9.25.2026.04.01.09.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:42:50 -0700 (PDT)
Date: Wed, 1 Apr 2026 18:42:49 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	stable <stable@vger.kernel.org>, patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 034/244] bpf: Fix u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <ac1LCTbV5ZnqUgG0@mail.gmail.com>
References: <20260331161741.651718120@linuxfoundation.org>
 <20260331161742.960922011@linuxfoundation.org>
 <i4c753x3y67ek3r7dp774pcmaaaid3gvxcsvdssosdingre4in@od45qzitwtrf>
 <2026040115-dose-aerobics-7c6d@gregkh>
 <CAADnVQLSfDtqeLFw=DjG-dG=xD_qS7p2LHsT9jAxO5aAK0YJig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLSfDtqeLFw=DjG-dG=xD_qS7p2LHsT9jAxO5aAK0YJig@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,gmail.com,vger.kernel.org,lists.linux.dev,nvidia.com,etsalapatis.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-232823-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ED1D37E4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 07:32:26AM -0700, Alexei Starovoitov wrote:
> On Wed, Apr 1, 2026 at 4:44 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 01, 2026 at 02:22:58PM +0800, Shung-Hsi Yu wrote:
> > > Cc Eduard and Paul since they know this change better.
> > >
> > > On Tue, Mar 31, 2026 at 06:19:44PM +0200, Greg Kroah-Hartman wrote:
> > > > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Eduard Zingerman <eddyz87@gmail.com>
> > > >
> > > > [ Upstream commit fbc7aef517d8765e4c425d2792409bb9bf2e1f13 ]
> > > >
> > > > Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
> > > > in __reg32_deduce_bounds() in the following situations:
> > > ...
> > >
> > > Hi Greg,
> > >
> > > This patch is causing the following BPF selftests to fail
> > >
> > >   #222 reg_bounds_crafted
> > >   #222/27 reg_bounds_crafted/(u64)[0x7fffffffffffffff; 0xffffffff00000000] (s64)<op> 0
> > >   #222/28 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffffffffffff; 0xffffffff00000000]
> > >   #222/29 reg_bounds_crafted/(u64)[0x7fffffff00000001; 0xffffffff00000000] (s64)<op> 0
> > >   #222/30 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffff00000001; 0xffffffff00000000]
> > >   #222/59 reg_bounds_crafted/(s64)[0xffffffff00000001; 0] (u64)<op> 0xffffffff00000000
> > >   #222/60 reg_bounds_crafted/(s64)0xffffffff00000000 (u64)<op> [0xffffffff00000001; 0]
> > >   #222/79 reg_bounds_crafted/(s64)[S64_MIN; 0] (u64)<op> 0
> > >   #222/80 reg_bounds_crafted/(s64)0 (u64)<op> [S64_MIN; 0]
> > >   #262 reg_bounds_rand_consts_s64_u64
> > >
> > > The failure is caused by the selftests' expectation not aligning to the
> > > stable 6.12 behavior. I believe the easier way out is to drop this, then
> > > wait for [1] to land and pick it up in stable (or I'll try to backport
> > > and send). That should address the root cause of what this patch is
> > > trying to workaround.
> > >
> > > 1: https://lore.kernel.org/bpf/d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com/
> >
> > Now dropped, thanks.
> 
> I suggest ignoring the selftest failures.
> The patch is necessary for stable and backports.
> It's fixing a real issue.

The selftest is failing because we're missing commit 1f8fe377855b
("bpf: Improve bounds when s64 crosses sign boundary") in v6.12. It's
the s64 counterpart to the s32 patch backported here.

In bpf-next, we have both the s64 and the s32 patches. The s32 patch
also updates the reg_bounds_crafted selftest to cover the logic for
both the s64 and s32 patches. If we backport only the s32 patch, the
updated selftest fails.

I can send v6.12 backports for both the s32 and s64 patchsets if that
helps. There are a couple minor conflicts when backporting the new
selftests. Or we can just cherry-pick 1f8fe377855b alone.


