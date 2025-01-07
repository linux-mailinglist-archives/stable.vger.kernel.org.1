Return-Path: <stable+bounces-107836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57EA03EF6
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1652188566C
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7701DFE0A;
	Tue,  7 Jan 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud7BMJko"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A118C0C
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252488; cv=none; b=Popif2roI3dKy7vbmYT3WFLFMnNeOb0lJtK1cyDy+xBfFHJ4D41A1eMB/Ga1XyFCl5KoolbDJmXSb4sJJ8Izhu41OLMSlnOpuVwpGUnLkmpSLa7IX8lrUiUHTBNHD7NGy/0uaCOqCiUUsGgS6IGZxQAsoq/brxiKiYMOjYVwFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252488; c=relaxed/simple;
	bh=D1Etn3txFhKoQjFizo9oCi0lO+MKHRok+gDKC6yCRaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDau4U+eqbEzKtKtrJPLtr/gMSE2m0iyNCeRFGsQwmGA19asnig/0lzjGDq6Y6+wAMnvnCgCEyFlJR0+O9ux3Yg05wgQzAifQAwQRNSVkQ7cOIiHQ4VC+zj53MVvx6hyOkw4GjWrWnKfUhdBSlOOioPpVtS9YnxjVs7bAhBD8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud7BMJko; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21634338cfdso6334065ad.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 04:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736252484; x=1736857284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMk5FvMugOn4M96ewqgpsWQainnISa9eVMfptWei7UY=;
        b=Ud7BMJkowm5EbzQE4WPvRMoaofQQ+diPYLzf2vo5HsnyJL/9ueAv5hhlg0y+i9k39Z
         apCGnQn0jl46YSx2f5AnAcTShSvY5SZi+bS1aYajnpe7betI/PXkGbLFn1gXGOw7hL5I
         OvU5cAWLt6884AcczmZEk0nj9j6tdhXr2mWIiWTW/OCoH5oLXsoFaHvbRQ1SVP8ojd71
         O/5h+DjiKPSWSYCrbVv4h8+841srBTc+hTmHCoGdrRTvznf4Es76us40c3G/yXCsOvwy
         RKssksKhRkuHy2yWxefm3rhEkVFN2fhLFB/iQf9v6+T4WJlDeIY+MjyhTbZ54k3zQ6K+
         cFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736252484; x=1736857284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMk5FvMugOn4M96ewqgpsWQainnISa9eVMfptWei7UY=;
        b=EP1QF7w0iCWb6wbZN8clkpGpTbUwH/dyPuhYYI+d7bf702WTdiT9tUa2Tp6vLWLtC/
         imgOD1mqnbaIQn4dgsffpneBwLxTR7txzNw/BI0+ByMuPtzfNqCLTlxAz+hr07/5JgfT
         SKxPztU6jt3uDP3rqm14T0Km/QrgWuyBNoPTSv4hQhm4nqGMmbMtjNWRrrF+IAtNbXMj
         lPJ1VSaVsQYOMgrGgqFNywkRMg2cGskUaU94usTN7HevMrqP+eWNmsNbGaJTBRF3zWTb
         vryQ7T/sIxRnk/aBcGY+rjt/RxqSmMOykMjQ4v5fmwDhVsYnwZ7wskCwdaOHJIZ8HGTc
         kt5w==
X-Gm-Message-State: AOJu0YxpABzhJ2Ts5dRT3PIGb1MJqa29ATajReZYRbEewSiPI2MpqOcX
	+KcgCn/f5Z7WD3FY/vHWHnHQfxVOhkTbZ8wZM6ss5OjEMj0lVdjXo+V4JHvlWHLdItm/Ko/7jjh
	oFDP4SjsGDn4U4k9KGRQsACB3YGR7q2OK
X-Gm-Gg: ASbGncsCVTgXskjPipFxyjN5XtAQZlQfCbN1glp+RHOsaKC+83N5vOs6hFiCnybjR+Q
	72PDy7IYJvq4/qzYmiWX/vp/2l5NbIQIO8wPfVQ==
