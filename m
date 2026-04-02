Return-Path: <stable+bounces-232981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDzOHG5NzmmjmgYAu9opvQ
	(envelope-from <stable+bounces-232981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:05:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6CB388110
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8870A30579E8
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE03630BF;
	Thu,  2 Apr 2026 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVgp8y95"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC503AD536
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127731; cv=none; b=qHfMc5i9qKKRYUNeBSfDQXteDIoVwsxNL2w/FXQaoQ4fR1z3b+dIz6DDwCQ4LKfdGGy8Ty88HRdK33HVxZVBIp1xGslwhT3WxZ+dIkJDem9xP4M98RrMC8AChUTXAYEVepIg4ItrOD4Hxt2PeBJHsQun/2dNerytDYo6oAvhRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127731; c=relaxed/simple;
	bh=g1PUzPDOerdwNyKi6ER2gbfLx+t48czd+Z5hXY6tY4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4FjIItMXyqKTHrC2knkpj3YsQ+N0t7xAvgoxeY/bJr0sUlZ0SZ4dWOvRoifZtku1d1KOEyAOXgLko5/hYOu5eAPwiCJvnXqfTXz2gwm6KrjQhNxDeGKWNwZI2AG9w+IK03EAyyvQVqCiFnlBopJ4yccYeCL/3kniKiipzwmVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVgp8y95; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486ff201041so6983625e9.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775127728; x=1775732528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tf3op5lKH+OvN0zw8qp3z/h5oZygSPqopKpCD8089zY=;
        b=bVgp8y95SQqdqXXFeP77cHYe/zryT10pV1j2LM6P5iXkWM008Llu5+hSdze34c7vA6
         n0RwrsYECtBbwRC6A+DVYmlztpZJH8jgGQwcmgZRUVVS58e3TYZtVJOVmSUQMk6HOBUm
         WDIqO5FAIu0zh0a8yF8IXxTegmoUyvJozX6tNG8n/GMorQy8MXovxvkWzapekAZSnNt8
         wdYAKV6alrD78mafdjSdGaWP+XJqoyIIHieDks38xr9mScDCS0AzMR5HeozP9+cfnpwd
         KSwk0RDCR2Y2FnOLJxVg4d6cP+oDWETjCQgbYokEpvPK4Dup/8TYWVVpKDk8SfhQpIvm
         Yz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127728; x=1775732528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tf3op5lKH+OvN0zw8qp3z/h5oZygSPqopKpCD8089zY=;
        b=RqOS9BBQB1C+jz+Jime3ooFSPN3cajNwW4f8IqfCF4A8fMUFMfzPWdZmIeD0nNA1Hj
         2bcNS59fbMnKzbBDVkO/xaZuq/p1g4AeCPE2OAz9s75AxTpwmoVZu8RG7zWdLE9Qzxli
         kHy5zs4d+IWirSXTgiDLu+JP6RI4bfAXD8gHVmGiGmjfOYRDTyRiCOZ4ikyiRMCghpcZ
         0aKUEqJIEvPDs2ZlIiAqQWfOi2Fha4wLP+fqgja2TnNT6RX2yULIWgzKL86S2eFn2sXU
         3Nr1/goByag+W13NbVl4Vov/PQp8DfZfrIXdw04v97T3/PhcChmEtFAXSi6EERtYvMeQ
         wKVg==
X-Forwarded-Encrypted: i=1; AJvYcCWxrf5h2rPzlxRCTBpyrv6mkrFB52hBmncXb3Z+75Dfp9AKFELpSNR8kr+cVjCXsRvc4UNnu7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnrLPE52HY60w8inrECW0HAqZQKsFVw5nsm41aU/DFpzW3qBc
	G7GzWSRNCSSbZMqbanl7jDca8Xcp/YgMujJRlEXS7yg2qQeXTLefPb/G
X-Gm-Gg: ATEYQzzZ/kKNZ2DzCbhcXQ2K4q7qkCQzgcMYB7VowHNEDc5JfxRn96ZWc3EQ1k/FsMm
	yFW+aFqnqKfp0NZbs4gqUuyofyPVVNQGQksoW5NV3CalYLRfL5AyYjqy8jKgr5dsHb9pQqLpshf
	GffY5kQN4h7K/ZM2khgKqp53MkjsfgDEApgSEkD2BKEU1CFUDkDOi/YC0EMkwoK5dVrFHyBg+Aj
	mOcjVpmRhhQueZfJnO6UnPydWILIx1zKmZAH8rzylBPROsS9mWpTW5OLl/q0jlVqwPV2sb7YHNS
	LQzr4yDTaP+7l0SvJI8U6WkOqT7AYP98zm622QtZvt9OeGbFI3I0l9tKhHM5tZZsS/fZxIqJ45Z
	M90+a+TK8r2c2GtyajlQ4eqI/p+zDIfJ3Zihjarm9eDXhGaIGCDVC4aQ1nzNXDi3F9osU92K5sL
	dlJaIrkjhZIqT/MUYSwTqzJidCk1qsrGCf3jEaaNpaqHlmE2Zmma+0cQ0uBBFv8Fa3aigcPEf/O
	ZQwk8W0VhVxMpDCWatgA+HiSMqIeGArp87vYne5twlZaSh1McFoVjS6VFYHRoJMQmnYDwlzOlNo
	Kpi/SeeiP9yk/Z8b0dZR8f6Hz9jQOBGhDln9ZLA2imk=
X-Received: by 2002:a05:600c:c107:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-4888b6f7f5emr34209405e9.8.1775127727616;
        Thu, 02 Apr 2026 04:02:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aacb88fsm65229755e9.2.2026.04.02.04.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:02:06 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:02:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	stable <stable@vger.kernel.org>, patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 034/244] bpf: Fix u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <ac5MrSA8VbSNdlG_@mail.gmail.com>
