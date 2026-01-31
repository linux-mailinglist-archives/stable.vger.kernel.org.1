Return-Path: <stable+bounces-212960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE/nLrhifmlNYAIAu9opvQ
	(envelope-from <stable+bounces-212960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 21:14:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F70C3DA7
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 21:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFCB8302D94F
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AE1376473;
	Sat, 31 Jan 2026 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnS/G4TN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C0F37475A
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769890470; cv=pass; b=n8fWa8wBoYogdFUvycEXSzzCz2MeDRUdwKAa+J12iAsxieq50dcXVMI0MhwfU9EF39fPGEencX2dLeoI7Rkv8TA03Yn3B2YKjlW9Kw5Y2lwLNf+kjDIq4TBM20G0iyUIT0xU7kdNHITUszWOEPYy5l4nCvegCqSzLZ9Y0YQUFLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769890470; c=relaxed/simple;
	bh=yMZHFitBveSwTiyRgSyxNN1NEBI5FO4K9xicZu7zkl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUYlLAp1xiLsu7KMeno8H7y9OX8lzKJiLn+8hnXtflfpg/znQVrnYzlWWLhDgwAjVs39vRUbQJkp0LPaTrDxzsgVA6OpMoN/z1MRIvaqv106ipMSsk1kNGyKknTNDG93YRT+g7dJ11EFKrIfbyKIQ5dDTgn3TGfiB+lmZesQcbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnS/G4TN; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658f1fde4bfso1417757a12.1
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 12:14:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769890468; cv=none;
        d=google.com; s=arc-20240605;
        b=EOuZu0WU03XY7dSfCyYjXv5GEMyRujSFshCXahj74tubXEG8Zo+IbHgFbKnJRtw2AK
         +aeDuB34dx8PR/ZNFVlEijgz/vcXHGz2Ma3K21cG0tu592TYfQyRVYB//XjsS27mlM1Y
         ASAahJ5Yx+9tLNJSvwlU3xUJm6Wz/1dlLUFOfsabMcVmXoTvyvVNYFib/JSC28lzoOyv
         ZkMvxs2XbF2+WbtoKD7OztVYxpgG9lukLH8Qjv8VaQcWmm+GdQxXkYJeqyTf97tNC3zD
         DPr8UO1DMkXBEtCPFSg8lZ/vAt+Ja1+KZYIukmj3jHHi4UWVEMiZ6ONlGvU1i2FriLwb
         ivqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=km8kplnm0XUJRbZI5k8OFXrzF6vf8FSgEbZtSrDmOz4=;
        fh=2WYExVZv8v6NV3Q+ihm1cgNwQfq1CEewfAdZu9a79Fk=;
        b=jU7s4Avrw/GZev12YO8/OzhSL5Db4BBEUa0CGQ6W5DXPx6brXvdxdP7uUwi6KfQDrp
         mFiwmu2PRn6MsB6jy1j6KBAF2kAUCqCjgs73D+5UfCF5SDOL5ReCw+SuO6TjGI9f0nQG
         GO3u03rRz/ab2gWRyRLPZlbjvCQZ3T5RxCdnXJLgoBLi2+40kfx+CMGGf2Ad0pcMyB+8
         IrOixAA7Op/DDzzSseKB8peD5YXoFlsx1y9Q7i8pQ25xlVZW4mmDsGF35Drl/y1rbFal
         8gCpLwoXDMWZgx5Ex4TF8IPLvOwyZiNDr9KBIJbFhYmvaU9PnnfUaJ6HOz9aclLGl0I2
         93VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769890468; x=1770495268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km8kplnm0XUJRbZI5k8OFXrzF6vf8FSgEbZtSrDmOz4=;
        b=tnS/G4TNEedmNr80OFoKem8ANs3tt3BZcWf8YQpk9OyLKiA89e1lPKqDHo1IAB8pHA
         EPYHJj8G/qWsfd3DsYU2EOCA/Jn4Pp0ZfMF+DUBEprY4CEoQMUYc3KiIFwIFMEJ04I69
         J+Bn80+H3EThh1iautNEZvzWsYTpk+TiVXyLUfpuIWk9SH7e737Bf+AYoJPGlbzQnvBa
         ofIsqEZVwxoaluliTZ46jHbPbyFAeV7q6IJRO92IIYdXncwGDtR9zk5eWrNVvuyENY2p
         Rt1uUNsSNia1f4arhgaaZuDXwKuPP3bnxbd8D0C4m1d4NyMuLxjK/0bjmaAerBh0509C
         aZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769890468; x=1770495268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=km8kplnm0XUJRbZI5k8OFXrzF6vf8FSgEbZtSrDmOz4=;
        b=Z4C502R9rAFCf/2Q3at1y5mA9M1uF5HH4R4BlZOp8OEkPorpEE3oitHSyHTvtqLkWm
         q1PUtSPzSUMp5laKjfVL2NsDjCQf+a4mTN3qpAnN8G7CFRUZtyvanrlLkmjfbyRPwTPH
         vM7ThgYSrclgz5es1kt6J087nzPtj5aoRw0UBVMQfULw4Tlsw2zvgkfAh+wUY0wTmh0P
         aDC/DoqxjlAj+3T+qqATqCWW7Yg4H4wIgmSyhkiWliF9doKOk1RbsXZys6bxo9vGDq//
         yxMTLXLIAwLJ4M9wAl3qv2pTkRQdeGwE3BVK3SJX6Q9NihavMwNF15DrHMkhHE9hDYG0
         3EZA==
X-Forwarded-Encrypted: i=1; AJvYcCXlLCPE/nRNs27rlslgbEJOlqQ14mIzk2SsIcP0HIAUhImT4RBkBPN9fM+0tARC0IB0h8hGwL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1njP7wstfLEPRc2ZsTDEKQIVswDVDe/BZt6kw8cvpqjIK1CeX
	Y4+OC6F5Eg0nfhev2y8//jxHqpCgVQXqsxUgyL4caj3K9wDNrLioBFrDdtxlwgwwLIRFbRKsSMO
	9Ejz0FS+nHqzJ3mSiiFHDdu6yqG432KVJoGFKlZlQ
X-Gm-Gg: AZuq6aIHx2zrdLo0CqvyCVibBI6W6iqgVLyqOFKswutWKGKoIiZ9/XN97c9GCHXE4/t
	6q+D6fGcHyUcxvdGTeZnhNmMrf424VEnLZiM6KO5B3Q8aQAV0Z1UxcwVdil4GAa1942KvT2LRjZ
	jvBaigk2qbgpka6IvPqkM6GVdcXAxDVkRqkh/Err3vEgvus5lEjbRdz43HL+dod278ciIhi6Qb5
	qcDiI/LOANqIhrF++diqA1MxBs3jd9g/J5S2qkU94tWcIKbtxGVTjasEkemiaq8Ct7Q
X-Received: by 2002:a17:907:720a:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b8dff432d83mr474220066b.16.1769890467383; Sat, 31 Jan 2026
 12:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129111403.3081730-1-prashanth.k@oss.qualcomm.com>
In-Reply-To: <20260129111403.3081730-1-prashanth.k@oss.qualcomm.com>
From: Samuel Wu <wusamuel@google.com>
Date: Sat, 31 Jan 2026 12:14:16 -0800
X-Gm-Features: AZwV_QidVxFPSSU4X1IAAyjblyzS6gM99DWlGcx5x-nNJW2TuFYl1jr8vKw-2Xw
Message-ID: <CAG2Kcto8GZmSkWMmdWkZaQLrt-HS8e5XQ2LWKVxv08PyQDjpjQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Move vbus draw to workqueue context
To: Prashanth K <prashanth.k@oss.qualcomm.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212960-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 38F70C3DA7
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 3:14=E2=80=AFAM Prashanth K
<prashanth.k@oss.qualcomm.com> wrote:
>
> Currently dwc3_gadget_vbus_draw() can be called from atomic
> context, which in turn invokes power-supply-core APIs. And
> some these PMIC APIs have operations that may sleep, leading
> to kernel panic.
>
> Fix this by moving the vbus_draw into a workqueue context.
>
> Fixes: 66e0ea341a2a ("usb: dwc3: core: Defer the probe until USB power su=
pply ready")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> ---
>  drivers/usb/dwc3/core.c   | 19 ++++++++++++++++++-
>  drivers/usb/dwc3/core.h   |  4 ++++
>  drivers/usb/dwc3/gadget.c |  8 +++-----
>  3 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index f32b67bf73a4..c9af126b9695 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2155,6 +2155,20 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
>         return 0;
>  }
>
> +static void dwc3_vbus_draw_work(struct work_struct *work)
> +{
> +       struct dwc3 *dwc =3D container_of(work, struct dwc3, vbus_draw_wo=
rk);
> +       union power_supply_propval val =3D {0};
> +       int ret;
> +
> +       val.intval =3D 1000 * (dwc->vbus_draw_current);
> +       ret =3D power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP=
_INPUT_CURRENT_LIMIT, &val);
> +
> +       if (ret < 0)
> +               dev_dbg(dwc->dev, "Error (%d) setting vbus draw (%d mA)\n=
",
> +                       ret, dwc->vbus_draw_current);
> +}
> +
>  static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
>  {
>         struct power_supply *usb_psy;
> @@ -2169,6 +2183,7 @@ static struct power_supply *dwc3_get_usb_power_supp=
ly(struct dwc3 *dwc)
>         if (!usb_psy)
>                 return ERR_PTR(-EPROBE_DEFER);
>
> +       INIT_WORK(&dwc->vbus_draw_work, dwc3_vbus_draw_work);
>         return usb_psy;
>  }
>
> @@ -2395,8 +2410,10 @@ void dwc3_core_remove(struct dwc3 *dwc)
>
>         dwc3_free_event_buffers(dwc);
>
> -       if (dwc->usb_psy)
> +       if (dwc->usb_psy) {
> +               cancel_work_sync(&dwc->vbus_draw_work);
>                 power_supply_put(dwc->usb_psy);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(dwc3_core_remove);
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 08cc6f2b5c23..052fb18c6b5c 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1178,6 +1178,8 @@ struct dwc3_glue_ops {
>   * @wakeup_pending_funcs: Indicates whether any interface has requested =
for
>   *                      function wakeup in bitmap format where bit posit=
ion
>   *                      represents interface_id.
> + * @vbus_draw_work: Workqueue used for scheduling vbus draw work
> + * @vbus_draw_current: How much current to draw from vbus, in milliAmper=
es.
>   */
>  struct dwc3 {
>         struct work_struct      drd_work;
> @@ -1413,6 +1415,8 @@ struct dwc3 {
>         struct dentry           *debug_root;
>         u32                     gsbuscfg0_reqinfo;
>         u32                     wakeup_pending_funcs;
> +       struct work_struct      vbus_draw_work;
> +       unsigned int            vbus_draw_current;
>  };
>
>  #define INCRX_BURST_MODE 0
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 9355c952c140..03d8a3a151e0 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3124,8 +3124,6 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gad=
get *g,
>  static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
>  {
>         struct dwc3             *dwc =3D gadget_to_dwc(g);
> -       union power_supply_propval      val =3D {0};
> -       int                             ret;
>
>         if (dwc->usb2_phy)
>                 return usb_phy_set_power(dwc->usb2_phy, mA);
> @@ -3133,10 +3131,10 @@ static int dwc3_gadget_vbus_draw(struct usb_gadge=
t *g, unsigned int mA)
>         if (!dwc->usb_psy)
>                 return -EOPNOTSUPP;
>
> -       val.intval =3D 1000 * mA;
> -       ret =3D power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP=
_INPUT_CURRENT_LIMIT, &val);
> +       dwc->vbus_draw_current =3D mA;
> +       schedule_work(&dwc->vbus_draw_work);
>
> -       return ret;
> +       return 0;
>  }
>
>  /**
> --
> 2.34.1
>

On Pixel 6 with this patch applied on 6.19-rc7, I am no longer seeing
the following lockdep:

[ BUG: Invalid wait context ]
6.19.0-rc7-mainline-maybe-dirty-4k #1 Tainted: G        W  O
-----------------------------
irq/360-dwc3/1244 is trying to lock:
ffffff8018110eb8 (&psy->extensions_sem){.+.+}-{3:3}, at:
__power_supply_set_property+0x40/0x180
other info that might help us debug this:
context-{4:4}
1 lock held by irq/360-dwc3/1244:
 #0: ffffff80368d78f8 (&gi->spinlock){....}-{2:2}, at:
configfs_composite_suspend+0x28/0x68
stack backtrace:
goodixfp: Succeed to open device. irq =3D 417
CPU: 0 UID: 0 PID: 1244 Comm: irq/360-dwc3 Tainted: G        W  O
  6.19.0-rc7-mainline-maybe-dirty-4k #1 PREEMPT
Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
Hardware name: Oriole EVT 1.0 (DT)
Call trace:
 show_stack+0x18/0x28 (C)
 __dump_stack+0x28/0x3c
 dump_stack_lvl+0xac/0xf0
 dump_stack+0x18/0x3c
 __lock_acquire+0x794/0x2b08
 lock_acquire+0x138/0x2c4
 down_read+0x3c/0x17c
 __power_supply_set_property+0x40/0x180
 power_supply_set_property+0x14/0x20
 dwc3_gadget_vbus_draw+0x8c/0xcc
 usb_gadget_vbus_draw+0x48/0x128
 composite_suspend+0xcc/0xe4
 configfs_composite_suspend+0x44/0x68
 dwc3_thread_interrupt+0x7b4/0xc7c
 irq_thread_fn+0x48/0xa8
 irq_thread+0x16c/0x338
 kthread+0x150/0x280
 ret_from_fork+0x10/0x20

Tested-by: Samuel Wu <wusamuel@google.com>

