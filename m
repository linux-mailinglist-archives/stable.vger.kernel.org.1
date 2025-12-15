Return-Path: <stable+bounces-201019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8CFCBD4B2
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10DAE30084D2
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574E314B86;
	Mon, 15 Dec 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Y6qIWE3W"
X-Original-To: stable@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B429B777;
	Mon, 15 Dec 2025 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792586; cv=none; b=B/WCkShmALLZz95OZKLla0DwMS6yz+2fn88KCp/h00VCXVS/mx9ImD6W8Tq2jIvHR+CQaJ/c1u1izgbPc02mo3eWvPLuH93HDEtfp51HgmKb8kg7vr//Np7IjwzBdUnMr2a+/ipFzdbp3WJfO76zl7u/nwPjrzOPBtUyVQL143Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792586; c=relaxed/simple;
	bh=lSNbYAu8lkoVN+OFRFDSmjK26Hg0H3/ilQ5CXzMzMYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VISSeJD/FeC3JZiqW2JSfKwOkD2hshgpErto7ZcRjZ73N0pDIBvAlh9YvKSf3UMIfmmzgUzQLl0qdyCKXygOLjCFl33a7wTBsg0wLlwvODyM8lwwYkHXwv4G0uMvsXrbOefe1fcSJ+TnhX+Ny4ZA6eCnQ2E6e5+dTfJOyinhG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Y6qIWE3W; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42757417C1;
	Mon, 15 Dec 2025 10:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1765792572; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TzFLaCh6dPkm5xGJzF1dzK9jvaJm/GhhTTcNtMo0sIU=;
	b=Y6qIWE3WFN8ROcTe4WexoFaNeRQvqBJejqVpY5RGJUrbawF6gd/GEoS0ZLZKUzIVeyc7fS
	kvJrodY5xzmsIQOVglR7DE/U+2uPsl6JnOX2KlaapsBBGHwTTbDjJh++mpviUry1i9fk1J
	1//JA8uNpNkukDZhBC6urOKRVxZCR4XIGwNjwgziva1Ye+Mgy+WDuu0zdGSJle540cd4U4
	NkgyH+4LldtaVXb/rFEl7wF4JluyzFybn/6xwjlcvSBuzmf4k5d2PosPZ+Ne0DfVb+nChg
	R3HmHxppFqAbPOMzYPQaT7WbLXrZNZt2pUyl8Vhos0JLXyDEbIm/FAfJIAEJiQ==
From: Dragan Simic <dsimic@manjaro.org>
To: arnaud.ferraris@collabora.com
Cc: badhri@google.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	m.grzeschik@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] tcpm: allow looking for role_sw device in the main node
Date: Mon, 15 Dec 2025 10:55:52 +0100
Message-Id: <20251215095552.3240340-1-dsimic@manjaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251127-fix-ppp-power-v1-1-52cdd74c0ee6@collabora.com>
References: <20251127-fix-ppp-power-v1-1-52cdd74c0ee6@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Arnaud,

Thanks for this patch!  Please, see some comments below.

On Thu, 27 Nov 2025 15:04:15 +0100, Arnaud Ferraris <arnaud.ferraris@collabora.com> wrote:
> When ports are defined in the tcpc main node, fwnode_usb_role_switch_get
> returns an error, meaning usb_role_switch_get (which would succeed)
> never gets a chance to run as port->role_sw isn't NULL, causing a
> regression on devices where this is the case.
> 
> Fix this by turning the NULL check into IS_ERR_OR_NULL, so
> usb_role_switch_get can actually run and the device get properly probed.

It's usual to denote functions by always appending a pair of braces
to their names, so we'd have "fwnode_usb_role_switch_get()" in the
patch description above, for example.

> Fixes: 2d8713f807a4 ("tcpm: switch check for role_sw device with fw_node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index cc78770509dbc..37698204d48d2 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7877,7 +7877,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	port->partner_desc.identity = &port->partner_ident;
>  
>  	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
> -	if (!port->role_sw)
> +	if (IS_ERR_OR_NULL(port->role_sw))
>  		port->role_sw = usb_role_switch_get(port->dev);
>  	if (IS_ERR(port->role_sw)) {
>  		err = PTR_ERR(port->role_sw);

This is looking good to me.  The usb_role_switch_is_parent() function,
invoked by fwnode_usb_role_switch_get(), can return -EPROBE_DEFER, so
using IS_ERR_OR_NULL() is the way to go.  It's already used in the
fwnode_usb_role_switch_get() function itself for checking against error
conditions, which solidifies this as a proper regression fix.

With the above-mentioned nitpicks addressed, please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

