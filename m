Return-Path: <stable+bounces-215874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIJsFmjUjGm+tgAAu9opvQ
	(envelope-from <stable+bounces-215874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:11:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4996127136
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A22F53024151
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A506534FF47;
	Wed, 11 Feb 2026 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZRuWlQ1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B45303A35
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836846; cv=pass; b=eEVC1M3lQ5fTeKaJSF0GlU+GCRNblFejljAGXQcFP6wVnLAIiAEyJ1M73GYFY2FFfKdC5SvDY/xUxVDjSppLNmHTQBAbDD8YSUQBc4WXiOCFXoyHWS318dgj2qZw7WC0hOsm47YwyHIlWPiL47buYUZ+SgudwZGgIbyu7+6bCRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836846; c=relaxed/simple;
	bh=p9HwxvmB/RtNijuLWoEzhbkHs3QEd/JA8FvZu8Cd1SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/2x8dAWV4H5FnUD7rLUiSOa22Ia0xVRRWZgc7d+k3qCrtQG89dZvWKiXoDOhcJu9NsQwranTq37eLLUGIg1GC/xX+3o5k2mSD5L+yvakS8wLDc5y5E0hNVF2v/UmDKq05TLNvGsNExUhs6ckAjoGImYiWyOD3yFSySTdbSs4bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZRuWlQ1; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5033387c80aso16217221cf.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 11:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770836844; cv=none;
        d=google.com; s=arc-20240605;
        b=BDrk0kvcM8cTPy1aNVA6a/HR7bEPZb5eHTtSwqa3uomWQrmWSDFWfeNrg53qkrMZsu
         vmUKeNTNPhYdAaovGdYKJijSiFS/7Accl3jdMJnpEHwXiEQP9X3sUlDPZC0XpPxJpG/p
         kGMuDL0e0Vi9ekyaNra1plXIVWKrD//3W1+LES5djJpD7ckDTzdw7CCqDz+CCfioQDMq
         Is8Te7JlVm/hnCT+LZ9VmGJ7A1JjHbauQ65YhPDwakQxdZIZmlhJWRO+00HViDpuzs2M
         lXSqAtbTdKnfOXS+6wXCECb9rFVfaXucgyAdPzVrUOfSU2OKUPdTvlGty37lPRtqNw69
         zmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DnLuFbeq8pqLAUutep5qhmfm1lskl8h2Igp5g6q46Pg=;
        fh=xYJeyd1Ht3LtA2+tXNW/5wfq3kgBeALewI1sJL8r010=;
        b=HL5I7MVp7E3WsoUj11fPzH/lSSIqJuNyw1H1WcdGACP+Zj1YnwwHJW26MwRgqfNLK4
         Ipo63kgICKXQ+xveHNCac24g4FYTUOxUEaT42Toq4zENHq8w6//bt0DHacPF8hFgRiQz
         DJw3/dBCOSE1wbEQnlEcNU05VJhumpXZH77ajRwDdGJ0AXgFcIGN79ARByNjyWD7v1Am
         WGtv3jouE5G/OTWE/Bomi7vJ/Wk30bfhxzYA96vAb7s2M0O5qBHXjIaUnpOY4OET4r0d
         ZybH/GN9raHiVmZ4PRqMkHQMSHmcB3Mt5Vfn8sbHjyFmivA7vzhkD/z0aKNvlX7DBUNH
         myyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770836844; x=1771441644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnLuFbeq8pqLAUutep5qhmfm1lskl8h2Igp5g6q46Pg=;
        b=cZRuWlQ1GM3iTErfUUy0pI1A0i/LeYC9ZB4ZAoXJSoNATFFNBG1QFE927M+UAUPzuP
         Hx9bMxPlq6F2kiHOJovp/YjeK8isxrr49kWur1tX8TnZoNv4dJ/RsIjNELZ7Lv5SFGiU
         D1XOZ6qbam4NCEHlccpsnUmbw565uV8IjyDrtn1OikQDJGwSArzDm0dN30YkXM8qEJ+C
         j2Y6mRT382luG8CVwzppll6GiHflVcsmgtFfDFzgzCgCFH5bHA0eHBOFlbX14WhHTMnm
         0zWYHgk99TpEPYv+vK5qUrNC28OjpbzE4/y+EiPjwGBDWUlQw3JSJs9/+NXh4vhgu0aE
         1O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836844; x=1771441644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnLuFbeq8pqLAUutep5qhmfm1lskl8h2Igp5g6q46Pg=;
        b=WMnzxGvRYduckChEP8GVp/btQkan8olGoi6HZgQqRy/csYQ3jCP1SpDd2uqvZucK01
         QMd0PaEBJ0VMZ41j7XzHxktLn8j+P36/VtwvomZCUMQpkt6LfAKtHYOYEYRxzX9RHABU
         /5T5aiZwY508/ZTiXs0aX38f76DtZz/5zZ0AFBv73El7bDIi3A3SwqheBIRmCtihs7Hm
         0TPXNXtMtHsxv6bp+yFj+UKWUUas/zJwfRDlcwxhVFlb6LClIrCVLcTGDm2/3Rt7hbEU
         RClp70cgHwKNNF2hmmmu+3bD716V8njklJkReFLTtYKYAPjgaEgzQbs+ZvQAc9+uaVJh
         1x7A==
X-Forwarded-Encrypted: i=1; AJvYcCX16Oyg+qbvoMUWA7o3fStr4TFEE0LB58UsjolMtUuKDrBx2eMiOIVpHLy5vqZJJlYjP7VGIiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtpeEc+7h68Y5108RY8ayAyDFrMELQFftbO8aFA+xtre9qc14q
	/DYAvdnnnxJ2F8JETvt+GZ4KXk0gW65FT+vGPphwG5KGquOdo95LyG8kCgc4Bm808J4GgiKqcqS
	4a7VcStt1uHeKi2ojswdX8dBxFHq8JJOfX2TvUqHb
X-Gm-Gg: AZuq6aJxHFGE8LI8Uzyyc4uhA+S1coSEXU2A1RWocsSRSaOJ4O8p0eQbD/LPeJraOri
	ELrwcr9a4rIKbb1hdxmmkZEJMbqUZ7y5ppEL+tt7dp0SYg3/jNPi1xY6q3o8rfUBrs5PXhOExnQ
	H8aS3e0qaxL00ZXroHDYfncf8Bzhzx97DvzRYziB/6ZHKrxeTbhJZgNnWxYU25MDIm1CP7mqpbG
	diP8rMR009/WtxaHn8rLLgOkb3qoJ/aUpQeJP8BEWRuRgxQko/otOYa4XIiXWn8w88UjT0m9U51
	x8VXV+ew
X-Received: by 2002:a05:622a:1648:b0:4b3:8ee:520c with SMTP id
 d75a77b69052e-50691b7c850mr6329641cf.19.1770836843536; Wed, 11 Feb 2026
 11:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211184848.731894-1-cnitlrt@gmail.com>
In-Reply-To: <20260211184848.731894-1-cnitlrt@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Feb 2026 20:07:12 +0100
X-Gm-Features: AZwV_Qju27ZDej9fUpmFOnWmvu4Tc2zoX29NHZ-GbfVzP3U_PrWeGiJeb6Ch2nA
Message-ID: <CANn89iL5F=zN2t-LfBPtR6xzCQjVr8XB+bHu=LLYCvaao3Fx0Q@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
To: Ruitong Liu <cnitlrt@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Shuyuan Liu <L0x1c3r@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-215874-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B4996127136
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 7:48=E2=80=AFPM Ruitong Liu <cnitlrt@gmail.com> wro=
te:
>
> mapping_mod is computed as:
>
>   mapping_mod =3D queue_mapping_max - queue_mapping + 1;
>
> mapping_mod is stored as u16, so the calculation can overflow when
> queue_mapping=3D0 and queue_mapping_max=3D0xffff. In this case the value
> wraps to 0, leading to a divide-by-zero in tcf_skbedit_hash():
>
>   queue_mapping +=3D skb_get_hash(skb) % params->mapping_mod;
>
> Fix it by using a wider type for mapping_mod and performing the
> calculation in u32, preventing overflow to zero.
>
> Fixes: 38a6f0865796 ("net: sched: support hash selecting tx queue")
> Cc: stable@vger.kernel.org # 6.12+
> Reported-by: Ruitong Liu <cnitlrt@gmail.com>
> Reported-by: Shuyuan Liu <L0x1c3r@gmail.com>
> Signed-off-by: Ruitong Liu <cnitlrt@gmail.com>
> ---

I do not think we want to support very large mapping_mod values, this
makes no sense.

Please reject wrong configuration instead.

diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 8c1d1554f657..0ab83dc776d1 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -126,7 +126,7 @@ static int tcf_skbedit_init(struct net *net,
struct nlattr *nla,
        struct tcf_skbedit *d;
        u32 flags =3D 0, *priority =3D NULL, *mark =3D NULL, *mask =3D NULL=
;
        u16 *queue_mapping =3D NULL, *ptype =3D NULL;
-       u16 mapping_mod =3D 1;
+       u32 mapping_mod =3D 1;
        bool exists =3D false;
        int ret =3D 0, err;
        u32 index;
@@ -194,6 +194,10 @@ static int tcf_skbedit_init(struct net *net,
struct nlattr *nla,
                        }

                        mapping_mod =3D *queue_mapping_max - *queue_mapping=
 + 1;
+                       if (mapping_mod > 0xFFFF) {
+                               NL_SET_ERR_MSG_MOD(extack, "The range
of queue_mapping is invalid.");
+                               return -EINVAL;
+                       }
                        flags |=3D SKBEDIT_F_TXQ_SKBHASH;
                }
                if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)

