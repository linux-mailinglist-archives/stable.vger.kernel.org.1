Return-Path: <stable+bounces-249370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COL/EBViC2pHGwUAu9opvQ
	(envelope-from <stable+bounces-249370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:01:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFF572861
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D1233017BD5
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1338B149;
	Mon, 18 May 2026 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E42DB2do"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71917B50F
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130890; cv=pass; b=YsmOFzwofxcfUtVsBCbXzxsLGy1OH22P/nSrECJnYhh35Tg9b8n8u606oWf8Ehfvy8bFOiErbPJ3Q0+1KGANV7NRnXQlqo7OUYLfvt0M56gcuVHdpTRce+XvnBMAlG1WBcHN5pYkkoSNjak2ZXcMiEZtt7IMuJvuQYt5/CZT160=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130890; c=relaxed/simple;
	bh=mpK7u4PCSqQRcbGoSCMwAEJaJCeAXdQkCv8Lit1PpyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c43wTuA27QswQEHLIJidUg40rgjBYRKvKz1747Ogl65yE6Y+y4xbqEruQ1HS8S/0kNpmMijXHFg2XurMkAjiZG/jXApgP/p6rizOVSIHHSv9KDCNR4/iX1K+gdf2CjKpS4rHgJ76DDFdKGS0tnSIUduxAjI4+wiCBXZ6Q8VGB3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E42DB2do; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4824b15c19eso2430269b6e.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 12:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779130887; cv=none;
        d=google.com; s=arc-20240605;
        b=d/6GJUV9ncr3u/A+Pqs5FiUjU6hal/3BDznqYWUhWaqQCmBfe3f3XSDYTw61UopfXn
         Roc1Ixx+XkP0xBbgvdxFTtctpsWDyxy7hb1ymehuYLog/774kWqKzS+eVNEZWC17Mje/
         yg4lDMYoFVhhQ5ALmoKHqo9U7SD6JI3t7+sUB4Pvn8PvnJ3qv60CixDIPq17wpAXQ7Ml
         4+yj21/Nmv+gLtCGe3YhGwcWSBOeeNmBnfMK6UzNcxGR/ulrkU9z5eWJJOOsznP+Gz/m
         v/6Q9MiF1u01mPyn+EtHxz6Rs7VGeyTNwmR9xlROEQnIJcP+WOglTdP1VyWkta2kXuls
         ApnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRI31PKgbkirUhtXF9xzrolP+bQLXGzf3pB4KteZN+E=;
        fh=Kvl21A3vs2Q6sXPWCyTUbs1fmip9zO1ylJwfm7dp0aY=;
        b=kXNy9ano0Rn9tqiaVz1B3FSwFHKXRAniUhDOdtOeYzaHM/dfxQSt8npGD6QCYMyKiU
         hyBgKUlz8XKYRbQccLzRIdBGmpsUXqjGSychB4fWgQnLG2dZ2vCv5ibkQ9y45rKQ11Gm
         5/yXoqGx+kNDOzwBdpeOotRTCjypdVU33E+XkVt75LZH37j9AA78R8gtTPOY8X/819t8
         Ic8N0G8Eh/ediJn2yaraubEC2BwaSrH+O+u6mC8nspabphFthXjVpvusR7lOxFqc5Fyq
         agInXZVoDNalgaYf9fjZaxYpoAKqhvA6BLXE13m3l3kTUBUyvNZn6027WiimAJruvurM
         qCTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779130887; x=1779735687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRI31PKgbkirUhtXF9xzrolP+bQLXGzf3pB4KteZN+E=;
        b=E42DB2doApFDWxmd/YpAtRP4mx4rwi3Aj75DxjBubrhqFZv2ZRCpK2S3zPISO8lFbW
         A5FVoQ2j76oe3704tzDrMIoY1mgSw7c3Fj/mWFdUYPxpQdSwOg6yAiZSul2V8RJencaU
         rmbHXxQ+2SM8cw3Zs6Fs9dILO8M4//ycDKhk6w17UU5OKxawVLsrCfxA99qXjX/fp4x3
         mgdjT0cSIPrnBunAY7zYnRhtKepy2aEUyMVdhNYEJ9cR9L/tMB3/MkY2M4xolgHdoPe1
         seZtIad8OtMPnW7jnMDdMOLdmRYwvCUqbZIfQLN41nNvygBfJ8XCsPFbDpTsqgob9Fps
         CyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130887; x=1779735687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRI31PKgbkirUhtXF9xzrolP+bQLXGzf3pB4KteZN+E=;
        b=a3MDTXDdhDrhUgeiC82zvXkxo/iacOsgv5E4TIVChEPI3p9CYAPR4GBzP6g0P/xem7
         rJjW+U5oxm62Xw058BUn4EOr0LEMT+uNRAkatfchtQ63VFXM7pOf/t0gK+XOHSSqvJ7W
         QPdFeEw650xb2QxVPKRRswfoFEr27Qwbx/HSCVFTnL2zUtjz4FcnLzAiA2IgfU0ZXtnW
         tX9JHMEgEgjLU7bLJMZOgfftl0wDQWsBS1T5a0fYqcQV8IEabEEKvIl6HJT5f349ZVRI
         DdEm6LrxiBLxqaXt9AEZnpies0PmofIPrAjHFH93JdG9soJ2DIK3uEl/yrzTGS9iJ278
         Ye6w==
X-Forwarded-Encrypted: i=1; AFNElJ+JeZAk8k5xd4QcEErLhcPgICIgs6ol4Gyw/oEMwQnP48v+ranYHSadNsRa3XEDpAAAs5HfXGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxEvfRbWo6RGYpwW1UBgHrMT5Cz0v5j+uF35eeuHmT//B9eVVV
	J4qR2oNplYpNDIdAIW3XK7nxtIGMufMwsmqd4vVmCWBVIufl0ffAwSW41NhvAQLXRdQNSWhfYbO
	OX31RvesBBFX6ldM2oVmgBZtv/XAHy5U=
X-Gm-Gg: Acq92OGpneCSvIqaYWldtadrcpu6d8IvkBICX/nl+icTUzbmOG+vJFQGVSPSgb9JZdD
	K9ZSIAr54hszWdSLDiyhlkagGhiI9LQZz54VVg+1sbn4w+KVC0jUWxMa2QcsYhXYZPBEmAS4WR2
	HAmkprWyszN+32AWokdTmmmeb/jOpVXDTF0PAhWML3jNlbp6iLLiAz23htuTveqKerjeKZ7xsck
	j9YGPOdiKoY0ljoQYmgEUgubqD571AsBh5iAdXaJEbL5310/GvWWU7tUwJ/36lVP3x+kiO57cju
	e3gujiIm
X-Received: by 2002:a05:6809:3d8:10b0:484:afc2:eecf with SMTP id
 5614622812f47-484afc30716mr4575537b6e.24.1779130887073; Mon, 18 May 2026
 12:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510054111.784204-1-joonwonkang@google.com>
In-Reply-To: <20260510054111.784204-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 18 May 2026 14:01:15 -0500
X-Gm-Features: AVHnY4Jjq5NacN1j_98a3TZeDoCXC3k88pyw_ZmVI4ycR1PxCAIHy8VXJ1WcuqM
Message-ID: <CABb+yY35-jTK3ez0nmPAmCPG598PmH+qH_bJK3gpkkyb68VfnQ@mail.gmail.com>
Subject: Re: [PATCH v6] mailbox: Make mbox_send_message() return error code
 when tx fails
To: Joonwon Kang <joonwonkang@google.com>
Cc: sudeep.holla@kernel.org, dianders@chromium.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249370-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3BFF572861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 12:41=E2=80=AFAM Joonwon Kang <joonwonkang@google.c=
om> wrote:
>
> When the mailbox controller failed transmitting message, the error code
> was only passed to the client's tx done handler and not to
> mbox_send_message() in blocking mode. For this reason, the function could
> return a false success. This commit resolves the issue by introducing the
> tx status and checking it before mbox_send_message() returns.
>
> This commit works with the premise that the multi-threads' access to a
> channel in blocking mode is serialized by clients, not by the mailbox
> APIs, since the current mbox_send_message() in blocking mode does not
> support multi-threads.
>
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
> v6: Remove the Cc tag from the commit message.
> v5: Add note to the commit message that the current mailbox APIs in
>     blocking mode do not support multi-threads.
> v4: Detach it from the previous commit that supports multi-thread in
>     blocking mode and rebase it on the latest for-next branch.
> v3: No major patch since v1.
>
>  drivers/mailbox/mailbox.c          | 6 +++++-
>  include/linux/mailbox_controller.h | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index b00f7a32e866..066702e5a46f 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -98,8 +98,10 @@ static void tx_tick(struct mbox_chan *chan, int r)
>         if (chan->cl->tx_done)
>                 chan->cl->tx_done(chan->cl, mssg, r);
>
> -       if (r !=3D -ETIME && chan->cl->tx_block)
> +       if (r !=3D -ETIME && chan->cl->tx_block) {
> +               chan->tx_status =3D r;
>                 complete(&chan->tx_complete);
> +       }
>  }
>
>  static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
> @@ -295,6 +297,8 @@ int mbox_send_message(struct mbox_chan *chan, void *m=
ssg)
>                 if (ret =3D=3D 0) {
>                         t =3D -ETIME;
>                         tx_tick(chan, t);
> +               } else if (chan->tx_status < 0) {
> +                       t =3D chan->tx_status;
>                 }
>         }
>
> diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_c=
ontroller.h
> index dc93287a2a01..26a238a6f941 100644
> --- a/include/linux/mailbox_controller.h
> +++ b/include/linux/mailbox_controller.h
> @@ -120,6 +120,7 @@ struct mbox_controller {
>   * @txdone_method:     Way to detect TXDone chosen by the API
>   * @cl:                        Pointer to the current owner of this chan=
nel
>   * @tx_complete:       Transmission completion
> + * @tx_status:         Transmission status
>   * @active_req:                Currently active request hook
>   * @msg_count:         No. of mssg currently queued
>   * @msg_free:          Index of next available mssg slot
> @@ -132,6 +133,7 @@ struct mbox_chan {
>         unsigned txdone_method;
>         struct mbox_client *cl;
>         struct completion tx_complete;
> +       int tx_status;
>         void *active_req;
>         unsigned msg_count, msg_free;
>         void *msg_data[MBOX_TX_QUEUE_LEN];
> --
> 2.54.0.563.g4f69b47b94-goog
>
Applied to mailbox/for-next
Thanks
Jassi

