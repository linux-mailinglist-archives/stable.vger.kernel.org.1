Return-Path: <stable+bounces-238039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIcGKrcg32mJPAAAu9opvQ
	(envelope-from <stable+bounces-238039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:23:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323E240072F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59E23037DE4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A5318EF6;
	Wed, 15 Apr 2026 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mgBfTpis"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F32773CA
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776230581; cv=none; b=uVcrJmE9hxfQ8w0HE5/GG7GfihcGJsJ29kQfj9T+o+Bq1unDKYa5cQnKyfYcOo+6fSERP8n9t3BJVXfO2OW7G+Rv+fogmmSWb8efE8oXb5tEayN2cJSw/iYsM5p0H/OMqVVyPeIn0WXOuNbETp3wMglkUGKsQio+f6xnZXkUA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776230581; c=relaxed/simple;
	bh=/efp6yRw/jDQ6sXHjhW+nvuV4O/U6xG7TmI78pQuTOM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sdmXcYMKFOZ+uOkJeUxgqxWeVGz5GiqdPpijJxV6S0QLd3MyGB4kcrR3ecpWKDlmnUYjogipyIiiy989FLHmQWb29o9K3t3u35nTXtnQ9R0iB4E0pTd2m1lfa4PQZ6ZnNvBvv0l6WtOoQC7znZMjMU2eYGGY2tOubjKDUM+w4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mgBfTpis; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776230577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/efp6yRw/jDQ6sXHjhW+nvuV4O/U6xG7TmI78pQuTOM=;
	b=mgBfTpisD+KZxsj7EdmMsUp9r7OSo5eUVvJfRMuuzxRhNUUHhshTBqIuXrPU0H8K9dq8lW
	qdzzgjYnnaGPsF4WL9O2hJf1FIUu6NW1Rh/NeBI6FlrKKWGlCXIIzSZinyE/or8cW99EdB
	iK6nnSu9fY1Afq8FddFwkMucqg9ihGY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 07:22:53 +0200
Message-Id: <DHTH6SPDQ037.2W1FBRA030J1V@linux.dev>
Cc: <error27@gmail.com>, <hossu.alexandru@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix missing frame length checks
 in OnAuthClient
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Luka Gejak" <luka.gejak@linux.dev>, <gregkh@linuxfoundation.org>
References: <2026041526-resonate-overpower-e45f@gregkh>
 <DHTH3PLMFNK6.24NLM1U01XPKJ@linux.dev>
In-Reply-To: <DHTH3PLMFNK6.24NLM1U01XPKJ@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238039-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 323E240072F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 15, 2026 at 7:18 AM CEST, Luka Gejak wrote:
>

Ignore this email, aerc(my email client) is having quirks.
Best regards,
Luka Gejak

