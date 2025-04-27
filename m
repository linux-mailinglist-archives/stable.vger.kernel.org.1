Return-Path: <stable+bounces-136794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6E0A9E495
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 22:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C237AC24A
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA51FDA8A;
	Sun, 27 Apr 2025 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="GtnbAlsq"
X-Original-To: stable@vger.kernel.org
Received: from wylie.me.uk (wylie.me.uk [82.68.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824328F5A;
	Sun, 27 Apr 2025 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.68.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745786163; cv=none; b=GSGt5louijwbkdNhQtDBFC20HJjeg+ZemQ28ym7/x/8dhH2Af6iYTUNecFruG4yzjQymYpQu5+Hd7iZO89VUbaMI3YgCp4OI97Y08YoUie2X9u0BWsO1cKjLkRa0q8UCLDNtYRJHNmGy3GuZ67ksNwVineL1RHdRM4V+vSraOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745786163; c=relaxed/simple;
	bh=SWMTbEmm5//wR2OBFc2QnhX7Z0C+SqWQvafmLIydBS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KP/FKyEGse4nHLpFgjoV3zvExZrg5QOdAyGjaHlDvj0ceN4bJpsRf0cOWhKNGfwdmjxX/x1FxTzkTyQxwVhxkQwHTx1VFWhd/YOIMw5fbooI1TOeUaMHjfrRavh0QzJiDU8H8eXin/UYnCMF0VNxOrYjA1ZsyQkpCLXRLD3Q6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk; spf=pass smtp.mailfrom=wylie.me.uk; dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b=GtnbAlsq; arc=none smtp.client-ip=82.68.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wylie.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wylie.me.uk
Received: from frodo.int.wylie.me.uk (frodo.int.wylie.me.uk [192.168.21.2])
	by wylie.me.uk (Postfix) with ESMTP id 05F87120713;
	Sun, 27 Apr 2025 21:35:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
	s=mydkim006; t=1745786149;
	bh=SWMTbEmm5//wR2OBFc2QnhX7Z0C+SqWQvafmLIydBS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GtnbAlsqxgtEdG+qrGaaRfb7yyBU17yk/maPGOzJuxlHOxwiEkoJ8RvuwJgzQe0we
	 QJ525afA393TQxmEZekt9f8w9rpYndnftsGTRcil4eISuKo6pyqWURxHQ2VI2TJKFR
	 e0P0SWXCI+JMnJDt42+/zWjEaIZhwM/nGx0VEt0LVCMcFVTrjXwIt1VwtT6JpG8cCj
	 dLPZvJw+dyC86ucyOI9zk3NDchTPpRri2b4qT/asglXgG1GD6DV+oyTxQ9z586MNBz
	 WPujbcvJLCvn7hgzkQf7mW9xQpz33ghA4o7fS2se3do6eFQyjiGiAtEgUkquv0SAi2
	 gZ0pP8GtKD/jg==
Date: Sun, 27 Apr 2025 21:35:48 +0100
From: "Alan J. Wylie" <alan@wylie.me.uk>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Holger =?UTF-8?B?SG9mZnN0w6R0dGU=?= <holger@applied-asynchrony.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev, Jiri
 Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <20250427213548.73efc7b9@frodo.int.wylie.me.uk>
In-Reply-To: <20250427204254.6ae5cd4a@frodo.int.wylie.me.uk>
References: <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
	<20250421210927.50d6a355@frodo.int.wylie.me.uk>
	<20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
	<4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
	<aAf/K7F9TmCJIT+N@pop-os.localdomain>
	<20250422214716.5e181523@frodo.int.wylie.me.uk>
	<aAgO59L0ccXl6kUs@pop-os.localdomain>
	<20250423105131.7ab46a47@frodo.int.wylie.me.uk>
	<aAlAakEUu4XSEdXF@pop-os.localdomain>
	<20250424135331.02511131@frodo.int.wylie.me.uk>
	<aA6BcLENWhE4pQCa@pop-os.localdomain>
	<20250427204254.6ae5cd4a@frodo.int.wylie.me.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 20:42:54 +0100
"Alan J. Wylie" <alan@wylie.me.uk> wrote:

> That would be https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/ ?
> 
> I've just cloned that. I'll do a build and a test.

$ uname -r
6.15.0-rc3-00109-gf73f05c6f711

It's crashed. Same place as usual. I tried again, same thing.

 htb_dequeue+0x42e/0x610 [sch_htb]

Rather than a ping flood, I was running a Speedtest. Both times it
crashed during the upload test, not the download.

https://www.speedtest.net/

Could running an iptables firewall perhaps have anything to do with it?

HTH
Alan




-- 
Alan J. Wylie     https://www.wylie.me.uk/     mailto:<alan@wylie.me.uk>

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience

