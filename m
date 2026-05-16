Return-Path: <stable+bounces-249018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CwYKJerCGqB0QMAu9opvQ
	(envelope-from <stable+bounces-249018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:38:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4455CF89
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 634663004052
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B603E8351;
	Sat, 16 May 2026 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="UTLOZhkp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44153E3C40
	for <stable@vger.kernel.org>; Sat, 16 May 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778953105; cv=pass; b=BYgfePyLpZY8CZPrGVeZN+xHnu3U9eUYON7TLRIoE5aJfTl0TPPDaG+mWxWaPP3xZ5xpBHg/Erk0FLbjxa4COE+97UehvqPktAU4VGJhPgtMK6pTmpi2TrSpGSv4lj1mWHtezkvLzfC3O5waVzAJcZlkt/xacg9GSmhARlA/9bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778953105; c=relaxed/simple;
	bh=OkrMi/TXdG40eKm3Q9OdbThzj7pTlThc7MJ8KdYmvaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trD3UjhHOK/1YZRNa8SMxS7mhs33yVti47TaC6OG/8MEKtfkrw7sjY6yG7pAGcGs2Mgfx38mUKN4FFmV5UNqi7L1dV1kTbKTqTmVYfBeY7wnN+wJZLCooOMrEyYREji3gMzI7YBH566jxGEgwBH79tD354sPp/wJfq4UNDZOgPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=UTLOZhkp; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso833504b3a.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 10:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778953103; cv=none;
        d=google.com; s=arc-20240605;
        b=KX6uQf8Bi08yoScBlAlqCod8jdkS4w8BKOvlTqqRwbxyOU2ZineZxIqXt5VFea3Es1
         z4Qam1OnF5yJVSy1OwaonTGWDlgHVLR7lbXbZnYpdtaFWfUX0jUeQi/80nhl/f5SE/NU
         wYc/e7LzCdPb1a7woG5ZFroS+Zg39xWrPxR1DB05Dq4AvrIxr8U6wgCVyNlvBzOWORnN
         nZuS/QcIu/kjDDhOTOAnZ9FQoI55Orfz7MmGKVCXerqN+/ddQUXYFuLII2of8tsWa2b+
         q5WSIJh4LEuz6ZjU3FOiD09zgJ1bsCJC0q9uI/i3QnRyKiHpmSYvkwKRWf7fmL+9Wv9m
         8hyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4kLf/IDpaJiLgOHOdp4fOl3PFJn48m5f1SnG8AhR504=;
        fh=ttw+KrzpxvrA/sxJs148lFQs9HKPRwhBQ86ShvwXIlw=;
        b=U0cWp4bSAflCSLLfTDjVjptgsJPenq0nrawpvCWGbpd1ditYRc4yiGEeHXb2IKz94p
         U+iOLw8+0qVzHH8h1iMwvF2004K3u7+Px5si8V1RYptiO9wpuVtXsINco0KLhdn23nXz
         5GmiXLzrURbiFbNWj5Tvjacbhtfz0jYLawRQ96eDRIOp63aVR6VzqjEHMjPEwqw71paF
         GFCNyXyxTeEfNIbjjDBTdXdPQDiM/YVCUTRSAFXo3wvwGr/wj0g62Hb0hgFXSMnZ4ToO
         1zg7Eh60lqGwdsDQnsuXPj60X8+FOBmqQq8txBfKZ3cx2D2zzhIwgc0f+mVH0PYv77H3
         VFaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778953103; x=1779557903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kLf/IDpaJiLgOHOdp4fOl3PFJn48m5f1SnG8AhR504=;
        b=UTLOZhkpa158/9v25RAvfhofKswnSzr9JYEQLrkCMM1yxGDBI7F23hhYm4cMth6Rhe
         RvODOg/UmBaONdue4M/tgbsVTFUptwUhEsNpvZRv2/yNggrVReSH10Hk7p16AIvP4Pew
         bXade5EqSO6+RbCnGS8vgmVwX5OCdXxYcFsvsOld1nGNE5tcV0KXH/QSyu5ARa27YNwm
         cIUDsVjctCNCQdiqzXzimuXFyxESijaGFhFkUMHOEOTMX/kLyd4iAhG410Jm/PiOL13H
         uu7kAn+KKkeiHjURjRZkCxwlhDzg0hNnX7bidDdA0DG+77roOnzZtpir8Jbs9e/QjuN4
         SVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778953103; x=1779557903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4kLf/IDpaJiLgOHOdp4fOl3PFJn48m5f1SnG8AhR504=;
        b=VwYaLvAmfDJpq/yNCjKfLM/iUnSwNySsDFUfOmpqkC70tJQaJegHzLRfJyF9z7cRtf
         ZQ+gEyczq+4oUDdl5Xv8O52bN3rnTOsEmhcJJ+13eSTHPpOmuQR+bvlM4szuMcRcWUMm
         8q1wrnN8f+ezhQUNNKZnBJ3O5L+ObzSW7L2KhmWnQsbFmoi3V/4TVAWudKV4lOPtrTIa
         Ol2DVgWF/SHpPa9kar/JC/wpeRWGNr+osa5StpN51o2n134OiIewqIunZNYBmUejKqRq
         +0cPvsXEzyP6wLG+23N+uMRQWc74Xj/8/CxCyO9sKD7/9YttOkicgSM4nWPa3NIUqz6T
         hQPA==
X-Forwarded-Encrypted: i=1; AFNElJ/Z0zBOFGUmyEy/Ymhcp5nGF8To4RVZ83xksYzYruklC0hEjJUBKJpCmNooUuNDrRHNx9MISok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNvBtOx8E4TCzz0VmixDRG/D8b9P2gUrLREB5jfC4jOgyvhl7
	qxdfFqG95KKA+TvWO/cTg0vrmhBqxqo7Xco+Vklq92W/jksmgApZTKD/TKr0M7vg6kFyyAq30hW
	4TsjCYm/29k6ZqXIPKcb9uLbg/kFaNXwoNSNfMvsl
X-Gm-Gg: Acq92OEN8Ivgt4JPICGxGrczdCwLylvyW1qU12mcqjSZESF/pX6jlUz7+0I3mIvzo5e
	FCTFBwwjms3RQXn04bDXdHKAUzXnluK3VC48ym5OtTIhYt0fxdJ48M5cpCkFUQPGeAOzrMHFfFx
	AW3Pz4weui+oYI4/CjTb79MT4QMJifZ+RWOmB+/f3bFl8mwZHQL/QBOxCytkfs+XevLIxLCZXdt
	7MbqgRjopXH5W6fCldwIhu/T7Oo0p2DDuEcvPVi+yzcfW81i5gR3bt/JMU4xEI6+tTJipVcAKAh
	8DSH/8kp73Iov/GBQpHz68ckixT0O/MB/xFezYNJ
X-Received: by 2002:a05:6a00:bc93:b0:82f:2a78:6302 with SMTP id
 d2e1a72fcca58-83f33d97da5mr9462105b3a.26.1778953102906; Sat, 16 May 2026
 10:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516162825.1480113-1-rollkingzzc@gmail.com>
In-Reply-To: <20260516162825.1480113-1-rollkingzzc@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 16 May 2026 13:38:10 -0400
X-Gm-Features: AVHnY4Ka4gsjMANdAeumvJvNOiAMpbvA2eip4qX5mh08hu5rAkldcm8BAoaygmA
Message-ID: <CAM0EoMmrn4gJ8KNu4kDpEP3+GWR1+jtJgbxMDgO_ZmyA4e6qOA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: extend the writable skb range per key
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, zerocling0077@gmail.com, 2045gemini@gmail.com, 
	stable@vger.kernel.org, "yimingqian591@gmail.com" <yimingqian591@gmail.com>, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A7E4455CF89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-249018-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,oss.qualcomm.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 12:28=E2=80=AFPM Zhang Cen <rollkingzzc@gmail.com> =
wrote:
>
> tcf_pedit_act() builds a rough writable prefix from tcfp_off_max_hint
> before the action mutates any packet bytes.
>
> Since 6c02568fd1ae, TCP and UDP keys recompute their L4 base from the
> current L3 header inside the key loop. An earlier key can therefore
> change a later header-relative base and make the final store land
> outside the initially ensured prefix, where it can fall back to
> skb_store_bits() on skb frags.
>
> Keep the initial estimate as a fast path, but grow the ensured writable
> range from each key's final computed write offset before loading or
> storing the edited word.
>
> Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offset=
")
> Cc: stable@vger.kernel.org
> Co-developed-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>

Please dont report or post such patches in the public next time.
Follow the procedure outlined here:
https://docs.kernel.org/process/security-bugs.html
I have removed the public mailing lists from this response.

This issue has been under discussion for the last two days based on
two other patches. Those patches are better than what you posted. We
will make sure you get added to as reporters of this bug.
Will you be willing to test the final solution?

cheers,
jamal

> ---
> While researching recent page cache bugs, we discovered this bug. We conf=
irmed it allows overwriting the page cache of read-only files via splice().=
 We haven't attempted to write an exploit, but the corruption primitive is =
verified. PoC available upon request. Recommend fixing ASAP.
> ---
>  net/sched/act_pedit.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a27890..58a8eae6d43e7 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -398,11 +398,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>
>         parms =3D rcu_dereference_bh(p->parms);
>
> -       max_offset =3D (skb_transport_header_was_set(skb) ?
> -                     skb_transport_offset(skb) :
> -                     skb_network_offset(skb)) +
> -                    parms->tcfp_off_max_hint;
> -       if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> +       max_offset =3D min_t(u32, skb->len,
> +                          (skb_transport_header_was_set(skb) ?
> +                           skb_transport_offset(skb) :
> +                           skb_network_offset(skb)) +
> +                          parms->tcfp_off_max_hint);
> +       if (skb_ensure_writable(skb, max_offset))
>                 goto done;
>
>         tcf_lastuse_update(&p->tcf_tm);
> @@ -414,8 +415,9 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
>                 int offset =3D tkey->off;
>                 int hoffset =3D 0;
> +               int write_offset;
>                 u32 *ptr, hdata;
> -               u32 val;
> +               u32 val, write_end;
>                 int rc;
>
>                 if (tkey_ex) {
> @@ -451,12 +453,26 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>                         }
>                 }
>
> -               if (!offset_valid(skb, hoffset + offset)) {
> -                       pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n", hoffset + offset);
> +               write_offset =3D hoffset + offset;
> +               if (!offset_valid(skb, write_offset)) {
> +                       pr_info_ratelimited("tc action pedit offset %d ou=
t of bounds\n",
> +                                           write_offset);
>                         goto bad;
>                 }
>
> -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> +               /* Earlier edits can change later header-relative offsets=
, so
> +                * grow the writable window from the final per-key store.
> +                */
> +               if (write_offset >=3D 0) {
> +                       write_end =3D (u32)write_offset + sizeof(hdata);
> +                       if (write_end > max_offset) {
> +                               max_offset =3D min_t(u32, skb->len, write=
_end);
> +                               if (skb_ensure_writable(skb, max_offset))
> +                                       goto bad;
> +                       }
> +               }
> +
> +               ptr =3D skb_header_pointer(skb, write_offset,
>                                          sizeof(hdata), &hdata);
>                 if (!ptr)
>                         goto bad;
> @@ -475,7 +491,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>
>                 *ptr =3D ((*ptr & tkey->mask) ^ val);
>                 if (ptr =3D=3D &hdata)
> -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
> +                       skb_store_bits(skb, write_offset, ptr, sizeof(hda=
ta));
>         }
>
>         goto done;
> --
> 2.43.0
>

