Return-Path: <stable+bounces-161416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC05AFE5B6
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720463AA09A
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8095D28CF4A;
	Wed,  9 Jul 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="D1JWyogI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823528C5DC
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056792; cv=none; b=c1FXG//dTxO8Gb25d4ZwG0tuFSVExtwEBzPTjX6unj0oTuNOQuMFUfOlor4wEJ71Yx6dL3Jms8ZXT84eRW3z3WDWfatXjYNJXAlV8WN7oBeifvsxYJ8Hgywms+URVg4ZmBpntCLpQVbO3pSdHzSzyXlgt0Rjw2eZ6sOVx8DS6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056792; c=relaxed/simple;
	bh=wbnVGbjHNz2co8d+fXBHn4JejafVFSAL2G4zjFDrvs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egWx+lpa3/lMltN1kQslpTi/BvR6L0sxfMp73tjXDjJ13RTsTpaCvKlJLnhlCX26aicUp2u5JwR1suoHzCmbd4sWlzV62TYPAfvIF+GyApJKcKttsxK85qWZxfpCREEOoz8wTYjYVru4PD8x1T7Te+lNzknYoWQmZ9/0L/HTr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=D1JWyogI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so906596666b.2
        for <stable@vger.kernel.org>; Wed, 09 Jul 2025 03:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752056788; x=1752661588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=D1JWyogIFCQUnqEHsgjBo5v8xFFmdw5nxvVF5+3jX7gn+gUeOqTuFIeiKGdQrPcuOe
         M4yWynuUfuCTAH6wUj4MplmTKljf3gHKXGf5xfcILfPbR3pFLhuFmcHc96MVKzh8NgV7
         aCT5PhNylYrNh35vuWZlau4iA0PQuT8a3ep3zn67Y6EUw3Iw80wrBCmMxtpAKaAvi0wf
         AdaERMFYNNo2PU9A1D8OA2KB+ZWwEwkSETbmCrFxUq1+GUwplKL3RB2p7bjd8t3u7zyM
         u3ahRHR1TCPLt5wdiucAaBLkAf47HkvJYZJVDlhCBoyY4Oyq/P8dK9RL9f3Qpa21B3jD
         g7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752056788; x=1752661588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7WBoHo27tCDa77Ry5M8MzBflIzY6f9OMpHwiXcLHSs=;
        b=ZC4JvAokMpB5fcHIj0jp26M5gdLesQuLbFbAbffJstKmufYRcuOp0P5s70s5/TwIzV
         3guFm8CQdXSasQWph08bqjZIh8GPKeHIpkRgonKt5BcqO4KrqIB1tioAYTti9YC5ncyR
         rdNs5hNKApBaYB7gZQvq5IYC93bKGoUO66JBFEEeXjFJPGkoMLSKwr5aEyBxiOrNNolu
         lbgSjC1fuSf6Vs2sYApWlKffAbMxPAJf+lGcABbwSfHXjcBchKwMsz+rn1dbR3Hb3b2l
         dfo9ukHAnQJQ6lN8UmRo3eCshOP0lnQ3dvW37vTV7Vsz1Fil6lIHh2X8MvlnUwgLa/LJ
         GTQw==
X-Forwarded-Encrypted: i=1; AJvYcCVcAkV5br4AdEa6ipEmvA2iiQvp2Cmmmp79MHfdFsbbvSiP8rmEPPrOPx3FrCMgUswZk0MoaCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54r7I4CRsfXYGtvwglseuFejZ+RSsksiNv38Hc0z32di8quy9
	MtUT1LDX/X3eDCIHlxekieTOnU9PvJeuB02hJZv89mKgO3B3Z6u1qxkxn1Cv2J1A/v0FU9ghYdZ
	AX8Y99kl6gBBXxY39dAVTK34r4CFwykLU4VrKPpfxpw==
X-Gm-Gg: ASbGncuMhgbFjDHYDTIG3QPwPUr7ZxNeTnLSNV4hKlqLMuzyYMqqMCFM1ooHmRNx1WZ
	JmCjwbmVgSVGiK/29HZktcafwXPaLp17aaIQuugiL0zUtUAXlrm9D1we0P7y2Jb6m+azdfDixHK
	gVV5xk8uwavGwMRQC8eehEUeSksslwLsUcq52aibQ5H8MOe4/J7xcmQNFJMsHf4yNeKk0xsW1+1
	cgJspP4Qg==
X-Google-Smtp-Source: AGHT+IGbqwygDCctWSd13zB7txA8nj1LhT4JGyQ85VQ1ULmFhI635wDH8IR1PaEr0MvmBrrgrCIFH+uxlqg39uXxl9g=
X-Received: by 2002:a17:907:1c15:b0:ae0:bdc2:9957 with SMTP id
 a640c23a62f3a-ae6cfbd985amr185279366b.61.1752056788493; Wed, 09 Jul 2025
 03:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 9 Jul 2025 12:26:17 +0200
X-Gm-Features: Ac12FXwp4fbGLXVwqf6tAOr1y42YQrXGTBI6Q0Kfy3_DmIljAuOKBpuGHKZXSZ0
Message-ID: <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

David Howells <dhowells@redhat.com> wrote:
> Here are some miscellaneous fixes and changes for netfslib and cifs, if you
> could consider pulling them.  All the bugs fixed were observed in cifs, so
> they should probably go through the cifs tree unless Christian would much
> prefer for them to go through the VFS tree.

Hi David,

your commit 2b1424cd131c ("netfs: Fix wait/wake to be consistent about
the waitqueue used") has given me serious headaches; it has caused
outages in our web hosting clusters (yet again - all Linux versions
since 6.9 had serious netfs regressions). Your patch was backported to
6.15 as commit 329ba1cb402a in 6.15.3 (why oh why??), and therefore
the bugs it has caused will be "available" to all Linux stable users.

The problem we had is that writing to certain files never finishes. It
looks like it has to do with the cachefiles subrequest never reporting
completion. (We use Ceph with cachefiles)

I have tried applying the fixes in this pull request, which sounded
promising, but the problem is still there. The only thing that helps
is reverting 2b1424cd131c completely - everything is fine with 6.15.5
plus the revert.

What do you need from me in order to analyze the bug?

Max

