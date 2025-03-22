Return-Path: <stable+bounces-125821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8ACA6CC45
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707983A125E
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC98221569;
	Sat, 22 Mar 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="b3bDNhVP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC6145A03
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675544; cv=none; b=B3pEwhIUR7w0JYo/NJnJvwDpAPokjvNdB1dPPN1bTOQP3kp1ONh/ZjV0K+HL/HrrodAN4USgczrN8BGIdjeSsJc3yQlXXj9ABHWX3UciibBhEgnGMNB5bZt7SVnrokZPym4KNgauS8cKOePanvtAzt0/1CvVG963SJeTK8uXhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675544; c=relaxed/simple;
	bh=D6xw3hIsJ2aRRajmvqQhUs8BD4FYVV0vhxPiULPlv3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLA1tk+ivGlhFP4kprZQ63ken4MlmAuYsYW+bO1ocuZHDsGzVUpToYAKPb1WoAjgJSFdaK9zm4mAeOqYTw0Xzf1MEyfPh/eU1bz+Dk2+IoXOMAA53B9DM1ey0YqKQKp5oB5QPdSXaCyqA6cNDjGW+xkWe5iDIAkx8VCY5fmruj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=b3bDNhVP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so5517424a12.1
        for <stable@vger.kernel.org>; Sat, 22 Mar 2025 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1742675541; x=1743280341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBaCnQErjphWQ/6DEDPtyGgc1KmN6LXb9upYohAu4Nc=;
        b=b3bDNhVPeNmzKd/jOrwLQqknPm3PUVY1yqDJEuZvqkJpseXbQdv9I1AWvnUwU5eNHE
         MWkyA0pjpl9Tin2FHueDDOsMdlvJlDICslZiHAWKxkgHwkr+XJ57wN8ovAFlkB+zv6yD
         V4kwE4RRKZE6Wc2uuB5m+OcU+yBHqVDQSDqpvZkqVHh/Ab8Nma2YlJVpHrRtJkH0zIv8
         iKOXunTP0A+yh4677m6fU8iEnip+eI4yZNUzRH0R0SdrbN0cKcNdIN0H8gCPWImkQNNx
         YrfBbalczmwPPWbXYRRUs349ZjSMPCOWKZIqB8aeBWINcngF1vz6Ze4YFxPrnUxXu0yY
         FIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675541; x=1743280341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBaCnQErjphWQ/6DEDPtyGgc1KmN6LXb9upYohAu4Nc=;
        b=V0dcePutKlZynlE2M79QltIqX5OIh7o3Y+dWjyXuCu5gayySV4BX0ep1uk1Tayq+1S
         9wnKPKnQcrdLs4lEV1sysu4lg++YZrkC0eE7SOtxJ6uXBQwTvx+T++2Glxfsnl/23Oz/
         h5dxQbzUlxcMvXfSeRX74ZFlvBv+tRh65XsTBLWb5OVUsHphRLkKXnfq7Mny+T150+Ss
         N2vJzhZSHfM0TbDzXUvVmY1qaz9Si3ofbFrZybpqsD7EI3pi+fsELxEc4AzLDikQlZxN
         5YxWbWlpnS8qCf19k69bS0NKnAdalXGchK2VtdaDzK92YX8Qglb8aUBmrqogGynfa8lt
         rdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyXdszHqqpL00WJIi8HjwtdZ/gPORNEp4ZkUlAe8oBLePR87exl24HicURfitHtLDBoQTZC0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2B/45LAS94CEW6WQkoBiAMN0fw3NTPVKTD+Zn5L35s8cWXZJQ
	3qBmolKl6bca09+GAHTAFMPMmdQTN4Zrg8tTsmwXLIp+GS7Cl1fOA1mUHD2zbE1nWaDmSATVYjx
	U5xRqkmtoDKgwvAzrQWVvk1mztt4hwdmidLjeIQ==
X-Gm-Gg: ASbGncuyKhjSbp9gewAZZ9gDTg7rX093Rhk58P8UMrAkW4v/uZeJSMQnlANy9D6R0u3
	v3ctRLmBWY9b05MorhZ3oe7zR/WZ5bygSwjCFYNiCdmMKpaZzpz6WzzCS8K49VfuqHWNWNI1EE3
	sb4TSNtk2gb53jvnxATtPLZ/mLtbZo2tdt/GMF6w==
X-Google-Smtp-Source: AGHT+IFtgOvQ/ipQ5UFSn66TToxJyVI3SzkIjV049UlX5bGqRqNfgfHmq7s9TmGxajhk9iLQXeErbCLQrAMLvdy2238=
X-Received: by 2002:a17:906:d552:b0:ac3:1373:8a3d with SMTP id
 a640c23a62f3a-ac3f226dfc0mr719120366b.20.1742675541018; Sat, 22 Mar 2025
 13:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321145302.4775-1-johan+linaro@kernel.org>
