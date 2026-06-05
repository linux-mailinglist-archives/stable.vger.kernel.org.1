Return-Path: <stable+bounces-260799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3KlBNJImI2rvjQEAu9opvQ
	(envelope-from <stable+bounces-260799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:42:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBE64B043
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:42:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VB4SOiI8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260799-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260799-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F7B2305F737
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC58404BCE;
	Fri,  5 Jun 2026 19:37:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A104071CD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688271; cv=none; b=qcMTV4Zc2UV9F98t3bF7jYVIMC8G0n5bAtdFPBv3zyuMO2SbIVo5D61zajhrSdGhSZBYNXXWW6EL42k3eDlB2KG1lgMC9wIzaG2BqLKo2Eat5fPx5w7p3jKgljHIKNGAozhgDtVNJtQyqxfmjYviMuj8k+HJxph/XaVrKADnho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688271; c=relaxed/simple;
	bh=iVW+Mbr5MeW/bez5cAkVHCUcvFiTQncJ68/BRBKCGY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCpY9M4rggh6SbIzknFRDMmcOtXkNRoMCKHpXrFxVPPZAbzD3DgCyJtfDg0C9vrtULyW3pmrLvtWHsJuaABtwdbcjzB09aups67syrzhpGn5OKcba+A5bDFfuTq2DpdYnQbMcsJGMRSIJP7n67qUOIF+m7JHZr+dn364lvBRfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB4SOiI8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533191F0089A;
	Fri,  5 Jun 2026 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688270;
	bh=WplpVW73VeZ5SuFEh+ve8+G80Q5TzLBYK+gkAu1bxGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VB4SOiI8bI9bVOnG8JCrJNSzVtTDN2H9hI3/RM1sGbtZhVGFChalsr/IlrO0YAHJU
	 xHOwdReT/EfFlFl0bwoztq2OgyLekPHNHuMD7YMg0oYnRT8XaCXBsqm6EnUoCxLZ7D
	 Iz9y8cHESs26bi2Dnu63hmYXO4SiWso5Ymqvy8HKJ6CNHlAAp+JdFwZHbx0kbO7/zE
	 WlFDZDVI9Sm4GxVFEXD65J9AVEbwQZPMzNnr+udfv2yj/dfbuSdujnPqyVNXrk08vp
	 txpgqZGvuLtvnwwa+ucg/+Fw6AH3tar0QT++gmNppUow6N9TNg1aPz18oWMRMKfyNF
	 aO0V8RCDf9+zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] USB: serial: digi_acceleport: fix memory corruption with small endpoints
Date: Fri,  5 Jun 2026 15:37:25 -0400
Message-ID: <20260605-stable-reply-0018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604120758.2769085-1-johan@kernel.org>
References: <2026060427-gossip-stony-dea7@gregkh> <20260604120758.2769085-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260799-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:johan@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FDBE64B043

> [PATCH 6.18.y] USB: serial: digi_acceleport: fix memory corruption with small endpoints

Queued for 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y and 5.10.y, thanks.

-- 
Thanks,
Sasha

