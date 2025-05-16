Return-Path: <stable+bounces-144638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C2ABA666
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 01:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72CC7BCA54
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 23:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B78528032F;
	Fri, 16 May 2025 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAJ7qzf8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A55236426
	for <stable@vger.kernel.org>; Fri, 16 May 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437119; cv=none; b=HkHClbH5f7T8EDl1ZsIyWqj0xjYZ5E1QMef0I+5UzbYwkNdBUXxTB9tMOB7Bs4+KjfOycc4yxpcy/OSCi3NzqY0ZjXkJyUfhnA2n3fzbCdR5ksy+ZABA/xK2a9q11+PId9qHA0dBQT+U192Rrff8I7LLYu2N1GQFpYa4zl5IYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437119; c=relaxed/simple;
	bh=OqugXQKW2BX+T3PbGJGbPTR0CK06fVopFgGf50LvnZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwYPtsuy1SjOAtW17gM2pkPMJqaIFTgMvT1/ppP6oOpbdFom32o5156n2JqM/clyIpkgTYqx4wGgURkjlGR6/HqqYQ2xvVw71xRCyOH8UsH+0Xf6VSSuBKme+0441iNUxlKNxGeepxMoV6WnbPnFKUIYndtVwf2o5INj8P8FnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAJ7qzf8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5f720c717so449802085a.0
        for <stable@vger.kernel.org>; Fri, 16 May 2025 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747437117; x=1748041917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqugXQKW2BX+T3PbGJGbPTR0CK06fVopFgGf50LvnZc=;
        b=wAJ7qzf8BLjwwwazNTrG4Vem2QP+YmaN2Xa0ff6SniZG1B2eduPtzv/BdGkqPA6U66
         xxcpTQamI0jLPxaBogyFUo94WG1xXEDqoiGYDp3LJ7XjQGDuLb09gPhAoUFUGNFbeO2d
         DofSS9UsctERhO2Wr556Fb9zYNHTJzumUMoOXVJnIqRGwg3XM9zKpaWES4YVWyeU5RXF
         QwJh4wL9kwouT1jtwSwUCejr6RTZ7Q0Ya9cXQCdqPOkj48oUFQxR7/uAC/z4peO2RI5b
         L32ZajqU3OQwbfb0Hm1XWZlziQnRqZhokaE4peETHuxZI6TjuJEs3GafaZjFEt+6BVSZ
         ll/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747437117; x=1748041917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqugXQKW2BX+T3PbGJGbPTR0CK06fVopFgGf50LvnZc=;
        b=kTm/dgLi3cr8l4HAnC9ayyJzic3wXeXurjjvywQfGORl3nl/Q+2bb+bS7LJt7qYRYZ
         vRdfBexJq9iZe54jtRQKrSZoQU3rH/SVNWiDFDVVmAHaIbsW7K9Ox6KJ3fgSHQjoFIad
         eldSzUNswfbRLtW2WYFRcjQoTULCsuU4+9HuDL5H1lHo3cxqxX6h2Xk7DOntPFD/urEf
         Y5ctRd0goRuh6gT8JEzsTZTaW1P3R4Gs7pm8K3JLGCY84po4hGGA3RFE/PqaPqJ0BThF
         kgoBiBKel1SNBjbD8khgM/qxbwZibjsx+MdAVvi+yZwqTXytVN6fvQ3Zjz9sosrhOtSl
         DxXw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbdjHgD6VV5pMeXz0sjgIIxLUhLnNB3RYLg+wyILEw5DxpTpPtuRK3KXq+Rx7btjhBF2spCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xmUw8B3E6AP7LdM0sqnTragGxDXFlRHroWdr1BxURop+eLSP
	FtQ6F1chvdS61wguiXh+NCeV0GrkEinIHtXjbMDNGpndZQJOW+4BlaGh35qSqV5KGVYSHi329Yw
	41WXWb37V0b+FyWmMkJLdK7wgbiqi2EjwUaIPr8UZ
X-Gm-Gg: ASbGnctVWGWN/hTJOvKDJopjrU4E1MOxg4niio/8aJ70DOfBVheh5xEKja53MYHA/N1
	bUHdj8IkDPJH5OZzHjunEKZm+DOEGKXetIqnN28oH8sOdAeSbZMy4bN/TsAXccTfBWZ7b3mh7j4
	aTdwZx03wnT7sIdFTLue+57F/jX5w2pH0=
X-Google-Smtp-Source: AGHT+IGQvSSrPkr7h0bza6OG2FoIU10eYzkpv5Fg9fDQCDDKKTN2XlS1tv+gLuU6FKmYZTKU9t1k9rcjkDY0LWgWQVc=
X-Received: by 2002:a05:620a:9162:b0:7ca:d9e8:d737 with SMTP id
 af79cd13be357-7cd39e1b14bmr1079981685a.22.1747437116939; Fri, 16 May 2025
 16:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515185227.1507363-1-royluo@google.com> <20250515185227.1507363-2-royluo@google.com>
 <20250515234244.tpqp375x77jh53fl@synopsys.com> <20250516083328.228813ec@foxbook>
In-Reply-To: <20250516083328.228813ec@foxbook>
From: Roy Luo <royluo@google.com>
Date: Fri, 16 May 2025 16:11:20 -0700
X-Gm-Features: AX0GCFsMrs5J30EUO0n4U0eNx8NgCyUTGXB04orUYY9TWHPynysT3i90ibLSUtE
Message-ID: <CA+zupgwSVRNyf40JiDi6ugSLHX_rXkyS2=pwc9_VHsSXj4AV5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>, 
	"quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> There's no state 0. Checking against that is odd. Couldn't we just use
> xhci_handshake() equivalent instead?

Ok, I will change it in the next version.

On Thu, May 15, 2025 at 11:33=E2=80=AFPM Micha=C5=82 Pecio <michal.pecio@gm=
ail.com> wrote:
>
> On Thu, 15 May 2025 23:42:50 +0000, Thinh Nguyen wrote:
> > In any case, this is basically a revert of this change:
> > 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state()
> > helper")
> >
> > Can't we just revert or fix the above patch that causes a regression?
>
> Also note that 6ccb83d6c497 claimed to fix actual problems, so
> disabling it on selected hardware could bring the old bug back:
>
> > In some situations where xhci removal happens parallel to
> > xhci_handshake, we encounter a scenario where the xhci_handshake
> > can't succeed, and it polls until timeout.
> >
> > If xhci_handshake runs until timeout it can on some platforms result
> > in a long wait which might lead to a watchdog timeout.

On top of this, xhci_handshake_check_state(XHCI_STATE_REMOVING)
is also used elsewhere like xhci_abort_cmd_ring(), so a simple revert is
off the table. Commit 6ccb83d6c497 did not specify which platform and
in what circumstance would xhci handshake timeout, adding a quirk for
DWC3 seems to be the better option here.

>
> But on the other hand, xhci_handshake() has long timeouts because
> the handshakes themselves can take a surprisingly long time (and
> sometimes still succeed), so any reliance on handshake completing
> before timeout is frankly a bug in itself.

This patch simply honors the contract between the software and
hardware, allowing the handshake to complete. It doesn't assume the
handshake will finish on time. If it times out, then it times out and
returns a failure.

Thanks,
Roy

