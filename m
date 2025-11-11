Return-Path: <stable+bounces-194441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE61C4BB00
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 07:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F86C3B58FB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 06:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21DE2D97BD;
	Tue, 11 Nov 2025 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fo2KCE4p"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155D2D878D;
	Tue, 11 Nov 2025 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843124; cv=none; b=rw9lQvx0a4SyxJWFmTrVKdCiHBh5o31UrN7C341I6ngB4+0Ddk17UY8t/nMU85U6tiDABduehXAuAlwcqlriZEL1oCHO5OgZf2X4+hDmtPZLdQtixKsBxxx6bQPQoAK7hcT7b3alisqLozj08JKiqSnIoqKGkMgxqTKnxm+OnKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843124; c=relaxed/simple;
	bh=6di1o71pk/6OFEAwg8psKSCAvfy6s+Jw2/vTk61MmuA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=b2IbBrbMXdidmhB2ezx6hqQtJmyfdItf0XdFxhEulZhSqYEUfp3O3AlBUeXhqoz091BbOmoBl6V/ROhitWDOi7bgweWf4PmXSFI4+wqzggXjYWAh/f5Edwuld9uPA49eD3uWeddJlbW+sLN83SfpFf968Ty8pvzgiLD3gjle3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=fo2KCE4p; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1762843105; x=1763102305;
	bh=2gP/UTs3E1V8UWhQmC3621rbndr983hJJAJfWyYU26c=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fo2KCE4pKXtT1q2HIoaHRpMYy/X5PrUJemvfIL6g9U4HK6a8/gZNoH4KLlNz/zUAh
	 3CPlyOMUuXpK6IVY9qN8LhU89C7wI8em8arXLh349jbEp0MwqLX0ftc4Kzle5GSmnc
	 yK879IRBV2TVuvOaywjeidz+8tf3zjeJVbUs+MC6fos2pslfK86X3tVqrkswg3OpMj
	 Yw7k4G6BarjhKsmax0AvCdgmyOKjYvsi+ZKXUt4KJsz1OqqkzNxMhWCVCFme9VMiuv
	 GjJak8O8gRh2KeYtP/VNbzVHw9HGOcqUsANsH2jWwGXrz+Y8Qd5joCXdbfVzOuPc5+
	 Qb78JrQt0XBoQ==
Date: Tue, 11 Nov 2025 06:38:21 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zizhi Wo <wozizhi@huaweicloud.com>
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
Message-ID: <zuLBWV-yhJXc0iM4l5T-O63M-kKmI2FlUSVgZl6B3WubvFEHRbBYQyhKsRcK4YyKk_iePF4STJihe7hx5H3KCU2KblG32oXwsxn9tzpTm5w=@protonmail.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 6639fe2dd9b290776e25ba6748290397a81e88a5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
[SNIP]
> Zizhi Wo <wozizhi@huaweicloud.com>
>     tty/vt: Add missing return value for VT_RESIZE in vt_ioctl()
=20
Locking seems to be messed up in backport of above mentioned patch.
=20
That patch is viewable here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/=
commit/?h=3Dqueue/6.12&id=3D884e9ac7361b2a3c3a7a90ffaf541ffc2ded6738

Upstream uses guard() locking:
|    case VT_RESIZE:
|    {
|        ....
|        guard(console_lock)();
|        ^^^^^^^^^^^^^^^^^^^^^-------this generates auto-unlock code
|        ....
|        ret =3D __vc_resize(vc_cons[i].d, cc, ll, true);
|        if (ret)
|            return ret;
|            ^^^^^^^^^^----------this releases console lock
|        ....
|        break;   =20
|    }
=20
Older stable branches use old-school locking:
|    case VT_RESIZE:
|    {
|        ....
|        console_lock();
|        ....
|        ret =3D __vc_resize(vc_cons[i].d, cc, ll, true);
|        if (ret)
|            return ret;
|            ^^^^^^^^^^----------this does not release console lock
|        ....
|        console_unlock();
|        break;
|    }
=20
Backporting upstream fixes that use guard() locking to older stable
branches that use old-school locking need "extra sports".
=20
Please consider dropping or fixing above mentioned patch.

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


