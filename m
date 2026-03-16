Return-Path: <stable+bounces-225568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAOiK6QWuGl/YwEAu9opvQ
	(envelope-from <stable+bounces-225568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:41:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2529B914
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AB23307411C
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5A82D063A;
	Mon, 16 Mar 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNcTo7z2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909652C1594
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671933; cv=pass; b=lRfysn/1bf1yWgAqCw2Jce+gH6iewfgX1q58yK9PxcajpaUNtFpwoxqPJrb5jYHxs6pV3BUATurlBmTAFTgvwOonAmRV8xHamenRJmUD1D8k4qdsZkROvHK33l9SyRX6gtD3Yu7wo98SX+o3ImXgV9CNGE+M1J/A5+vKwU0cUXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671933; c=relaxed/simple;
	bh=8tz8cJV3JMrlvEE8awZB92wRqurtJhd5Zcy2cM4jGHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCxIVHx6wM5RHClEIwBM++6T3IN3/1Jtyprt3+HjlzJkskYgNdPWjNQseqvJAkXV6cBqKvBFXePD6tMUUZ76GNUx0rTZy0zTW6hnTDTjCgAN9TXHdwXbop4wbsMkT9FAekG//5h96wd0lC3D42BVkW1j490rAXyBYlZcsgZaovc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNcTo7z2; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be084d8166so360512eec.2
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 07:38:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773671932; cv=none;
        d=google.com; s=arc-20240605;
        b=bR6RfMx5HKUDPCT2P3zw+ON0l6wzZ/TnT8UVSqP0NQxvG1XZygiN3px5W57NVMYIqW
         eOkPCGZCHUNbzS735zcHou+VgJ0g7nsJHCist0GDG2eWqMXPzEI+aWem0o/0/ZrrI5t1
         WkQwaoj6PqqRU/GMCooitHsHioIniGyB6VN/mz1Y6Q84qIiHmOLRoa+OxZNy1p0zIfDS
         sqHh56/cqrx/DgiSosHjjlM/52dvRjzUsxjN68vgn0uY2sEb6tyHx97qAiywWKpzAV+A
         dtjkwuE8kjhtsBGkVoG9PSGZ8ri6qFK2I3gOqJd/95d5ulhdkOVqWiLueguPuHVPbaSv
         eYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1oAfO4kk9+ce4bAmHjxkSea3HeVPWrM9gkj0DpyhShA=;
        fh=rpzUyIeiW3SLYs5EojmgfxxOmyixhQC06SuJjFJUFno=;
        b=SSQQzs/MqmfmKUmSdO5M2hpWbgKdzgRD01CsLD5mMH/JqSbGyiSk5LEArySl5UnvTZ
         JA7/UQoWjSrqeU3qZi67ClAHtR1pPgTG/qstSvKfoniCg045sguytTLfdWCzqlXTDzg4
         yxNn9uykkU5tjX+36k5Qv+OkWoULjOoKDbWO7ddaav8iEhqDIF1bDszYwXtuKMhQcATR
         5abH7Ux7u5IfLKq6e++nyiZjnr/JLwjkn7xsP1dqXJVh80r14uXY31eKRISmGuuo75sK
         Ntx6rYoUqTPFn01TnMJ860OKCg7Dveep0SXbNCYqdj6k5jZfh3IwsJL13Y6SXoR1ju/L
         4llg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773671932; x=1774276732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oAfO4kk9+ce4bAmHjxkSea3HeVPWrM9gkj0DpyhShA=;
        b=kNcTo7z20kvyPJobEtu5R6pvswdnx5E/oJZ54Xuozp8XKmrpbuOlggPqNQLi3lGZxm
         YBN2R1efPxbB2KLRPb7KngtR16wirEOIsf7N8yZuMvEjE9fkAdoIwYJhWh+v7tI+Bm+2
         uGnrKSsW1kCKBPxIgtLrOO1ITbMuzFvSVmbhvzefFBQ/Ma5Z7avFArRei+4Qc/N1tLkd
         HQzBk+orNldT5sbv2aEIW5CmsSoDI5fuCxzN+dbPD20NWl296/QdWm+uIOinBePHzK2w
         wj2YIK9dNW5z5Z8SzJnXFr4YYsZGDkV/MBzk9CAtAExp+dpkrhyuwqofKUkCVy0Dn5PI
         WWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671932; x=1774276732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oAfO4kk9+ce4bAmHjxkSea3HeVPWrM9gkj0DpyhShA=;
        b=sdnySjQtNE55dkFPH/XN1JXeEYVG+bsHALjm600XMkIAe1ifNkTHqvxCIDSRxgZag2
         zWcF4QWJ0DLSmbKdydA6uHgURLOFJ7atKlhS5W0GT3htrwWfm5X1zGCkRVm6IXr0JrL5
         o7NTNnEFSLw3CfrLjmr27sbsk+AH8fSD2Y46EiGV7Eou0z8lahKmeUvLQ12dTDWiAyqJ
         wEFVYbIMsJVUmZZQu4K9nyXPzKJsx3dz5ti65GhN/VvyzsQwk8vmzGfqA8+0vM+831Nu
         x9oZ1NQS+p7IVzYhDzk2NJjlxy+7ACLtRLUB2MV60TLf+6wecysYl/Gd1OssYg8hgFHb
         eIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWETioRNaOuB7WudkVq9oan4BPrbgXPYFGpgz0j3aISghprHRdOktIIhF6sAfaYjaBbYW096/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0Jg39pTsHsap+f3PrjrL9mptdwpt2/sqUitrcHJkA0qzQHz7
	ETtBGsMKRGT3lKiG1dgkkykiuwZgsuj0GlXPWA2jM6l0vApihjkaQu871yBaiYZJf3z+OM4FcP6
	IlcFOFu3GypfxSNoLgGU+KjUI5BtPc+c=
X-Gm-Gg: ATEYQzxd4kIZtxu+IxKOb9B5HfQlGowNbeLv0Nm+mxxuN2rejyoXHEVchCwf/g+3hya
	rbaVH1+mul3059RG/jmoDOFEm1N0bj57ZA+52JqYvfXLgI/5ae7JgxoZCmZi2+UQ1GAf2ANKD9N
	Q9ZRKwkXwlYsjFFHMzC/WOke2oLFs5tbXrA4V+JYhKJjX6oQdZYjrSWv1qA4zK02rxT8g7ZDJjZ
	R2hmIBC6IGxmkuunD+qMiQTiAgfoJwmLpjBaAiqmy80qX1O1u9DyDvFyhANf+ff07YNvNuaBiqJ
	GdHkC7iR7cnItMioA0EPlzDLjfS6241/VOvyURVuRJgDbTPqgfIzVgatQDUsQ/v2ASJsmOASDfF
	O5oirSCplli4NwWRaGOcPfT4=
X-Received: by 2002:a05:7300:fb88:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2bea55f6aa0mr3367946eec.5.1773671931629; Mon, 16 Mar 2026
 07:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026031601-outrage-unheard-916c@gregkh>
In-Reply-To: <2026031601-outrage-unheard-916c@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Mar 2026 15:38:39 +0100
X-Gm-Features: AaiRm51tR7Oi_8-rit1yHxUPs2vmcX3RAeb7cggnBapkVFQ7c_XLOtPogxKphnY
Message-ID: <CANiq72=DogsD6Y7C5owQ8raQd7S9NEz2EBX5=11qTtn+BSE31A@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: pin-init: replace shadowed return
 token by" failed to apply to 6.19-stable tree
To: gregkh@linuxfoundation.org, lossin@kernel.org
Cc: aliceryhl@google.com, gary@garyguo.net, ojeda@kernel.org, 
	theemathas@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,garyguo.net,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225568-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,gregkh:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1E2529B914
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 3:34=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031601-=
outrage-unheard-916c@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

This one and the other pin-init ones just sent were expected -- we
will need a custom version, but we added Cc: stable@ to get the
notification (if you prefer we avoid that, please let us know!):

  https://lore.kernel.org/all/CANiq72kk5_wzA9izJ3YPWUcQGiEUQmCif+iqFfwK9b_5=
mq145g@mail.gmail.com/

Thanks!

Cheers,
Miguel

