Return-Path: <stable+bounces-238282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGcSEmyr4Gm8kgAAu9opvQ
	(envelope-from <stable+bounces-238282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:27:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99B640C588
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A492231789A1
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923303921D7;
	Thu, 16 Apr 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRRXTGCY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957B38911B
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331302; cv=none; b=qY+/SBDs6jftI9y//18YUjPUZ4fhznRBZQKkZpE0Bp+70L3y/knVMd+AwIM5Mn8MsFZspgY2jQ4ekA0CTPWc02uOmaex98buTGvSapMZHUZUUKDGkCxjuD2cggGz6VFnQFz9aY6FFnq+nAhjIbkOVYuSoTm5o95a1CUaaJCUiLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331302; c=relaxed/simple;
	bh=e57nDf5tJn8pmI6DL/EqYWuRO62Bk6bXtzpM6Y09P7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzI0yCZg7p0Rz8sU3s/1VbBX+ufFbi2iohQJOWuB+oFweVLDO4/PCSxF5liuHUqwll2ZfC6bD/mVJ0wsqFjxhg1adyvtM1mAYoToYBPHSOe3Z1EyOUYbsvN4mI6bUQpTBYyiw9X4byYEO3OlGSeXDtEcoetfBuZhQgRwdjgwjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRRXTGCY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so72807105e9.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331299; x=1776936099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ4uoEfFYWjSIYr4YjUAeTcpQFLjt1x9S0J2zuFA2jc=;
        b=nRRXTGCYpfFZ+ZvzXtRXgsrWHh3rj9RLqWr2VHxfRBp3i4MpsB9gW+YgY+i19AivpO
         jyW3N97NdNyl5HMED7SrNf4taVqZCiqO9Msm9RQx/GgATGKZXlLEyUwigDul0Ulpq5Tv
         BDK6qdMYE80iImRH+BP4mSlDiI2fQ8N6vuMa2OY3VDb1T5fojSNEPuSiUxEyKiiFkCZj
         3bJAzAW+XXhC8cnwFQet78pse9KGlbAGlsxj76wqkSVAF1/wuW6fQezr5mp0W/sYTpzs
         zMHpoMkvtYUjWaCr7DZxocROnPKBJGjcRIgeGEjwLQilvoF/xiKGGpFibZuvf/754Eeo
         w07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331299; x=1776936099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lJ4uoEfFYWjSIYr4YjUAeTcpQFLjt1x9S0J2zuFA2jc=;
        b=bQJrRgQpjLzGRKMjQDoxWmR2Vg+5GLrFPB1lUfASrY02jsqkIJmKYLaqSepR4wwh0L
         UFuehQ/keDEzy6mhfdQTcsh2RPrsdQ67C0NGVncG5fkUin+h6vQ2HONJjujAxWred4hp
         POPy1AjyzTMLoVwqoyjZFp19AA0sSmseEYJI5nsvvSIkW6wpi9RkV6IE5dPlVGdK0l8t
         YQgziOe3pD3vH6qva+fGSR0Ro/3ytNEhetKmiYGaEUHcJUQ/ya+7Ih+pR4r/JEOSkxIG
         3asUWG4DInMXhUzugJKbQvB2szfjRkV4zq5CQvks8C4++xhG9K49pkmBSM9hL25eTNCc
         5rsw==
X-Forwarded-Encrypted: i=1; AFNElJ9oRn2Aydb9VLsJyWjGEc3gK+IlBAp4ACIHEtQGJF9Od8kO2xW6OgQCILXeC0pPlyZBdD9aaGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SzC9Cul2YtjitBEV+XJs3lrqzBlltyU33oGZHVAQp2OVEj8h
	2onzp6pTiXDjIuuctF2arKbE/F4YnfdIS8K9J9qW2prRcgLT6U0Y6afc
X-Gm-Gg: AeBDiev4yjoDneH0tjFfv+YPvlIewstMeqjUo1upeFo0RJ9aEbyXdk8W8s7z0XJU2CW
	oSMV+g35lfVAf5yPPJZktFBVJZwINkkCYZA4hxGQF8lw9YfNVFFNQNrlEnnf8eVcTGg9fPfAs2N
	FVViV3QXatQRkekWL12jk5uYpE3GV6vdy0NzlOzsMbNQQXuyDl8sLejogryUSTzr2RZr3oBmxvV
	FiXWdBWnElmmb6I3zb9TTD0qjEQ7fpSEJee2WCsHGWV9b4j3o9O6hwvpSxQ5KEGOhbRwYW/v/UT
	K3LinMZo6KBUswlSZ+sjjaFsQy0MoqKM5Idns++5iAp7fDV1/45ncO3xOc2jBmJGGNABhEsfgH7
	oWBkeFQkUNGaQ9sU7CCXtTgo5RsjoxMVnN97H8t9CC+B6jMXv0Ybf5N9ajNeCvRt69ypNOsrlis
	MVq25X1R/reIyIr2qRBw/RMY3KZ+171qIvsCuQSztouxmLzst2Et0EfhxuF6NxK24F
X-Received: by 2002:a05:600c:8b6d:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-488d688209dmr322411545e9.25.1776331299391;
        Thu, 16 Apr 2026 02:21:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d65asm12155424f8f.4.2026.04.16.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:21:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:21:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] ax25: fix OOB read after address header strip in
 ax25_rcv()
Message-ID: <20260416102137.4e7264c4@pumpkin>
In-Reply-To: <69e07601.c80a0220.2f9024.1e0b@mx.google.com>
References: <20260415063654.3831353-1-ashutoshdesai993@gmail.com>
	<20260415085921.757b48a0@pumpkin>
	<69e07601.c80a0220.2f9024.1e0b@mx.google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238282-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D99B640C588
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 22:39:13 -0700 (PDT)
Ashutosh Desai <ashutoshdesai993@gmail.com> wrote:

> On Wed, 15 Apr 2026 08:59:21 +0100, David Laight wrote:
> > Is it just worth linearising the skb on entry to all this code?  
> 
> Thanks for the feedback, David.
> 
> skb_linearize() on entry is a nice idea for simplifying sanity checks
> overall, but it wouldn't fix this particular bug on its own - the issue
> is skb->len dropping to zero after skb_pull(), not non-linear data. We'd
> still need a length check regardless. pskb_may_pull(skb, 2) handles both
> in one call.

The skb->len >= 2 check will be a lot cheaper/smaller.

> That said, linearizing on entry to ax25_rcv() as a cleanup to simplify
> future checks sounds worthwhile - happy to send that as a separate
> net-next patch.

I think you proposed just checking skb->len in an earlier version
and it was pointed out that the skb may not be linear.
So perhaps linearize as part of this fix and leave the simplifcation
of any other checks to later.

	David

