Return-Path: <stable+bounces-227445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCecJjn2vGkt5AIAu9opvQ
	(envelope-from <stable+bounces-227445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:24:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 099352D6908
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6618E304030A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132FF35BDA5;
	Fri, 20 Mar 2026 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyGmVNat"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E301346AF0
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991448; cv=none; b=aylWE0sBVXgjcOmfrlMZSx8zXHzKWZuHYptMV6Sa1Qpov7lFZYqqfgqFWzEyqwTX4BYc6B/xUk9wWjan1iWHkb0ig/3am78aIAjthKy9mzAi4qU4y9teFVdT7OJsU0OEV4jsqy81Q1IVoK8QL+eZOBXk3zzlhJ0uF1Ap+pxmBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991448; c=relaxed/simple;
	bh=qjVAP3D5ukSmU1NR06WySqsEvr0AT+fp0hG8taafxHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvaS6fEgrzAGBNAOx8rCsiJMPejNxpLdoknEvisDuKjXnDQjuw2aCknzGUakZJsuQztBGwdsh/l4lqBV2DaId5scyvIVI14CqQdvnY1MzzUItPBb99akjnmChpVrhVpyTmoYEWvfqPjgSj68SaEk/CvXhAnE1RMrl0GnCs2eEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyGmVNat; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2493614eec.0
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773991446; x=1774596246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vhjnmqld50oC2rRba79g88YmK/X0qsKWiFWVPW1+Wd0=;
        b=AyGmVNatXeAqkVhueG7oBVPxO0k0x0ZlWbFVOUg8ZkKwzO5N7F4w9aXtqrsIDAjLKf
         mjWulaG/RMrdQqeVW6S3AF5veikcebSDHJRuhTyazKldC3Fk3c7dG20jgaKU7SYvs7xJ
         KXI+/s7BymqfmCMsODPuZFzg5mwsGj6GoDnPv3LIFtQwIgdPbcRtjSgH+kNt0vPjIwRu
         gfH7PpcYxzp15s9KR/YcXtIX0/cQz9JNUYfgjnD4VRBFzk8L6TTKV57zJFs98+qaO/f8
         vg0clz4trRb6MtH+g4q8B1fAbcdpb/8XfU24P/zGRS/5yLWNbZOYa8jmhal+eBwW7JKx
         840Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991446; x=1774596246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhjnmqld50oC2rRba79g88YmK/X0qsKWiFWVPW1+Wd0=;
        b=K1eC6bzm8OaX5gq+qMB44jGbt37FHqQejw09AtMuHueqcdOLrmOT1qpFq7kJgurVRk
         K3DRFCwRNRJPO/G+1v3wo8T0Bvk1QdoIsiFvt3wKbGV1KvDHxo6zOpl76gsn72VWr2Mk
         zdQZiJe6sjS6vk0VXhR9/kgQSSeKztKicWVSqOeVvjkusjYky4rvIoGyx+wghFaTqihk
         X8lZLQz8mxkFZ51o7ZsEMY8MfAn6D/BtohfXGqySKhNyLd7P1F6hkO1Ma+54nY11JXJj
         sAk/pP1nlGgVOgGwUSDo1xUWiZtXZIexCuQVB/R/gOBwjSXpy7VvAuqRf/DDZhv/Y2JB
         bveg==
X-Forwarded-Encrypted: i=1; AJvYcCWJqzBX3YSmCPBi54c6MRKsZ8MWKA4hV7QJTMsoLvhyPkBlwlmP6P/2jKfTbYRZrKDafkWDSBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+T3Qod2ZszQtjuOCLleTT7ZIOj53IZg/OlKOtgMNVexnrPpK
	0GX9HX7cAhSVHWnXpVbcOiOqZ2sOcd0gNf04XuYMrrWkm8j4uBy0u+jT
X-Gm-Gg: ATEYQzyMVGIhnZrbdCAWA9iBKPZSZ+k52jeE0ZLYTjvoUg7uiUC6aUfJNjXjaO4AAgY
	BvgVxPelH0aQZY4k5r37uqh/EL156oshq8EjWYS8a9iNiEka77Y7kgXWotB8Ypj2PaTHKJSHTLR
	sT4S83/c7tFpp6AITAh+ELgREtBniOE6Bpx7jF4ULQFNNFVBOfPiUGP3+O2SpM5Tq3VikWaUl+2
	UsSRvYcIRmg9irHhU14k+xI28jABWLOBs3RviQywqTNmJ0AVIC32PiMfTOMMDA9+4W4W9nOX9la
	hUqwqTOdOTW7pabFQf7rpabtLByvTW5jJqrVXv5z5xiE1WCgzt2t74NGWExSoB5rIpoA+ydh1nm
	2AQDRocX+S7dOjwJ+wfw6a3q+hgUFhrFxtm+IZNY8JczW2o0LpnzZ3aZVEOjuEWMIFxseGxEZTH
	mdmcbkDP0gtBSpKMza7nRlTw/Tg9ESWr6uK9lyEcb87ecP2A0Uf84javktSr8wep46
X-Received: by 2002:a05:7301:ea9:b0:2c0:d207:5bae with SMTP id 5a478bee46e88-2c1095f236cmr947756eec.9.1773991446044;
        Fri, 20 Mar 2026 00:24:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8c36:d8b0:8e30:aab7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10aefd778sm2906333eec.0.2026.03.20.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:24:05 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:24:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Dirk Behme <dirk.behme@de.bosch.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] Revert "drivers: core: synchronize really_probe()
 and dev_uevent()"
