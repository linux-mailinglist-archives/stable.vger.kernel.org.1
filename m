Return-Path: <stable+bounces-227543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI75HLNMvWlr8gIAu9opvQ
	(envelope-from <stable+bounces-227543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:33:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5C2DB08E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8C8304C942
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D5188CC9;
	Fri, 20 Mar 2026 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qpok.net header.i=@qpok.net header.b="YnoIkz3o"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35577274B3B
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013614; cv=none; b=nEj5OV4SV1MEIMhbyqjhGteskv03cHH4RcOX298ivBHtXlyvThREwTg1eOfGbm1Hh6uAPUpSMJ91AUfe8a5aVuArMcftrG/SmJ6sxQCyce43YxeqSnRFFPhvfcij7VyeyQIAvzp5BSTi11bQ+qqA1+ChGkq+FsdKYqUGEE78jSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013614; c=relaxed/simple;
	bh=QCXNxW35egdbMpOv4aNaV9RCMZ8lQkjvQr5BO0XO0n8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=YyMHKFP0SD6MbPxkqPb0X2mhwnxrWyIFaeW/r6PxorNMbqNDDDf+i9mR706pLGay61iKF3t0ed7+3idFlI1rrDOgoh21UATJNmAkQ7/okB0nzRAlGv4huT5x20H05YsaCnS0IC32nTfw0ozzbODBdLeq+8ss3Qjuaydlltxn1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qpok.net; spf=pass smtp.mailfrom=qpok.net; dkim=pass (2048-bit key) header.d=qpok.net header.i=@qpok.net header.b=YnoIkz3o; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qpok.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qpok.net
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qpok.net; s=key1;
	t=1774013609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCXNxW35egdbMpOv4aNaV9RCMZ8lQkjvQr5BO0XO0n8=;
	b=YnoIkz3o0wQayIdnqV14+jGeCq7E5yUe6SEoTw0PYL2/gClcD+UbjMbT71hDTPfOhlNNgd
	QncMe0U8HwQKxmool6HMXs8zdnJZ7ECOI4HlfC0Al6LxE8NDMh3WjvwkxOj62HsgVBulsc
	mXVj69/SXMGoRqN0RRLEbEEWMjvM8wt7Eai6WNaYAip8pZ+RtUfzRDv2L8yxQek7l3M1jE
	F35nmePAA8TqkaJnOrIQzRO8mIlZahD9dvYL5olOgrCjM6s1WDyqOtv7J8shkpAEzMekAV
	KfVEMSRzdamPQlNtxjT1C6ESP1SwcuzIZtkD0KVP06vUTOo5/lVucytmATO8Xg==
Date: Fri, 20 Mar 2026 13:33:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Mark Somerville" <mark@qpok.net>
Message-ID: <dab036c7ad0ce6c28fa25b8c30e68cc20ed2a8da@qpok.net>
TLS-Required: No
Subject: Re: [REGRESSION] Unable to pass AMD RX 6400 GPU via VFIO
To: "Mario Limonciello" <superm1@kernel.org>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, "Alex Deucher" <alexander.deucher@amd.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=" <christian.koenig@amd.com>,
 "Xinhui Pan" <Xinhui.Pan@amd.com>
In-Reply-To: <1ce6b64b-47e7-4e73-a73f-58bf5f5202b1@kernel.org>
References: <1be114e1130ca59ee91fc5a73aaf43a912d408ea@qpok.net>
 <1ce6b64b-47e7-4e73-a73f-58bf5f5202b1@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qpok.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qpok.net:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227543-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qpok.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@qpok.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91B5C2DB08E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

March 20, 2026 at 11:42 AM, "Mario Limonciello" <superm1@kernel.org mailt=
o:superm1@kernel.org?to=3D%22Mario%20Limonciello%22%20%3Csuperm1%40kernel=
.org%3E > wrote:
>=20
>=20If you bisected to 8140ac7c55e75093a01c6110a2c4025fe7177c57, try addi=
ng f7afda7fcd169a9168695247d07ad94cf7b9798f.

Ah, nice one! Just tried that and can confirm that 8140ac7c + f7afda7f re=
solves this problem for me.

Also great that it's already in a later release than I have been able to =
test!

Thanks a lot for the fast resolution and apologies for any noise.

