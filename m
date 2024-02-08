Return-Path: <stable+bounces-19303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F380884E6F6
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 18:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315511C23492
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 17:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADB823CF;
	Thu,  8 Feb 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODmKEHzt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABFC83CD3
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414160; cv=none; b=esyHQW65i+Cz4PzQdvjlmKWeiCk9q+ffC3ZyjPz38P44eycVy/KXQn2TuvBxJjK6aUDmWy4U/G9m2HxLxiwYY1glfF5fOK/lOlF0avNsSbWWJAhOg0MNjGpkan9tNQjiNXWYGX8WuZOYcpIJ1gtUvnV4I0Cd7NsFChyJ+POPL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414160; c=relaxed/simple;
	bh=jTyqq1McBzhXuBGoQDTNsRl0bVoBKu3QPqRS+ZSe964=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8ofc3azzWKwSKgpg8hnUwfSb5z+JWQKB+qL0WejbePoYqjqAqgK698XYsmcsIIig45A5gd83EJL+SP2is7O+KkYNKQY2RMrvInnQlhzrlTpOhHuTL49C7zj1kg3UZKqVy/mVmC3jJMantXd2PKYSKTd8IQTlQu7iTgla/G71jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODmKEHzt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6860ff3951aso395886d6.1
        for <stable@vger.kernel.org>; Thu, 08 Feb 2024 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414158; x=1708018958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE9yJofYcIrp+q8fl2NtOvzDEIFhiUUc4detkUYKRUo=;
        b=ODmKEHzt3IVRk9s32gldWB8tCYoD1x7ROFpCAFaY0kCxCj1+OaGZJ9/nEATY0jCirB
         D0xzDilAaLkVd+aY1yUqSbsIMOTfmtRYo9o12oKtYFfp4ch5bs+UJrD0D3uQTUjSd6k3
         hVot2f+yitilQxsdjf0ybbKptSug95aUbdozzHRuRMCGPqVVi8Qk3GyNT7Yvij2DPh7P
         RHNcAo8ZWrAcfEdSjPXeQ1sA4Rqcyf+5MhtI/18MxrI5UVfHWj+a2x0Lft6j86eHxb7F
         SKsFNKeWCovD7j6ah6RCEAL3eThKvP01fR1834yKVPUpGS5ByW2nny0Sin5/qXtvGpMo
         cVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414158; x=1708018958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE9yJofYcIrp+q8fl2NtOvzDEIFhiUUc4detkUYKRUo=;
        b=bTa0THRqDApV4MNrgjIsCvBbTaf3DFaXtBiedG5yquBiM75ZgiKAF5gYPie5PFcxvE
         HBiX5AqEI8IulN0THLdMMviQO4kUZ0+OQ3MZJDCVn8RoAVprmf8g07UkdLqLiOmEOjOV
         npnraGuow6pQM3gmz7hbInEdyMl+ZWXyzW4Ulv/BLrtsAgEXX1AsRZVNveuadP0der3R
         FCGTSsSCX+8ezbrgyMqhQxnFYABPNzBgf8GbAdXGeQ9Qaq5U+VSvXvBWvGdSDd+Ur55+
         6iFDyhAVIbKLl+e1AXnRq6s6C8WSEyWGl3RVp+jYbkGH2/OaxHiGaliOtyyxuOMMI7F3
         hDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOlQgakswWDRtRCruuFpkH2FiWqP+ScSo7jhQWa2E6qqTYTIZNKuQUjsYSgRrixrImAHENJYGlhwJHeW2Mw8I0OJHY84He
X-Gm-Message-State: AOJu0Yx0IOrE/XcTa+7/8dPqHQ1ffchcyMBs5qyuXyS61Is+mgK1KX2X
	6OET7kC+qdC6YG1/MQAnjwZmZlnpfXz0jD1PS1TAiW0Ys1lQWG+Nb9Anh1F6RVkfNwSzk1ifkX6
	wOpmB75iYAcEmBE+dZIkcEo2ZFRuW/ummDlZR
