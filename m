Return-Path: <stable+bounces-192653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A2C3D947
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 23:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D7B74E4EBF
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 22:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F930BB80;
	Thu,  6 Nov 2025 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVp1GdWZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E82F5A1F
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467668; cv=none; b=JOq/2lwJZk6Oeq7vKaIYWGNWHYAE5VjcHKYK6F9mJ8o3KbRb/zpgk/x3oipI5Su1S6QSLfuxGEzmjPeaIDDcomTq0z2cki2Oy9LAsdOL0h2kmn+QFaObKsZBcBnxPP5Dk1lAF7tP8wo5ZWRHvxyTIVjzVLExKxk071idI6Qp1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467668; c=relaxed/simple;
	bh=/ygoso68qxAo+I1gPqHR/S2bVV2Aj+Lzf1IsI2FGUc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnyzuSImqxwekGJA+RdNzKzqrGX4Abndxhb/aZOfrebGNcn1NqQeQZQns0msNrePPEDnAUsfRg8UHCrpfepb3cf11+mR51EuwpdqlEkTg5Y79lsgcuF++3bT/kn5V05sRBJvOm8mHeCloRoLvCWvw7SzoxufOPV0tN8j2rUGamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVp1GdWZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso219503a12.3
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 14:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762467665; x=1763072465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ygoso68qxAo+I1gPqHR/S2bVV2Aj+Lzf1IsI2FGUc0=;
        b=nVp1GdWZQSoLCTtWBPI/wQW40cdUNt6zcXDRIdPzHfJOBfxXz4i6nG2tb+khDun3en
         GSA/UGRIBiZFarKPMvQWbZrs/y1FL5A3jxVyWHvo8Oh0mP+G0GOEFqjnPHEpnqwzScia
         Mol9ViPXk6slEs6GTB9KIYAEhPj091PrlNcc7jxfMspExOGixUVV2vDuCiirCM852WTX
         1k4j8Hcdp0jC+mGDc3nGomiLviDMxbC5UBBltJYJmxweAFkUybUs8mhiEL26lIJVyEMR
         thLL5SXSrVYFMUUcWVHIIbhjCttk5WNo82l7U8//In6FBJTwVvy5zJaFKBqGvdJ9d6Ej
         wBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467665; x=1763072465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ygoso68qxAo+I1gPqHR/S2bVV2Aj+Lzf1IsI2FGUc0=;
        b=pe5pqy6xhVIu0WMVLgxS2dSPKcGuesx1Qacj0fAhEhtslAdoglhzt2OP9z9xgezLvd
         k9BBsJrYQQCjiErGL72DPg92I4zoiCAqzKRp8dlcjTHUimMhnSmaQ+C6lIZJCsol2tiL
         KYhifKF54xhv9rRrZhTvLFQtmfOY5lYkiO/7UbY30CmCc6mHKtCpLwds7LXrjiekw4pD
         51PzvmYY9QweaxOypa9GQtNv+/f4dRJXYj5ui5KImdZUYqW6DQPaYhV5RKhxaF8Mg8N2
         4JYab+Py98NmWeQ8axAJICJNiRbLHq60yn6bhg7nKDWDafmnXOzu9WvASu9mS3U/kcrm
         yebQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBTnCRHD/DjDbpBMXi6MjIQ49Y6IG78LvCmPe/A+rR/lEGG1pl6DkpiMD06mtPeWNk6hM7dwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDAl+z48Jb7AmuK5bx+J/G6OPU6ArGlK6wqaYqKaYVd1VVftY
	FS2+YTkgQ0OsPxdouMYhqOT+k+JtJmb9bZO1pQLtjdkfjZIjcQEJ4cLz+QEjh8Y9YEYu6+gaztL
	Jzmv6KNH/ew+2guRnXqRFXLO2+hnYijw=
X-Gm-Gg: ASbGncu/DgdV4d6gU2HnwHiWJXhQITMROOetTwjNw6ASpbO6/PnBmNyuA7fPSP3oHUI
	Tt9ysTVnMphcg8GVIXvMSw1Puk2MnB/qpyUMEygYEDROZuNXhfgG/+Ifm5aDAEtJVyUckxA8ZoK
	LWR6+Ul420jRP9TM1LWKoJ5zjWhSH/07JglFuqNpLMn9thQGZEXyIhLlmJ18Of3l3RVUcHeLtFn
	urzEB8X0vHB2+j3mFgdPgiIA2FYgJe8/AL0oJe8FOZK74KAvqcyQV5AVJoOeSjEoN2bhjCoPorJ
	yRTSc8c=
X-Google-Smtp-Source: AGHT+IG+TIAJ8IOua7l1mEprD2KTfqDGE+T9uMgK3wmEihVKudTfZaDUPZk/PP9mSw+jigEdELh8riemQen7Kc2izxY=
X-Received: by 2002:a17:907:60cd:b0:b70:68d7:ac0c with SMTP id
 a640c23a62f3a-b72c0ad942bmr82880966b.42.1762467665046; Thu, 06 Nov 2025
 14:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024034701.1673459-1-danisjiang@gmail.com>
In-Reply-To: <20251024034701.1673459-1-danisjiang@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 6 Nov 2025 23:20:53 +0100
X-Gm-Features: AWmQ_bkDYJ3Fr-1arvEyDEO1bXJ01gqbCdu39kZW9fG-2HstgXs4j71OYjmvDxQ
Message-ID: <CA+=Fv5REZNSH584Sy2cA2-iKqfRzV64=d4_nwOCT5vtH+1jX4Q@mail.gmail.com>
Subject: Re: [PATCH] agp/alpha: fix out-of-bounds write with negative pg_start
To: Yuhao Jiang <danisjiang@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	David Airlie <airlied@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 5:48=E2=80=AFAM Yuhao Jiang <danisjiang@gmail.com> =
wrote:
>
> The code contains an out-of-bounds write vulnerability due to insufficien=
t
> bounds validation. Negative pg_start values and integer overflow in
> pg_start+pg_count can bypass the existing bounds check.
>
> For example, pg_start=3D-1 with page_count=3D1 produces a sum of 0, passi=
ng
> the check `(pg_start + page_count) > num_entries`, but later writes to
> ptes[-1]. Similarly, pg_start=3DLONG_MAX-5 with pg_count=3D10 overflows,
> bypassing the check.

I guess the bounds checking in the AGP code for Alpha has some limitations
as to how it's implemented. I spent some time looking at how bounds checkin=
g
in alpha_core_agp_insert_memory() is done on other architectures and I see
some of the same issues in for, example parisc_agp_insert_memory() as well
as amd64_insert_memory(), which even has a /* FIXME: could wrap */ line at
its bounds checking code. I guess even agp_generic_insert_memory() has
similar limitations. I'm wondering if this is the case, because at some
point, it was determined that this will never become a real problem and no
need to mess with old code that isn't really that broken, or just that no o=
ne
ever got around to fixing it properly?

If it needs fixing, should we try to fix it for all arch's that have
similar limitations?

Magnus

