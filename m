Return-Path: <stable+bounces-195268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C789C73EA5
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7D24F3084D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8444A332EA1;
	Thu, 20 Nov 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNT/qRJa"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6413321DA
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640856; cv=none; b=WD5mlhvrPyuf7cQB/jg3Fu48KI/dOxvEMv4K5DJeOYvVwvAgsYFsZuD3FZlZfyOnvUc4eWPV1LvRLqopHxhLd56JCujcMM9SEWIWtDPI1sGUU5DeQcTFICbb71mAn1nxVA7dR1Dk4/B0LMK+3hcN22JvJMiOxKnhI+9KYpM9R0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640856; c=relaxed/simple;
	bh=afPc1NBubibhkYAj3B9LVVpPs3rRw+YuXpTnHu87Ey8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5+9Z9DdShO5EhR2O+7802SSIVxMmAWyJKeDM1dNpd0WuJ3Skw0JLrmtr6wpf8/jg5J6pDmo3p+neVcFqQgSWGy2lk4C5w+C4cjdLXwI5BZgm+29IV/Gxxn7UOdr/Y/tKi4yvLLEKfpPKGUb1ZNCqDOkhjJjDsR3BQq1bj2i6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNT/qRJa; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65744fbb2e4so300192eaf.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763640852; x=1764245652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afPc1NBubibhkYAj3B9LVVpPs3rRw+YuXpTnHu87Ey8=;
        b=DNT/qRJaZq445LS7tOTjGSSsmQAmpv7S/qwgqiqKNt4NC+5nuqs2jSZ8wryNrHOPvY
         iYnGl2YWdqKkWXa6OPuxxgkms3acKRXJ/Ju9pQcAWEmFeAtPlAZoyyNhIboXrk4QsnJP
         3JjxNXL1uMp3iwp0J67flZtOzDN8UxI8huK3zFDSYRon6YdR3PSicxk2lcBuoObHNgvi
         8pzZSGy/Hox3U9G6XFQ0WfGyblGakfs4tpA6QEo7qto6SFYS3+AFExHKepNKsSZQd+Bc
         o1hywQBjLpvtXv9FIyNEGHB/amv2ZFSH3TIO7RmD0ZgGFhK91+47BC5fkPVXffj3Tq4p
         YIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763640852; x=1764245652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :x-google-sender-delegation:sender:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afPc1NBubibhkYAj3B9LVVpPs3rRw+YuXpTnHu87Ey8=;
        b=CIJcr3p5l+hdHq/vnPv6fTOq6zDEisCZBpJKqVC3mc2CsiBqm6pHQl265HcYRywo51
         seHdsU8f5uMZKoymsYFxl69odhK+n8NT4MufGQTP+ZdJ03dRXJLz5Kz+1vJymKya5vw8
         OVdMeH0tzwJ/3s7B75Z7SfsyCHK0sfKs/7dQR1lNcV9WpAKxvtudUs1kQKCYfpkqho6x
         dp5WXcpnZDkjWVGARDtlIjctysWGgmIPCQXuM0XXMSfb+ut/91MEWD1FXcruuY4B1kxe
         jk/EQy8cMDkzuN9VecgVJAvYh3UX4VmyMwKGs48KCyxw4lJCalYpa6ejbCvGqH/g6Uzi
         ll3g==
X-Forwarded-Encrypted: i=1; AJvYcCXXhzax437ExfXPX5IQpUz6EIi/A9RNTpxdFnovDuv8GEQR6q+7QEXZYOYykZIgi/NFXYrpzms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvzD+Z+epyT/O4c494qEtbpaqvJNKCqu3e8KV0PnryjAV5nVET
	26TTAKOitvV+yo+4InSbIjvx0RPNcrLYC1VR4f/bE7ff87QFK4kpqub02RVdi0fA2/+Jeos67eX
	60H0+NjSUsOOUMS0/CmWgOQRWzoQo15o=
X-Gm-Gg: ASbGnctKn9m4ZlzyDloP8JfZkf+A1HbE/J5fQOCMjv9dnBckYgi6H8G5pAM+f8iKBiP
	nVbFcbwOElzdgeQj1YqIVpbp1ZbCZ5QBYjpson9uSvAVZNpY6PkowtAAr5rb9FhArF/HWxpZJcO
	1vGcWQIREP6D89MZNd6ymRcWiNxGN5FKfvCmPQyKGq7rZGXBWIIYEBZzkdFbDpzbGpD/Rek8yb8
	X4wQfN9TQAwqo85I/7FyQs3szQEq/B3HXd/Myy6LV4xf+o3Feqtx6QVvPX7tCKXC4yVWnArxT9O
	FPzF
X-Google-Smtp-Source: AGHT+IH/eb3Dv0UCJrH1SZTf8BRjK9wJlIx5viCddf8iUS/Adh5/Wq0DDGKJebipoqWAx6FTViIp4L8FHEEuuUe+tRQ=
X-Received: by 2002:a05:6820:2d8b:10b0:654:f9a7:76dc with SMTP id
 006d021491bc7-65787f3daefmr493288eaf.4.1763640851785; Thu, 20 Nov 2025
 04:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118033330.1844136-1-hanguidong02@gmail.com> <038697aa-a11c-45ce-a270-258403cc1457@redhat.com>
In-Reply-To: <038697aa-a11c-45ce-a270-258403cc1457@redhat.com>
Sender: 2045gemini@gmail.com
X-Google-Sender-Delegation: 2045gemini@gmail.com
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Thu, 20 Nov 2025 20:14:01 +0800
X-Google-Sender-Auth: yD23ODSIyzTE7MrBut6Z8fEMW0I
X-Gm-Features: AWmQ_bluxQrCtKwmX5vZq88lt2K-omHHzjSpi9caWAxfKnV3WK2fZc43sm6lac4
Message-ID: <CALbr=LYBs9P92oHpF3-w1k6a+W8u3eTqBpgZv5WncfTm+zCHUA@mail.gmail.com>
Subject: Re: [PATCH REPOST net v2] atm/fore200e: Fix possible data race in fore200e_open()
To: Paolo Abeni <pabeni@redhat.com>
Cc: 3chas3@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 7:26=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 11/18/25 4:33 AM, Gui-Dong Han wrote:
> > Protect access to fore200e->available_cell_rate with rate_mtx lock to
> > prevent potential data race.
> >
> > In this case, since the update depends on a prior read, a data race
> > could lead to a wrong fore200e.available_cell_rate value.
> >
> > The field fore200e.available_cell_rate is generally protected by the lo=
ck
> > fore200e.rate_mtx when accessed. In all other read and write cases, thi=
s
> > field is consistently protected by the lock, except for this case and
> > during initialization.
> >
> > This potential bug was detected by our experimental static analysis too=
l,
> > which analyzes locking APIs and paired functions to identify data races
> > and atomicity violations.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > ---
> > v2:
> > * Added a description of the data race hazard in fore200e_open(), as
> > suggested by Jakub Kicinski and Simon Horman.
>
> It looks like you missed Jakub's reply on v2:
>
> https://lore.kernel.org/netdev/20250123071201.3d38d8f6@kernel.org/
>
> The above comment is still not sufficient: you should describe
> accurately how 2 (or more) CPUs could actually race causing the
> corruption, reporting the relevant call paths leading to the race.

Hi Paolo,

Added the detailed description in v3.

Thank you,
Gui-Dong Han

