Return-Path: <stable+bounces-27023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017AD874215
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 22:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB477289F0F
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C211B809;
	Wed,  6 Mar 2024 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCzyRXE1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A121B7EB
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760974; cv=none; b=YmPLCODaQuFW8NCdDqWrRILN0UK/ue7ZinFFl7v7ZDNl4RcpXu84MD5W9xTes0gcxOL+/i+c+F0fHJm8KIrlVeOnVNTnhTnRQGmQKWc6uAdKydRrnfITt5aXmKbcvL9b3q8Q0LnyraX1d9TJHvHTPTcNkIc0MZ/gJgJYJYusZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760974; c=relaxed/simple;
	bh=YlaGW5DIfQikcv1Ey1OaeroVdJnLORWMXlwJte/PfRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxACBPs7QexkjnYwiJFEY3FSw5c2pVZb3S2w1qrsyCV5AzS2BFuHUc2IBlbpZk4+WOH7Dt8TqYByua9c3aGhoLdHEfgvAu+FOKNs/1ua0m74QxSiWbdZqd5MP2ycza3+CidyYg+NdgFOrI/PPgmCwlmT+ARr1vIjFHjdtnt1ogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCzyRXE1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-428405a0205so16691cf.1
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709760971; x=1710365771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuRty+lhYaNXcOtehTNWQ8+EoEDd7pkrwovTsDUb2fg=;
        b=zCzyRXE1Zr7e75wrVh48ChI+p1UJOMsk9luj9Tyz+QO/gUDqTZfG0an1k0tQw3ntgI
         xj/Fj/1VpxCFslkqhmUY521Xs1CeslrMW51VNH3JuJju3saRWa+iArhICPb8PO13FTe8
         KM4VENUeaG2kaS49iB4yH4yY3OySGQs/3mA8sNnURBMTS7SqNnvf+dhEvl4cNJ5Fduqy
         XN4VdWB3/WiyN3I4D4Hd+3pSX6BsW9Wtva35sk76483Yob2ekAEbPV6MvFPs3js2Jwul
         8wODDKlThoDfOckOxB+l0h/3VVZw7QktB9CNhSRL6byZyb2KyBf/YTZdEmllJdZQufGp
         XeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760971; x=1710365771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuRty+lhYaNXcOtehTNWQ8+EoEDd7pkrwovTsDUb2fg=;
        b=hnUo98iM++cojUYoEeI/nFGm+sfjJYRO7gmBjcgxlnzjK9IsdIdeLV1kmugd5jNnsg
         wexgzJARSXOQFN1GwpEzVuDYUr2ZisgrX1kuY8Df96+t2/mhnabAGnoRMgMQnu/KK7q3
         i/ii17kPmDlqcm72SWZ4AP4yfBD0mBw5b3a2AcDYJmPnc94s7gQlejto/HTYIibF0Cvw
         5GE8HkJKDaxEv12yt+9ndecROk5SmmkyhQJIlLPdOjgGJr3DIO5CvtkYyJBWxqNorg61
         KJw2NqglaoctMZI9O70Ihq4fgDX026G/vKcLgSkkuy32mTAPc6kyi6UnghyxpNUoLzkG
         DTqA==
X-Forwarded-Encrypted: i=1; AJvYcCWrjhlLas0dBz31ychXDryebMchZfl3XRKs42KjnFtYt2Sqv5txfhHZAa7sC8qGe1rT9ixhonmvVxvsAJ2tcsmV4FrO9Me1
X-Gm-Message-State: AOJu0Yx+lYVaKi/Tk5ln3aAKFTkMepJATUs+ogVrgoKyFfqBuLwP6Afl
	ZAvWA7KdDA218KdzJ66VTAl73fkq1USIY33Ats2j0WlhhsZBwi98nAm9jQueO/yjSmuorvOSQG5
	9+obHxyh2JDZfbOethU4UpLTXMiTrYTjgHprW
X-Google-Smtp-Source: AGHT+IHlc4s/s/55ElUaUz3cVLVdAQgf0cVgD2Lgnr2hgoE30sFPrSs46+Kf7Q5rU7kI/xgLWqRerx7iktLxcbQX/no=
X-Received: by 2002:ac8:5f4c:0:b0:42f:a3c:2d51 with SMTP id
 y12-20020ac85f4c000000b0042f0a3c2d51mr132826qta.18.1709760970984; Wed, 06 Mar
 2024 13:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085007.169771-1-herve.codina@bootlin.com> <20240306085007.169771-3-herve.codina@bootlin.com>
In-Reply-To: <20240306085007.169771-3-herve.codina@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 6 Mar 2024 13:35:31 -0800
Message-ID: <CAGETcx9RFS7Z61FeCYXMxRSDXnMYhg_y96dgtbHp-3t_9x8+SA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] of: dynamic: Synchronize of_changeset_destroy()
 with the devlink removals
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 12:51=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> In the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
>
> During the step 1, devices are destroyed and devlinks are removed.
> During the step 2, OF nodes are destroyed but
> __of_changeset_entry_destroy() can raise warnings related to missing
> of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2 ...
>
> Indeed, during the devlink removals performed at step 1, the removal
> itself releasing the device (and the attached of_node) is done by a job
> queued in a workqueue and so, it is done asynchronously with respect to
> function calls.
> When the warning is present, of_node_put() will be called but wrongly
> too late from the workqueue job.
>
> In order to be sure that any ongoing devlink removals are done before
> the of_node destruction, synchronize the of_changeset_destroy() with the
> devlink removals.
>
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/dynamic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 3bf27052832f..169e2a9ae22f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -9,6 +9,7 @@
>
>  #define pr_fmt(fmt)    "OF: " fmt
>
> +#include <linux/device.h>
>  #include <linux/of.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> @@ -667,6 +668,12 @@ void of_changeset_destroy(struct of_changeset *ocs)
>  {
>         struct of_changeset_entry *ce, *cen;
>
> +       /*
> +        * Wait for any ongoing device link removals before destroying so=
me of
> +        * nodes.
> +        */

Not going to ask you to revise this patch just for this, but this
comment isn't very useful. It's telling what you are doing. Not why.
And the function name is already clear on what you are doing.

Maybe something like this would be better at describing the "why"?
Free free to reword it.

When a device is deleted, the device links to/from it are also queued
for deletion. Until these device links are freed, the devices
themselves aren't freed. If the device being deleted is due to an
overlay change, this device might be holding a reference to a device
node that will be freed. So, wait until all already pending device
links are deleted before freeing a device node. This ensures we don't
free any device node that has a non-zero reference count.

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

> +       device_link_wait_removal();
> +
>         list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
>                 __of_changeset_entry_destroy(ce);
>  }
> --
> 2.43.0
>

