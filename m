Return-Path: <stable+bounces-249266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPQuBGQAC2oH/QQAu9opvQ
	(envelope-from <stable+bounces-249266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A97E056C30C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FA0B301F36B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6923F9260;
	Mon, 18 May 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQUDSLPs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618EC3F8EC0;
	Mon, 18 May 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105419; cv=none; b=PSJeqxalWfdrnAeSMkbyg2r8rYu1ZEA15geW9f7BDktu+28UmmPAvp/1SWxQR00rws8U3Jwa8vf1PnRZtX87lU2AQb2GPn++lfWCd7hrhMTuxRtw77Y6WjOHS21HHsMLa2JceKsES5MEZaLfyoRCRXfE0MEsPsKVuB8kL1YEWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105419; c=relaxed/simple;
	bh=PsvTugG2pT5YeHJyBpX5o2SwCQnbgkQvZnEddZsthpw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Gafxj/GvVZGtl7oiXY0eGlLBVtLRmrrOSABt3pPBhp1d4GMQV2EcvEcBf5GSOAFl8GtJgU/R8dluPAHEP4Hs3PWMpao20cbaQWcMb9FCfpsw8E38XEb+Vb566WR7wztCAZQ1449AFJ0lIK3D1lBHnejeOguGAK+VdfS/OUOwus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQUDSLPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8C3C2BCF6;
	Mon, 18 May 2026 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105419;
	bh=PsvTugG2pT5YeHJyBpX5o2SwCQnbgkQvZnEddZsthpw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=BQUDSLPspdSCHEdSHA5V2bFyHhQGaAKB0Vqyg43Oxkbx5o9Q78FxPnqIs6AQcL4yf
	 +H6lCNsA1iutPHlE3kT6IxZSQT4FlslLyy++7JO8fjpe6sA6HMZRY6iWEueGxBUdRF
	 UEh5Cf3Rypomto5iAWCmmoEuUyrLsfDAnOrHDW3+rhgpbt363p+nPxnV5iiDTm00Yp
	 zGmDYF7MSo6JADf+6qNRkJOIvfinzGpUz3+Ytf1ls78bKPVgwQseySCJuOew5M0eyv
	 /od4xKE0HgtOCk3lkyzMOOHrFaEjssAVCtHuuGhszbUyuvmfjDvoi3UKKBuH3exFdH
	 lHy1ufRYRNqZg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 13:56:56 +0200
Message-Id: <DILS8H3JN5Q1.1H0OODCVWMYPR@kernel.org>
To: "Sasha Levin" <sashal@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: Patch "PCI: use generic driver_override infrastructure" has
 been added to the 7.0-stable tree
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Alex Williamson" <alex@shazbot.org>,
 "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini"
 <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>
References: <20260518115337.833706-1-sashal@kernel.org>
In-Reply-To: <20260518115337.833706-1-sashal@kernel.org>
X-Rspamd-Queue-Id: A97E056C30C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249266-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon May 18, 2026 at 1:53 PM CEST, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     PCI: use generic driver_override infrastructure
>
> to the 7.0-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary

I think it should be caught by your tooling, but just in case, this also ne=
eds
commit f45a49a2380a ("PCI: Initialize temporary device in new_id_store()"),
which did land in v7.1-rc3.

