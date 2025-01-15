Return-Path: <stable+bounces-108662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52749A116DB
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 02:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EDF188A4B7
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 01:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5322D4FD;
	Wed, 15 Jan 2025 01:51:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311023243D;
	Wed, 15 Jan 2025 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905916; cv=none; b=f6D9Vhr3dftDpossHkGHlulPXMRxuV3+JnK9Hmxbn25TS5s8aNZfo2l7VuTtOmcxgMdnr6QZuMpJ7IiP+MagzZKFkVEu8GIv7H28rEkc9uPSMvXOPnMRQR4wwBuS0y+r6H0z3lgiGzF2Z4gCynizQsA8z/8DUmKxxI2JEwDXZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905916; c=relaxed/simple;
	bh=VJWB0V44+S0hgujWr/TPwbO+2mSn75owOsQXSLix5SA=;
	h=From:To:Cc:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JuSu4EKIP1LqWtH2ONm0vkuqeW5les5mCicuh2/W4xBRVUfNUo7bpqOf6kzstnQa/9KWTpQcDt0kjtjfCdhjJJdNqcp0i8QwMQ5Vtu8/nZlj/VIPERXkdG6oHs98ZT7R2aRXvTxcTHTFZEEqwydHSH2FK6Tk5hKKyz4Hyj3chsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one; spf=pass smtp.mailfrom=nom.one; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nom.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nom.one
Received: from 192-184-191-5.static.sonic.net (192-184-191-5.static.sonic.net [192.184.191.5])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPA id 50F1cs9M017786;
	Tue, 14 Jan 2025 17:38:55 -0800
From: Forest <forestix@nom.one>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke fastboot android bootloader utility
Date: Tue, 14 Jan 2025 17:38:54 -0800
Message-ID: <h74eojd2r7t9f9jh3ebt07dlrhh6etqv4q@sonic.net>
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net> <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com> <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net> <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com> <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net> <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
In-Reply-To: <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Sonic-CAuth: UmFuZG9tSVaAmhbZHQzGvqX3ftxBkP4r5hsMGbvvK0R2ZmZApHlHbzNM3uG+P08uyIPX9cAVYO/iN/IRGbWL1xumssQqZLj2
X-Sonic-ID: C;1Ksse+HS7xGzRKxkvwPenQ== M;+vtCe+HS7xGzRKxkvwPenQ==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd

On Mon, 13 Jan 2025 17:05:09 +0200, Mathias Nyman wrote:

>I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
>Let me know if you want to submit it yourself, otherwise I can do it.

Thank you.

I have prepared a patch against 6.13-rc7. This regression also affects the
stable branch, but I don't know the patch policy for stable. To which lists
should I send the patch?


