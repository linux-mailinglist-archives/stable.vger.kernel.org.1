Return-Path: <stable+bounces-59253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43206930BB1
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 22:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F73280CD5
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895413CFBB;
	Sun, 14 Jul 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHdGE0Na"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96118AED;
	Sun, 14 Jul 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720990500; cv=none; b=I82DWussEbXdmSQ1iqI8Z90OMee+pU2bVPFYHLq91RbHtAoCgWhDAWUUQ/a58UyFeSECa+svXv59cSQCx3uSVvQJp7BbRAOXkwP5snwIhxQTGebBNopBbdpERl7cftSrJJzxrTEwrvpR3mP9ezZyp4CyfD55Ye3sUaWbz7f2chE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720990500; c=relaxed/simple;
	bh=W1yqfKj+E6sNKafGXp4QFzyomqwKN4BP4CSrNMWT8xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzrF5cIOfmDaObLsobPFjiRchkJePJU5IqGFX0NAutlIDrOOUGkyJJQmqKv52gg2yKsksWVNNRmshT+X34ym5nNA01VOFs4HlchayqRhR0PsxBjEMJ41RAVLFvkAvo5aqf3xPtUBxRCKBv+lS0SPGrjMwMFYIvNGZJkzlcLfMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHdGE0Na; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so42383111fa.0;
        Sun, 14 Jul 2024 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720990497; x=1721595297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4v9yh3TKbyCiRcM0Hm0vfZMcOoFanDFliV++pw3Igk=;
        b=bHdGE0NaBi/j4iM4lP0AF2ePGdREzPL7i1PuKne6MsS6P37Mt8apM0VMOqyqX1WiAt
         Qi3ybwIC9MnSwtc7IBStn2d7E+kmFQq0p3VCbWa1G3o+qJOIj4vKwbpJgxd25EJ4oefn
         y+wS7iHKf3gEkyVFIsv/1vIW5RKrxxt/QCVYhFdKLN34XENk8lHQtZVxSxq0Nq7WHe+S
         QX2pmIZyuZQddAjxETtJ4Wog2jIR7h6FAoh6Zox7gTeVT8mH5B/9qKXTIc1jz7kGvREN
         VRkQ0CPT0WXy6vhRBNNkPJ6Jh4PsP6hcTm1M5e/CROlBM04FfUEuMkPVmALCjyVLnRyV
         0/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720990497; x=1721595297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4v9yh3TKbyCiRcM0Hm0vfZMcOoFanDFliV++pw3Igk=;
        b=T/EUQUQ/2nfPHPJPP+yxcB7Oa0rKwtZIxdu6LITxqqZCeFa09C4Zg/efI8eX/fclo0
         kDKEpkuxD/FOHfUUa0I6ndTzcgaGuOfuqtmZl+DlJONfnLm0pX0mIyJWm29HFr1B/FoN
         hDwl1DCuyNrgKn6RC6vvYgAtxfzU/jwvQuRzW2bO5OYfQxexUKJYaxOgNkIDYX9mcR7/
         QvvpXFuIq+03JHkp21z7qEsph6lrgLkyGmTt2PkOv6YZzjV/uVvQ0rD/iOR1nc1shFSL
         +iaRFJ2vRJsSXP/C0SQ7KNHOMGVsG4pqTVveJwojsJMRtTVx+lFCXt/ztUoaZ2qer/lQ
         JFng==
X-Forwarded-Encrypted: i=1; AJvYcCXxmrZm37KlriEuh9PshRFuADgF7Y5h5k23Qd+was0/ZdfkFvYtIwmQ/u0dS1jpcsOMKHshklcoRe5wkRqZiVdwrF2nWcViuiGM1mcXuqpDYkJ/c16994NBhtkWdgmsrPxa6SyeaN1QYR2auXiEKju5bTw2HQ3gjMEW6p0vuMfF
X-Gm-Message-State: AOJu0YyovwyqjyqRetxoeEhX7JCu1jixp0wuegG+vIOO3c6T26maESwa
	EL6W501tlKg65HleZp6eIzTd6n6+srYfVv5lm5C+e5hiB8RWJDlbXwttA73t
X-Google-Smtp-Source: AGHT+IE6umD2PQY9dYePZFeiMEylR7CcDejrl5iUvXUweEKTMdaVp6IvP25oegFRXqF9D7PS4vK9PA==
X-Received: by 2002:a2e:880a:0:b0:2eb:e258:717f with SMTP id 38308e7fff4ca-2eeb318a0ecmr114034771fa.42.1720990496888;
        Sun, 14 Jul 2024 13:54:56 -0700 (PDT)
Received: from foxbook (bip217.neoplus.adsl.tpnet.pl. [83.28.131.217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a770cesm2529395a12.19.2024.07.14.13.54.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 Jul 2024 13:54:56 -0700 (PDT)
Date: Sun, 14 Jul 2024 22:54:51 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Tim Lewis <elatllat@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
 niklas.neronin@linux.intel.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <20240714225451.193914d1@foxbook>
In-Reply-To: <CA+3zgmtwunPaLbKygi0y+XY7XUd2cBGVP8So8MXxK_1pOX3miQ@mail.gmail.com>
References: <CA+3zgmsCgQs_LVV6fOwu3v2t_Vd=C3Wrv9QrbNpsmMq4RD=ZoQ@mail.gmail.com>
	<20240714173043.668756e4@foxbook>
	<ZpP3RU-MKb4pMmZH@eldamar.lan>
	<CA+3zgmtwunPaLbKygi0y+XY7XUd2cBGVP8So8MXxK_1pOX3miQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > Not on 6.1.y:
>     drivers/usb/host/xhci-ring.c:2644:31: error: ~@~Xir~@~Y undeclared
> (first use in this fuunction); did you mean ~@~Xidr~@~Y?
>     2644 |                 inc_deq(xhci, ir->event_ring);
Sorry, I didn't notice that v6.1 is different. You need this instead:

  inc_deq(xhci, xhci->event_ring);

Another refactor interfering with backporting :(

