Return-Path: <stable+bounces-177876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60247B46252
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303BD5E046F
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E704267B12;
	Fri,  5 Sep 2025 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gF0ZI/5t"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85530597B
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097319; cv=none; b=iMYvP9sarubDKplxIdGyNVwulj2j2ADcPBPwovDSK6e1QgNyJg9cu2tjp1uLkVzBFAWpnwcndQF4C5DUEQoWvwZlimWNE5bEn2wmoh3N5z7GlvojaPmX/wQkA2AYD7SPqsT/2W20T2ZJiINW5vEOo4RJB+6B1anQ+XU/+xkA4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097319; c=relaxed/simple;
	bh=KRLb9ZnkF4pEhXEUSBJPf6M16zLAfnT4g7wGxS2/IZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tof3RH5RAaDTP4VK0JJVuRE7PFg0mkpqZi8xR01M2+6apQdqwSkuc+qE5yKzBvJ342KNtnmT/FiB5JnXbuxe8r49qi0bVAa5o3Cp3y448R3u/xjATADSsayaBNj/Lc6qBDBwtYhPU+YukP4CGc8UU3dHvLCDzQHwVY32FtOqO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gF0ZI/5t; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0472bd218bso438996266b.1
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757097316; x=1757702116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRLb9ZnkF4pEhXEUSBJPf6M16zLAfnT4g7wGxS2/IZE=;
        b=gF0ZI/5t05ui/KNeP70q5M1ZmEhk4ju6Laq4nbTCTBM2vTW+gF45DpQhLCXCqNw5x2
         tmKBVRncX6Vn5JLAv45QXeS+vQzRvJWzQiCvU5U1LyevzVg0kC1IbuwDO7i/4p0NZ0Q4
         OhBX/XYz7AaHz2DC/dS+cZxTQHJn08f18F5svQGw9osegxfpvCDPmJDzk4HKqI8zL65S
         VsL2gs3XE0p+rNmqjJ3zAbTtx+OvGCrnxZ0LPD6SZmHmHAZ588/JYmJQ10NFILrMCepT
         pytBBNjS/9B+ImV84Tldrb4l1GFP2vM8AOaTfepnebiS40boqiDrakS4r44wtgul7wc0
         UARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757097316; x=1757702116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRLb9ZnkF4pEhXEUSBJPf6M16zLAfnT4g7wGxS2/IZE=;
        b=W2lKLunxTGNRk9kToy9CVYS6H95BqO9tW4fPRBlPDEitcN2LSKKu9ZcweZrR94qG2L
         ByOXV71jB4Fne5qZhBTpiTxIQ0cbl6fhaQAjDyQdugEMVNfB3n0VlxySqE6B9dDLU5/X
         282xamXfHRuYlQhHjCvs2loMDKR8sK/Z/E5e537Z3Yls1FRFiJziM2krdpn50DeBPViz
         2+0KXYZ22RiKNf9sXw2FpC/rl/fAH4KxevqGSMBlYzVaTTqLczjzCZ/h2vtEsDl9lfnb
         Bo0FUaw/pb7oXjE+PGs2dPeJh/hCpeCxJBLlju9I0y8hwi607hAfYn74N4DE/Myb8Rw7
         2b5Q==
X-Gm-Message-State: AOJu0YyME9/Hn4shYgvCXsGloGD6YTiHkcaOrqDgiMlpnqxKyQu7pXz1
	thLqrPeaDNE6Moa0D7S3LpRlbGOl1IFfi4i8p2HBH3P+TYXvDBoKu87cpnnTD/LYhH1UWlyhuBP
	S4Bylx3GyIzRyWhShbRu/ZnwHqaI/fiiPN/5g9jJjuw==
X-Gm-Gg: ASbGncusNCiLO1N1tpv1wSMD5rGN0Cr9X0nIJjZfNZvzoxzZYwV8Hq3m6lGWn+U4XZn
	LZUokLRzGwscXy8xx8LOEf4Db3kdVrQHLP3GmoW7XX3IJtXGQ/TgKzJvMQXusM44setlB8ByTnC
	BODZIJUVX/Qdm1gMPxN3n5wsPL/tljjDmKgvznXtYPXUH1Awv+ahI04CcOwKMPazlv1UUSQIN9w
	aJYOxwY840c2DBOvmoApw5ZgMi3UHRzAQZhFGyuUkKJukBHDtAI3doI6A==
X-Google-Smtp-Source: AGHT+IFM2GeY32KhIS5FtgWmgvnq0vzOyjWdw+oC8TH5aziQiwP7KgrJ3yKotRAZRwqa38zXBGqPyxV/r0ULShzUXzQ=
X-Received: by 2002:a17:907:1c8c:b0:b04:563f:e120 with SMTP id
 a640c23a62f3a-b04563fe48fmr1484767066b.53.1757097316133; Fri, 05 Sep 2025
 11:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827181708.314248-1-max.kellermann@ionos.com>
 <791306ab6884aa732c58ccabd9b89e3fd92d2cb0.camel@ibm.com> <CAOi1vP_pCbVJFG4DqLWGmc6tfzcHvOADt75rryEyaMjtuggcUA@mail.gmail.com>
 <9af154da6bc21654135631d1b5040dcdb97d9e3f.camel@ibm.com> <CAKPOu+8Eae6nXWPxV+BGLBVNwSu5dFEtbmo3geZi+uprkisMbg@mail.gmail.com>
 <25a072e4691ec1ec56149c7266825cee4f82dee3.camel@ibm.com> <CAKPOu+9MLQ5rH-eQ6SuiXTzFCEhmaZ9s-nKKQ4vpUCyvc9ho8g@mail.gmail.com>
 <b3d2da1abe05087f52a8e770bd8eac04c46b3370.camel@ibm.com>
In-Reply-To: <b3d2da1abe05087f52a8e770bd8eac04c46b3370.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 5 Sep 2025 20:35:04 +0200
X-Gm-Features: Ac12FXzHHlOx1CsaHx5BR6NbVbREi1ylMDBin7Wxfqwc3b_z5BTef3YpbT5tW9I
Message-ID: <CAKPOu+-HZQa_p3JUXeQY+KZL1yAFK29A6PD2KartKTT6zA785w@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/addr: always call ceph_shift_unused_folios_left()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:11=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Fri, 2025-09-05 at 05:41 +0200, Max Kellermann wrote:
> > Thanks, I'm glad you could verify the bug and my fix. In case this
> > wasn't clear: you saw just a warning, but this is usually a kernel
> > crash due to NULL pointer dereference. If you only got a warning but
> > no crash, it means your test VM does not use transparent huge pages
> > (no huge_zero_folio allocated yet). In a real workload, the kernel
> > would have crashed.
>
> I would like to reproduce the crash. But you've share only these steps.
> And it looks like that it's not the complete recipe. So, something was mi=
ssing.
> If you could share more precise explanation of steps, it will be great.

The email you just cited explains the circumstances that are necessary
for the crash to occur.

Let me repeat it for you: you have to ensure that huge_zero_folio gets
allocated (or else the code that dereferences the NULL pointer and
crashes gets skipped).

Got it now?

