Return-Path: <stable+bounces-253449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOLFB+WRDmq8AAYAu9opvQ
	(envelope-from <stable+bounces-253449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:02:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEAA59EEC6
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8003027958
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0436CDE9;
	Thu, 21 May 2026 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="atBJk9hP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4503321AA
	for <stable@vger.kernel.org>; Thu, 21 May 2026 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339690; cv=none; b=rRFoeQq2w/M1dis/NRoIUaYSPmlsArS9sdGvGLwqbhXruE53G6k6p/pVQvuSFLtu1rYvP801/hwvWJBsbmUVVD6Iaui6GBhEClKOlf7wU6MRG4hLrAF242UMdYpCOWlTOqEofi/VreARd7e1Ifts9vbTizCRgj20xRu1kQ38Pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339690; c=relaxed/simple;
	bh=iVLb5e1ifsXgBUkhpZ1VHH+Nx2xXMNQ3qtSGYR82lwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1LbjGxWG4GQwpisIoMKn+/MEx+5GDEfRlgi+2kz0HHa2ZT0ucTTXztiUpHF0MQvUc3x2sbxc0CHKi3UjkA4L8UIRy/4j/KtpndkO+jt5CgSBO/Nq8gloeQiiow8y3+LToubFVjAOoCuJlZSC9fyNfFvM8gVuqrwx25yC6xFxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=atBJk9hP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so57549085ad.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 22:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779339686; x=1779944486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvJuHVv9eiYWj3ZSTMQfkj6w3gQGBBgxZXCsxd2MBno=;
        b=atBJk9hPCkjE15Fuzo2k62aG/L5W5EjuiRNsxOPYObo3YKqK2qnn9OO+x4GvbP3Qfr
         3NjBslILg7jHOjLu3FhEM6XHOA+fkHwJUh6MQ4Xyt/Jr8dpPNS2GpdDnK9j+oUmeh3jt
         QpWUNIJiYA3KwDpX9/+63VI3LBVQii30OSGjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779339686; x=1779944486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvJuHVv9eiYWj3ZSTMQfkj6w3gQGBBgxZXCsxd2MBno=;
        b=DaOjsJu6kpQHxNaERYHOLTbZ9YWutM849nJGQ+QhXus34OcyG7xEz6nVVzMEXRqHOf
         CoWN+U4AOvoCYczlm7r4n0/cGC13FR8TDstE08SOPqTTnNRw05Cx3IdrliENzKCGeUCT
         FicXNB7BOpYHcCBxOruQxRHH6wW50inW+s1Dy3UVt33yOCzmQP+e1vk0S+g2dJKqAZtD
         DG6Caj7+A4T4BldP8f+ClftCHKIJnTVjG6uP1skvlch2kojsjNGe0Iu/Id57ZOpcaBje
         QDYFcIzgpaqDqElvEfRq3YdyTx4zwsIrniH5E+J2XFWyzJzLiPz53lBkM6X1Xyzfmzuo
         U11A==
X-Forwarded-Encrypted: i=1; AFNElJ+zfxqdbaMMkwa8R0x7AyOG+l22EVJeTUm8YPY+0XUBSP5mP/ebJPkefc+NObFqzJb8SbPjDpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqLkKbJuvz7gWmChT1mdaLtHlRxv7NHLjU8ILWxEZqVEBLtPM
	I+jck53fubGWLRqud58pOHdeBZxGFXTUyqVVmbTWLjc+4lFFt2sIGSFY4aynJDhmBw==
X-Gm-Gg: Acq92OGmG8KauOSYq38LeMtAjLKGQ0l0EDfPDsE6q5qQJyEUjvygjAn7IP+FUgad8Wp
	UXsj7EPKNSfzoz+8Hzbaim62jifwLxfoV5Fa8VXTmlEwddfQy8zABf/Q+HKkPM+/siHjisZ91uk
	zxoEZ7PQRdpUdUU6FHyYHGm1haXN7jlh6JrtN7SVZJByGeXUccSullafWrewKZlfPvavS16LqXo
	R21hXygUbxNong1fjBZD4+GpsMwehaFWA4Rjd0UZBQVcBY/UkQI1PqXDTk/1IG8UHtQMfjATA5H
	KHnViOITi4wItPE4mRJtreSPSKv3xF/6Jpp46U6nRkbN5t53a2hIj2XxWjP6uoo70DCM4bDNMK+
	6M1zdDaNqN88YdhJYsCxb/6PEE+8aW2djPiyS7+xd2qH+CDbQ/wI+utiU8w/72OXlGlxILiiGHJ
	ly2ouSHkPE7rU4Om0kYIOhz7pR3aMveoFvlqAyObObXExnjMMF8XSn6+xzzOEVBhw=
X-Received: by 2002:a17:903:4b30:b0:2bd:646b:2ddc with SMTP id d9443c01a7336-2bea32fa53cmr12402805ad.12.1779339686016;
        Wed, 20 May 2026 22:01:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:9e89:7571:583c:e885])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49c9sm242838115ad.49.2026.05.20.22.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:01:25 -0700 (PDT)
Date: Thu, 21 May 2026 14:01:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: ucsi: Check if power role change
 actually happened before handling
Message-ID: <ag6LPTDYc3p-hmOV@google.com>
References: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
 <20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253449-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:url,chromium.org:email,chromium.org:dkim,qtmlabs.xyz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EEAA59EEC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On (26/05/19 18:41), Myrrh Periwinkle wrote:
> The CrOS EC may send a connector status change event with the power
> direction changed flag set even if the power direction hasn't actually
> changed after initiating a SET_PDR command internally [1]. In practice
> this happens on every system suspend due to other changes performed by
> the EC [2][3][4], causing suspend to fail.
> 
> Fix this by checking if the power role change actually happened before
> handling it.
> 
> [1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> [2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> [3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> [4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
> 
> Cc: stable@vger.kernel.org
> Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
> Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>

