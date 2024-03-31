Return-Path: <stable+bounces-33854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8B2892ECB
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B04B21556
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FDB79DF;
	Sun, 31 Mar 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quaintcat.com header.i=@quaintcat.com header.b="Yr79cs3L"
X-Original-To: stable@vger.kernel.org
Received: from mx3.quaintcat.com (mx3.quaintcat.com [51.222.159.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268B1C0DD3
	for <stable@vger.kernel.org>; Sun, 31 Mar 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.159.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711869316; cv=none; b=l4jGCV/yF6T9FUE2tlsBtLDdnrQH1IpcZZlKdwtw/CPVdzSBBNlgzq6PM0sIBPfsaFeN89GAvJz8znUlgHU2Cn/IEwCvLcMX6UFwikTP2baXbcWco+JPIkYAw1lG0GyD6yIemBFAmeBq2GSEyxSpNNUXlaRbVMxhiCMYpGIj1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711869316; c=relaxed/simple;
	bh=q+vOh9o6WBoZ+lVzE07R3zOd8qEGRP1ByzZIP7oJ39Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HJtTffwcDotv5njXTBPOI2DHp0Ig2qSxEPK9kVFfsFRVUq1i9AVYq2wJIsuIOWjhYE19qa5zFbPsGcz405WYEWXBHClFVcglhJ4MF5n05bOZ7yN6LjBo1oIY5MP4uIL2/wSbR2zcvgqugjwfYDhrzNA0XfpyKuf7qADJ+KeVMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quaintcat.com; spf=pass smtp.mailfrom=quaintcat.com; dkim=pass (2048-bit key) header.d=quaintcat.com header.i=@quaintcat.com header.b=Yr79cs3L; arc=none smtp.client-ip=51.222.159.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=quaintcat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quaintcat.com
Date: Sun, 31 Mar 2024 02:15:11 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx3.quaintcat.com CC2A92004C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quaintcat.com;
	s=mx3v3; t=1711869313;
	bh=xFQ/WJLieL3fHLNC4Fua/1/ISIU55qp3ITXKcRcpmTw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Yr79cs3L/BthAM8x6+nOQmZfWJBf0NFg7R911xkEuWzGD5ewra0PetJ8yiSgJCxfZ
	 CSuQ8C8XnpKV+siDZRsq8iOr//yQdKIEOKrXvYeZ+ikAl3E9X1nzxvCusuWEwNMdOM
	 MpXcZmHCFi8/eydOtTincoUQ4gw3TaRdZzmYHhK4Vdx4UxENoQMHlb4TUXqEIkPwIb
	 njiR1nVE4mkLlUchXEDscQg+tYcEdhmf4Ryz1lRQiQloJhCBWtPXFgGyMWN24vyrMR
	 NBIZaep9fUYjSkIzxmc8IAT7wzGkDVb9Ox7QuoQwWhAQ3LecihE/1wdHe1ZRJM43/T
	 ix2zxvI8Z7fMQ==
From: Andrei Gaponenko <beamflash@quaintcat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
cc: Andrei Gaponenko <beamflash@quaintcat.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] external monitor+Dell dock in 6.8
In-Reply-To: <e9e23151-66b4-4d4f-bf55-4b598515467c@leemhuis.info>
Message-ID: <7543f75e-6a96-8114-cef9-779594a36460@quaintcat.com>
References: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com> <e9e23151-66b4-4d4f-bf55-4b598515467c@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Thorsten,

On Sun, 31 Mar 2024, Linux regression tracking (Thorsten Leemhuis) wrote:

> Does you laptop offer a HDMI or DP connector? Have you tried if that
> that works any better? If it does not, then the DRM developers might be
> willing to look into this.

There are only USB-C port on this machine.  However the external
monitor still works if I use a small (passive?) HDMI-to-USB-C adapter
instead of the dock.

> Anyway: could you try to bisect the problem as described in
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

Will do.

Thank you for your reply!
Andrei