X-Google-Smtp-Source: AGHT+IF/oo8IEKv/OpOv7Nts3WwiuFWPiAadrA9W8YOOQSaDPIVl9tifEfOEYCOU9txhDO7q88i/wtHWiiqZWz6vIyU=
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2f452dfccdcmr91045475a91.4.1736252483836; Tue, 07 Jan 2025
 04:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151150.585603565@linuxfoundation.org> <20250106151155.069105214@linuxfoundation.org>
In-Reply-To: <20250106151155.069105214@linuxfoundation.org>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 7 Jan 2025 13:21:12 +0100
Message-ID: <CAOi1vP9_s3oW8XP6bytvKm3JocPO0-odkv9LQFuuEU==JBgfaw@mail.gmail.com>
Subject: Re: [PATCH 6.6 118/222] ceph: print cluster fsid and client global_id
 in all debug logs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Xiubo Li <xiubli@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, 
	Milind Changire <mchangir@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 4:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Xiubo Li <xiubli@redhat.com>
>
> [ Upstream commit 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ]
>
> Multiple CephFS mounts on a host is increasingly common so
> disambiguating messages like this is necessary and will make it easier
> to debug issues.
>
> At the same this will improve the debug logs to make them easier to
> troubleshooting issues, such as print the ino# instead only printing
> the memory addresses of the corresponding inodes and print the dentry
> names instead of the corresponding memory addresses for the dentry,etc.
>
> Link: https://tracker.ceph.com/issues/61590
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
> Reviewed-by: Milind Changire <mchangir@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Stable-dep-of: 550f7ca98ee0 ("ceph: give up on paths longer than PATH_MAX=
")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ceph/acl.c        |   6 +-
>  fs/ceph/addr.c       | 279 +++++++++--------
>  fs/ceph/caps.c       | 710 +++++++++++++++++++++++++------------------
>  fs/ceph/crypto.c     |  39 ++-
>  fs/ceph/debugfs.c    |   6 +-
>  fs/ceph/dir.c        | 218 +++++++------
>  fs/ceph/export.c     |  39 +--
>  fs/ceph/file.c       | 245 ++++++++-------
>  fs/ceph/inode.c      | 485 ++++++++++++++++-------------
>  fs/ceph/ioctl.c      |  13 +-
>  fs/ceph/locks.c      |  57 ++--
>  fs/ceph/mds_client.c | 558 +++++++++++++++++++---------------
>  fs/ceph/mdsmap.c     |  24 +-
>  fs/ceph/metric.c     |   5 +-
>  fs/ceph/quota.c      |  29 +-
>  fs/ceph/snap.c       | 174 ++++++-----
>  fs/ceph/super.c      |  70 +++--
>  fs/ceph/super.h      |   6 +
>  fs/ceph/xattr.c      |  96 +++---
>  19 files changed, 1747 insertions(+), 1312 deletions(-)

Hi Greg,

This is a huge patch, albeit mostly mechanical.  Commit 550f7ca98ee0
("ceph: give up on paths longer than PATH_MAX") for which this patch is
a dependency just removes the affected log message, so it could be
backported with a trivial conflict resolution instead of taking in
5c5f0d2b5f92 ("libceph: add doutc and *_client debug macros support")
and 38d46409c463 ("ceph: print cluster fsid and client global_id in all
debug logs") to arrange for a "clean" backport.

Were these cherry picks done in an automated fashion by a tool that
tries to identify and pull prerequisite patches based on "git blame"
output?  The result appears to go against the rules laid out in
Documentation/process/stable-kernel-rules.rst (particularly the limit
on the number of lines), so I wanted to clarify the expected workflow
of the stable team in this area.  Are "clean" backports considered to
justify additional prerequisite patches of this size even when the
conflict resolution is "take ours" or otherwise trivial?

Thanks,

                Ilya

