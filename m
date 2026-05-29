Return-Path: <stable+bounces-256531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPH3KWk5GWpVtAgAu9opvQ
	(envelope-from <stable+bounces-256531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C45FE409
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E2031C1CF8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D383AB5BB;
	Fri, 29 May 2026 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRPIQRXl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F333630A9
	for <stable@vger.kernel.org>; Fri, 29 May 2026 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037567; cv=pass; b=fz/l1ISaNdSRMhpKz35lBUTVsnq0ofOmYA4QBnztTiue/ycjV/dzRRurZG3CE04UMx4NQyzdTX9L0tZkvdD9vCP7wesBsWumRuqHm+PU84sZpMCkTMCAeG88t2+dWL89i+bhIZ0ZgKk3SV9ulsD/4osSx6U9lTw+JEagLG2M61g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037567; c=relaxed/simple;
	bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YV6GRxgLKb0CoukbTu8Dqvs4VqbVZ2AQs34gEtzr+dQZyK4eOZSfedbcoKYQTlXUTonl3g0C3r7as1kddesSWLhRFH7WxqvTlAssfwmGyl5oIuSCEFiqjbyhBuOPiV8iGwliQI50rlFRKC1r/Ah4SMAq+E890wclersJLpUf57E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRPIQRXl; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef1198766so191555f8f.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 23:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780037564; cv=none;
        d=google.com; s=arc-20240605;
        b=KrNwj9qATLYC6Epj3ytEPqOVXTYFcr64rDHOQzwR+0c7agZH6eu/P6vDonF5RXkqrq
         n5MiMUREWVMlBa1qQKW2z/udIoE1BaIimoElgo/Xc0XR+rjozvuPe6U4sNLPCbk5i9y9
         DBaTscLiZjPAtmcdbQ8tZWXedW2mhAoUIFsxa2fr+TSJp+g9luxC4uuGCF75qguxT+ZL
         7kphmX6YdGt96qnalPg6dznWwqG0g+AZYQFYYWkzDkpm96ZV5eSevqB7reCTxGqUX/lN
         8y2uPHp4GKOHAY9TBF52FdMcjv/EYe/mzbAXOWUKP1/9uCG/LPO11gWjySsTtC27J8sq
         4Sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
        fh=Jswm+WUyGm1sWyFyQPOnBj8EJ8fq1RIdf3JZSW7wwBk=;
        b=UfaFXAm2C70MWciFQSNyJfE83sWqjPGWgugtBrNKfeQ+OE3P8Gn4snvUt4pY5cKpBa
         QsYaSkw6kCgXIUbptDiK42zIhWuLPgVt4fyiL486EMLRgY/JGpbCVkk58b+3RgwGFvAi
         9PY6lA8y3/46UFidIAyN+2n3NSsSfLw25OJvL2nIV2eahv6AQ1H06kNr2FxgX87D8rgs
         kBdbY9Ga34npQADiWnbrudaCH97zgjLpEDTRnkbHuJLmiBmmOkx9EKqqMGvDwLb6zQFO
         +wFRgISVrDADj3FlXu58hbIBLgySAPsxUcRRhyC8dx+C+c8cOi8lSAVfo6mxIOsC7DcN
         3iMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780037564; x=1780642364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
        b=oRPIQRXl5RxN+R5q0MMZuh1Ke87ir+4TlNeH2PxpQUL9+Bg0K8Tyk0sRs6ILS/BU6I
         ov+d8qlgDdV5dI//669Z+ghXaqKadPpYACesWknw4RVqCQ67HXOYksJph+FJpcTJDmHZ
         DJpNna2sYRE9otuZFeYvdt8CBXbdhrngefZzZSnu+2M8pH31krIB0dJK2q8k+MdLRYeo
         pKglpUed8we17rSVlbjTUKlOeIw5OoaOY4QNgD7I9bjtN/vN98kh+9m001mp2yusN9qZ
         COKJbXzHXAwvHJI7IM+aftbGilsNq5adUG2WApiEm8luiL40YUzVGN4bgIwoED+V53Su
         T6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780037564; x=1780642364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfRQBWZrpEVVcnkeXr04N7MfphpLoboVNgmHFGTrJ/0=;
        b=GOHGQ/MhSD7MzDkXAlv7zglbbjfysuPohz3MUxt40Rw7kMsjfWktv7VvuMOdUsfIjq
         Xwf3pgMIrRrvZ+8yT7YMEqTN+5ILb+c1SHLRj3794yjb8rpktI8QqF2Db3t4VlsQGe8c
         0XZcXWmijlj9yxI4wJiLvxcNhG6FIqvgS77ffRssdwtpIrEFEmdfw0hbLd9YHRlQVMKF
         jJ7oSeC5DAs97RFyLh/Q9omk2IFfMLyIIfwsZb23B+Le5tUodN9gFfV2IIFYFvkkFamm
         QvjZCQl32EmfwVty7JeXBwUk7rJ8O5L2bjlRsuZvLB0ZTKERDVX38CSQtwrto9ld65nB
         bNRA==
X-Forwarded-Encrypted: i=1; AFNElJ/1yXtGhfZiPJumx8TPgkC0G65iwIZMfY+VI2FfWUbgUfZQboV50DAy4LZTDHK6zt3cjje++2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzaKS4xn0+Da7k0BZF3qOkwlV9TC/0SnWwO+aHVaeIRCNdHrG
	1GMdDLqDjn4HBTiVhOOAQFGsziWWDCNuQB1whVYZ1v0XuJiADxcNkmfyB+UjFt5DclAf810K25N
	U5Gn1z7EHCsBv/txRAB9qJL3bpGaDiZY=
X-Gm-Gg: Acq92OG/15el4yXKfpxQ1X9xfU2C9qyi29yrTAS+DhqMc7R3urmz3dvpqwkXazW9srI
	4JaORdCFwnzd3tT0lAi0+zvdg/tQa3OF4E/d/db8NxV785n9pZkqH7bkOIpBHG/G5YCoU0I9Vah
	GHFNfLuzS/pezA2vAPg2ncnFewBEW2duBld0InZ6PJZJWz8+kFHU23XxhomiE5xyHu/QBs42E+p
	lVQtiuHxAewu55mUf8zvCFK9yMpCy1GmC/kSTk0fviqSXqMNOxOF61baDJVBH5pxA6gFCvi2TZW
	yXRo361UcoPLNE50A+PngTGSvaRt
X-Received: by 2002:a05:6000:4915:b0:45e:ec31:91db with SMTP id
 ffacd0b85a97d-45ef132db76mr2142532f8f.1.1780037564017; Thu, 28 May 2026
 23:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
 <CAAVpQUBKHhj6h5Rke=N9NyeUOPvVB0RKJSr2=HPkUKgAqQA0Bg@mail.gmail.com>
 <CAHPEe=H5SFJN-=EFggXdNreN_A_LE2r_KHrpWU4UxJmq+g-bhg@mail.gmail.com> <CAAVpQUAp8pvg=s0K3QmkN62Osat-kf+4XPosfgbBZ_avzZR04A@mail.gmail.com>
In-Reply-To: <CAAVpQUAp8pvg=s0K3QmkN62Osat-kf+4XPosfgbBZ_avzZR04A@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 29 May 2026 14:52:33 +0800
X-Gm-Features: AVHnY4IOOkLMXNm_j8bV0jM4Vc6N9eDKu9CgnwIhR-_I7cCTyGyv25rgE_WIjvA
Message-ID: <CAHPEe=G330Dve0BdMhs783LiwC68eik7dc=Amm_Qz=kdD9nQ3A@mail.gmail.com>
Subject: Re: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256531-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 535C45FE409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Kuniyuki,

> > > Do all other callers of ->get_link_net(), dev_get_iflink_dev()
> > > and batadv_getlink_net(), require the same capability check ?
> >
> > No. Those are read paths.
>
> See how netif_change_proto_down() uses dev_get_iflink_dev().

Thanks for catching that. You're right, "all read paths" was too
broad. netif_change_proto_down() is a mutation function and it calls
dev_get_iflink_dev() inside its logic.

I read through it. The resolved iflink_dev is only used there to test
reachability (the !iflink_dev return) and to read
netif_carrier_ok(iflink_dev) for the carrier_on conditional. The
mutations (proto_down, carrier_off/on) target dev, which is in the
caller's netns and was cap checked at the rtnl setlink entry. So I do
not see a parallel cap gap on that path.

If you agree, I would like to keep this series scoped to the
rtnl_changelink path Xiao reported. The per-type cap check on
t->net->user_ns mirrors 8b484efd5cb4. If you see another angle on the
dev_get_iflink_dev() callers, please tell me and I will look again.

Thanks,
Maoyi

