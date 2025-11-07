Return-Path: <stable+bounces-192702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E94C3F488
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 10:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 365894EABB1
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788A3009EE;
	Fri,  7 Nov 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D06raH48"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75082F5A0D
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509479; cv=none; b=QW7IqpVkW1aFDa3sEqx/IaRtk2OIwSb9P+tVIRiNa75tWeBGHVXCGRoEWSeWjGUJbMyqJVCFdNsCtAAJHZLWZwWMjsKmmt21jMQkJddsKqbYFGMqYlCmbCTZkIovP+w0rbgw5UXoFVRrA1B4OR7Tc/MpHmaVZMu0uTj+aLhVBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509479; c=relaxed/simple;
	bh=KQApMmeyeroojj1oOh/JwuYBVW4ykgOBnlMtNZQB+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aixKh2BYUo6GMGwrHO4wceUBJDzuugYrHiD5O90rOf59zVPjL+mtF7xYzmW6cRmQiYrM3oxWEIcV5FR9orO5/lc+C0XFYax7kUXgbqXBAKK6ddLvtIh+dUjnazdmk/rfGpT8K2VWILFqnnJW6I9k+apEciKJb6UYJtDbP2Sh6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D06raH48; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so347195f8f.3
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 01:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762509476; x=1763114276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQApMmeyeroojj1oOh/JwuYBVW4ykgOBnlMtNZQB+YA=;
        b=D06raH48kP1ho67e3kOoT2LSpBXFcforv+fHeGj5MEwPYSXcDSNfUODM38z37QiRAN
         qSriMCIQLsNFPjrWgWV0RwkHEwLckKxnbmnA/OEW2gV1MN/jowT6RDaLfcxKBNCdh0Bk
         gbQYCLiq5lKs2NM0yXwDTiV/EUc4q6CiMoCio/AxqcIF+c0iIVGYi6xGG82Yu0L8ctWX
         FDBSjKE5fPjm0PUTvCBTXbX+Ss+KIWTZNHmbR8+rHiHXLa/NUAD3Z7RLPElRhoBbquGm
         VVCyCR21AMX2lxjJLgFN9267TudGZvBNt6gLpB7V6wFvmXKQ5WA5Ev9D0eK9o4SHUOdX
         m6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509476; x=1763114276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQApMmeyeroojj1oOh/JwuYBVW4ykgOBnlMtNZQB+YA=;
        b=gRpVIED0XOR0qTgU2W6wVZW0yiCPW0lK5FYqWt/FqrfRDXp1KWltYkFRHYUqJq1f5R
         Yu0/OcReFIzeZ/vBc0I4kgILBh66+8SDS9N/l63yfmMwGXs/0iHtHzptTbrBRswTjfSf
         viMe6xyupU7rrx0S/zceniAZaLOJhvccOuAdQD7cEnqSSGKYXAK2aS/WRIuyXoO1xcaI
         qbjUN4CPJ7HgTkFL/u5syc35xX2ApF5rtgkQ9mDL5/QdUhwQP+HHJ36weNGJVHxG4uwJ
         pZw5Ty4tTQws7WybwaxHL4FdAIJ14wJk8L52pc8dHMZze30zuu6VYhhtB5SornzIqoWx
         dJVg==
X-Forwarded-Encrypted: i=1; AJvYcCXhfsiHu1Lmom2f/dZeffNwAmuUtMEcdlDQDSI7j5rcDRbdnWGkxzp4gy42HW6EYeXPOaWrayw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCj6cILvyOaCW5p3qCVFJv/nJtVWaA701h0o5OWvawh5OMFGmk
	/gMBqIjTFtFa9J8RpVVIy53tRtbh4bd+tEKQ0q4cDlBbqJHaebKT4kTQFAkjG6+c5+c=
X-Gm-Gg: ASbGncv/TNiusOgnECaoV5Dq2wFVLFf7LNlnwGBJ5OHidDSu84lzP9Wl/Z8IvFdbcW1
	98/Q2r3fzs/phPqcXGrJf6qhjtFW7nXFhnj5O2KsisL8/OpeA8xO5KJ4DsCMkV9P4k++A94JpdA
	cde3A/d4VJfHO2L/xEZIRw4x0eewjJ4sC8meghbslPh5ag/33oRfAJ3lIi6fv/MNncSRHOZcga5
	ry76epha//FYuWHU4wAwzuhDPrzSaaIiG4fsaG6zTzQtIwBOt4kG9mtNcxQWtAgNrIEmerMuEdy
	hM2X6LVcde+vRCBrHWgEYhOh8dYDHk27jSsDIhaZfTMM36IhQ5eVMg+Hcq2ENDAJV24XpXnFVYw
	ro5bNwJ5NnG3YBIxbSkw9388hNUq1+FSLkB6BHVvGun2ama5ZxasrmbROt727dTQcyVOX4tFFVK
	eSQkLGrxINmHIf+D6WvlgS
X-Google-Smtp-Source: AGHT+IGYXYnlAsEjuk23F3IZ/BoFx5TsEGM0egBLAX1ErlqS5ss+2CzpuASNt4N0drqS+uWjT87dzA==
X-Received: by 2002:a05:6000:656:b0:429:bb40:eecd with SMTP id ffacd0b85a97d-42aefb43e0emr1979840f8f.52.1762509476103;
        Fri, 07 Nov 2025 01:57:56 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca3csm4397591f8f.23.2025.11.07.01.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:57:55 -0800 (PST)
Date: Fri, 7 Nov 2025 10:57:54 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in
 cgroup.procs and cgroup.threads
Message-ID: <5r6yyuleoru7h6wcbdw673nlfzzbsc24sltmfg5hk2mj6a34xa@2xo7a3jhhkef>
References: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbm34c74aqa2td24"
Content-Disposition: inline
In-Reply-To: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>


--xbm34c74aqa2td24
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in
 cgroup.procs and cgroup.threads
MIME-Version: 1.0

Hello.

On Thu, Nov 06, 2025 at 12:07:45PM -1000, Tejun Heo <tj@kernel.org> wrote:
> css_task_iter_next() pins and returns a task, but the task can do whatever
> between that and cgroup_procs_show() being called, including dying and
> losing its PID. When that happens, task_pid_vnr() returns 0.

task_pid_vnr() would return 0 also when the process is not from reader's
pidns (IMO more common than the transitional effect).

> Showing "0" in cgroup.procs or cgroup.threads is confusing and can lead to
> surprising outcomes. For example, if a user tries to kill PID 0, it kills
> all processes in the current process group.

It's still info about present processes.

>=20
> Skip entries with PID 0 by returning SEQ_SKIP.

It's likely OK to skip for these exiting tasks but with the external pidns =
tasks
in mind, reading cgroup.procs now may give false impression of an empty
cgroup.

Where does the 0 from of the exiting come from? (Could it be
distinguished from foreign pidns?)

Thanks,
Michal

--xbm34c74aqa2td24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaQ3CkBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiL5AD9H1iQzx9lGKNZBRyzM1W5
RyQlf1K/qfz8QEBX+SwBuXMBAM2seBFyUe3eN6EcRsWiedVguCDdbBxoEEDM8d5T
m+0G
=NBTZ
-----END PGP SIGNATURE-----

--xbm34c74aqa2td24--

