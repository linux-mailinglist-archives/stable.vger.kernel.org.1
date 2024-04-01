Return-Path: <stable+bounces-35495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D388945EA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 22:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC8C1C21968
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 20:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCE3D9E;
	Mon,  1 Apr 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTLskXyD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E82E410
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002679; cv=none; b=FWfyFTgEdjFNkVbgE2RgDIai+Oy+/pGR0gK89kmChg2JgnvcN5bzBaFbnNym4lsot1Z5b7ZNlUh5U4/zt239q3fQM+w69Tqby8oMnYcgmBRaRqjJ/6h8ETdweVp5U9cxC8e9Zy2tKTwdcgbQWD8VM44jGwm64kU8EiFJ8zdmY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002679; c=relaxed/simple;
	bh=ZY9811+zu+uQ7d0Cuk1AcJNSqLqOAsff3pvUj9TS+C0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4NGM5x/V0JoQ/+3k0uND5jwtwDrluB1yRG4He93F+pCMp9gREmn6sfOYri3BBMnYerVOUUjdwhcrSJLXP9peXWUXWWx83KpRi0i7y290N//HTDJoBoWx/9z9cj6rXJTOgty/0RsrJjQcejPV7QE45XomhlQZQnL6qwwcowFOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTLskXyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6216C433F1
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712002678;
	bh=ZY9811+zu+uQ7d0Cuk1AcJNSqLqOAsff3pvUj9TS+C0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bTLskXyDXOEEJriKWcQ1QY5oc06Mw7AUsGE0KVxVyrfHn1RUR7LmNPrA78ifjatP+
	 MqpObFkTAEt8iIp4oti+TFLfIvlmGHCxYpRPJ/lo1knBuI5FY1ur2gZxj7tE5JQSvm
	 Smc9us6yduCPyJP/ylJs/X4/a5Sp3Ne6D17mPDOL7sNskbWPg6hJaDqBKiqMT+OGGz
	 CTJ7i1k86je4Ay90n/pRdygA677qNqNhzsiFp9sk3EGX0UqRsHKAw5zIUAKk9JdmH4
	 TFx916kFLad/xFcQZ5Hwm7s7htTtwat9zJZytcIickUjE95aDU5qf8rl0X0GWinO9d
	 mw0Sws1U8fS8Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-515d49a6b92so1606117e87.3
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 13:17:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyQ5q2ZS20AgCR1DtV0YvTN2MZTwhPm314dVWOmugv9uLnYqnSR
	ehsuycir0t1+MN2buuM6xLzcFH4yndX09oqQEsI7jS5krp4g+Z7B2Cbn0nZ+33Tgysr57YTuc9L
	zE554BW6TRupz+aK1+3BkYO1JzQ==
X-Google-Smtp-Source: AGHT+IH/WCDpfF40/4k2Thcy+kvgYXzXW006C+tEnefpOqLa6560teCSXDzOxxEQ2kLNL7b9UyTa+Tblg9J5jZB/WEM=
X-Received: by 2002:a05:6512:5cd:b0:515:a6dd:9657 with SMTP id
 o13-20020a05651205cd00b00515a6dd9657mr5841843lfo.16.1712002677570; Mon, 01
 Apr 2024 13:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152530.237785232@linuxfoundation.org> <20240401152533.057644896@linuxfoundation.org>
In-Reply-To: <20240401152533.057644896@linuxfoundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 1 Apr 2024 13:17:45 -0700
X-Gmail-Original-Message-ID: <CANeU7Qm5dU_G6Y2omjeAmLNSsZ1G5ynH6+VMQvzC-RmV2Quu=A@mail.gmail.com>
Message-ID: <CANeU7Qm5dU_G6Y2omjeAmLNSsZ1G5ynH6+VMQvzC-RmV2Quu=A@mail.gmail.com>
Subject: Re: [PATCH 6.1 079/272] swap: comments get_swap_device() with usage rule
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	"Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good to me.

Acked-by: Chris Li <chrisl@kernel.org>

Chris


On Mon, Apr 1, 2024 at 10:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Huang Ying <ying.huang@intel.com>
>
> [ Upstream commit a95722a047724ef75567381976a36f0e44230bd9 ]
>
> The general rule to use a swap entry is as follows.
>
> When we get a swap entry, if there aren't some other ways to prevent
> swapoff, such as the folio in swap cache is locked, page table lock is
> held, etc., the swap entry may become invalid because of swapoff.
> Then, we need to enclose all swap related functions with
> get_swap_device() and put_swap_device(), unless the swap functions
> call get/put_swap_device() by themselves.
>
> Add the rule as comments of get_swap_device().
>
> Link: https://lkml.kernel.org/r/20230529061355.125791-6-ying.huang@intel.=
com
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Chris Li (Google) <chrisl@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 82b1c07a0af6 ("mm: swap: fix race between free_swap_and_ca=
che() and swapoff()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/swapfile.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cca9fda9d036f..324844f98d67c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1222,6 +1222,13 @@ static unsigned char __swap_entry_free_locked(stru=
ct swap_info_struct *p,
>  }
>
>  /*
> + * When we get a swap entry, if there aren't some other ways to
> + * prevent swapoff, such as the folio in swap cache is locked, page
> + * table lock is held, etc., the swap entry may become invalid because
> + * of swapoff.  Then, we need to enclose all swap related functions
> + * with get_swap_device() and put_swap_device(), unless the swap
> + * functions call get/put_swap_device() by themselves.
> + *
>   * Check whether swap entry is valid in the swap device.  If so,
>   * return pointer to swap_info_struct, and keep the swap entry valid
>   * via preventing the swap device from being swapoff, until
> @@ -1230,9 +1237,8 @@ static unsigned char __swap_entry_free_locked(struc=
t swap_info_struct *p,
>   * Notice that swapoff or swapoff+swapon can still happen before the
>   * percpu_ref_tryget_live() in get_swap_device() or after the
>   * percpu_ref_put() in put_swap_device() if there isn't any other way
> - * to prevent swapoff, such as page lock, page table lock, etc.  The
> - * caller must be prepared for that.  For example, the following
> - * situation is possible.
> + * to prevent swapoff.  The caller must be prepared for that.  For
> + * example, the following situation is possible.
>   *
>   *   CPU1                              CPU2
>   *   do_swap_page()
> --
> 2.43.0
>
>
>

