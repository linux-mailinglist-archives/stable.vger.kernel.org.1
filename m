Return-Path: <stable+bounces-165616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7622B16B1C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 06:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94691685CA
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB723239E85;
	Thu, 31 Jul 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRVKnrpZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56692194C86;
	Thu, 31 Jul 2025 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935466; cv=none; b=WjTGQTKiF6sgyY1GhU6wJJOuh+1UFN3KLCOgo/3WSMM7fhpBiSGXKEN2NRpeo5mRhsOlkDt+mQSO3RLnx4KTxiixrEKqCP3+/67mhc9OseLXq+9c0msxuSIq81YHShWKknwOZGhcMMB1q124ZOaraCblEgplLhXxK/qFbtH7KW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935466; c=relaxed/simple;
	bh=pdpEixiSJRKDUk41L0t+kqCsPtoW98MyTj96BdafVtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1N4Nm8CP45PrFi8uGw16dlKKlplAjQD90AsItZyeWbNEQnORFNWiUOZGTJMgxqZTA3P3x4nXxwzT2eQ3fl03J/xJIsIT1qr8P03YMHbo9YqBHPs15c68wSzw7ZKqtrRGOPEVIebARjy4gCQOi6CTZoHHv7sVIbexWEOpyiXHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRVKnrpZ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-306e88f0b0aso192768fac.3;
        Wed, 30 Jul 2025 21:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753935463; x=1754540263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pdpEixiSJRKDUk41L0t+kqCsPtoW98MyTj96BdafVtY=;
        b=QRVKnrpZ9M3o02NAyN2Vn49jpVRs47JApmVTHVD3snbBAi2KcIgbaBlGq+AfW4kUC6
         Vb539rj79zhb938ciqUqkxYcTxhaG1M8uhMPNUe5ZycERcoe+MCtchY8kBJZCMGc9TI8
         78Ldea4VwH1YRExXPBKcHh1o9RWOaYfjH+Gbjs3edXJ1wYkh9EMIicDD5aiM268mK1qq
         hko7sStLTMMtndtUw6gMzfD7rknzhh9/31LigAam5eDUkx+eZX4nzjMGqpMcgxkiQXhi
         6OIoLFfjNTb1graadZRPJPriJOP0jNOE6fa39eG/SefynnuQyCHRa86ybgt6c2Bu93UI
         IoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753935463; x=1754540263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdpEixiSJRKDUk41L0t+kqCsPtoW98MyTj96BdafVtY=;
        b=YwovBN1sPkkz1CkkaxPiSxSxnOCgV2YuAboL7Zl6rr3Bcq6o8VeDDFSVsSjOzqWmoi
         iwIO/O5W8/T8zq/5OM4DZG2+Z0TOEx+t8bDDZOvaDDlos4lvvtkuaY3rAEo2xA8LoMYQ
         +bYuCEA6W5YB9bMSONi8OwveWG4c5Ovhc5IuzmuvrQHIryH8UEox2CmR4MM0NatRJaUm
         FG/s7ks/AlSiudSl1ZOk/15WyI9bcGx39xKbpP9Tq5WhnB/nfgYH8nxNaG2E4Zig1iLk
         XKL7O8nTQrHe71LW6tmN8VFrZ+YT8dR2ptYdn2c1FHErzpU59h1vpH2mb2rB5QcpPBEm
         gvLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlKOWEOK0+doFiDaoqjiLTwCz95Sbg8dqYESnH8egin+A1NRm7AX6pzg1HswdpdOHzDPBQgfmNP6LHtus=@vger.kernel.org, AJvYcCVHa7qH4HKsFui6CSZkJrOJXrTQtb00VsGgG1Qc33NbLUI7HX7IJnqyWXiJSmJ/v+19wkYineXn@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYSBynWpK8YdFfJ+74deX13rUOOP9iBtL/KkaW3eIFCkFRrya
	Lx7nM6slIBIHLO4mB6XeYv4Z5VfuxQLxfEftxs4iQDesnpvD+x1r3EiehY9nQMJY8jOgltd9A7p
	wRBxjfD+V8+u0C6tpSQUWtgMnolA2KNk=
X-Gm-Gg: ASbGncuMbSS4ZfYH0+rw3wvII1elrRdw58FjlYbZTVTEGk5dR2NbpGdcPmAWBETR6eP
	yLltZVDSHo3F3+s6jPb45S3Pj62IDFWZQ3VTDUVuoy7T3s7HgQd7ITd3t+r2yIkfG5fNEu5IL4X
	GDkuWtGNueqxfSPMLdoqAMTg8m3cWXz4f77ipnWXunJl9LCGkXecIdJvLIipuyglMdbb0o6rU2e
	kbz3i56
X-Google-Smtp-Source: AGHT+IHGHUprxJYjV+kRocPkbQvoewipOuKFbEiAf0UVq1rv+6mWShZRWDaf0BeNggrmLEHVJb90j8/i5Mh8mUQttDI=
X-Received: by 2002:a05:6870:6b8a:b0:2ef:e245:c65a with SMTP id
 586e51a60fabf-30785d59ff3mr3598956fac.38.1753935463283; Wed, 30 Jul 2025
 21:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com>
 <30f01900-e79f-4947-b0b4-c4ba29d18084@intel.com> <CAO9wTFhZjWsK27e28Gv2-QqMozns47EacOQfXtTdMfLjR98MTw@mail.gmail.com>
 <834f393e-8af9-4fc0-9ff4-23e7803e7eb6@intel.com> <CAO9wTFi6QZoZk2+TM--SeJLUsrYZXLeWkrfh1URXvRB=yWtwig@mail.gmail.com>
 <7590fe81-e771-42b3-b9fd-31ad3b7860bd@intel.com>
In-Reply-To: <7590fe81-e771-42b3-b9fd-31ad3b7860bd@intel.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 31 Jul 2025 09:47:32 +0530
X-Gm-Features: Ac12FXyT5v0dosvfmbsWOpS-j32vb71T9uRc3bfohW4BVHNq5uRKPNPQ98InyBg
Message-ID: <CAO9wTFgEeNBO9dkEyZe43fwg9NyZunzYtLNFCznom1-pqEXqVw@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	peterz@infradead.org, ravi.bangoria@amd.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 00:59, Sohil Mehta <sohil.mehta@intel.com> wrote:
>
> On 7/30/2025 9:27 AM, Suchit Karunakaran wrote:
> >
> > Alright. I will send v4 after the merge window closes. Thanks!
>
> Sending the patch sooner is fine, if you want. I meant it is likely to
> be picked up after the merge window has closed.

Yup got it.

