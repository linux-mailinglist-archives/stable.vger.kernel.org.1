Return-Path: <stable+bounces-220010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLYMMkgGomkGyQQAu9opvQ
	(envelope-from <stable+bounces-220010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:02:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516EA1BE09D
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 22:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C165430FED4D
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45474508F4;
	Fri, 27 Feb 2026 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="SJ3Dkx0v";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="tZWNrw17"
X-Original-To: stable@vger.kernel.org
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FADC155A5D;
	Fri, 27 Feb 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.167.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772226081; cv=none; b=fBPjjUIrfZ/MvPy4Awd7hzROg10+HeQbBNr45PtPARGGEazR0EGWBU/hC/CGnXNSM/3iA6F9MuMSeAEOQbeWMwIGRe2wPEJITAtL7ZXif5DjiPk+TbOzdWIPtBwuSih7AVZ5NqHf2bbUaknaXlcnV6QodINpRKhIvnxB45ERVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772226081; c=relaxed/simple;
	bh=b8cpBJ+BLETE9Bm5uhnEimPG2iFenFLy/EYhMrN+aak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xjaa/YFggpPMRIyFqaRshjvp12PR1XWR1+VclH8q5+hs6Lw5BEYFtdZTzllCZ4nUGQDP5m/RQeapjefEVLCycwFkOVDElhrRUVd4Fx2GPxWPlelY3NQEV0wv/0IPEeMZSaJaaYV1XYT6OsStDVeodXdZC/897HkyNNDOpXPbEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com; spf=pass smtp.mailfrom=moonlit-rail.com; dkim=pass (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=SJ3Dkx0v; dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=tZWNrw17; arc=none smtp.client-ip=45.79.167.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonlit-rail.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kYERC8XBOsJ/fKCJLNFGonkbyKeWtUJ/BBE5WAytVIE=; t=1772226079; x=1774818079; 
	b=SJ3Dkx0vv1EthKYqWA2udivD/CZhaZfcoV5/0KD37ugWqKEprU/Z5x/lsJ4rgz0B7AvECiMjMyG
	gRZQu1JTAWCHH21wjWUgvJ4Cp+mpCVcEyG9PCJDwUnmBiCNcb/zHlyDQoHS8BaHv9+/muVxryf8bt
	JjK5JILuoMzQawav68+EYDRUkvworOR5mRfVbAQEvN3inLdpR3AoDBaWdbhxPTrBjhbo7RLIhgP/2
	p044Y6xDvb+nf3nbXJhJB9iNAF/6IsGiEZy/qy9hnlEeKjt+5DobmUfJezCXpbBt13tueKpDLxJvs
	AfjVUA1rc67CSlM4xRNhysCGCbx59XC739rQ==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kYERC8XBOsJ/fKCJLNFGonkbyKeWtUJ/BBE5WAytVIE=; t=1772226079; x=1774818079; 
	b=tZWNrw17dgljnGJaw/GtmYAx2jwj3acSehYCSMEIgP35IDN1E9WaTsSHQI9aoDp5PdkfVolYv6z
	mtoV8Ssq8AQ==;
Message-ID: <8909a57e-22ca-427d-8d41-cbd68895d33e@moonlit-rail.com>
Date: Fri, 27 Feb 2026 16:01:18 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19.4 - Oops, regression
To: Genes Lists <lists@sapience.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
References: <2026022657-clambake-mountable-8175@gregkh>
 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
 <2026022612-buckskin-surfacing-d854@gregkh>
 <bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com>
 <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Content-Language: en-US, en-GB
In-Reply-To: <67d9f732a55a31f3073675164e8d7ada46da3dbe.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[moonlit-rail.com:s=rsa2021a,moonlit-rail.com:s=edd2021a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[moonlit-rail.com : SPF not aligned (strict),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220010-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[moonlit-rail.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bugs-a21@moonlit-rail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,moonlit-rail.com:mid]
X-Rspamd-Queue-Id: 516EA1BE09D
X-Rspamd-Action: no action

Genes Lists wrote:
> In my case, 7.0-rc1 also boots just fine, but when attempting to load
> the nftables rules, nft gives an error and rules are not loaded.

The nftables rules with "sets" load fine for me under 7.0-rc1 here on my 
desktop/development machine, the one which gave me all the problems. 
That said, my largest set here is only 35 elements in size.

My version of nftables is 1.1.6 (from Slackware64-current).

> Resolved by rebuilding userspace nftables on 6.19.4. 
> 
>  - nftables commit de904e22faa2e450d0d4802e1d9bc22013044f93
>  - libmnl   commit 54dea548d796653534645c6e3c8577eaf7d77411
>  - libnftnl commit 5c5a8385dc974ea7887119963022ae988e2a16cc

I second Greg's comment - "Odd" - in wondering why you need to patch 
userspace and/or recompile it if the same userspace was working fine on 
6.19.3?

FWIW, nftables 1.1.6 (libnftnl 1.3.1, libmnl 1.0.5) is still working 
fine for me under 6.19.4 using the .abort_skip_removal patches from 
Pablo as forwarded by Greg.

Kris

