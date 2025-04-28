Return-Path: <stable+bounces-136908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78951A9F5D6
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5003B561D
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A78E2798E6;
	Mon, 28 Apr 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7fmLXz1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4314D2A0
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857851; cv=none; b=jgfjnJXLep5k/6VJ17Vn03Abvfln3Pvi1mtETRnoqRXBJQkKstCbgOvOFsR4EMLZp9PLrER8zTquAmZdpIP45jF5snhEvXuA5pXslT1M7E0BIpBJRqqrdJ80A6LdGdNEMN4NOTapOauK7t2n/G1Ej9xc6fXP7VOm2yDXSNnmZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857851; c=relaxed/simple;
	bh=c2j3wvBAtJ0GDwgGXeGIR4XMhG+aqgluAkbj+c/x8BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naYdMVPs7J9o3RZuDyrhqZHbODVkqL4304IO4FA544j60/9brDyJsC5SZ8WBf6hZvITG8DYBc3liMuDn8dlUwJer3p3OPtWRCMbWR4NJsLuDSKvWDvGuCnT604Fy43bhRn2Xvbt+MubhrJ7pPImQm+lmXROqsOw/eM+yFAp8rL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7fmLXz1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47681dba807so512941cf.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745857849; x=1746462649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2j3wvBAtJ0GDwgGXeGIR4XMhG+aqgluAkbj+c/x8BE=;
        b=L7fmLXz17BACjBlzTpAfNvAfQ8UXmug2eWrWnwv00a31n8jpY9nfL4GJ7TlDbs15QQ
         BdkXiaGgDfDYtdvyNkJ23qfPypYVONEl/LbdIRsPqUFrcoujvEwmB5BmUT/fFjh5zLTS
         6wZIDmQOAE1Wo42XStGFdfUm23T3HnSVOXspfkDYAH6bpFTcvdnPOh24kqnRadyczmCX
         H+TRK5HK71zPOZfmyU1QGO0qENlk/UVloyB+iwWzTJM9s38TfBayWcpyS9vaDu0IjisR
         8uPGX/Lwbh60JMO7SMzmJPsgYC+rY/v97KkQ3vpyLqs2iWLMBG1S/C4cd1L0wSkRYPom
         n71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857849; x=1746462649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2j3wvBAtJ0GDwgGXeGIR4XMhG+aqgluAkbj+c/x8BE=;
        b=It6hjw+/cGTwUCVBC1sEQqlwJOVNZ2CqMXZcRxJY8PETHWlwZgkHqno7r8xIDKW5qj
         mRgnvuxa4D5NpkvQjR7Ydn/ggDtD6mn3lS6QDHoOtkUNXw4n3y1AUKMFSPg0D2mGh7Zm
         TcmxLbcJSFfcm4T9OyTE2HGs/qwwx2ydZCz8uQ+c/NUDccPGppZoic6tM+Y4AzcnZEu1
         TTGrPNlrEZgiwEVZWYp2aJ09Sru4mKTsMAmdHaUSGAGHbsQVAlhIWMtXb0iPy4C1Bi+G
         F1dvJSG3iWwX7a/zPX/wf3ht9WVrlCE39yFj4wSrCOgS2J2hNB78s3+qUeKuTxggoodq
         XjNA==
X-Forwarded-Encrypted: i=1; AJvYcCVDNbYxpdpoNBsVNcIEwF98x181M5kq51UKLHoPyER1XpQ7BFWMYzwEyu/GauglHF0Y3eORrgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PnyvEywY//Fba/MoNMS2RkiDj0A0nGqtjSykmklEVOgRb3Vy
	yclynGcqdxG+VsW0Aa3rptGcan+rREZHAcXlQwESCDRNmDDFKdZmybv3rFSoAqfiuGRXXORUvL6
	Kn9PD1WJ5arMFRli/6YRPyNGA5XYmtCyc6r4l
X-Gm-Gg: ASbGncttmQTw/hib/IeYhxCX3SodNjg4v4V88CpudMci0qWFYA4f2O3HDtn11MuGYoH
	kJLAYhdaHQZuMgHWApslWsg5+h3Vn0mNnOJwYjIsjtJkOsmglngWXWema0j1y0Qeazow/9wQ5iL
	VkDhLmyzl+1iZ0raZHcL5t8d0f7WmnNEQ=
X-Google-Smtp-Source: AGHT+IHISK1kxrYk4RfbziCnCnzPWCd0oWI+e9SVH/lBMnDhpa52pdJdvOhZCLc8iwRh9PYrrSIzc0NhpiEDqA7CwQc=
X-Received: by 2002:ac8:5d4d:0:b0:486:b41d:af93 with SMTP id
 d75a77b69052e-487fe63bc50mr533301cf.20.1745857848688; Mon, 28 Apr 2025
 09:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>
 <174500659632.1583227.11220240508166521765.stgit@dwillia2-xfh.jf.intel.com> <9a4b347f-9a18-4578-9031-0d1bc98e668d@intel.com>
In-Reply-To: <9a4b347f-9a18-4578-9031-0d1bc98e668d@intel.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 28 Apr 2025 09:30:36 -0700
X-Gm-Features: ATxdqUELDAnyO3GkumJUBV1EJePzSaA7vBfrlJPvUNeMSl7GggLRW3jYHMePSec
Message-ID: <CAMGD6P0ORZF6Tbkuedv99jEpk+6HjG=pyqCwTHKU5dVxt+kRCQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] x86/devmem: Drop /dev/mem access for confidential guests
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com, x86@kernel.org, 
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Kirill Shutemov <kirill.shutemov@linux.intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 8:53=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> Would most developers reading this know what an "SEPT violation" is or
> what its implications are?
>
> This results in an immediate exit from and termination of the TDX guest,
> right?
>
In most cases yes but it depends on the settings.

If TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE is set then the TDX guest
is terminated immediately.

Otherwise a #VE is generated for the guest to handle.

TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE is disabled by default. See [1].

[1] https://lore.kernel.org/all/20250401130205.2198253-11-xiaoyao.li@intel.=
com/

