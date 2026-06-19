Return-Path: <stable+bounces-267445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wHnoG9ioNWpj2gYAu9opvQ
	(envelope-from <stable+bounces-267445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:38:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D106A7AA9
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 22:38:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267445-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267445-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806DE3055831
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D93B9D8C;
	Fri, 19 Jun 2026 20:38:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C72330B30;
	Fri, 19 Jun 2026 20:38:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901519; cv=none; b=OgUi/rKaVuCpniqclDvTx7ehms/aDsyomoHpFEMMfLPePB8z4YbEhfRxXXsD7NzM7IoOnvREnLfRIPdJUVxidRgT2v0HqwenNtxvGOH9DMfhICFA4SuiQkxgs6KbL715Orsdb32SAKme3Edcttun20n3+iHbySjZsHsmwoos2PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901519; c=relaxed/simple;
	bh=kKmXsHMakcX+AcUV5b9G2IEP7NtVx3VprW8uWnQOD1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1FlLcPnVesf3JwKZCSjp2LusSFfKeLGk7cqzMZd1bWLnGTiOA76Ef2Pl7JxTkUs3dKceNK0Yj4967FT+ak4HkJ6XNNUDmC5w02pby5gNeID12rJSml2LwK28A+2FsaiVST99B4T3P8kTa4ESC2YjGwDmuJZ6BoQcsOZ30cGubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 54EBAC0CC3;
	Fri, 19 Jun 2026 22:30:08 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Fri, 19 Jun 2026 22:29:42 +0200
Message-ID: <178190096345.793016.14917236922404403238.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:miquel.raynal@bootlin.com,m:shital.gandhi45@gmail.com,m:stefan@datenfreihafen.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,m:alexaring@gmail.com,m:shitalgandhi45@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[datenfreihafen.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FORGED_SENDER(0.00)[stefan@datenfreihafen.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-267445-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan@datenfreihafen.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,datenfreihafen.org:mid,datenfreihafen.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01D106A7AA9

Hello Shitalkumar Gandhi.

On Tue, 21 Apr 2026 13:02:59 +0530, Shitalkumar Gandhi wrote:
> ca8210_spi_transfer() allocates cas_ctl with kzalloc_obj(GFP_ATOMIC)
> and relies entirely on the SPI completion callback
> ca8210_spi_transfer_complete() to free it.
> 
> The spi_async() API only invokes the completion callback on successful
> submission.  On failure it returns a negative error code without ever
> queuing the callback, which leaves cas_ctl and its embedded spi_message
> and spi_transfer orphaned.  Every kfree(cas_ctl) in the driver is
> inside the completion callback, so there is no other reclamation path.
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
      https://git.kernel.org/wpan/wpan-next/c/e09390e439bd

regards,
Stefan Schmidt

