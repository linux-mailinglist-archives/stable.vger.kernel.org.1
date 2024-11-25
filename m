Return-Path: <stable+bounces-95382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2E9D8737
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0AB1653F5
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41ED1AF0A9;
	Mon, 25 Nov 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UpQQ/ruA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400A1AE850
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543195; cv=none; b=giQM6tX1Qg6JSKEgiT1jKNyrxQVyHk2ZdvrM09znwGS992nZpPE9x+jh/OgplvFVj/TbX/7rmsCXcQYdPTG3JzvQ+PscxffH1r0gB/lRiLxvkHe8r5DmVcddzsV6GeyvVoG81DH65eiMzq9wgEwF+C2yCtjwYMRc9VBiODriG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543195; c=relaxed/simple;
	bh=E8nIC1QMQF0fv1CW6rYzP9Cy3c+iEgEnoJ86Z+Jxk7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnCJ5zuVbgIG64x4Ii2CfZ5wemRLLwVdcRl6b7bqwZNgl+7RaBPjoZUuifc9CylMKbvaGQhdoPf5tT6XigoA1k5KGchUzHaCRp4CdE7LhwY+uGQfGumDVR6AIztwq6Q6Rns31E9OVtLnHpPcn9WAgmzQ5no74INVvVDjrpCuhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UpQQ/ruA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso50821371fa.0
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 05:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732543191; x=1733147991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8nIC1QMQF0fv1CW6rYzP9Cy3c+iEgEnoJ86Z+Jxk7g=;
        b=UpQQ/ruA98jopTJVOsqsQkJQZKduuIcLlnNCDuLXJW9ZSBt3xDLBNa5pweO6yvOiVD
         rK0dMD4DO1ie2+/WHUZyoawKH0oJjFsuDhhoeAYMJdejPgg6+AemF/OqSz2JGWZsGQss
         bz4fl2+b4wwrl+AuJ6yoeOzYdV9LrVeTISrXbTf5Rt41iFUPJcX8cBQIwYRvx9UhWBcs
         8V1nYo5LVrJIVeCUOw6SPWmyen/6rUCyl8VtaoayUG0hMlYH3+tNFDZjbLx09rs2wdzP
         7h1jsmZe2jf5nG0cKeVskXV0xZ0Ut25Ff/u7oqjwxQaGM6CZQcHP+Jval/3nzqBQiz13
         JEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732543191; x=1733147991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8nIC1QMQF0fv1CW6rYzP9Cy3c+iEgEnoJ86Z+Jxk7g=;
        b=mgyoTZCKulEOrQmP/Xfwy13tikz403qcRoqgVI3I/RFrfCJ/DhXrh29tZK8zb6avkj
         oQsgf7qH8jQyGabFrhaF5piEAWArzVjOCsaA7GMvOA422OobcSUFVX0agxDaIDEein3G
         ySV+DL88VC7GYPNcBqJ7q5n1JSDGKaHrTJrYHAYxUEBueXHO5wT5kU6qVRiN6pXKKE2D
         a/n5aX+JfNanMIZ+bQqnVR+rvbik2BgjBfJo6xeziRAWNzjoKNLLT5gpY2iB/dlmMN/3
         q5v/+lqxSHgTc4oIhtM2eZM3WadJT21MVNx2MN0nXvYFfd5cxIRiiTSl+npIUzXehz2O
         1+tw==
X-Forwarded-Encrypted: i=1; AJvYcCU+DrX6BkmqCVu6HL8XypumZbiLMrDBS4pnBpb02NiEDgREKh56Ax9WO/nD1beLzXXT1YtZpuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nG23A2Vju70lfWll8JcRH4V2nGwDiSK7IJE39QlRP4o/lGyc
	rI4bbCgw/Z2LWiNEB2CPa63pqCeDxi6BqigB8w/JY9ry1Qkfja8hnZbM0GWAC9bg8kgho/plOmC
	FKJxdhYZ0d9JqKnGuhrS0RKP4/llE1pUiwQvnWA==
X-Gm-Gg: ASbGncvFwzv3nuwNGC6Tm0/VFDVZOm9xWtd3u3SWZGzRt+rYsLw/ou1RtzuBStWqNqh
	7+np2VxHQhPUXMx4tmw54W0nctp5xQSOxg+Ef1supevhpWAyTLZ3kw3VuY/2W
X-Google-Smtp-Source: AGHT+IH73yZTyIDCHHrbFTIalkWywowb8ZZKOHo5jE0IO/R7trvqjhf5t9qKLZtCvrgKQHzQR0Gp6IUGA3oU75IteeY=
X-Received: by 2002:ac2:46d6:0:b0:53d:d3ff:85f1 with SMTP id
 2adb3069b0e04-53dd3ff8ef1mr4515352e87.42.1732543191117; Mon, 25 Nov 2024
 05:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com> <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
In-Reply-To: <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 25 Nov 2024 14:59:39 +0100
Message-ID: <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Alex Markuze <amarkuze@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:24=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> Max, could you add a cap on the retry count to your original patch?

Before I wrote code that's not useful at all: I don't quite get why
retry on buffer overflow is necessary at all. It looks like it once
seemed to be a useful kludge, but then 1b71fe2efa31 ("ceph analog of
cifs build_path_from_dentry() race fix") added the read_seqretry()
check which, to my limited understanding, is a more robust
implementation of rename detection.

Max