X-Google-Smtp-Source: AGHT+IHisO4YeJ4HMjJTJ7Pa6g2UoWbHmyDF6/F8nMdBmOGtjRmAF7AXJRfz3Lb4ftoWcIr8EGxQVdi4TlQ13SQyHQk=
X-Received: by 2002:a05:6214:258b:b0:681:78cf:3920 with SMTP id
 fq11-20020a056214258b00b0068178cf3920mr12087645qvb.25.1707414157664; Thu, 08
 Feb 2024 09:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38f51dbb-65aa-4ec2-bed2-e914aef27d25@vrvis.at>
 <ZcNdzZVPD76uSbps@eldamar.lan> <CADKFtnRfqi-A_Ak_S-YC52jPn604+ekcmCmNoTA_yEpAcW4JJg@mail.gmail.com>
 <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at>
In-Reply-To: <1d4c7d06-0c02-4adb-a2a3-ec85fd802ddb@vrvis.at>
From: Jordan Rife <jrife@google.com>
Date: Thu, 8 Feb 2024 09:42:24 -0800
Message-ID: <CADKFtnQUQt=M32tYhcutP0q6exOgk9R6xgxddDdewbms+7xwTQ@mail.gmail.com>
Subject: Re: [regression 6.1.76] dlm: cannot start dlm midcomms -97 after
 backport of e9cdebbe23f1 ("dlm: use kernel_connect() and kernel_bind()")
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Salvatore Bonaccorso <carnil@debian.org>, David Teigland <teigland@redhat.com>, 
	Alexander Aring <aahringo@redhat.com>, 1063338@bugs.debian.org, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:37=E2=80=AFAM Valentin Kleibel <valentin@vrvis.at>=
 wrote:
>
> Hi Jordan, hi all
>
> > Just a quick look comparing dlm_tcp_listen_bind between the latest 6.1
> > and 6.6 stable branches,
> > it looks like there is a mismatch here with the dlm_local_addr[0] param=
eter.
> >
> > 6.1
> > ----
> >
> > static int dlm_tcp_listen_bind(struct socket *sock)
> > {
> > int addr_len;
> >
> > /* Bind to our port */
> > make_sockaddr(dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> >     addr_len);
> > }
> >
> > 6.6
> > ----
> > static int dlm_tcp_listen_bind(struct socket *sock)
> > {
> > int addr_len;
> >
> > /* Bind to our port */
> > make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
> > return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
> >     addr_len);
> > }
> >
> > 6.6 contains commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on hea=
p) which
> > changed
> >
> > static struct sockaddr_storage *dlm_local_addr[DLM_MAX_ADDR_COUNT];
> >
> > to
> >
> > static struct sockaddr_storage dlm_local_addr[DLM_MAX_ADDR_COUNT];
> >
> > It looks like kernel_bind() in 6.1 needs to be modified to match.
>
> We tried to apply commit c51c9cd8 (fs: dlm: don't put dlm_local_addrs on
> heap) to the debian kernel 6.1.76 and came up with the attached patch.
> Besides the different offsets there is a slight change dlm_tcp_bind()
> where in 6.1.76 kernel_bind() is used instead of sock->ops->bind() in
> the original commit.
>
> This patch solves the issue we experienced.
>
> Thanks for your help,
> Valentin

Good to hear that works for you! We should fix this in the 6.1 stable
kernel as well.

IMO it may be less risky and simpler to fix the backport of my patch
e9cdebbe23f1 ("dlm: use kernel_connect() and
kernel_bind()") and just switch (struct sockaddr *)&dlm_local_addr[0]
to (struct sockaddr *)dlm_local_addr[0]
in the call to kernel_bind() rather than backporting c51c9cd8 (fs:
dlm: don't put dlm_local_addrs on
heap) to 6.1.

I will have some time soon to fix the 6.1 backport, but it may make
sense just to revert in the meantime.

-Jordan

