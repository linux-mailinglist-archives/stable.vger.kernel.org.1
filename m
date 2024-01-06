Return-Path: <stable+bounces-9931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A2825E19
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 04:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B941F2401E
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 03:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF915B3;
	Sat,  6 Jan 2024 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="jGTP4ySy"
X-Original-To: stable@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F415A5;
	Sat,  6 Jan 2024 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XVoH2bWthC9wKGidUvWdR8qVLzbMp71NddPvjPGWg0M=; b=jGTP4ySyUKF9CKWJsZ5PMS4RFh
	SxMMa80DZ3npfF/i3Oo8+l01eB97tRQ8Bf6pRMXMaG4+Ri/nqLD1quGKhDALXzZKb/+O/BbnitQtQ
	/5tjPuyztaAFZ/FNNBpVXtEqiEuqPhdJpbHaZ3X1K1LPMbbloumcGV2JF4Urqw3sjwowWdjl98IKI
	UgK9J5H/YCQAzI5L0t9SK/s6DbgrHFaJKrSkrf1voMb57wHuN4eaEyxITM5wo1tkwo00UZa4agXEA
	m8+CjUcC2rw/VuVoN+yHLFZrHjNwTr+q56S0eFZJKMGH8Q9+S3t6gOnevMsgp9wK6opdW3aZBJUGs
	bTCFVhCw==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97)
	(envelope-from <phil@nwl.cc>)
	id 1rLxPw-000000002A1-3nAh;
	Sat, 06 Jan 2024 04:32:12 +0100
Date: Sat, 6 Jan 2024 04:32:12 +0100
From: Phil Sutter <phil@nwl.cc>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] rtnetlink: allow to set iface down before
 enslaving it
Message-ID: <ZZjJvJY4facvIu8a@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Jiri Pirko <jiri@resnulli.us>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
 <20240104164300.3870209-2-nicolas.dichtel@6wind.com>
 <ZZfvHEIGiL5OvWHk@nanopsycho>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZfvHEIGiL5OvWHk@nanopsycho>

Hi,

On Fri, Jan 05, 2024 at 12:59:24PM +0100, Jiri Pirko wrote:
> Thu, Jan 04, 2024 at 05:42:59PM CET, nicolas.dichtel@6wind.com wrote:
> >The below commit adds support for:
> >> ip link set dummy0 down
> >> ip link set dummy0 master bond0 up
> >
> >but breaks the opposite:
> >> ip link set dummy0 up
> >> ip link set dummy0 master bond0 down
> 
> It is a bit weird to see these 2 and assume some ordering.
> The first one assumes:
> dummy0 master bond 0, dummy0 up
> The second one assumes:
> dummy0 down, dummy0 master bond 0
> But why?
> 
> What is the practival reason for a4abfa627c38 existence? I mean,
> bond/team bring up the device themselfs when needed. Phil?
> Wouldn't simple revert do better job here?

Ah, I wasn't aware bond master manipulates slaves' links itself and thus
treated all types' link master setting the same by setting the slave up
afterwards. This is basically what a4abfa627c38 is good for: Enabling
'ip link set X master Y up' regardless of Y's link type.

If setting a bond slave up manually is not recommended, the easiest
solution is probbaly indeed to revert a4abfa627c38 and live with the
quirk in bond driver.

Cheers, Phil