References: <20260331161741.651718120@linuxfoundation.org>
 <20260331161742.960922011@linuxfoundation.org>
 <i4c753x3y67ek3r7dp774pcmaaaid3gvxcsvdssosdingre4in@od45qzitwtrf>
 <2026040115-dose-aerobics-7c6d@gregkh>
 <CAADnVQLSfDtqeLFw=DjG-dG=xD_qS7p2LHsT9jAxO5aAK0YJig@mail.gmail.com>
 <ac1LCTbV5ZnqUgG0@mail.gmail.com>
 <2026040240-friday-gurgling-7088@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026040240-friday-gurgling-7088@gregkh>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,vger.kernel.org,lists.linux.dev,nvidia.com,etsalapatis.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232981-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF6CB388110
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 12:46:10PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 01, 2026 at 06:42:49PM +0200, Paul Chaignon wrote:
> > On Wed, Apr 01, 2026 at 07:32:26AM -0700, Alexei Starovoitov wrote:
> > > On Wed, Apr 1, 2026 at 4:44 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Apr 01, 2026 at 02:22:58PM +0800, Shung-Hsi Yu wrote:
> > > > > Cc Eduard and Paul since they know this change better.
> > > > >
> > > > > On Tue, Mar 31, 2026 at 06:19:44PM +0200, Greg Kroah-Hartman wrote:
> > > > > > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > > > > >
> > > > > > ------------------
> > > > > >
> > > > > > From: Eduard Zingerman <eddyz87@gmail.com>
> > > > > >
> > > > > > [ Upstream commit fbc7aef517d8765e4c425d2792409bb9bf2e1f13 ]
> > > > > >
> > > > > > Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
> > > > > > in __reg32_deduce_bounds() in the following situations:
> > > > > ...
> > > > >
> > > > > Hi Greg,
> > > > >
> > > > > This patch is causing the following BPF selftests to fail
> > > > >
> > > > >   #222 reg_bounds_crafted
> > > > >   #222/27 reg_bounds_crafted/(u64)[0x7fffffffffffffff; 0xffffffff00000000] (s64)<op> 0
> > > > >   #222/28 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffffffffffff; 0xffffffff00000000]
> > > > >   #222/29 reg_bounds_crafted/(u64)[0x7fffffff00000001; 0xffffffff00000000] (s64)<op> 0
> > > > >   #222/30 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffff00000001; 0xffffffff00000000]
> > > > >   #222/59 reg_bounds_crafted/(s64)[0xffffffff00000001; 0] (u64)<op> 0xffffffff00000000
> > > > >   #222/60 reg_bounds_crafted/(s64)0xffffffff00000000 (u64)<op> [0xffffffff00000001; 0]
> > > > >   #222/79 reg_bounds_crafted/(s64)[S64_MIN; 0] (u64)<op> 0
> > > > >   #222/80 reg_bounds_crafted/(s64)0 (u64)<op> [S64_MIN; 0]
> > > > >   #262 reg_bounds_rand_consts_s64_u64
> > > > >
> > > > > The failure is caused by the selftests' expectation not aligning to the
> > > > > stable 6.12 behavior. I believe the easier way out is to drop this, then
> > > > > wait for [1] to land and pick it up in stable (or I'll try to backport
> > > > > and send). That should address the root cause of what this patch is
> > > > > trying to workaround.
> > > > >
> > > > > 1: https://lore.kernel.org/bpf/d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com/
> > > >
> > > > Now dropped, thanks.
> > > 
> > > I suggest ignoring the selftest failures.
> > > The patch is necessary for stable and backports.
> > > It's fixing a real issue.
> > 
> > The selftest is failing because we're missing commit 1f8fe377855b
> > ("bpf: Improve bounds when s64 crosses sign boundary") in v6.12. It's
> > the s64 counterpart to the s32 patch backported here.
> > 
> > In bpf-next, we have both the s64 and the s32 patches. The s32 patch
> > also updates the reg_bounds_crafted selftest to cover the logic for
> > both the s64 and s32 patches. If we backport only the s32 patch, the
> > updated selftest fails.
> > 
> > I can send v6.12 backports for both the s32 and s64 patchsets if that
> > helps. There are a couple minor conflicts when backporting the new
> > selftests. Or we can just cherry-pick 1f8fe377855b alone.
> > 
> 
> I'll keep this dropped for now as I have no idea what 1f8fe377855b is,
> as that's not a valid git id in Linus's tree.

My bad, I meant commit 00bf8d0c6c9b ("bpf: Improve bounds when s64
crosses sign boundary").

> 
> Can you send the 2 patches needed here and I will queue them up.

Will do. Thanks!

> 
> thanks,
> 
> greg k-h

