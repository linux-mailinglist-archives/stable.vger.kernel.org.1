Return-Path: <stable+bounces-240293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGeNHOyH6Gk6LgIAu9opvQ
	(envelope-from <stable+bounces-240293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E42443808
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612B2303FA90
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7003B27E2;
	Wed, 22 Apr 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VKFKUix/"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78518DB2A;
	Wed, 22 Apr 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846430; cv=none; b=pCDK/e9L8L/sYmKpaxNgcoLI60wUOcToTVPjIvn9JNAwOIh5f9KvA6YZVhaqw+TEGMuvcm/BVN3rs0Y0MkrS/3zXo4YbdBgg+FgQX4W1Wa0om5dEfR1I7MYSSX0h0Amo2dz4FqL/pWabYCBDMt2PGVG3In/EOoqdeykkzilBkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846430; c=relaxed/simple;
	bh=8a1uwxbP+LJMfY9lNLmas8PKtcFqF6itOJmh8LA40qs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quJbKYr9CxKdahpZYU5+dA4rGjbVLVO1epwoB3Gj7+pxquYTvbpYagBcLk3l6qccltLerla+/2czgMIBVZmzWiRHQM/UJtlYEyMHlaRiSIeon3l5Z5G4YA7ulSWOjeeErCLuumMVtXgIhg7h7u/CzbmYzKhf3fppex8w9JfN0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VKFKUix/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id ED3444E42AA1;
	Wed, 22 Apr 2026 08:27:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C33D3600DD;
	Wed, 22 Apr 2026 08:27:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7436D10460B55;
	Wed, 22 Apr 2026 10:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776846426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=d6DEoIeAIIFpKrk0/9dUHqk04CZJNIFHlbHvTeJ1r2Y=;
	b=VKFKUix/MyVqXEPXHEqLF5GDl20pqZGof11WsF1CtQ2ZMox5iXMONaf9Z4EVCX5oKB1VAk
	G6Ju8lT8eLzGhjtdg6irVAKw+R9Y/lynwfLaDLQLd2Vm1/0TwGnumj/lIWxRLu38AScN3j
	0RVb5P+zVArB9XeE6027R786caDRD+ruuXDp1awOXL4YjpnsfsYHmcFZaabmVVyJ0kSt2c
	aD5iE5NePX3rvmYgRjK4aaqy9Dh64H9rVjANAnnKCHjIwRa/WcG6RIyouLwBsYl1/rsgX/
	blkvoxN2sbRK/ZtD9yXosaZZtuWzOKuMMGr49BGQZMzpcgOVlV45+nIWAsEU0A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,  Anurag Dutta <a-dutta@ti.com>,  Apurva
 Nandan <a-nandan@ti.com>,  Dhruva Gole <d-gole@ti.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH 1/6] spi: cadence-quadspi: fix runtime pm disable
 imbalance on probe failure
In-Reply-To: <20260421125354.1534871-2-johan@kernel.org> (Johan Hovold's
	message of "Tue, 21 Apr 2026 14:53:49 +0200")
References: <20260421125354.1534871-1-johan@kernel.org>
	<20260421125354.1534871-2-johan@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Apr 2026 10:27:03 +0200
Message-ID: <874il35rjc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-240293-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: D7E42443808
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 21/04/2026 at 14:53:49 +02, Johan Hovold <johan@kernel.org> wrote:

> A recent attempt to fix the probe error handling introduced a runtime PM
> disable depth imbalance by incorrectly disabling runtime PM on early
> failures (e.g. probe deferral).
>
> Fixes: f18c8cfa4f1a ("spi: cadence-qspi: Fix probe error path and remove")
> Cc: stable@vger.kernel.org	# 7.0
> Cc: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reading it again, I probably got confused by the impact of
pm_runtime_set_active(), what you propose looks correct.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

