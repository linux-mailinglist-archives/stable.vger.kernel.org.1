Return-Path: <stable+bounces-239992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBbGBcCC5mkIxgEAu9opvQ
	(envelope-from <stable+bounces-239992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:47:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD194336EC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBB213024A3B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBCF3CA4B5;
	Mon, 20 Apr 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoRkQ2h3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CF3A7F7A
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714292; cv=pass; b=ZHWc6FXCf7yCiaCtAXK5dxsvV3bvXmGYvezGDAOsR2LMZ37tk1Qf2IBH+VtzTli2CvVDJOUG26j/AP+UqqrXiBEvpi01O+8/+Cy4ZAt/FvkPPil83AVjvhX0foNU7A6dyhn9ah81f3jfvEVDkBvQGrbBITYye+7ANiVrbVW2J9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714292; c=relaxed/simple;
	bh=6jXgnYqFlngMwDcsFq8mpBHFUc04URMA1SiiHOhe8Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbTpRhriiZJqPHLJRXLSsOre2QD5NvIWApVvNmWNx6a/+BysFAO6j2/Jm5ZV3ikYoeV3JjoCWobnHaGW6cl7hDDy1+syO2gvGiRLnEHEyXfA99fSkOpEERjhqTJNCNDafIUurUotJicTGdttFVHQwTYekG4fPuHT4nFaQjICXAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoRkQ2h3; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40429b1d8baso1595261fac.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714290; cv=none;
        d=google.com; s=arc-20240605;
        b=FL0DY1lkgNcPM0eWIhg0lfzH+s6evZeVY7AFM0A7OpKE2X5tSnGcKzFlakLqey+bnd
         QaFWW1VqxboTZ2yhFPTJIyVTbPiI/wEaSliHzr9+eUe4ispz6Uo/1Sp62h+tLD1V8ZCO
         yZZ+OfSDGDhXvwu3yXFy7GTyoZhyloxQYyvY9ZyEqAw+nTMDFeMLZKbNAWgSCBUgHayf
         WR2oY+uSvzlPFd5cbSQsV5kh4Z3d/t5d3MJbEjXgankpv2bNiNfrrHo1ztQQJhMQBE0e
         x/wJM3uxjajui5/uS1UoyiWwTpOF8TWv1SItCPof9wqFbiBciwkgEgdnM0veiB2hV48i
         l61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NrFBEd5Hxd3znL27N+M0coP9GIoEE8kuB1MrCyY7TmE=;
        fh=U1ettvCMHT1ixda+oE/OdW5QwDge44iQfgeMDdW+EV8=;
        b=KuWazttJQ8gFE1ybAln+xJHCX9Uy8dACDWP3n/fyndFY7jgSZoR9FGjocESNxnzkny
         RWCm4wKaEkafwjR4mlZpJnzR0qrmmgUn3DkMWA6WJqjcbwu/j2HesrYKwi4xH+FzfuTA
         vnabc7g711hdZs9fLbMheUMlNpeCvjP1d7r7qCCqWVXwma32ijjAm547i4Vvbt7OfySS
         0DKF/sdvB0ED63s2Hx0A8Xsf7txtoy5Hetxv2Chq01bB67481TU4XuVYG+tZ6Bf0ZsMt
         7oPi3R74HhggZWKygtxKNso74MHe+/Hbriiijy7MrawEXrIlzYpBLaazOxTeHR56gcGw
         8B4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714290; x=1777319090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrFBEd5Hxd3znL27N+M0coP9GIoEE8kuB1MrCyY7TmE=;
        b=BoRkQ2h3gvCy4JMT7w2epL+KNzj39HXWZkSPdbMtBftzaK7JHvShcLbsGGPZ2z2rH+
         EyYujfCcqogPr85eahtttxAGdLvtk1ALq8l+cbj2QBvmKZznErAheVg9pCT6FBZLGxMn
         jKtnDlrYi+vz+rCQSaAV8Bko+cdjv4BExikePFTtk8BQNJKP4RTZFj35R/7R9DvaJ1cb
         PGdu8riFVbsBCJGXnhdyvRW1UJXN3ZfMRloPYc+hiDbO5NAAEBdtjsG5SGSJvfLzQ32x
         m/jG0K1P7QCKBfBfKpZdVEwdwzw2Lzl4BZ7HEk++r4kKe/dxX78rVEkqu3TvFhD8BfDi
         f49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714290; x=1777319090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrFBEd5Hxd3znL27N+M0coP9GIoEE8kuB1MrCyY7TmE=;
        b=TtJWxBOKHCBOKGbhVgFKSfo8INLDaYp3/gp1qM9PyY5LeTJO/PEMIJaJmzns1XUFR2
         K00FdkKKnuiZbUIqPwMESnRdqQWbCZpV7uV0d1o2IiwbFgCftu2pVwJrdSykYnhPGEj1
         ze/69zpNvdHLpluoqiTTEuTy1ONf0I+7I/nVM6CJ14voHGgSzkX3g7QKs0BWUHF/1sFW
         MeCQ2qXDXvtWFhpIzpOId5jqTsgXNV6htGj9dyqBTgx6HAhHWaS8d6pWnQs+qdgA6WEg
         FSWfUe7fDTJvGBi0ZdX19je5HLOkTjRprqaBTNZ2bqUaCXlmknvE4A2oXOrDaaVNYALo
         ryow==
X-Forwarded-Encrypted: i=1; AFNElJ/5eZI64yjLtzEVhSaaFRUW8NCEmG1funU6e+p90sxQ6Xuwgry6/JpVpamw76vqF6Vdpb3yH60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3ZuzCU8upQIY42byDFWvakQwVtXa75lRwgmWh+1u44SbMbZn
	q0o+VU1XDH3U1OFq4jyAexjICJ8ymAYS7Qxd5sWueO6K08IMH1PeILzX/EJyTgw/HtniZy+bNjH
	ihWqgtUD074PEt1/ahsR7QYjvjgMRgDU=
X-Gm-Gg: AeBDies3qkrWk5/psrCj2fDQ82Y12QRNSooqyFzom25KciG3nzn68h6C974zeWl6xES
	DEqojlabO2chUCWzQyuTgPYmZt9RsLe8vmLKujgCNdB9+X5PGJ13fIxcnzdWKkizjcEtwOFZ8Om
	R8suyjva764PQY8/DmkxuJFz/mLiVfrB//FFqjMwNVQLZC4BfyL1Ut4SnfIwwX2+jr45uf/QxpK
	AEfi3TV8MVF4j0SfIgioE2cOCWl9bfj9u4tdUzCKRqHYmLKL61PbuIboXP2O+DkRwuWAbXKHzaF
	vDKl34aPSrOmd9+Wi8pCyHVECBQpA4bW6ZSCtdEKt3ioouqw
X-Received: by 2002:a05:6820:82a:b0:67b:f1c8:ede1 with SMTP id
 006d021491bc7-69462f44064mr9004785eaf.53.1776714290182; Mon, 20 Apr 2026
 12:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417055408.4667-1-devnexen@gmail.com> <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
In-Reply-To: <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 20 Apr 2026 20:44:39 +0100
X-Gm-Features: AQROBzBSluoIh10jRt0_98McgNJVoNK2fLZ7HLdTtSL5hz3I43x5DeSAEDkEuRw
Message-ID: <CA+XhMqyN_fFptjA=8YJtXzyStQZ68xJiNSG464o4R-dQFLHt7w@mail.gmail.com>
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
To: Justin Iurman <justin.iurman@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Weiming Shi <bestswngs@gmail.com>, 
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239992-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,gnumonks.org,lunn.ch,google.com,kernel.org,redhat.com,gmail.com,lists.osmocom.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDD194336EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Julian,

On Mon, 20 Apr 2026 at 20:02, Justin Iurman <justin.iurman@gmail.com> wrote=
:
>
> On 4/17/26 07:54, David Carlier wrote:
> > gtp_genl_send_echo_req() runs as a generic netlink doit handler in
> > process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
> > which eventually invokes iptunnel_xmit() =E2=80=94 that uses __this_cpu=
_inc/dec
> > on softnet_data.xmit.recursion to track the tunnel xmit recursion level=
.
> >
> > Without local_bh_disable(), the task may migrate between
> > dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
> > per-CPU counter pairing. The result is stale or negative recursion
> > levels that can later produce false-positive
> > SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
> >
> > The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
> > the data path runs under ndo_start_xmit and the echo response handlers
> > run from the UDP encap rx softirq, both with BH already disabled.
> >
> > Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
> > commit 2cd7e6971fc2 ("sctp: disable BH before calling
> > udp_tunnel_xmit_skb()").
>
> Why not fix iptunnel_xmit() directly, rather than fixing all possible
> callers? Basically, jut like we did for lwtunnel_{output|xmit}(). The
> advantage would be that we no longer have to worry about BHs in the
> callers, and BHs would only be disabled when necessary.

Good point =E2=80=94 your lwtunnel fix (c03a49f3093a) is a close parallel, =
and
  a central fix would avoid chasing callers one by one (sctp was patched
  last week, gtp is this one, and tipc/wireguard/ovpn genl paths look
  similar).

  Happy to respin as v2 with local_bh_disable/enable moved into
  iptunnel_xmit() (and ip6tunnel_xmit() for symmetry), and drop the
  gtp-local hunk. That would also supersede Xin Long's recent sctp
commit
  (2cd7e6971fc2), so I'll make sure to Cc him.

  One thing I'd like your take on before I send: iptunnel_xmit() feels
  like the natural home since it owns the recursion counter, but would
  you rather see it in udp_tunnel_xmit_skb()? I don't want to pick the
  wrong spot if you already have a preference.

Cheers !

