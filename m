Return-Path: <stable+bounces-232766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOeVAKQLzWnhZgYAu9opvQ
	(envelope-from <stable+bounces-232766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:12:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFBC37A3C3
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11ABB3074E17
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD043E6DCA;
	Wed,  1 Apr 2026 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="FBAezy0i"
X-Original-To: stable@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6893DEFF6
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044795; cv=none; b=BFaphDyJObnLcI+x3t/3QTIH4GLmOE9ppKhZfKdr7v64R7hAvTdmaWRm/zWZD0QEkwpcy/D1CL6rCNjhTwYBfoRqBFrWTI4tPy6iu9enFCrbdYTey9Ofnbf3VoYFdexh6WjC6fpgvGA7lbhr6BliPgYl8zincYTLn03yYHEr2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044795; c=relaxed/simple;
	bh=yoddX4IZ4ec77cwOPa2F4+K1rvtdfnrzECWap8mVxMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzFN0xRSmpPB1uUK2JPffNVd6K9RHk4kC3eV/wBCKG3AWdxsgeIXzoW07rHmKoWNj2UUM+55zPBiSoKKXoiugmRBYfYf+xGYD0cHcGt8kK0xjViQxydSbPfNl8/DdNRjOWxgISInM5FVdOgRlktOtkEbE+NR/KbWSRZc9ehHixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=FBAezy0i; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1775044789; x=1775303989;
	bh=yoddX4IZ4ec77cwOPa2F4+K1rvtdfnrzECWap8mVxMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FBAezy0i8n5XTo5BiP3WmhXMeoNEz01bghNaPIh+y0owMr9ZvJBMPKa41yhYcO1Yx
	 c1pCi4ZC8X44Oj4pK9WgvyTIMzGu//Dy8LWmEN+wECd1mNoDGx0nAySSni2z2rp3Uo
	 wpz3bOfhBzYNY6sZADMfIRAvA368LPt33mOPDZvki0/+3U2m0YhckdUlLW2KWwV2SJ
	 NRcpGx0hAb8DvVvEBHjP8FKw42pgRXde9lSLMrJgB6NrIFGHHlidIzdg98+35mEEQ0
	 o/ALJTecRgusj6UccrFGBRFFLHaMvRsYuhQJ5eMqd+ab4nmoLreEBK2WOjOVnv5iAr
	 o5e19RrkwN+PQ==
Date: Wed, 01 Apr 2026 11:59:46 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: Kangzheng Gu <xiaoguai0992@gmail.com>, gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, kees@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-shapers: free rollback entries using kfree_rcu
Message-ID: <AA-_oeafacETaUw-zXqE2GL70EacawnSC7XXZnHEdy9N1gMfMr6X2N-8_ReZ35CpJl097iWNsCafQjaSiLLfhqttBeen2cUWRdRkomYEWG0=@1g4.org>
In-Reply-To: <20260331183358.3d6f9799@kernel.org>
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com> <20260328185804.41325-1-xiaoguai0992@gmail.com> <20260330181541.5a3c9f73@kernel.org> <CAKvcANN1OEqXv9fo=cxTEEnq+=qs8NnZBrDTf=FTzdo9rHYJbQ@mail.gmail.com> <20260331183358.3d6f9799@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: e1f4d0d7beda9c064e2a86bf6a40840f82f327d3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232766-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,1g4.org:dkim,1g4.org:mid]
X-Rspamd-Queue-Id: 9EFBC37A3C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I noticed this patch
> https://patchwork.kernel.org/project/netdevbpf/patch/20260309173450.53802=
6-1-p@1g4.org/,
> but it seems that there is no further progress on it.

> Please experiment and return once you are sure.
> netdevsim (netdev simulator) driver supports net_shapers, so you can
> easily exercise this code in a VM.
>

Unfortunately in the case of shaper.c, netdevsim only implemented stubs=20
that return 0, so it's a not a 1:1 representation of the physical drivers.
The rollback path specifically is not reliably reachable with netdevsim,
whereas it looks like a proper trigger with real hardware.

