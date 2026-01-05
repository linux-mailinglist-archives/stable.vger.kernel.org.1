Return-Path: <stable+bounces-204762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A040CCF3AB7
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAFE63014DE6
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC1335081;
	Mon,  5 Jan 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U41c3r2A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F932B9A8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617522; cv=none; b=judif9UYuCO7cIdh0P6S0ce4m1K7AOWHuiCnXcdiCHnf42+nzKD4R/5WGmuemjsnoXoLJYYXBKAQ1clG414BKopBNTi/GMI7XpgKzLuwrZNvUhQwahahO9YZXwVBwW9+bE39Kr6dsdOW7me/E3bHHv9xuTjfEGkifDbkaEvczFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617522; c=relaxed/simple;
	bh=4KlXMDvVk2Y9UNsBqpwH+8dwYAskJr0J9c/xBNsrefc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHHBr0c/7Qoxx4++DE/vq6eoU6QmFAGUUJMR7yvFIeaZmvylRMSFWlOPeaAKYNOKMsQ578EO/hRDKEu+wVngrxuBHRI4bpuQpZ9+Omu3A3iIivTb9HCVzL+LHsJws3HQptkc+wl8ptM7/ok59pFqm6HFwqmxb2aiLhCvzGUu5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U41c3r2A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a12ed4d205so122788885ad.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 04:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767617519; x=1768222319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIoM2jDtI46cPfcnhs6SMUE4vjSExS5U4Rjxj3hmM7M=;
        b=U41c3r2AaWvX4xGAY9sIKpaMOC6864ynTLVc9LhWOGGzMPOWV1sJcT8gCx+SQip191
         Q3agzNKJSFgQa3BAkgroBefsM5PSfB+p6n1mKVpB+ILkm84L8nwZNgY8e6bFwuzU99f9
         EoPoCTxn64zCPWP41eb1WGH+qZsyrPzk2QWRvu410HmmtsAFa/I1AB6RNrdzyVN+mOlX
         hVZr2vkft+Rz14aNuboWsDPacY5tRdT3wUruZEMwT94Ju7iyIOcdUy8MKQQhsTPVu7go
         +ylb+Q0E3ToTGXQxrob+V3hZMbiL2bKl3Ead8vela3RijYs94DLoJWbo1jF/BguzzaCh
         sRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617519; x=1768222319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIoM2jDtI46cPfcnhs6SMUE4vjSExS5U4Rjxj3hmM7M=;
        b=vPcXe77S632R/eFbeir4irZjIwLtJSYNT9jqzQIPCSybSuhDs2YwULq+0AM0kho0e5
         l9XCLzgBfp4YeFayuf4V4Z3wfDZaXBd4KDxs+l6rZL0LPJ8UQWNQDoC/IDAMrvJJWXwf
         vP6SqR/f8yLt3Q9lAnFkAeZS6mcMoUSHnXc/FXOFssXbdAjrWzpExrXqq9c8ourZvXPY
         SIEP+DpFBmQYy5K7RmUWhst9YDcH7S0i6ntGLve7vicbJ/8xMsaJ4wSWnxOSlGj/ZnoO
         BOatEm7f0a0NtwhAkLm+N/8xthDWl0Sei3xu9IHEKr4u1NjDat4d3keaE04BQ4Mc4+1g
         qPIw==
X-Forwarded-Encrypted: i=1; AJvYcCWuVxPVgjzgS9eQrov+RG2Y/MGRTApDMDow45gS9/mwlapN8okRoxnb51jcGN4WOmESbz9Eswg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+k6lvq9X2FAdamHrwAOfG33fE3AqZyP5VXoDcGtlbEq9o38MH
	/RriteA83lK4sZ2fcqhwtcQnYCVF/9IBMxXW7sNJBS2JViS6CotbJSooAAdKH4pj0+ZUA71rmsx
	JODCPReFo1+xlduMn4SCqzP6FZm1mKLM=
X-Gm-Gg: AY/fxX7RqVKuVCsAsQYhoM73bSEkFh34WTUHmYfiIS9KJL4Nh/27aCSyni1Yzb2i4CZ
	zB+dC5pkL4ERgC/XkZCqG7YqSEzpFk4+MfGPMbmfJ3XrCAvNGisxmskWHaoMhm0rbwSU3uewU96
	UjrRD2jsOGhvdCpeOZkDCFOIahEdGq62562oVQVCIiEstYwMBQHxqJ4E2kE+zF7wXc6meiIvzvU
	8vK8vCo2flJe65ncv9lZiZrbxxN7u+78Wd11rLT18rGj5cOcr5S86+z/F+pAxBUT4/LEK0=
X-Google-Smtp-Source: AGHT+IEXerOKeKOtB2sspI6kFR5QkFJ+Zr+D0dSc5pMahKMWycdWJvhmtT1SmXyL/YXhI4p2gm1GSa3b4G+p2WkMb2s=
X-Received: by 2002:a05:701b:230a:b0:11b:9386:8254 with SMTP id
 a92af1059eb24-121722ec414mr44206169c88.41.1767617518832; Mon, 05 Jan 2026
 04:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231040506.7859-1-CFSworks@gmail.com>
In-Reply-To: <20251231040506.7859-1-CFSworks@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 5 Jan 2026 13:51:47 +0100
X-Gm-Features: AQt7F2q47D6R4WXpHK6TLAOa1OdzRxSgQoSFN7TMgW_O5ppNSIvanQB-2ttegeY
Message-ID: <CAOi1vP8WvK-0nGjKY6ss2MX6ZjvDOhcur5SyM=E=uipW0fy76g@mail.gmail.com>
Subject: Re: [PATCH] libceph: Reset sparse-read on fault
To: Sam Edwards <cfsworks@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 5:05=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> When a fault occurs, the connection is abandoned, reestablished, and any
> pending operations are retried. The OSD client tracks the progress of a
> sparse-read reply using a separate state machine, largely independent of
> the messenger's state.
>
> If a connection is lost mid-payload or the sparse-read state machine
> returns an error, the sparse-read state is not reset. The OSD client
> will then interpret the beginning of a new reply as the continuation of
> the old one. If this makes the sparse-read machinery enter a failure
> state, it may never recover, producing loops like:
>
>   libceph:  [0] got 0 extents
>   libceph: data len 142248331 !=3D extent len 0
>   libceph: osd0 (1)...:6801 socket error on read
>   libceph: data len 142248331 !=3D extent len 0
>   libceph: osd0 (1)...:6801 socket error on read
>
> Therefore, reset the sparse-read state in osd_fault(), ensuring retries
> start from a clean state.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  net/ceph/osd_client.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 3667319b949d..1a7be2f615dc 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4281,6 +4281,9 @@ static void osd_fault(struct ceph_connection *con)
>                 goto out_unlock;
>         }
>
> +       osd->o_sparse_op_idx =3D -1;
> +       ceph_init_sparse_read(&osd->o_sparse_read);
> +
>         if (!reopen_osd(osd))
>                 kick_osd_requests(osd);
>         maybe_request_map(osdc);
> --
> 2.51.2
>

Hi Sam,

Good catch!  Applied (with the sad note that support for sparse
reads is officially the most problematic patchset that ever made it
into libceph).

Thanks,

                Ilya