Message-ID: <abzxGvEOqtoTiya4@google.com>
References: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
 <75F8FAD9-964A-4F87-8D71-AEF166D9E10D@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75F8FAD9-964A-4F87-8D71-AEF166D9E10D@live.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[live.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 099352D6908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:16:33AM +0000, Aditya Garg wrote:
> 
> 
> > On 11 Mar 2025, at 10:54 AM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0.
> > 
> > Probing a device can take arbitrary long time. In the field we observed
> > that, for example, probing a bad micro-SD cards in an external USB card
> > reader (or maybe cards were good but cables were flaky) sometimes takes
> > longer than 2 minutes due to multiple retries at various levels of the
> > stack. We can not block uevent_show() method for that long because udev
> > is reading that attribute very often and that blocks udev and interferes
> > with booting of the system.
> > 
> > The change that introduced locking was concerned with dev_uevent()
> > racing with unbinding the driver. However we can handle it without
> > locking (which will be done in subsequent patch).
> > 
> > There was also claim that synchronization with probe() is needed to
> > properly load USB drivers, however this is a red herring: the change
> > adding the lock was introduced in May of last year and USB loading and
> > probing worked properly for many years before that.
> > 
> > Revert the harmful locking.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> 
> Hi
> 

> For sometime users of the appletbdrm driver used for Touch Bar support
> on T2 Macs
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/tiny/appletbdrm.c?h=v7.0-rc4)
> have been facing a regression that caused the Touch Bar to no longer
> work on resume. A person tried to bisect and this commit was found to
> be the reason.
> 
> The person has tried to explain the whole situation in this GitHub
> issue:
> https://github.com/t2linux/wiki/issues/635#issuecomment-4092907335
> 
> And this seems to be the most plausible explanation:
> https://github.com/t2linux/wiki/issues/635#issuecomment-4071720148

Hi,

I believe the person who did the root cause analysis told exactly how to
fix the issue. Your driver should not assume that the device is in given
configuration and if the device needs to be transitioned into particular
configuration which given timing it is on your driver to implement it.

It appears you have rule that triggers on "ADD" event for the device to
not only load the driver, but also toggle the configuration, and relied
on it be executed only after initial probe (that sets configuration 0)
is done. This is not supported and should not be expected to work. There
are dedicated "bind" and "unbind" events to signal when a device binds
or unbinds from a driver, but again, the proper fix is actually in your
driver's probe to configure the device properly.

Thanks.

-- 
Dmitry

