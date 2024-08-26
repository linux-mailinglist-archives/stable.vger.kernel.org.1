Return-Path: <stable+bounces-70243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B495F570
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20131C21357
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E161925A1;
	Mon, 26 Aug 2024 15:46:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619DD5B69E
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687178; cv=none; b=CuvvmP2YQ8tpQRjPB+qDvLN8uQA6iwJv/b9t3QAe4nLk2NxRGSRbI5c9kSFejBmLR/yAOpm2WrIrecvhv6w1Os5epPgz8mDTZmT5C1YyJkXx4pBQzJIT/w2EiUrE5wYuSSCFzPB90A2BFMglo3+fFsMXc11a4Ndj8mlkYor9LlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687178; c=relaxed/simple;
	bh=aZpsChPGzFIVG5WrSdJRCUjjvgdrpqxOKJQFVaATKF4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DGU1eARjKcHYeSIMxXhu20XiK1gCdpk4cnnJSo6dgMwtvX68U41a2Kr0i8z/AZNAI/3FZmV/xfJgPKF+9thUJXrms/SfOdrfLr27VExsGHcLTw23nDxtJYtR75CrrCbX0XaEhywetYQi8MWz+lQJ0epuo6zlvbCN8ELdojUeogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 47QFeUCM010749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Aug 2024 15:40:36 GMT
Date: Mon, 26 Aug 2024 15:40:29 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Greg KH <gregkh@linuxfoundation.org>
cc: stable@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
Subject: Re: [proposal] binfmt_misc: pass binfmt_misc flags to the interpreter
In-Reply-To: <2024082626-shaded-trout-6d80@gregkh>
Message-ID: <Pine.BSM.4.64L.2408261539100.17678@herc.mirbsd.org>
References: <Pine.BSM.4.64L.2408260104111.16173@herc.mirbsd.org>
 <2024082626-shaded-trout-6d80@gregkh>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Greg KH dixit:

>As this is a debian feature being backported, why not just add it to
>the debian 5.10 kernel?

The maintainers prefer to upstream as much stuff as possible,
and it=E2=80=99s really a qemu-user feature, so it=E2=80=99s also helpful t=
o
users of other distros.

>But, as it is a bugfix, I'll go queue it up now, thanks.

Thank you!

bye,
//mirabilos
--=20
=E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.=E2=80=9C
=09-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every system=
=2E=E2=80=9D)

