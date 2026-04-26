Return-Path: <stable+bounces-241152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF42N5Zh7WmwigAAu9opvQ
	(envelope-from <stable+bounces-241152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 02:51:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58723468846
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 02:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9286E3009039
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCD51C5D5E;
	Sun, 26 Apr 2026 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="gmw4oQ8w"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD57817A309;
	Sun, 26 Apr 2026 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777164691; cv=none; b=HIlm+j542owgtYz2aXqjTa+pEN+ebCxba3shx/94mt8FJ0sXWU4wAPxbnhWPbyS3i4UQs9XoMeCtcc6pdyG8n6Wxa9w4k9lr4sw1cIyuFiOtJ1Smszk8LuuPgFLnZKoT3a1NJq576AT3RHMLSU3QJEw8AAzLj9vcHxikcq0pa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777164691; c=relaxed/simple;
	bh=Sgnr9Qr9ne7BjH6WRYKhedQMXlZE3fWk0DFIiWwNP2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMoyhLU0sCC2W1cZwkArkdJD3oY0tHvf452D5NrbikjK9hy9EGctP/j9WD1vP/6Imv84RQcZno0CzKhEZqFHF/FTQBCtGg4YN5dGFXccY2UWkidq/tVpFAHnKWV44tKN5mejAsgGRi9WqXdTLxBZ8y+nNWComykbTXKYxEU2GIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=gmw4oQ8w; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC8AF11431B;
	Sun, 26 Apr 2026 02:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777164681;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VWnRzjDOFEvgT8xfWsY12oIkXZ6yB0jt0uta3PSs17U=;
	b=gmw4oQ8w+QZF/EYORa7wd2DJ4ZlvWgXgJzwIRzSlgj7WwfjSCr9K5Z2PEypRogmXkKxvoK
	tvMnfctW2GAa99szlcdjB+vm1hX9R+Cx9vgxzTRocdC0sceZk5COWkk9ap0Z7GiVpkRgc3
	9ciiO8WEkz3T7TDBkwUaSYI0W78Ivfrc1+l2JBKGpPJm1BL6CgRsb7dCvFq3uxI1C6OUPS
	dBTu+hCdVUcwtaIkohMZQn7JU/d0QVnQXcGC2MwsKyid5Gej6IQxjZ4PMGSSJN2UXPYhN8
	PGts1EXnTY9PQHHbvKlGVRl6gr3gls+ehf1vSZoNqfeu3V4KvAy+IB7k3svuQA==
Message-ID: <8ff84eba-0e6e-45ea-bdfe-fa934de9cfa6@nabladev.com>
Date: Sun, 26 Apr 2026 02:51:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
To: Kris Bahnsen <kris@embeddedTS.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, Mark Featherston <mark@embeddedTS.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260424192534.3504976-1-kris@embeddedTS.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260424192534.3504976-1-kris@embeddedTS.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 58723468846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[embeddedTS.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241152-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nabladev.com:email,nabladev.com:dkim,nabladev.com:mid,embeddedts.com:email]

On 4/24/26 9:25 PM, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits, moving the 3 bytes to a single message.
> 
> This change was tested on real TSC2046 and ADS7843 controllers,
> but not the XPT2046 the workaround was originally created for.
> Confirming that the original modification to clear the command
> register does not impact either real controller.
> 
> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> Cc: stable@vger.kernel.org
> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
Tested-by: Marek Vasut <marex@nabladev.com> # XPT2046

