Return-Path: <stable+bounces-222391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BdcMVaho2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:15:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFA1CD55C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B51A0300752E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C716132A;
	Sun,  1 Mar 2026 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mattwhitlock.name header.i=@mattwhitlock.name header.b="1BKgacgw"
X-Original-To: stable@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B673463
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772331346; cv=pass; b=r4HuYFIUtpzTi4tb/596tJ4R70hp9zOyfMooGfPm5jQaSGRYiS1BmAK29AmeITZJp0+AA0fu2vqNOBnfRJF4cxEdJQDMM3UDFQsrcwiJthgMgRNS7sXX466QVrC2hn89le0Qhm7teqEIGDDZU3aphSDntEEN7gaOUcElkcR9YMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772331346; c=relaxed/simple;
	bh=XslPH37Q/0YbH2/nGeyGdzH/vPrf3ZHqWM8VLVE1XXU=;
	h=From:To:Cc:Subject:Date:MIME-Version:Message-ID:In-Reply-To:
	 References:Content-Type; b=OBWb8WZjWk2d27OgTq4qdyE0RuMLuAs/E//h8FszyIOisl+yBFywlG6Iru4lAyPlqmNFDezeJQUSSe44FubkOA3MAMOSBTWE3SlLae+As6/WNQfgDGeI6EbmzFH6KbSb7PT3HvEmYeT3+ZNwH26/mPJHKnCi3L1ng2a+HmsboTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mattwhitlock.name; spf=pass smtp.mailfrom=mattwhitlock.name; dkim=pass (2048-bit key) header.d=mattwhitlock.name header.i=@mattwhitlock.name header.b=1BKgacgw; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mattwhitlock.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mattwhitlock.name
X-Sender-Id: dreamhost|x-authsender|matt@whitlock.name
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2774D7E136B;
	Sun, 01 Mar 2026 01:57:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (100-105-14-226.trex-nlb.outbound.svc.cluster.local [100.105.14.226])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AC3B67E1539;
	Sun, 01 Mar 2026 01:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1772330252;
	b=MDkYninpMydDLG5jiu+erLGE+yj/ZyNRSsf+A7Rg6PPaLHE6uqR1r9PQ63laaFhoxakNbP
	I5LG0rDO+qOIiaHCGrAQ/1Z8FQqBzZf6eHaZ02GuVoGxy+aK9XFRZG2zRRPfMDBSgm6qKB
	8XXh+KAGas1L1D3bNeWaDaDyhPfl///omcbOuajn4itHScvn1N8v7l+jDLXUk+4T22wvUk
	oCh+E9GewUC+obhunLZ7bHSlJ5uJ1hv7DhJDAv+vhWG7rHCSbefNZN0i9sl/MiVdbtRkOa
	TgSAo22Qx2pZqACHK52qDBUh4tV4SSrZb1nTsIt7M5HJrtKcneYUhMnF91MqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1772330252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XslPH37Q/0YbH2/nGeyGdzH/vPrf3ZHqWM8VLVE1XXU=;
	b=Sg0zjrzAjlN+Rf38Frt2UAE4y754F33lxWEeq0m9yJ3LOLq2jrpdiS7GbdzgX3MTEfNjl7
	bpVINp+3REiLiXtBExBIJaKTJscTxaWwxzRJHb9PEJRe0/c2EZ5rjkbM3u9VjCuf3XF5V1
	9/+r3LVv8eSirTXuFfpaKla8uSn+ZKxANLvlQG+8Ue38QszEYSPKm+A1ipyrzhCDuBpOvL
	NsF92f3pCrZ7RYRAyV00OsGCOloVRg9cdMEYPDSMZUxWCxXSi8T5Y8gcVDJmbeKZCCLZC3
	9FtPiGekDowdC5ByIQeB0AEdm0vHvoevo5QcoNv/v3SuKiHkYjd9bXvurzJ5uQ==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-95599;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kernel@mattwhitlock.name
X-Sender-Id: dreamhost|x-authsender|matt@whitlock.name
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matt@whitlock.name
X-MailChannels-Auth-Id: dreamhost
X-Inform-White: 1a102fc8411714e1_1772330253036_12967548
X-MC-Loop-Signature: 1772330253035:3583424461
X-MC-Ingress-Time: 1772330253035
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.14.226 (trex/7.1.3);
	Sun, 01 Mar 2026 01:57:33 +0000
Received: from localhost (unknown [70.8.171.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: matt@whitlock.name)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4fNlZ40yvJz1054;
	Sat, 28 Feb 2026 17:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mattwhitlock.name;
	s=dreamhost; t=1772330252;
	bh=XslPH37Q/0YbH2/nGeyGdzH/vPrf3ZHqWM8VLVE1XXU=;
	h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=1BKgacgwm66T7lvpEZrZKmLDZxa3tGrsX0n6DE1Endn8dW9set9L9wqDib0koci+t
	 MFzFPP8T485ehKtMTMoMVL2NZwbUuYN7JZ5XPdoFnH8o1n/pTd2DCyMH4xGCHaMiXB
	 kGTyeTiobX+UaE1kI0pMrJq+KUBBUdc6mJZ8pgUf0fmIt0aQnhlR0Quly+nFPbIHLc
	 0YbzZ3doAMRk29l43Xk86bSF+/BRzLDTtkiZoePpR9yWEDweVfhP8BC0tqM7QJxbkP
	 6YQi9YCjF9gxM6qklbuJkDXZPt1MqNemXDwkJGlrgECEcWcAWWHIqE/zbu0+B+I6Dr
	 805oNe86He2dw==
From: Matt Whitlock <kernel@mattwhitlock.name>
To: Sasha Levin <sashal@kernel.org>
Cc: <stable@vger.kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 <dm-devel@lists.linux.dev>
Subject: Re: FAILED: Patch "dm-unstripe: fix mapping bug when there are =?iso-8859-1?Q?multiple_targets_in_a_table"_failed_to_apply_to_6.12-stabl?=
 =?iso-8859-1?Q?e_tree?=
Date: Sat, 28 Feb 2026 20:57:28 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c6f5ccd7-84dd-4efe-8842-8d08693d1d5a@mattwhitlock.name>
In-Reply-To: <20260301012206.1678262-1-sashal@kernel.org>
References: <20260301012206.1678262-1-sashal@kernel.org>
User-Agent: Trojita/v0.7-781-gfddd17b7; Qt/6.10.2; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mattwhitlock.name:s=dreamhost];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222391-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mattwhitlock.name:mid,mattwhitlock.name:dkim];
	DMARC_NA(0.00)[mattwhitlock.name];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mattwhitlock.name:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@mattwhitlock.name,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 58CFA1CD55C
X-Rspamd-Action: no action

On Saturday, 28 February 2026 20:22:06 EST, Sasha Levin wrote:=0A> The patch =
below does not apply to the 6.12-stable tree.=0A=0AI believe this assertion i=
s incorrect. The patch *does* apply cleanly to 6.12.74, 6.6.127, 6.1.164, and=
 5.15.201. In fact the dm-unstripe.c files in all of those branches are almos=
t identical. Maybe something is broken in whatever system is managing the pat=
ches?

