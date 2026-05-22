Return-Path: <stable+bounces-253686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFdSEd3KD2obPwYAu9opvQ
	(envelope-from <stable+bounces-253686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 05:17:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E138F5AE477
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 05:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14FDF300A304
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181173168FB;
	Fri, 22 May 2026 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1Io78+K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDC3093B8
	for <stable@vger.kernel.org>; Fri, 22 May 2026 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419860; cv=pass; b=NbVzr+9M9mm+LMlwJZs2fwjdy+PwvGKVz59fuCxJbxmUoxG4Js15BgU/WAdSxQ0Pr575vIp/tq35RjFp6vhgtnGb82+CHXFT5R1mQVXf8cHn5ODXH19qrfbW+i9Wz/1fO09UxiwPlnq/tvuvvgKXLsxhSw74ZW4Sa24MuDrpL/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419860; c=relaxed/simple;
	bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qArtHlVdhnfUcJRCDIV5HjsIxD2b3OsIDmHk08uP/vCML9BnMBITiyMd5ssd51DFPvfIbizlXcTpB9/Z3iK5dVC0omcy5NKbRw/0WrFCxmaPOtfLRf6ajsqiSrpxukKFwZa/UsFnzmosRfmqFXV4BuWiF69hAkScaZVl+maxnQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1Io78+K; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso66524805e9.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 20:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779419858; cv=none;
        d=google.com; s=arc-20240605;
        b=cd2NQJQbIe1+sBgy/bhnbgGKSqD0TyZEz43+TgYcOcVz7Kpg9jq2sze1sqLQa4lul+
         RAF6M30WHRlTuNw+ySNHmKdKRWXEvizsuX3+wMRiOIdfoqcTapmN+py1QlORnExyU0GI
         XRJqiOKUx9wwgaJcthZx1yc5WNe0gfONHtxXjDBudWXFMDTGkG/kA/jzrUGPLG5JL78+
         UV7w1Rg9Kn2cSkDcrcz4rJQi6OE772/+4TxVUGOMRKATzyLVRp+XRwTQPXXVvEiafyLu
         UzMPAQaqfE4qFl5tis+ZOTXzpRDn0YLNWjvME5UuuxHlFmiOqi6n6iU0fc2PtoupVwuh
         U0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
        fh=F8+bdpYMy9cUL1pWTSttHnhiNdWZ36TUMhmNDNNSDVs=;
        b=JvzDFXqrobrGtoBaB0rORKHpNBCc5BuQEyL3Ayeo+33stMJbNHlA+y+4Gdmka5eHi8
         fQtJ7RPTLTU8GiC4DKK+w3GIv6ff6Ziwb5PPYkC9zZR3rs6EGYOciXk98mD1yXcX4ZcG
         6FAhinyNWZyHf+UVPYeRQg5/FHRH5/v9ABoHZVomHDsk9IMBzxzZY/WfI2QvNH3r1qxL
         A2mzFZQz+k/mDQwuRtOFUC9jZqsnN/rk5m1qCygc7IdDHRIJs3NnMN+Yy83X5/j4j/Bk
         CLIX2zE98ZJQy/BT0XanBjYrs709yATAY9NgkbF/K2Ku61B7oqKPRb9ueZ9I3U+n9CEI
         1UVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779419858; x=1780024658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
        b=A1Io78+KpGOR1fVHL+A04AnAhyAwRvNHibBH7TvEdlugo/K5WMmb2ZSoc+rDRo9KdX
         sGieBdVXWH8lq4r/g30cCwGVOf5is0zgViu+d60RF240KATNa8ha6yOyaHDIhaK8Fyey
         XUZ3O7lRSg2IITA0O3xQKBTDktjsOEtH7UrNYC0HYYUaiKtSCyIG7OEL71+/3aYlzgoo
         cBcfKZg0OF6z9QeIB3GhydAnSq/OvST7TJfufBTgJPuOH1jzK/oMIwMBTGEd2sOOLAMI
         kHdKTKwu2pkkk/AsSXsDsKM7WAs5tftLmmiT/O38nqGqRttNKrJ+stBk1UW99F15Twtw
         JYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779419858; x=1780024658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3HZRUClfHJOiOx3noZRC2Ilo6doWWUTUMntfi2bpuXw=;
        b=FbKFdpD2iEtcfMaALV6MEfbAbq4DorXhXQp7ucTr/W9QTBMqOtWrvhncG3JsgPiIPv
         iN6/6pKuMsugTFx+yck82H8ZCh9TbkE1xDDAnVZvdxexGc7/gxjQoEaA3aChNfAc3juS
         r6XGoWbeKzeSV40DpNOejjxQFRDfmc60SX2LjsCOxd3VAK6TT5PW6A5D3EOAuCOPiBBc
         eQNOQX5pZ6vrI4tL2JfUJKj/X7XGi+OeIDw2Mlhv1kTcDLUNgywJ/6yTYO+8T8cqT9wm
         QgEkEJQaCT9mO+0h+6Ml2FosthkWxLR9gC/x7088mF5spht67kXJ8oq1eNaJ9aFHsALJ
         6SUA==
X-Forwarded-Encrypted: i=1; AFNElJ+HYPE0tezxzDZRBs5ziGfKAV1BZqZ8C6Cb3fLKvdK4gqGqo5Ho9yL8glCwclV933Qhm1Qsy2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+46SXlWm2mBipVr7ef81LtP6wlLD9IXsOSRKjtn/TBTTCvXK
	/qCDSGXJY2TFRazQJ9gHTzWiiCVkK6yHV6TKt79SjokDXhNeeyy00rod1qGISZfQZ+tHmB3SX0s
	xRJZ9y2s/4OBkTb0CfSRAuY5ccIFBwsw=
X-Gm-Gg: Acq92OF+3+Fgf2/3FvbT5kR1PojEZDKiyCfzbFaASYz6dvLovLmiyyfFZPiS3QKn1dn
	J/4dUythfibtzSEplH80YPDzgtHhBTomFrsCSJVK+pvSiE+79ZieZqnpakhFNkgc8CsZzQ7LGVY
	S4/VaZqWyMOBbqrDv13r9RZrW+JGqeeKeENM09AXj2uKtcx2tsuaCzVbewpWx2f79eG/1DqU2Od
	uLn+fwCrxGA+/vvVo18IJYo5Ofv1YG8OFIyRax/YvX9KF/M/VrLCOnkEkiwToS8UniGh79z3ttX
	4QrixvAgQU0Jpu/YtHGeQNbhs7Iu+UwcHWRAwQ==
X-Received: by 2002:a05:600c:4fc9:b0:490:3cec:52f5 with SMTP id
 5b1f17b1804b1-490424883a9mr16488425e9.2.1779419857596; Thu, 21 May 2026
 20:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
 <20260519123547.2055911-3-maoyixie.tju@gmail.com> <CABAhCOSEP1voA-g16sHK+C+84rcQZvX9CWJs1hNaSk-ygbbD1A@mail.gmail.com>
 <CAHPEe=GX7wsLetw7rnOpeSkc05Jgi3h5y56e0RGYa4dszK1E4Q@mail.gmail.com>
In-Reply-To: <CAHPEe=GX7wsLetw7rnOpeSkc05Jgi3h5y56e0RGYa4dszK1E4Q@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 22 May 2026 11:17:01 +0800
X-Gm-Features: AVHnY4JuqaQ7c-wuivZin8SvqfKHD7bmMZmQJKeBranmaSXhaRffZpEtfvmbT0I
Message-ID: <CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253686-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawleon@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: E138F5AE477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 8:58=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> Hi Xiao,
>
> Thanks for the review, and sorry about the wrong Fixes tag.
> 5e72ce3e3980 is not where the bug starts. The dev_net(dev)
> vs t->net divergence first became reachable in commit
> 61220ab34948 ("vti6: Enable namespace changing"), which
> dropped NETIF_F_NETNS_LOCAL and let vti6 devices move through
> IFLA_NET_NS_FD. v4 will use that on both 1/2 and 2/2. Same
> shape Jakub took for the sibling fix 1d324c2f43f7.
>
> Thanks also for the ns_capable suggestion. The top of the
> switch case only checks dev_net(dev)->user_ns. After migration
> that is the attacker's netns. With the v3 patch the lookup
> uses self->net. The else branch still sets t =3D self, and
> vti6_update() inserts the device into the creation netns
> hash. I reproduced this on a v3 kernel. An unprivileged
> caller in the migrated netns picked params absent from
> init_net. The SIOCCHGTUNNEL returned 0. SIOCGETTUNNEL in
> init_net for those params returned the migrated device.
> v4 adds ns_capable(self->net->user_ns, CAP_NET_ADMIN) before
> the lookup. With that check the call returns -EPERM.

I think a similar issue also exists in the rtnetlink path.
rtnl_newlink() requires CAP_NET_ADMIN in the link netns only when
the IFLA_LINK_NETNSID attr is supplied. However, this attr is not
required when modifying tunnel parameters. As a result, a user with
capabilities only in the device netns can modify tunnel parameters in
the link netns, including endpoint addresses and keys. I'm not sure
if this behavior is expected.

>
> I will send v4 shortly.
>
> Thanks,
> Maoyi

