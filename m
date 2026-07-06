Return-Path: <stable+bounces-272229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oxFbATjDS2p3ZwEAu9opvQ
	(envelope-from <stable+bounces-272229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:01:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECDD712511
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 17:01:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=wegslaAl;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272229-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272229-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EFDF330E694
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966532B111;
	Mon,  6 Jul 2026 13:37:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40349317177
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345037; cv=none; b=U3PxrsZB9EAFDXq1ZTWzLwBValBwWZExMOUlRYSwOkKFBxRl0bZ6w5YqohkOL2CR+Vj7O5iO8Q9hU1evG5LVpodRoAbKqU0tqpKZLTLHgZ8eqw4JrttBGloHy11QAra21iTGrmMtOZrYN/Y5kl3ZDCYEUe4X4yskGLuYAYZMiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345037; c=relaxed/simple;
	bh=nYc4/CNmu/Hpz2BKrNBXe2Sm/VGLPPqJIS4LBxS09v0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=gaS9oVmn2hgOfrn9UXJS3RuBpdPoduTeEkEgN7C9y0SGNXNjin8a5Z54ZRQaqi3pn4Qakeom5EVuxaSLD5s5byLGnVqj7fuNas12QEbH93+TZjxPtQ+uWrV0T/ZuGckofP5PPxx5oAvXEVXHJB//Jg50J4jn0hRoEYGxpnroYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wegslaAl; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CFF931A0E91;
	Mon,  6 Jul 2026 13:37:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FDD8601A2;
	Mon,  6 Jul 2026 13:37:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AE7B11BBA1FA;
	Mon,  6 Jul 2026 15:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783345033; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nYc4/CNmu/Hpz2BKrNBXe2Sm/VGLPPqJIS4LBxS09v0=;
	b=wegslaAlf/E5SyUEcIoDiMbBET9wPd31EhjJaORyDUHeGfSD2rlw4+T4IuFQr4MtIzhotd
	pNj3N3xwlYIr797dpayIGaEYscOgoVNAaw3LA5tkZ3QwnI6DHroyUHOiyQdR9nwmc/rNbA
	b2lO79LVvj6LOPs02iZW1cQVGdrdMFnxfXGkAk5kHeo3d6PaM9++X2J8YKc8/oB8D8CHV7
	XnUtwSVHDBpwqhOhUeRpjQ4Sz0H5iohEm/SJE+Dw0QFv9RncEhKt4KSxL9rP+GBOBDk6O8
	PzC9y5NcPl3chwPjfZhLNjFbVSRVBHo63hsd7lo4PHfVUim8p8vcQw9pWRltqA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 15:37:11 +0200
Message-Id: <DJRJ1XHDEB9M.W9JU7GHZX0NJ@bootlin.com>
Subject: Re: [PATCH v3 0/2] nvmem: layouts: Add fixed-layout driver
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Mathieu Dubois-Briand"
 <mathieu.dubois-briand@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Srinivas Kandagatla" <srini@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
In-Reply-To: <20260608-mathieu-nvmem-fixed-layout-v3-0-12ddc69f4c51@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272229-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:miquel.raynal@bootlin.com,m:gregory.clement@bootlin.com,m:thomas.petazzoni@bootlin.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:mathieu.dubois-briand@bootlin.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mathieu.dubois-briand@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[mathieu.dubois-briand@bootlin.com:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.dubois-briand@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,bootlin.com:url,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ECDD712511

On Mon Jun 8, 2026 at 3:42 PM CEST, Mathieu Dubois-Briand wrote:
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
> Changes in v3:
> - Fix device node pointer leakage
> - Move nvmem_add_cells_from_dt() prototype to internals.h
> - Enable fixed-layout as built-in by default
> - Rebased on v7.1-rc7
> - Link to v2: https://lore.kernel.org/r/20260515-mathieu-nvmem-fixed-layo=
ut-v2-0-8ac215dd4016@bootlin.com
>
> Changes in v2:
> - Fixed dependency on core layout code with CONFIG_NVMEM_LAYOUTS
> - Make fixed layout optional
> - Link to v1: https://lore.kernel.org/r/20260505-mathieu-nvmem-fixed-layo=
ut-v1-1-7f6ecbce108d@bootlin.com
>
> ---

Hi Srinivas,

Do you have any comment about this updated series?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


