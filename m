Return-Path: <stable+bounces-216281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG1+Hqlgj2nNQgEAu9opvQ
	(envelope-from <stable+bounces-216281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:34:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5F138ACF
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 381CA3033224
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC5286409;
	Fri, 13 Feb 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4kZi3Hy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDE263F34
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004070; cv=pass; b=HHVCt2GXlLuZWnCBA3pUjL0SNLixChS8MaCdD2ZeZiWhbQ9OB/Esr8UTWqBeEggrIs/3dodOSiWbooJ9cUYPQCt9qRbRK1/WhQDmoPJm0wztB6PT5Sq/3ZRc05Macd/6Ae4lbPU3POCU0OKIgbCXwjqCqfx7KT5b1pOTtAk0Do4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004070; c=relaxed/simple;
	bh=nIhERrl+/6suf9bReXI5bkMmHJHcG8yyweVsM7E+Vss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9i+jpmeyzTtG/RWCmj3tQWfhDSjPrC+ZtVzUbMq0nN9cNuAz+pgYa/AD47tpDcaKtMgMBdhBHrusPb5QwbPRCh3ym1oeGM8MKNhwIhHLn9GeN/6GTjWRe6NEQZLfQJgBvyzgnlOrW9Msxj3WjJAjcTXTQHdjohdh0DO4rymWhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4kZi3Hy; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89505dd3e24so15061836d6.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:34:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771004068; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3aGCtL4skBsNjWkCe8YdAPoj0bf88ZppknOfeNhw9g0snqTaoNO+eAL2EcBLjbC52
         KZPeSh/gkAFENPp24p6st/5zUQ4VSDpLKjn/2et4dvMIgBlYfyAV/vV0yo34rsmM5ggp
         V7wdMI+Bx8fvi5H6/j161rn4HGFhqspC1JIvSX81zat/+FuHozgDRc0jxKs+jcv94E8v
         ONR8TBqiEVIAGB4HKdtnJvjcbjFjCHBwTxzM8x562eLsL3wtXTp2urOPxuLeMZZSj6Aw
         pIQwA62Od/mfSOObzQXy7S0zH01anE7Q99X7phjFACbH+a6KrMPCDOWtnw25DMuWqfQC
         Cbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4yvhP1H7yHsZiLOV9ztUW3AB5Dd0c5ghQQ4/diRvLxY=;
        fh=X0Dnr1ZqrGJII/6Mht1jyyLx4Upo/WV+aYvB6/wDwJM=;
        b=LMj0nM8hYZQp+Ph1I/mn0eW1spKBJ3OQAFAUak2AoVb82TGizhToissCdBIcMD41a9
         cl3Q/Gc45uTBcWrmhPTUOqH5GlYATLTRaBpEXPe5itxpnod6GddrRA8Zvgf0Rj6KdPAI
         6WMnh6uixcIiHGHGUhggg6lJw3LIsDnHdhmNqK5AYVeYaRktn0PiTS4i/xFbYggTFkta
         jwUtN6zIVktI5DdCefUUodpFzhBVuSce2OoDWVMTLgV1H0atIS+ZpXPLPx7Ggs3RlfiZ
         0QPrXwyyBjZ0VIn/7kGo0mQPNMzYAJIPem1nL80Fwak0EN7dIoNCn7G82qLMFx5AFh8r
         jgVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771004068; x=1771608868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yvhP1H7yHsZiLOV9ztUW3AB5Dd0c5ghQQ4/diRvLxY=;
        b=N4kZi3HybwtA6g+06hp2R8jbWCVDrK1T+i7Ipn+ClNXv2qq+QzYAuVd5MTnTrRmRzR
         k4p8rG5Cvg5CIye8K4YySTGOdhrp1+XOc4TK6fst09PgXAfuF5/d1hwavPwIN6NaIaLp
         buaRjWAYqzxqR0En37VnEjcwFgq4lLE1/KAgL5CkvU1rBGyaSv6ooCA8tuPCsq0u/2tI
         Q+16Nlki+96jXDWjI4H+Yp3RxgQbJwoEFzJxKqKb2aS3jsMsl9JtAUf5GGqmClp9StYP
         /hxSMK7RVAVI6i2+e8Zo7T7hi/cqz6XyPTB0ZWhCw6wSVF0YoE2jeiOm7aYLKKxKIdpF
         Hs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004068; x=1771608868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yvhP1H7yHsZiLOV9ztUW3AB5Dd0c5ghQQ4/diRvLxY=;
        b=BtaKcSeHW6vRKnwHOKxn0bM0112wLhVPz3DO/Am4hrC2Jx+4+7rLxkq8jcTf1kdWAI
         /wQMtizfBXo26Y4rkw6lyQTQ5hO4vpPGH0G5nXHmlr+nUCJ29pb7M8QZ8G2D6D/2J2KR
         DzmRSMQ44J0jFfWLySYiAXnOZgrK9Z5Poas7K0xarKhMwaP2fqDBwKv5r2zcKUuTCJpE
         HM+9bwhM+1PIWYRF45XV7iNYLfHLqVK2bv/AQtkbkqura7rJLP278p5s/CfqULIrMbZb
         uO00bWgEAZ3ifSTjdWT4swQOQjuYLJ/PqSE6DVgyVDPqdzu4hLwg/NqDDfoCRO95D38W
         75JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3RUzrL2v1lOWhcVSnIC+nhURFR0SY733uDxEfKMS8ssFyyGc39jkcqFAec3lyKKxnB4qW9Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4RA2Rks+ilIA/akmbXFzeWwRIn83pzU0oADkpP5S3aqffNYq5
	W6uU7GQA23Jl1nssa4gkKRGjtaoF+WWudOZFUHUV5+xQLMo/QJQgqiTCx1GlPRX7SZ5OmnMdCM/
	2L3/Skz+hrWPHCEbRLaZSVFp5nC7XxuU=
X-Gm-Gg: AZuq6aKYSyN/gsu8dI+h5erDIZh0PF0+7lz5PAIILmd4Kj/60+Zp2hDlfv4piUBRFbq
	dot6KwDJwOZ9eaDjJK51tmh7tSUpwmLRcChKfcNOnOS9qh3ZphCJVYFQMKYT9+aW3ukfLKIuLrC
	OCXUQz9GSxNjKO4G87MjXUXlkf+zyZJnJYEQZapHFRJ4oeZR6HKf8/TTnXivrzKz+7KAFGLMurf
	1sdSK4v/VH3ZOQndbDnS0TlvdKaUFQN/MF4rbFW64dr768Wv+jO9UKkOpnCkqUHxjvFQ7zVpxVG
	TuQ7ArVmiW0P+aYjAfLVhW98c81ixHre8fiy880I3NOmle8wg59fNzN8x3dMZ5hZkCAKJG7KdjG
	C07Hq5gnw25GFOk5xNfFYV8vR3LMibWAZkqsiOJTzeZFDuoWEdasjE24wsl1l+2PE+WCOtP+xZw
	==
X-Received: by 2002:a05:6214:1c0a:b0:896:f9c7:a833 with SMTP id
 6a1803df08f44-8973606eaa8mr33561156d6.12.1771004067962; Fri, 13 Feb 2026
 09:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-kbuild-fix-debuginfo-rpm-v1-0-0730b92b14bc@kernel.org> <aY8wyR572eZYWVJY@sgarzare-redhat>
In-Reply-To: <aY8wyR572eZYWVJY@sgarzare-redhat>
From: Steve French <smfrench@gmail.com>
Date: Fri, 13 Feb 2026 11:34:16 -0600
X-Gm-Features: AZwV_QiOcHxyXHosuJrWmnZirG4ujnDxFjrIXSXPyoAT82XMAIdRgLRxgC8uN-Q
Message-ID: <CAH2r5mtRZdQfdBBVZBaiL0MiEA7DWkczYMafiDaEBSby5RxK7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] kbuild: rpm-pkg: Address -debuginfo build regression
 with RPM < 4.20.0
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216281-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3B5F138ACF
X-Rspamd-Action: no action

