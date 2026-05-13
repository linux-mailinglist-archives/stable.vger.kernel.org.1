Return-Path: <stable+bounces-246890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGhNIE2OBGoVLgIAu9opvQ
	(envelope-from <stable+bounces-246890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:44:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C05355A1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAC443011068
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED29438FF7;
	Wed, 13 May 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cetola.net header.i=@cetola.net header.b="TXzHkl59"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9414AD20
	for <stable@vger.kernel.org>; Wed, 13 May 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683179; cv=none; b=usB8wf57rH5lJeC2NuiNNwxjlcFWY5pzdaOOCdAnTcUJB/Dp8TwDmHqmmNaHVm0SvecVPy2dVlP/SBf/QPtgSw4S6bI+CPKuVbDie+r/y5Ng4mo9jn2iHE0X2gKwPQHPhMMpOFuWuD1ERsAraCm6UPjWcD/Zxbi4tex39uk1DkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683179; c=relaxed/simple;
	bh=8fg2LHVRcK2coVOgzeENC5kS1JrEY5lupp9BGNfsbkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOQ0j1SD1DdryhcL2zaXd6bzcCKHD4yDLgU1DlwgCI2Sb8Mlj0Ittyo4IWn2hY8SPZnmGFRG8WpIb8OAXLkRWld64uKl/1JadL3vJL6DEwelpzLelxt9yZd1DYUPAiktXJzysEc9lMf0flOSNACs+61lxqWSWKX1kr4dH4GeKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cetola.net; spf=pass smtp.mailfrom=cetola.net; dkim=fail (0-bit key) header.d=cetola.net header.i=@cetola.net header.b=TXzHkl59 reason="key not found in DNS"; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cetola.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cetola.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id N9IYwxwVRnwj2NAkGwWS2U; Wed, 13 May 2026 14:39:32 +0000
Received: from box2192.bluehost.com ([50.87.253.143])
	by cmsmtp with ESMTPS
	id NAkFwtKfOtuVJNAkFwPuUV; Wed, 13 May 2026 14:39:31 +0000
X-Authority-Analysis: v=2.4 cv=BNWzrEQG c=1 sm=1 tr=0 ts=6a048d23
 a=j14/dPpTP3/5aO8YB4ELDw==:117 a=j14/dPpTP3/5aO8YB4ELDw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=jNmq5YGq058A:10
 a=aJ1-2QklXahT5ntjsnEA:9 a=QEXdDO2ut3YA:10 a=dWMlSAZEh1Dptg_Be0X5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cetola.net;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8fg2LHVRcK2coVOgzeENC5kS1JrEY5lupp9BGNfsbkw=; b=TXzHkl596Z71qDmJb3Du092zVo
	eRhDxIUbPoAcqvHhdvbk3ZezZXxwdseF3JQeTBYr2EInkF5ERfBd0CPXH4hswEmUZYbTH1HxLMYKB
	Y6FJTCtx5KhcezZ3eZOo/RVYdP7K7lPBUn0z/rOmWMLIGw/Xh/UbnH2UkV2GwePCYby8=;
Received: from [71.238.14.13] (port=43518 helo=[192.168.1.191])
	by box2192.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <stephano@cetola.net>)
	id 1wNAkE-000000022mn-11Td;
	Wed, 13 May 2026 08:39:30 -0600
Message-ID: <67725402aaddb935a94d2cd751f317e6bb844654.camel@cetola.net>
Subject: Re: [PATCH 7.0 247/307] sched_ext: Skip tasks with stale task_rq in
 bypass_lb_cpu()
From: Stephano Cetola <stephano@cetola.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	 <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Chris Mason
 <clm@meta.com>,  Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>
Date: Wed, 13 May 2026 07:39:22 -0700
In-Reply-To: <2026051301-tusk-parcel-15ee@gregkh>
References: <20260512173940.117428952@linuxfoundation.org>
	 <20260512173945.338221208@linuxfoundation.org>
	 <2f509cbf-f14f-4dfc-8ba9-d53dc10e0aad@kernel.org>
	 <2026051301-tusk-parcel-15ee@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box2192.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cetola.net
X-BWhitelist: no
X-Source-IP: 71.238.14.13
X-Source-L: No
X-Exim-ID: 1wNAkE-000000022mn-11Td
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.191]) [71.238.14.13]:43518
X-Source-Auth: stephano@cetola.net
X-Email-Count: 5
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: Y2V0b2xhbmU7Y2V0b2xhbmU7Ym94MjE5Mi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF70Xkq3UIHRvvYuDMxDI12Z5OHZMYAMvkq9wZM1/VTs4i9+ugsKRswZ7v8C+63uOwlH8Fx2Jc2aDftiSbAxddeLxf4Jb+sKYdAL76EdWkXSiOKOV5Qi
 cbcJei04rc6CQ80P+Joxce7ogU3rogKFMA+h+7hp7LEN3iK2z40mKbjbWpNNgjR92i4dcOF7hMG+HMYSr9MR7lyl15/kw0bhFYI=
X-Rspamd-Queue-Id: 143C05355A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246890-lists,stable=lfdr.de];
	HAS_X_SOURCE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[cetola.net];
	R_DKIM_PERMFAIL(0.00)[cetola.net:s=default];
	DKIM_TRACE(0.00)[cetola.net:~];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_ANTIABUSE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephano@cetola.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.651];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cetola.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-05-13 at 13:58 +0200, Greg Kroah-Hartman wrote:
>=20
> This is odd that it doesn't show up in my test builds/runs.=C2=A0 I'll go
> drop this now, and push out a -rc2, thanks!
>=20
> greg k-h

One of my build machines was able to build 7.0.7_rc1 successfully. The
only difference I see is that it does not have:
CONFIG_SCHED_CLASS_EXT=3Dy

--stephano

