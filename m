Return-Path: <stable+bounces-66743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDF694F162
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598211F22D48
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A428517F374;
	Mon, 12 Aug 2024 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="enZE672M"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45117E8E5
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475414; cv=none; b=daUWAY1mGm6gNrAhIgCu5VIvDlpGEzOHrxaX/QloO/lrraxZ/v6idpLrt6CLTE/tZtRvYkf2QbaKrSjh9Cgl3IUhaVaeL/yr+L17LDZLc5QCQZF1nSkE5VYr5cjJmI9gqCaQ+7M0d9aj99cmm9gOqrKRHqzkTqVY66Hi6RbD4Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475414; c=relaxed/simple;
	bh=VGF6oJyAgmPFuwaefTGZFzlfeJQSh6cOYKm2RKH7HrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlLJp/dr0sxkX+4KZrTqHpaAyy8LDNoipbP6f4PpvfUFx+FQ3dvxVanCZK5mXo7sDAT7w7gUfJfeOTb0aZg8zUmmxgcp4xBPxMxO+AShzsij6GIfyQBXKuAlMPEynTX0ifMYs9nLwPVWicJKlej1O9xpJ+3vDWXgRHAm4eYfQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=enZE672M; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-530d0882370so4306642e87.3
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723475410; x=1724080210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5ISblONe9ovI30OJlQ4o3WBGuasGom4tOKOheQ7zcY=;
        b=enZE672M3HEiOQBbdl1OpT7NcIqKlMjQaxzYYxiNLCGOL4KGTw19yFQoBxY7Rb4AJc
         cWV+Fk1+Vj5witFWqsUYPNr4UYqCGhC5W8U8nb4Xcsj28r01Swy16jLxp4TYlHJI62UJ
         U1IJltYqKAjDPYuLkMI/C3V7eQL/tSVl2cKzsIdsoVRC8BXWgmJYL13gYiN1N/5vaiHI
         LuSQJ6fx9PlktmjSsuA1csfTpmMNjSR7UfOAOO50Nus8fIBeuOik1MvKxebwheRNYP4U
         hoed/VTb2ckTWhvSW611Paj/iieVMMPS3sLMvuFZbyJvXnqqB1Eszfh6QX/f6izFpDVx
         iHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475410; x=1724080210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5ISblONe9ovI30OJlQ4o3WBGuasGom4tOKOheQ7zcY=;
        b=WEmtSou5YG9oXxRv0n0VpwhTkV3nVeFIisSn53G2QDdGzfOSJw3kbqzQ9ip5hRC/W5
         NEUdm7FEaBLycpwukAM1ZhcVQj7rXQl9v4k/Lwz5l576ZO/7Vmxk9X3vHSY+KAh9H5fS
         ZYjpoWhtsLdmHpCKMfjvaEOIfBckX1ugZ4yeKhTL6jEGHWfx/Yv8h4FDw+wHBK3HmtsW
         wfvtRFmt9SxFvIAMffrFneVJ6Yj8vNREuZ875GsYIjQ9SnPHijLtv+cYsnTydpb7YmBg
         ADxv2rXpFq5m3W9Q9FpRC9Sthjp1BPdK/JoQdnE6SJwIYxlwtWHAk46HMiRYQ7z09RYS
         Se2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWi2g/amcfYOzX17DIMzGWceRIcqSwMkvuIY0z7zRxDO8scXLStxOUIy78cSFa3AKYCHlwVhApczpmhXAsPvtemG7Q/rppx
X-Gm-Message-State: AOJu0YzLKQzI79TAjJdUKowCeX9T3ogECeJcN31v6uoyWbfbAHJmoRuL
	EhITeTKeTu/veMen4Jch4ke/KdcHYUuOepVgS7QHjKyoi162gDayGjzV/L8Vfr7kteMQ9ulroL2
	frrRtgpbNRW7Ul9Eb6Y2f0WXR6FUxoE0bqe67Gr4Z6KnYT7Fb
X-Google-Smtp-Source: AGHT+IGciZYPjqufT5xOYZFO4wlBpxsedoZpaLrO0eF8OR4tPQfVConuXFTLA/bRO3Qt9CtzwqJKkfhriYV48kQaaOs=
X-Received: by 2002:a05:6512:12d3:b0:52d:b226:9428 with SMTP id
 2adb3069b0e04-532136483demr422478e87.6.1723475409947; Mon, 12 Aug 2024
 08:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024081250-taco-simmering-1043@gregkh>
In-Reply-To: <2024081250-taco-simmering-1043@gregkh>
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 12 Aug 2024 16:09:58 +0100
Message-ID: <CAKisOQHHWY1EQ6n6qT4Bh8=8EG6rY-oxcTBo=9bNe4jzSHnNNw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] btrfs: fix double inode unlock for direct
 IO sync writes" failed to apply to 6.10-stable tree
To: gregkh@linuxfoundation.org
Cc: dsterba@suse.com, josef@toxicpanda.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:07=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081250-=
taco-simmering-1043@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
>
> Possible dependencies:
>
> e0391e92f9ab ("btrfs: fix double inode unlock for direct IO sync writes")
> 56b7169f691c ("btrfs: use a btrfs_inode local variable at btrfs_sync_file=
()")
> e641e323abb3 ("btrfs: pass a btrfs_inode to btrfs_wait_ordered_range()")

I have a version of the fix ready and tested for each stable branch,
I'll send them out soon with you and stable@ in cc.

Thanks.

>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From e0391e92f9ab4fb3dbdeb139c967dcfa7ac4b115 Mon Sep 17 00:00:00 2001
> From: Filipe Manana <fdmanana@suse.com>
> Date: Fri, 2 Aug 2024 09:38:51 +0100
> Subject: [PATCH] btrfs: fix double inode unlock for direct IO sync writes
>
> If we do a direct IO sync write, at btrfs_sync_file(), and we need to ski=
p
> inode logging or we get an error starting a transaction or an error when
> flushing delalloc, we end up unlocking the inode when we shouldn't under
> the 'out_release_extents' label, and then unlock it again at
> btrfs_direct_write().
>
> Fix that by checking if we have to skip inode unlocking under that label.
>
> Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@go=
ogle.com/
> Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during =
direct IO append write")
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 9f10a9f23fcc..9914419f3b7d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1868,7 +1868,10 @@ int btrfs_sync_file(struct file *file, loff_t star=
t, loff_t end, int datasync)
>
>  out_release_extents:
>         btrfs_release_log_ctx_extents(&ctx);
> -       btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
> +       if (skip_ilock)
> +               up_write(&inode->i_mmap_lock);
> +       else
> +               btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>         goto out;
>  }
>
>

