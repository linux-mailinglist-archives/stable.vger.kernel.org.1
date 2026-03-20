Return-Path: <stable+bounces-227503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMfBNTMTvWnG6QIAu9opvQ
	(envelope-from <stable+bounces-227503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:28:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 523882D801B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97BD2300788E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E2330D25;
	Fri, 20 Mar 2026 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qpok.net header.i=@qpok.net header.b="FZzupXFV"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74684346E7F
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998896; cv=none; b=AaISgpUnGQNcY9u4YrPGWFObB2vU6NSUtN3ObYgv4xax/fTzKt98RD7qHfHBs7pZxCpyuE1e4OPnZtPsN7iUM+BX6T+m/GlTT7hd7VlRQGUKjwuAgoRH23TUeBguFFAVy6BPEBFLVsPX81U0kPz2Q3HzfFK2ul34209snH7Rrjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998896; c=relaxed/simple;
	bh=rNO14Di7KZnMVWefKhh0ij9quz7UDkBl4bwAflBVCFo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=o9WdGBzxaXHlQ/0RDNS6TdvCdrprjAlXUQOG+NsatFvaTHpI7lFIYKW8Ay9g7QuCTDZqOwjcB+ankRhQfsmVHXR0erNnd6ILDrdV/jHQFrWiSxy8scdCag4OYiwa+uMZkIXtXxWVuktYkibgofnGl6oRSyF50M9F0Clve1tEfc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qpok.net; spf=pass smtp.mailfrom=qpok.net; dkim=pass (2048-bit key) header.d=qpok.net header.i=@qpok.net header.b=FZzupXFV; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qpok.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qpok.net
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qpok.net; s=key1;
	t=1773998891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6cu10aOjRylqbgtDpJ7kKRC5JYCqevnVQUIUK77SSis=;
	b=FZzupXFVrgnabe7HqLP3wiNPOiMidvL5zcX4JDSfOlb2ecUGf0U9RPeElY6+GNuXpizWZY
	cINY0L8DTG2GvzlQ9aOVG7tBxpJ7l5A+e8Ukhtdiy8Uwt3OOkIKbdNxLuVr1J9JM/E9EZR
	AzzV89VQqYhuB2tpj4a6/woVvojivwWZoF2XacaIhSkt0cl4CJbXpX3U5Negfj/zQWiuj4
	EIK05r1PJsulirpfNSWsmeklrlBOC8YEsGO/gMw38pP7VdxFe8WKJr+s3rz+CzALUIT/I8
	YBdNXuokp4vvZNk9nrP+i0sh8scMkOu9YNap0Wnta/szCDBP4TxEF6vIjeDB4A==
Date: Fri, 20 Mar 2026 09:28:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Mark Somerville" <mark@qpok.net>
Message-ID: <1be114e1130ca59ee91fc5a73aaf43a912d408ea@qpok.net>
TLS-Required: No
Subject: [REGRESSION] Unable to pass AMD RX 6400 GPU via VFIO
To: stable@vger.kernel.org
Cc: "Mario Limonciello" <superm1@kernel.org>, regressions@lists.linux.dev,
 "Alex Deucher" <alexander.deucher@amd.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?="
 <christian.koenig@amd.com>, "Xinhui Pan" <Xinhui.Pan@amd.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qpok.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qpok.net:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227503-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qpok.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@qpok.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qpok.net:dkim,qpok.net:mid]
X-Rspamd-Queue-Id: 523882D801B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello maintainers!

I run Debian 13 stable (6.12 kernel) and have encountered a regression.

My machine has three GPUs, the iGPU that is part of my 7950X and two dGPU=
s - one NVIDIA 3090 and one AMD RX 6400. I use the iGPU for the host and =
only use the two dGPUs with virtual machines via VFIO with libvirt.

Although I have specified kernel parameters vfio_pci.ids for the GPUs, I =
have not blacklisted the amdgpu driver so that the host iGPU can operate.=
  Previously, starting a VM with the RX 6400 dGPU assigned to it (via VFI=
O) would work fine. However, doing this with more recent stable kernels c=
auses the machine to hang immediately (and then, ultimately, reset after =
a while - ~30s). No errors are logged, at least as things are configured =
just now.

I can reliably reproduce this crash and a bisection revealed the commit t=
hat introducted the problem: 8140ac7c55e75093a01c6110a2c4025fe7177c57.

This is fixed in the mainline kernel, I have tested and verified my RX 64=
00 is working with VFIO under 7.0-rc4.

I *think* this is still present in the 6.12.y branch but a second (curren=
tly ongoing) regression is preventing me checking this on the latest and =
greatest 6.12 release right now.

Working:   6.12.63
Regressed: 6.12.69
Working:   7.0-rc4

#regzbot introduced: 8140ac7c55e75093a01c6110a2c4025fe7177c57

