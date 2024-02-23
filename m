Return-Path: <stable+bounces-23526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3C861C9F
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105D41C224D2
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919A143C7F;
	Fri, 23 Feb 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YrSmxdmM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8CA12AAE0
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717015; cv=none; b=pHg37N73Rd4okpvkEcrVL1UqUwBD2b9SJmXlTu5fyWQwZPa5ujKkj/IhL5lGJIRm5PY+7XeamEqwucmOtnqaUsYCHtTEHr+3OrPEzVRXBaeUTmG7z3YJTdhOHEooJREz6Xu1WGH7LRF8pNO5UAwb6YnaGkJU77CWUiJks1E58Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717015; c=relaxed/simple;
	bh=WNfkHchNYQlXF3zrF0ZpwFGveUd+gVRX739raeL2qM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQvlfU5gujaV/SxscFqidFeOQqIqwALAUtud3mvDbFAu+wTQ35oIbC335KhfLQ6uCKwmOw1A1sMW9FHn3tlh/atPYVxJ3yVP605oTKbwRp2iUhLNP3qI4R+IfGTwPRYUyKHqFsMBPx16cZ5X55JRHj2RYPFutaCWh/sviA0RFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=YrSmxdmM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so9178451fa.3
        for <stable@vger.kernel.org>; Fri, 23 Feb 2024 11:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708717012; x=1709321812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNfkHchNYQlXF3zrF0ZpwFGveUd+gVRX739raeL2qM4=;
        b=YrSmxdmMWYpMCP7MFEpedL7P+r+lKBaYH8wa7V6aoBnK5Xl1l2+XUnHl91bpWSLsca
         aJjyLc4lKOMHzdnlVyLF5z7Liv/hTQUYvhgFJPPKr37rctyzee5nX+VHeij1q+rviQVz
         tJFGTPZ+lBQ1wAFkfErmP+QWifpmUnENrmblg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708717012; x=1709321812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNfkHchNYQlXF3zrF0ZpwFGveUd+gVRX739raeL2qM4=;
        b=qqZjvZvLNVPCcTTL46rvv2+wQN6SHznIT4Opvu4Hq2m390nJQqMWKPCNKG71ipohzw
         bmuZtXXk7rj5A2NeIxvaj8tTs4pwdOKMDMcWr/Ta6c2mtbdHcCSIL5lh+iq5JU+dj4dq
         +Z/BIJRhDdJ6qxqJZjMpP2cWQYBdTha1BrLffYOdZ7Cytq11Yjza1fd5nYctSG+IY6LG
         7ztg4h21c4c7eCFeojjigzaPJvQkoLiH+/H7UuOBZEd8fYs8bk+1AEnY6GJ5kxCA74li
         ysFf0bhDQBQHToq6vHjPiukDZPG338WBWvgtQarT9lg0gGK+CpELX3LCMIJCOqk3nQG1
         Qlmg==
X-Forwarded-Encrypted: i=1; AJvYcCUYruTssdAEXCSPdJYSuTNy7KIGeFS6dyGnRqxJYt7GXwvcRnnMPl/5M4UAKvIF/fE/eoe3j+TNh3468uOMU7yYnXS2pxPx
X-Gm-Message-State: AOJu0Yx8GQ0NyW/GP43nWP9VRLl2mQ4rhLhr2Vx4rbsHbYaDQ9WT9xCp
	o6CI/Ig/rGmu2Na46y2SEDf6tiLoQd7YMip50Kc6Yi4eEn2ziRiz4JVTQrf1UTfJlkWKW6pYxhZ
	/DD0oMcH/idc1tPKe3Dqo0cr7U8yNDNi9wmzeCg==
X-Google-Smtp-Source: AGHT+IFMr5HxHcowGDJxIZiF/4hzCTmVH2gW6bkX4Dn1NbwB2kzEAU63dqBByUz+Db5CZXCHyemXbkYWJsh90O/Y8tE=
X-Received: by 2002:a2e:95d2:0:b0:2d2:796b:7e81 with SMTP id
 y18-20020a2e95d2000000b002d2796b7e81mr54494ljh.46.1708717011665; Fri, 23 Feb
 2024 11:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207110951.27831-1-qiang.zhang1211@gmail.com> <2024022359-busboy-empower-900c@gregkh>
In-Reply-To: <2024022359-busboy-empower-900c@gregkh>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 23 Feb 2024 14:36:37 -0500
Message-ID: <CAEXW_YSgDhXzxfrMceceuNBsYap+v-1nXsL4B=5_7s_wKYCWYw@mail.gmail.com>
Subject: Re: [PATCH] linux-5.10/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org, chenzhongjin@huawei.com, 
	rcu@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 8:15=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Feb 07, 2024 at 07:09:51PM +0800, Zqiang wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> >
> > commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.
>
> This is not a valid commit in Linus's tree :(
>
> Also, what about 5.4?

Hey Zqiang,

Do you mind resending these backports to stable once it lands in Linus
tree, with the correct commit ID?

I will also apply it to my stable trees so it is not missed in the
future but I appreciate if you can send.

thanks,

 - Joel

