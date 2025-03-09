Return-Path: <stable+bounces-121628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637AA58862
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 22:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BB83A4D47
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1621D3ED;
	Sun,  9 Mar 2025 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpGdtMr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19212C499
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741554567; cv=none; b=c8aIDvxpNmHc41nrcV5nocuOP5+wrABh+heSExQ9bVsS7BCc8sWXxdE7tDL3iF+HUB3ykTdi7IyI2h9DajM7DmLHYpN6JEkn2PV1HV8epGddC4bcYyJcKVvQTd80doOI9dDTUW5bRqc/QYrhAfxPiaMiAn2cy9iqiqKQhvSsHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741554567; c=relaxed/simple;
	bh=4MozytYEjw9xLscPwBf12j0oqj3D3Y6Jlo34I03d3Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atNJIhut+1tpxqNwPu3S3DB4W4wXVSVCBkBoZ9tQoORKBO7GSe8THwZUm+bqtNH7WDQd4463iq6VWQvz2aE1GHPNhzZGoTbaQNJf9of2p8V0SK57NYKzxKYHmdxVf0WJQQi1/4i7V6h/y+3JrjL5FbAAgNKQAdGFluBE1oKllDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpGdtMr4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec111762bso683380866b.2
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741554564; x=1742159364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsBRlcazmRwBGJXClWS6FOeEYoB3awN+z7M9OAzIMWk=;
        b=kpGdtMr4wrqu2pmELJYvHHt92Ve5H5Sr4V7nWMybwC4zifA3F5+YZ9JRJ/PpZQHdtl
         jIED19F9/BXDJFjCoKBDTvKEGWTX+sSMFnEtDdeN3d5QS+HZzbZGRgxHhOSgpaTUT0AO
         OcJeA5+ZiDmEgkFWDmMw/SSFF1B0sPoSnaEKwZIPjl8qgGq7Ydh0lmINC1AlNeu53FGn
         oKMkqkZl3RqFBjJV4oyaj69qzmN8SRK7nkdy0Y6PkUwZnyuVGB0aGFivuolUttL4sPoE
         Aqea95yNs96x+v4KyPIhxyuW67spTPyAYQJEvkx6iWwqk9wzyNn1uoXgXDl+v9wZW9ie
         TtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741554564; x=1742159364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsBRlcazmRwBGJXClWS6FOeEYoB3awN+z7M9OAzIMWk=;
        b=IFCPum08udgwgXJBW9FLF3/v6D35oQXWWgy6NRCn9FtoHsvHPNu53Hll23yHP6Sa2y
         M7Fkm00wxLm6/DNuiquRP1LO30an+4Yi+aavYHKoIqsero1qIGNS60qb3w3f0a9UG1bS
         bWkqA0rWimZowM6k5dw0Q7aXdRIUMVlxZNVEs2kyUkIagi4oV5nVJ4TBL5h1NkespXpm
         xXEAmGFWvwlTrOCScXIRbFvdseZyU+Sfb+wS/ASZV6vGVfeBL0vEZtSKaQlj0bk+QotD
         A342yQ3MTK8QG18YSSy5I1LIggqpurTbUxJlpskaY2oH48YzzE1UK2v26v3bn8CxvaiC
         At4w==
X-Forwarded-Encrypted: i=1; AJvYcCXWuFdvROyycl4x1rd2CB2D4IDAQuel47mthWuhLpZcH0fZlkCBivz14Jmx1v7uGyydfnzLX5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF65PHTtZVIWxEnNmhzQ+AjaiocXgS4MhlbHix/RYfAPdhfb7O
	ujA4TTEtdeu/sWPWac9+qlTrz3pBc6KdpKjUcnHRIu9vDWoLMA5wAYNZvA==
X-Gm-Gg: ASbGncs9xHqTqE3KAxAua17wpbN5S7PIxRVZIL8zBY5JAAynmy1nuqK7o75FrNOp4vf
	2YrZSMrvT6BbYMywB4QklSCuHxJ6sCI/mf74G7yDJ1Q2pcOsAG/kGS5VAO4+6+598s7zna7WYmI
	3O05kdFtcoYH/nLvAeh9dGi51eiK7SBKUvGL2yYjlZ8GnXkn8bePVebUslfjmdFSVDJiCblQmQM
	mq4nMr9sjvzgNmWIdI+uYo8LYGnN30jjmRGFC8k+R4isLnthb1yy7I+QIOzkE+OBseTKaozQ47z
	nxkbVIQaUFk/jp7NJZVQbMFdoLQEpVNOQpidQVuP+5f9ht1JKsM82jlCIaT3Pg==
X-Google-Smtp-Source: AGHT+IGFjPW7lvvLyRA0ufrygcpCySVSdCXT+7gfdXWHKh8zFjW5tpIsxgvgzMQcUt0cql7FREoXIg==
X-Received: by 2002:a17:907:15c1:b0:ac2:a10b:fe3 with SMTP id a640c23a62f3a-ac2a10b1313mr111299866b.56.1741554563235;
        Sun, 09 Mar 2025 14:09:23 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac27d922c58sm274376766b.40.2025.03.09.14.09.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Mar 2025 14:09:22 -0700 (PDT)
Date: Sun, 9 Mar 2025 22:09:18 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: <gregkh@linuxfoundation.org>
Cc: mathias.nyman@linux.intel.com, <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] usb: xhci: Enable the TRB overfetch
 quirk on VIA VL805" failed to apply to 5.15-stable tree
Message-ID: <20250309220918.26951f03@foxbook>
In-Reply-To: <2025030900-slaw-onstage-6b47@gregkh>
References: <2025030900-slaw-onstage-6b47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Mar 2025 21:22:00 +0100, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git
> commit id to <stable@vger.kernel.org>.

Hi Greg,

For 5.15 and later, the sole conflict appears to be

0309ed83791c xhci: pci: Fix indentation in the PCI device ID definitions


Would you still like a backport, or pull this small whitespace cleanup
to keep PCI IDs in sync with mainline?

Michal


> ------------------ original commit in Linus's tree ------------------
> 
> From c133ec0e5717868c9967fa3df92a55e537b1aead Mon Sep 17 00:00:00 2001
> From: Michal Pecio <michal.pecio@gmail.com>
> Date: Tue, 25 Feb 2025 11:59:27 +0200
> Subject: [PATCH] usb: xhci: Enable the TRB overfetch quirk on VIA
> VL805

