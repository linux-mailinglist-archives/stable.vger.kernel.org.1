Return-Path: <stable+bounces-244092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CebCM3Q+WlHEQMAu9opvQ
	(envelope-from <stable+bounces-244092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:13:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E84CC46C
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6FAA323C0FE
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF738237F;
	Tue,  5 May 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="S9TbMjId"
X-Original-To: stable@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E493845B3;
	Tue,  5 May 2026 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777978697; cv=none; b=PqCmxDFjVmHbFWA8slhndDuqvgoxdbNRUEgyzoGT9gXjco4zTF9Cdq777x2+or3Q+R3fxDMdaMS6nXkl4v/9gyN5yAjx3rPf6DSxrocQgzdoDY5EMFyYtIRWeQWAAYgu8lYfHynQKav9FT4UkEfVQLIrSaNFEJIed4Mq0chz5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777978697; c=relaxed/simple;
	bh=5Dy+uqqG81IVVF7jNcyPT96dYqgXe053xO3iZv+ix0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/kkbmtPjUMsJzl/hqyirSZ00lqK12irjDIPvUzPhOfIl9qjdHVOvCcnwkPIU/eyYd9EITC1j/P4dglxQZRFiGVLp7QEg2+h4B6//XIfRaOnUQDZWDgFwGtJrYQ60Sz0eTXD4z1CRyP9J+cdW+AutfvZcgNlbUMB9eXac67kLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=S9TbMjId; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:27a5:0:640:93ca:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 2D79C815C4;
	Tue, 05 May 2026 13:50:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp) with ESMTPSA id VodCBu0SHa60-hOYYrlhz;
	Tue, 05 May 2026 13:50:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1777978232; bh=5Dy+uqqG81IVVF7jNcyPT96dYqgXe053xO3iZv+ix0A=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=S9TbMjIdu0xyA+J55RtRFNNw+iov2WmXcB80m4HiksMcJtA3lToDrkGfzX2+VMkK1
	 aycfj3gb81NP9K9CbCV+I08d/pQL6+/YGpH+16rLEgq1xwQ6fovwoKrRtcP/ydkVxJ
	 vKZ05HxUkBNekDiQAcZIpT6HhitV/MBCu5x/S8hY=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <cc43af47fa75a7fe4bea41fda91dd2e49723243c.camel@yandex.ru>
Subject: Re: [PATCH 6.12] block: fix memory leak in in bio_map_user_iov()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	 <hch@lst.de>, linux-block@vger.kernel.org, lvc-project@linuxtesting.org
Date: Tue, 05 May 2026 13:50:31 +0300
In-Reply-To: <2026050551-rice-cider-db2e@gregkh>
References: <20260505094529.406783-1-dmantipov@yandex.ru>
	 <2026050551-rice-cider-db2e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6E3E84CC46C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[yandex.ru:+];
	FREEMAIL_FROM(0.00)[yandex.ru];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmantipov@yandex.ru,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 2026-05-05 at 11:57 +0200, Greg Kroah-Hartman wrote:

> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.=C2=A0 Please read:
> =C2=A0=C2=A0=C2=A0 https://www.kernel.org/doc/html/latest/process/stable-=
kernel-rules.html
> for how to do this properly.

In this particular case, "it or an equivalent fix must already exist in Lin=
ux
mainline (upstream)" is hardly possible because related stuff under block/
was massively redesigned since them. So I would prefer to wait for feedback
from block subsystem maintainers before doing anything else.

Dmitry

