Return-Path: <stable+bounces-27166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B10D8768AE
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985131F22C9B
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 16:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266779D1;
	Fri,  8 Mar 2024 16:41:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF077484
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916119; cv=none; b=sL5aCUobLE0pd+rgAYDBbEDSBmDqQL+FOg5g6Pd19RcCF6lSmXhAvDF70fJ25QQGHdBzZquYK2jKWZEcfKryUYloVkCsAbuGfDcCyaTEsABheHOPS+BeiCE9UWwbrGh1/m+y0TsLza5guTda4UcuKgEOrmu9eXo9deez2foO1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916119; c=relaxed/simple;
	bh=5WS6H0F9Lq465k4u2oZfvIqotHDcnyfc712c7JiVYpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A//nmx9ASHnXzsazgzY0hJOw0Yccm34ckBTaZOL4YYSQthrxrjMmYnIGJNl07CLem1fQITRW84Hlnc1O8rnOlIQHPrFtR77Mbv1Aqyzo/xVH9eis4kxfapIY8/HVBGqLOfXEkmyCRIWzuKqtLXcsiOZ6xIwMmKTBYDBayKBdWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ridI0-0003Pq-9I; Fri, 08 Mar 2024 17:41:44 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ridHz-005Afw-J5; Fri, 08 Mar 2024 17:41:43 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ridHz-000Ez1-1i;
	Fri, 08 Mar 2024 17:41:43 +0100
Message-ID: <62dee175d087ca22315f9a27ce9b1f2b6f7f032d.camel@pengutronix.de>
Subject: Re: [PATCH 5/8] drm/imx/ipuv3: do not return negative values from
 .get_modes()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Date: Fri, 08 Mar 2024 17:41:43 +0100
In-Reply-To: <311f6eec96d47949b16a670529f4d89fcd97aefa.1709913674.git.jani.nikula@intel.com>
References: <cover.1709913674.git.jani.nikula@intel.com>
	 <311f6eec96d47949b16a670529f4d89fcd97aefa.1709913674.git.jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Fr, 2024-03-08 at 18:03 +0200, Jani Nikula wrote:
> The .get_modes() hooks aren't supposed to return negative error
> codes. Return 0 for no modes, whatever the reason.
>=20
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

