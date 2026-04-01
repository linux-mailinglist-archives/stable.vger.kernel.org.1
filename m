Return-Path: <stable+bounces-232643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL2VFqB2zGmOTAYAu9opvQ
	(envelope-from <stable+bounces-232643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:36:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2FF37382C
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FB18301379E
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 01:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE8257452;
	Wed,  1 Apr 2026 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAEHpOza"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AA347C6;
	Wed,  1 Apr 2026 01:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007240; cv=none; b=ojUFb5IyZwvwUBTTytuno4D1T1c9DNxspBZONs9plH7V9vGuAfu5P5DFD8KE22xvewM1sX8MSoagvtgvEE/gVsX85m2XCcm6kVeHpd42IWA53y4HUNJbeeCEOZpmPlsi+r960AYjqs9VnWUbOLTPcENgmIMRueYh8zYaPQ4g0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007240; c=relaxed/simple;
	bh=gLMRaGSIA1Cv9tV3GFlaIaVOkPLyBIz3jyCsCpeVmUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4sSp0Eodar+bFztntITmGEoBAKfG571QMdYhrxhMC+WJDHGCAoZzWwygryuyGvb2WCkgUV/tI2HQXKNuOGtCQIz/Q67VwFBiVHYofyG1c6STbDhgSfXmBqm8dqGcttrCjAhd9KrVDQ16D40B/S8cyep/0HwCUb3FYca9zR+3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAEHpOza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF9BC19423;
	Wed,  1 Apr 2026 01:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775007240;
	bh=gLMRaGSIA1Cv9tV3GFlaIaVOkPLyBIz3jyCsCpeVmUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kAEHpOzaVQ31TDbwC5KiE74A/fXYuhkFF1a8z2sihFq9jFCv+pm6zmGQx9VJ18HRa
	 N9Q4V0DU2NORPsos1qkKstGEMc3TO81y3iojVTXhWKs2JA0L5SBRtn/mmQRFlDEi0Y
	 NX3DBrdDdccVAMHL8XgKnNSZ9M48S1uob90NaqLP14hZO8vYI7I4LJl1r4XBDXPKij
	 oCFiidn3SErd8UXYR8QMzoeycwf2UrKXs9tAChPcGd4w7098NL/IPV/5qUXJyV4CVX
	 UE5ok4Vo0g4xpeypcVcwXmoAJaDlogBd+0cIiUIucUJn3yyeYR7Oadvb71AKy/GcSD
	 vENUXLKIEGW1Q==
Date: Tue, 31 Mar 2026 18:33:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kangzheng Gu <xiaoguai0992@gmail.com>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kees@kernel.org, p@1g4.org,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-shapers: free rollback entries using kfree_rcu
Message-ID: <20260331183358.3d6f9799@kernel.org>
In-Reply-To: <CAKvcANN1OEqXv9fo=cxTEEnq+=qs8NnZBrDTf=FTzdo9rHYJbQ@mail.gmail.com>
References: <CAKvcANOzRwFk0jm4xBfMGVNJrgGhBT8zvb6r49qc=WdB5zP_fg@mail.gmail.com>
	<20260328185804.41325-1-xiaoguai0992@gmail.com>
	<20260330181541.5a3c9f73@kernel.org>
	<CAKvcANN1OEqXv9fo=cxTEEnq+=qs8NnZBrDTf=FTzdo9rHYJbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-232643-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA2FF37382C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 15:41:28 +0800 Kangzheng Gu wrote:
> Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B43=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=BA=8C 09:15=E5=86=99=E9=81=93=EF=BC=9A
> > If dump can see NOT_VALID entries we have a bigger problem than a UAF
> > don't you think? :/ =20
> I am not sure.

Please experiment and return once you are sure.
netdevsim (netdev simulator) driver supports net_shapers, so you can
easily exercise this code in a VM.

