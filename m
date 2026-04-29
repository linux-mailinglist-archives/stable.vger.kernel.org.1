Return-Path: <stable+bounces-241871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB+tNN7u8WmulgEAu9opvQ
	(envelope-from <stable+bounces-241871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:43:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567AA493AF7
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CAB3306D0E3
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79CF3F2101;
	Wed, 29 Apr 2026 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n5XYwwFy"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C43EF66B
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777462951; cv=none; b=CGZ+W4RAwIwqqofZmUgDq8YqdLCxLbb9Utia6ou7EV2b+U5Pp1dz/uWaaHggEVsegz7llhycfKZ4bR5jiTGrFG1qJ5YNJQe5wJtlzKcp00lyc5LOavZGVrFFq7LLI8NiLXGKqdp+K2fozQcdlp1Kje14gpQBxeUCMIyilbbriqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777462951; c=relaxed/simple;
	bh=anO7aaWdLJW9UNfbjRUxW3fts3q/GaVgmDjzm3sUBiw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RK/uGQZwQ84fI5HZWzzuDRBglx19Ohx+Xq3PKTlTEj6z25f+B+3SEXezllpJsGRQ6YiKrWGV9dzM20d2HLGbUSA1YZsC75uNKQRpwl/a9k1cIoaOTjHuppretVfhw7STh5oyapL09e0yXOjAeRvx/js1i0zJhRcyjhpino9xYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n5XYwwFy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B03121A33E7;
	Wed, 29 Apr 2026 11:42:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83FF8601DF;
	Wed, 29 Apr 2026 11:42:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64DC710728991;
	Wed, 29 Apr 2026 13:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777462943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=anO7aaWdLJW9UNfbjRUxW3fts3q/GaVgmDjzm3sUBiw=;
	b=n5XYwwFy2JBRaWNCzH23eSoWSmDz9W3kO1w+FyeBbMb+KFFSZdL/o7wLcMGxf/kg7e2SLW
	XkVaLX2FhWJnsSESYhbs6X5W24ciSh8rCRXzyU2A/LRg/MvhK5ztYQHbPuWHdsySn5yQUr
	QG9Txq5sV/TbqbkKa0Ah8SFYxRUFJ8InyzYo16JQiCrPhKtYGdZ5AKZQcH8wB8tU7ku5bO
	p3r3rX3/McHTW8GXBx2crkQi2YSO4bFXOOBhVoXEsZIPh8k3a3eBQOY/0fFgaLdBSRnscJ
	QDzTb3NJfxoZ6fjAsgQ4SmhYTcQ51rXj9XGF3uawNrVH+wljRuPHJx7hJbQXPQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:42:20 +0200
Message-Id: <DI5M0YBPLHZC.PKAWCS7KX9XG@bootlin.com>
Subject: Re: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda
 component_add fails
Cc: <stable@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 567AA493AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241871-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,foss.st.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
>
> Check the return value of devm_drm_bridge_add().
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: d28726efc637 ("drm/sti: hda: add bridge before attaching")
> Cc: stable@vger.kernel.org

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

