Return-Path: <stable+bounces-233090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKkSHG2vzml+pQYAu9opvQ
	(envelope-from <stable+bounces-233090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:03:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F438CD7F
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 526543017312
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E517370D52;
	Thu,  2 Apr 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZG7WqtD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17D362130
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153000; cv=pass; b=ijyKkLJGwGMO6IKQVGPgjrtM/eCBzKmphFzwxxNFy6bfwjGhTJd3qJpOQzgceEPs+TvJScge3Q2AoOROR4itVzQd80dvLJy/YcoaTLoKQ5ylmURhA9pblPuUBAT/waYAC/HTM5DHgiwzXsqghzSot46Rku8hHs1p9Q1T1E9Zzh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153000; c=relaxed/simple;
	bh=d+41bWrPZASMK3eSIbSSj318xtKaXZplSr2koxtWAOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc5AbSJgFeg4+hcEuB14VZA+PgR1Sb+m6f+yZExEeTnT2NSCHMLUuYtVgEd4J6rR30dond/5Ja2vL4h1oeTAsm07lKeG2y8ItMrXaeOPl4sOoiPeEPBIVM5tQF/dU2vtImTFFzhtCauoxW+ctf1NqBeOnY04nxMiXkmpiulxjpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZG7WqtD; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d750eeaec3so533162a34.0
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 11:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775152997; cv=none;
        d=google.com; s=arc-20240605;
        b=gzEWBdhnauCcVNfW5/PDS94LDPGhptCYfs2lSKkXvMtKucAVza7bpolZuKK3c1MnH2
         YRrPLWCmbZm8m60MGOdDvWZiqaVfHwsM5EwNvVxx9bP6N8HoNR4nO3mfAu3qmn++eEF/
         Fyprk9G15M9fS3HcS+HBstcs3w7mh8s99oDvwEdqptg1CS6DwDp1dmG6IYnpoKRkGT2x
         +e77bMbvwrE5f3i7fREdXn5hjkf796T38srUYJy+YVwHSbebT5o72ZJG3fiSMuwh6iV7
         pBp4bunT85wtHzcumnk06pbhdMyOziADigLDzchANT3uwI0N0MFH2BJy6HM+o48V7gZ6
         qV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0TW/KELxmP6HAx/s1ZGX6uuibSSGSUbIAcodT49xPg=;
        fh=0lchGt/AxOZQ9MrzDObT96luwKQNKAm+/XobSFMt3bg=;
        b=MbSNJ7V08KspndfDXqDoX5nUj7hHU5YntYQIPOqevQ6qOm/QyFQb6WV4JyL2bBbgW0
         CSX9mwCJid7oUcKMkydtgCZvCjgG2AwFXHXZAe2ymOoUnCtEtohvLw4dUTryjKM5rG/1
         NZDwlEKFR1Y1kJ1liYHf2R1+PuUSa2g1M4mId1QWd2V8SIctYFZSMFLMNLMbHnoraloy
         x7k1OPyUkQ9mSggr8XpxZha1Jsewe01BtcMHM2Aujm+LJjbWS49fgPZsw7Riu7U91Og1
         DhBa8xKCOuJmBomjgIzgvcQo5KnGcqWOj3c7qWDX7hEnN1Ob2Ed+Sp/chi18j9n72qV8
         c6Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775152997; x=1775757797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0TW/KELxmP6HAx/s1ZGX6uuibSSGSUbIAcodT49xPg=;
        b=UZG7WqtDKYhsXpbN2DMSWFZ756CS6iB41FR/9CLATLVZzHAFZXV/zg8ZFhDkdcuqTF
         Eb/WEnxwaRGWeBopVhlL9FDfRF5DyAMPpnTIwo6Q7my7RBWtSl8regLuGduV8qPmXqwZ
         q61PbRO53BSFWtYfRpEVXcLaqXyAs5dQl2EQ/RIx4mWRr46DpSzMYukHyFyj5S9Pzh2m
         ckth0F0V9sLrSWG0TUydjuPbb0XmdYX7HmeErUjuPuAVd8nXvQwpqTMfuA38cvfhnNso
         QUoVtGAw++SXV/hSe4f0Al1GEGNyHkaA0EBxJdh+h5pOpU3tYC3j/GBfTMkF7jqFPkrL
         H6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152997; x=1775757797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0TW/KELxmP6HAx/s1ZGX6uuibSSGSUbIAcodT49xPg=;
        b=Q70YTGNMlqGtmu5sjUCq13W/DBrqz5wB8YyzKqg2rqA23sHSmZWhTWDvJbvKfvpA6t
         S1LqzYIuTl3y6+mm1q7nbfgREQ6+bcKP7W/Eiy48N5Y0NMQwNRbMKa8TVqeji+/VJ3ir
         /+8+EGjxjUAge/Hk+x5oEBHfjG5uh2ZY4zXY2507voG8Wqx6RUCoSlikmf3zBlbSEZya
         BPYHH/AdVtf0ZjTmvfCS4uOrAr2tR1JMjD4G704IWP/p/MjD1l0XlF7z+lsBFZRix5Hk
         iIQWe4X3F8RfB1w36Ic2YcGGD6tLTGvEC024ZUIpVisAeUI72MmRT8tEHcTH4dUarfuN
         J0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsTal7W5g6EcySCnx3m5rsQpYjIRAQyHXnCmksrUTNIG+YiTrQAHKG4gj63IB/IAIBfLbl6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqe5fBstsp8jPyz3BJdaFX7m+f4SLMvzDNyk6NkeGjmlX7Ims9
	fC/p9Cwk9cDOv3C5GMVqjyWLWochCfGkMasF9qLwS/f56i4J7SGg1TiMf4kZyYEiol1TeJCM9G5
	o3cQVUH+zrfnFFp8N0k0WrjxOBLoDKIs=
X-Gm-Gg: ATEYQzxJ1ZrG7vQeNe2XXQUMrPsdbXYDZ7Edmx4m5FijeOgQubbSnWg4DJ0vSkvd8SX
	T+7NP552TTy+4iG2sOgkfmgLHAYjGIiXB4agNjGAsvBtpAK7eC74Tzm1NGFu/4fulZePzHVYurO
	WuEiSZ7Ie+vb33qIOkZBtYDZgpMbZLRYDEb/DsgzvTEC74jAWqQW9gJtu0Z57qixPDvBZnlfiIL
	9fCV4qkeD4DE3IMc52ibK6DE97axTPEulzY93mUyKImd41LlrZqWqqAxyeLtPPB3SbBNPrvsBzy
	VcrBWnhP
X-Received: by 2002:a05:6830:611b:b0:7d7:c96c:c5d6 with SMTP id
 46e09a7af769-7dbb6f1aea6mr240409a34.1.1775152996668; Thu, 02 Apr 2026
 11:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402170641.2082547-1-joonwonkang@google.com> <20260402170641.2082547-3-joonwonkang@google.com>
In-Reply-To: <20260402170641.2082547-3-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 2 Apr 2026 13:03:05 -0500
X-Gm-Features: AQROBzCl5IvjHSRY9VamVjuRyy3ZLLYtLTcWUCKJtq-4tAuHHgLfoU-JXy74tSw
Message-ID: <CABb+yY3hYcJ82QGor3w5KKHUGz9Pc1k64Jdf-94E4Yvv0DTeyQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error
 code when tx fails
To: Joonwon Kang <joonwonkang@google.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233090-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,nvidia.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 751F438CD7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> When the mailbox controller failed transmitting message, the error code
> was only passed to the client's tx done handler and not to
> mbox_send_message(). For this reason, the function could return a false
> success. This commit resolves the issue by introducing the tx status and
> checking it before mbox_send_message() returns.
>
Can you please share the scenario when this becomes necessary? This
can potentially change the ground underneath some clients, so we have
to be sure this is really useful.

Thanks
Jassi


> Cc: stable@vger.kernel.org
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> ---
>  drivers/mailbox/mailbox.c          | 20 +++++++++++++++-----
>  include/linux/mailbox_controller.h |  2 ++
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index d63386468982..ea9aec9dc947 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -21,7 +21,10 @@
>  static LIST_HEAD(mbox_cons);
>  static DEFINE_MUTEX(con_mutex);
>
> -static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct comple=
tion *tx_complete)
> +static int add_to_rbuf(struct mbox_chan *chan,
> +                      void *mssg,
> +                      struct completion *tx_complete,
> +                      int *tx_status)
>  {
>         int idx;
>
> @@ -34,6 +37,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *ms=
sg, struct completion *tx
>         idx =3D chan->msg_free;
>         chan->msg_data[idx].data =3D mssg;
>         chan->msg_data[idx].tx_complete =3D tx_complete;
> +       chan->msg_data[idx].tx_status =3D tx_status;
>         chan->msg_count++;
>
>         if (idx =3D=3D MBOX_TX_QUEUE_LEN - 1)
> @@ -91,12 +95,13 @@ static void msg_submit(struct mbox_chan *chan)
>
>  static void tx_tick(struct mbox_chan *chan, int r, int idx)
>  {
> -       struct mbox_message mssg =3D {MBOX_NO_MSG, NULL};
> +       struct mbox_message mssg =3D {MBOX_NO_MSG, NULL, NULL};
>
>         scoped_guard(spinlock_irqsave, &chan->lock) {
>                 if (idx >=3D 0 && idx !=3D chan->active_req) {
>                         chan->msg_data[idx].data =3D MBOX_NO_MSG;
>                         chan->msg_data[idx].tx_complete =3D NULL;
> +                       chan->msg_data[idx].tx_status =3D NULL;
>                         return;
>                 }
>
> @@ -116,8 +121,10 @@ static void tx_tick(struct mbox_chan *chan, int r, i=
nt idx)
>         if (chan->cl->tx_done)
>                 chan->cl->tx_done(chan->cl, mssg.data, r);
>
> -       if (r !=3D -ETIME && chan->cl->tx_block)
> +       if (r !=3D -ETIME && chan->cl->tx_block) {
> +               *mssg.tx_status =3D r;
>                 complete(mssg.tx_complete);
> +       }
>  }
>
>  static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
> @@ -286,15 +293,16 @@ int mbox_send_message(struct mbox_chan *chan, void =
*mssg)
>         int t;
>         int idx;
>         struct completion tx_complete;
> +       int tx_status =3D 0;
>
>         if (!chan || !chan->cl || mssg =3D=3D MBOX_NO_MSG)
>                 return -EINVAL;
>
>         if (chan->cl->tx_block) {
>                 init_completion(&tx_complete);
> -               t =3D add_to_rbuf(chan, mssg, &tx_complete);
> +               t =3D add_to_rbuf(chan, mssg, &tx_complete, &tx_status);
>         } else {
> -               t =3D add_to_rbuf(chan, mssg, NULL);
> +               t =3D add_to_rbuf(chan, mssg, NULL, NULL);
>         }
>
>         if (t < 0) {
> @@ -318,6 +326,8 @@ int mbox_send_message(struct mbox_chan *chan, void *m=
ssg)
>                         idx =3D t;
>                         t =3D -ETIME;
>                         tx_tick(chan, t, idx);
> +               } else if (tx_status < 0) {
> +                       t =3D tx_status;
>                 }
>         }
>
> diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_c=
ontroller.h
> index 912499ad08ed..890da97bcb50 100644
> --- a/include/linux/mailbox_controller.h
> +++ b/include/linux/mailbox_controller.h
> @@ -117,10 +117,12 @@ struct mbox_controller {
>   * struct mbox_message - Internal representation of a mailbox message
>   * @data:              Data packet
>   * @tx_complete:       Pointer to the transmission completion
> + * @tx_status:         Pointer to the transmission status
>   */
>  struct mbox_message {
>         void *data;
>         struct completion *tx_complete;
> +       int *tx_status;
>  };
>
>  /**
> --
> 2.53.0.1185.g05d4b7b318-goog
>