Can also add Tested-by: Steve French <stfrench@microsoft.com>

On Fri, Feb 13, 2026 at 8:11=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Tue, Feb 10, 2026 at 12:04:47AM -0700, Nathan Chancellor wrote:
> >Steve reported a build issue with commit 62089b804895 ("kbuild: rpm-pkg:
> >Generate debuginfo package manually") on RHEL9, which has an older
> >version of RPM than what I tested. Turns out that RPM 4.20.0 fixed an
> >issue with specifying %files for a -debuginfo subpackage.
> >
> >The first patch restricts the new -debuginfo package generation process
> >to CONFIG_MODULE_SIG=3Dy and RPM >=3D 4.20.0 to ensure it is actually
> >necessary and working. The second patch restores the original -debuginfo
> >package generation process from commit a7c699d090a1 ("kbuild: rpm-pkg:
> >build a debuginfo RPM") when CONFIG_MODULE_SIG is disabled to keep the
> >-debuginfo package around for older versions of RPM.
>
> Yeah, I had similar issue on Fedora 42 (RPM version 4.20.1) and this
> series fixed my issue.
>
> >
> >---
> >Nathan Chancellor (2):
> >      kbuild: rpm-pkg: Restrict manual debug package creation
> >      kernel: rpm-pkg: Restore find-debuginfo.sh approach to -debuginfo =
package
> >
> > scripts/package/kernel.spec | 57 ++++++++++++++++++++++++++++++++++++++=
+------
> > scripts/package/mkspec      | 38 +++++++++++++++++++++++++++---
> > 2 files changed, 85 insertions(+), 10 deletions(-)
> >---
> >base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> >change-id: 20260209-kbuild-fix-debuginfo-rpm-718f81dbcaa6
>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
>
> Thanks,
> Stefano
>


--=20
Thanks,

Steve

