Return-Path: <stable+bounces-180447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2DB81C08
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 22:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7AE4A4F0D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C52C1786;
	Wed, 17 Sep 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="E93ViBQr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A329BD88
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140749; cv=none; b=H97AXy0m6XDu1cjmx+N51EGP0FrOkRyabnPVv+4eaVhDFx8Aqt9K3Dm6H+dIetn8qnOhPTML+/OawSRttJq6jpSLvBvzpCMg3KIYYP3HNlWL8F59rZ0Zs9TqrpF9+VSM+ows6rcwCYhVgjxjhg1CDX1Mfvoy0NpIhiB7ZBSuJSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140749; c=relaxed/simple;
	bh=K6d/jzhMMI4CPpQDgjpBmEl98KL3cG+euC4yxGzEVCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPcVHBgUoRRymFmyFeXXPpCFl1/qz+1RmiGEwFOBYBrJyX5hWXptBu55AGBc2LjFh+XeH5qmz5tlCU3FGbBivgnv5qvu61dBRknGRCFbJE7zPpT4J4dVhzL9aIdLJvTe10hww98+FkcnydraUqiU2Ln/V8nTsoap89Qj7EDElPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=E93ViBQr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07c2908f3eso32902866b.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758140746; x=1758745546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=E93ViBQrlMJp2YF9PBilI+D4r4dqMY3kENfrRihA/DLYVvQ3tFSLBlr25yGkNQZSeR
         EvQ7C8EP9iYqCNcBmELAqwIYVELvBY01wXh1NLNH9pQelcTa3DBev1jJ9ZHywMfyQxiw
         jMskuvUL5nGW6CCje86E6qhKG7P8MZmMivlYzSl8zDKmxPEz1hyVpavb2LVlVOkvdWvq
         t3mPCff8/kzD1pdYyXAaFS5AF5PgHpsbs5DZiPHn0GSw5470xGRJN8PyzjDov6RbA/pg
         +ABF1T3cG5N6e6IE/Agbc6raLoM9Z7HCVkzSaFJMfkFcaUrwPUh4WxDRuf55acq4s8zE
         BmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140746; x=1758745546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhNK71BU031VL7GqxBW1Krt0QEpivweMDtH+UA/VF5c=;
        b=swzPuwdb74ZqAM41SQ/PiRrqTHtF6OkZOmvpVOc1P0ZSKOvGxz5jTxOemf4Nx/Q+ok
         T5kzwk+XyjbTbYvSNgXUAsx0sG4llnli2Q2I4jEUHGiyG3z0acamUhZbuMKmumRHGfzN
         p4+CSJxQZGhwYt4jnCfSqNJlx3tMfoTTd4amB60BgPrYXYOyMs2nza8k96Uh8tbfp2Aa
         BTjtlNiFIk09EtKJU+TU2CoV7PMjxMcRLx8NJH7x/poPYY7yAX7uiDk9wq+ljXMj38Nv
         jfule7k2fLT7D6jFL73mZ3uwGfSUY36kqWOW4f8w4G5GiMRhggFIo+igukXEZJPxGXt5
         7HOA==
X-Forwarded-Encrypted: i=1; AJvYcCVnpoLeYaIEK9X+Vfecrim4YxFdZ80bJPcr7O+QaH62gUtxfeb7Z3PyTeXbRdigzHBgoVm2dyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyZimIlbWfaHw0wu80hRIQtg1d1b+4eXx8HPyEJy5ucR5SMbm
	SzIOzC3VAvaJi+OrmoVtACRJ+5PFWgn/dq65kdmNArFH5cdInuZ9Y1e7i/el6zuOsWDzTf3lg9S
	Ei4VRUOG2pGACzlmBnks+BIKVHwPosnQdEjWFK1WgCw==
X-Gm-Gg: ASbGnctzDNXyg5kNwwEkAtWjbi9nSLltVZMI9jjaQonXHHWF9teu3A6MSA5YzltqvsK
	3v4d1vfsDZkJk4As8cW642PN+5DKBiwA+qb8yaVo+OAxX94af3QWvqhuDK9Tt5zCdLn8hoa2WnH
	DvycTf5ZrMEyAc0yNlR+Q4H4NRpxUXR5n+Yt4VIM1JXg2tFFmDPejFREc1ZCJlNlHdKW8L8lvkg
	JXaWfb5Ru6SsHs8cCyx4Bg+4KUu/zzrnp4rpr8Xe3psNuo+NdKokTppRDJ/5bQMog==
X-Google-Smtp-Source: AGHT+IFBvtsDmLFlrUPLrEdtXlj3XmnDOunMGaQVNwpHnx7V9K8cWA1KerJzVQIV4Og+xzCob2fZntJ3zIqyp+GB2lY=
X-Received: by 2002:a17:907:3e1f:b0:b04:2b28:223d with SMTP id
 a640c23a62f3a-b1bb6048f2cmr368398466b.20.1758140746182; Wed, 17 Sep 2025
 13:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com> <20250917202033.GY39973@ZenIV>
In-Reply-To: <20250917202033.GY39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:25:35 +0200
X-Gm-Features: AS18NWA9lLP5Eqngelj0xlWoIoGVHH7XtsnclhYX2neNhHDUumPEaBrniNeVLQk
Message-ID: <CAKPOu+8eEQ6VjTHamxZRgdUM8E7z_yd3buK2jvCiG1m3k-x_0A@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Mateusz Guzik <mjguzik@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:20=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Sep 17, 2025 at 03:59:07PM +0200, Max Kellermann wrote:
>
> > After advice from Mateusz Guzik, I decided to do the latter.  The
> > implementation is simple because it piggybacks on the existing
> > work_struct for ceph_queue_inode_work() - ceph_inode_work() calls
> > iput() at the end which means we can donate the last reference to it.
> >
> > This patch adds ceph_iput_async() and converts lots of iput() calls to
> > it - at least those that may come through writeback and the messenger.
>
> What would force those delayed calls through at fs shutdown time?

I was wondering the same a few days ago, but found no code to enforce
wait for work completion during shutdown - but since this was
pre-existing code, I thought somebody more clever than I must have
thought of this at some point and I just don't understand it. Or maybe
Ceph is already bugged and my patch just makes hitting the bug more
likely?

