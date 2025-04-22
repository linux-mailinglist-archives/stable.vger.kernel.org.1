Return-Path: <stable+bounces-135205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CDEA97A49
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0177AD6E2
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C53626C39E;
	Tue, 22 Apr 2025 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZPTX3bV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC59D2701A6
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360208; cv=none; b=Pni7n0gwNrwQRooAplU9DsiekT24v9ARj5KVPGD0//9KbGX8x6m7jPoBm/3lc5IfrGnzaAlLtpbyuocdEg/o739p/1f1ddUCt2sg0rqywGmuYs2fHZBH8D+lx1btqA5+8VaLk1UG0OKyP7W6ddU+ZxL5H2D1zEQ2cQ4hChvgdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360208; c=relaxed/simple;
	bh=j34TG0ZCU906v9hRGob+DPUSHNnxdo24R0/qWN7aDeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQptcOmfNpL7cPTPX/HJa20KY1G0wxpNU18U0zyz3HQjtQzl/CjBCsOloU3T0h/0g9Rrnu878FKw5/VgbHNzjJeTaMV54n++nsBNkACpMUpsv5mRZTJrsq8LAQDTxu+PA95YPNOY3GHGcNZKqKcfqc0yvLoTlRfxfcxoFp2Vq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZPTX3bV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30db1bc464dso55284551fa.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745360205; x=1745965005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKoimiCksQIzBUGjbx7qewGySEIiTp7eGdVRQpnqRgQ=;
        b=FZPTX3bVLWZUqGWhnT13PR2FifCPD7USOQz0wt9YXP22xgs1lp116oSokjxzIuku8g
         BNTKiKJCzyLIkKP2AxjnfqSXVbMsgIhHrg3wTK0E4+5OTkc6devNH6JNmIw70v7rIpU4
         wU5LFdKa+H5CbpsZLJLyLwBqzkrBRllW7g4ZsRNSVLkIm2wFDwMDAPGm7lcQ1fKwnKhU
         jGsU+KArM82Zvw07LL+KJQOdspLo+FXehb+HhPfIZVijSYUKuLbIQefYI8o4t3HcyN20
         6Kj9KiZWXfiKVauOKl+I6CHGBNvzJo2sUMiDY6aQZw3BbluLMecHxzHWD4YTyhwDyqmQ
         wovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745360205; x=1745965005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKoimiCksQIzBUGjbx7qewGySEIiTp7eGdVRQpnqRgQ=;
        b=W+5qxBsHyPPn72OTSY7enGAWQSIdGtjhHv/xpaGHD74C+ps6axSMzjXtbf9h4pFNBN
         F9cKQnugspMaU4ajVJ+6q5ShjPHfv/hA2ws7EaB6U6nuA20avMjHLg4mWYuE/MAHEkl0
         aCgCOOoXCtWWWhkjG+iGS+/G2EDxKO0i+UfcN1jqelKEHltCrra38LqA1yfRgeiZdmOB
         RswNq+ywYdqGRPNxEgK5d0xs7DIRdl55vJ6QcUbAG/nb0guAJDS9kQXh/x3/iKM7nbC6
         VzS1ozdEIF4vV+o33u2mXyxkFGk7CoJ0OtEMxSX+l7WCV5s+xxPFZz6kBarW+KXkylF3
         lkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl+GrDCUEXfASFcWs0C+Zqjk9w0ZK1qTukMRsdb1b8NeW5flxbhFDVngvn6jtru0bUaeARhB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUbiwt7VaadwN8CF6ZMA0bEuUu8mzAC+ydpk9gcLorxgafl/v
	gf/072Au7U5uL/Nqo7LPLDJvHRGHOZP/s9RSsqECHDm/9QayZgkMSIxcMkh6+w/hSyCG5bbsE2c
	UsZ3lehvh+n5EB0BTKOXCFbhfPhO08hBSDB8=
X-Gm-Gg: ASbGncuHSPdKuS7lgtUij6As08rQ51moFggqVXaynpzjTIi1DKQCDwz+2T+sbLM07WO
	wnLM+zVg6CX0GSyS/TbAzLEnVYXsiLOrpfef2d+AkMabo7A15zqpaa7K19Uya2bAgvh/CgTPoVy
	aph4ohi+FpzxOKgbA0N0KssgbZYfkvKhQUKdetx5XClVekfJ8RGA==
X-Google-Smtp-Source: AGHT+IFCqPiCVaci+VRuCTGYMkeXR6Umeyfg+uL/5cZ6CZxu9rQKeAcyUCvmN8ZkAAxF3uYo+5/BxaEaUOj73lEkbFo=
X-Received: by 2002:a2e:a109:0:b0:30b:d0d5:1fee with SMTP id
 38308e7fff4ca-310903d0644mr55127391fa.0.1745360204555; Tue, 22 Apr 2025
 15:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <16733109-69f6-e347-e1af-02af6223ca8d@redhat.com> <20250417030737.3683876-1-weilongping@oppo.com>
In-Reply-To: <20250417030737.3683876-1-weilongping@oppo.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 22 Apr 2025 15:16:31 -0700
X-Gm-Features: ATxdqUF4hGAAgUeg9QYAGnS1aBi43g82V1TajRKTO1qYwRfBd33fbXMlzpJlaTQ
Message-ID: <CANDhNCrpSApv55_0LN816nNaGhPWiWZNODr-_1egjPpgGGb1-A@mail.gmail.com>
Subject: Re: [PATCH v3] dm-bufio: don't schedule in atomic context
To: LongPing Wei <weilongping@oppo.com>
Cc: mpatocka@redhat.com, dm-devel@lists.linux.dev, guoweichao@oppo.com, 
	snitzer@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 8:07=E2=80=AFPM LongPing Wei <weilongping@oppo.com>=
 wrote:
> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index 9c8ed65cd87e..3088f9f9169a 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> @@ -2424,8 +2426,13 @@ static void __scan(struct dm_bufio_client *c)
>
>                         atomic_long_dec(&c->need_shrink);
>                         freed++;
> -                       cond_resched();
> -               }
> +
> +                       if (unlikely(freed % SCAN_RESCHED_CYCLE =3D=3D 0)=
) {
> +                               dm_bufio_unlock(c);
> +                               cond_resched();
> +                               dm_bufio_lock(c);
> +                       }
> +       }
>         }
>  }

I realize this has been queued by the maintainer, but in
cherry-picking it for the Android kernel, I noticed there's a
whitespace oddity with the closing bracket indentation. Might deserve
a followup fix.

thanks
-john