In-Reply-To: <20250321145302.4775-1-johan+linaro@kernel.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Sat, 22 Mar 2025 15:32:08 -0500
X-Gm-Features: AQ5f1Jo_ng3ufW9UOehzcLhlOEtOWJZFpCerf42h3io3os1P4AkoGlgh3Ackpds
Message-ID: <CAKXuJqh0_7fduDgDXWzCE2fYNHV-mDa29Lxq15h7-vam2Nin6w@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>, 
	Clayton Craft <clayton@craftyguy.net>, Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Fri, Mar 21, 2025 at 9:55=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Add the missing memory barrier to make sure that the REO dest ring
> descriptor is read after the head pointer to avoid using stale data on
> weakly ordered architectures like aarch64.
>
> This may fix the ring-buffer corruption worked around by commit
> f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> ring") by silently discarding data, and may possibly also address user
> reported errors like:
>
>         ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set
>
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LIT=
E-3.6510.41
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org      # 5.6
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218005
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>
> As I reported here:
>
>         https://lore.kernel.org/lkml/Z9G5zEOcTdGKm7Ei@hovoldconsulting.co=
m/
>
> the ath11k and ath12k appear to be missing a number of memory barriers
> that are required on weakly ordered architectures like aarch64 to avoid
> memory corruption issues.
>
> Here's a fix for one more such case which people already seem to be
> hitting.
>
> Note that I've seen one "msdu_done" bit not set warning also with this
> patch so whether it helps with that at all remains to be seen. I'm CCing
> Jens and Steev that see these warnings frequently and that may be able
> to help out with testing.
>
> Johan
>
>
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wirele=
ss/ath/ath11k/dp_rx.c
> index 029ecf51c9ef..0a57b337e4c6 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2646,7 +2646,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, in=
t ring_id,
>         struct ath11k *ar;
>         struct hal_reo_dest_ring *desc;
>         enum hal_reo_dest_ring_push_reason push_reason;
> -       u32 cookie;
> +       u32 cookie, info0, rx_msdu_info0, rx_mpdu_info0;
>         int i;
>
>         for (i =3D 0; i < MAX_RADIOS; i++)
> @@ -2659,11 +2659,14 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, =
int ring_id,
>  try_again:
>         ath11k_hal_srng_access_begin(ab, srng);
>
> +       /* Make sure descriptor is read after the head pointer. */
> +       dma_rmb();
> +
>         while (likely(desc =3D
>               (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_en=
try(ab,
>                                                                          =
    srng))) {
>                 cookie =3D FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
> -                                  desc->buf_addr_info.info1);
> +                                  READ_ONCE(desc->buf_addr_info.info1));
>                 buf_id =3D FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
>                                    cookie);
>                 mac_id =3D FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie)=
;
> @@ -2692,8 +2695,9 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, in=
t ring_id,
>
>                 num_buffs_reaped[mac_id]++;
>
> +               info0 =3D READ_ONCE(desc->info0);
>                 push_reason =3D FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_RE=
ASON,
> -                                       desc->info0);
> +                                       info0);
>                 if (unlikely(push_reason !=3D
>                              HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRU=
CTION)) {
>                         dev_kfree_skb_any(msdu);
> @@ -2701,18 +2705,21 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, =
int ring_id,
>                         continue;
>                 }
>
> -               rxcb->is_first_msdu =3D !!(desc->rx_msdu_info.info0 &
> +               rx_msdu_info0 =3D READ_ONCE(desc->rx_msdu_info.info0);
> +               rx_mpdu_info0 =3D READ_ONCE(desc->rx_mpdu_info.info0);
> +
> +               rxcb->is_first_msdu =3D !!(rx_msdu_info0 &
>                                          RX_MSDU_DESC_INFO0_FIRST_MSDU_IN=
_MPDU);
> -               rxcb->is_last_msdu =3D !!(desc->rx_msdu_info.info0 &
> +               rxcb->is_last_msdu =3D !!(rx_msdu_info0 &
>                                         RX_MSDU_DESC_INFO0_LAST_MSDU_IN_M=
PDU);
> -               rxcb->is_continuation =3D !!(desc->rx_msdu_info.info0 &
> +               rxcb->is_continuation =3D !!(rx_msdu_info0 &
>                                            RX_MSDU_DESC_INFO0_MSDU_CONTIN=
UATION);
>                 rxcb->peer_id =3D FIELD_GET(RX_MPDU_DESC_META_DATA_PEER_I=
D,
> -                                         desc->rx_mpdu_info.meta_data);
> +                                         READ_ONCE(desc->rx_mpdu_info.me=
ta_data));
>                 rxcb->seq_no =3D FIELD_GET(RX_MPDU_DESC_INFO0_SEQ_NUM,
> -                                        desc->rx_mpdu_info.info0);
> +                                        rx_mpdu_info0);
>                 rxcb->tid =3D FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_=
NUM,
> -                                     desc->info0);
> +                                     info0);
>
>                 rxcb->mac_id =3D mac_id;
>                 __skb_queue_tail(&msdu_list[mac_id], msdu);
> --
> 2.48.1
>

While the fix is definitely a fix, it does not seem to help with the
`msdu_done bit in attention is not set` message as I have seen it 43
times in the last 12 hours.

-- Steev

