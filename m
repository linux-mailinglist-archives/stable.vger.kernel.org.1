Return-Path: <stable+bounces-61974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828793E012
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 18:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160CA1F21C64
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B91849C6;
	Sat, 27 Jul 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b="ui54UfmR"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6118413A
	for <stable@vger.kernel.org>; Sat, 27 Jul 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722096478; cv=none; b=t8ZH1CO6TPISycatXB0HRIb6dV98V/4iKKpqdpzKnUpuPgKkB4eiJOUWJ8A73PnXKbL5l3tPTDjXBaaHSdGUTGkA+t0mdJeUGYPhDmbv0cvsgd22assLXHtYBnNu9hU0TdP7OFhGKjLzv8egxO4zFGF6IRyjVPb8u/1cKGgmLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722096478; c=relaxed/simple;
	bh=282oIA90G5O2Ude1KXvz8VqSWcqJ7AUYamQOvYzpDe4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=G5WVlNDE3bqMAGS0aI/Vy8aKhWSdwdLuIWPn8yNVt0UxmutATfKAGJjwcL7osdkGiN+IVC84EYHSQlQz7ZX725Wa4sePWirZk5MD5C/b1rPLg+6Iy3LOAqzIqba8+glgzDEsms20ulYGKtZTxVsvete3X/YqoU/oyL4QAQPtISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev; spf=pass smtp.mailfrom=holm.dev; dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b=ui54UfmR; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holm.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holm.dev; s=key1;
	t=1722096473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=282oIA90G5O2Ude1KXvz8VqSWcqJ7AUYamQOvYzpDe4=;
	b=ui54UfmR5vMXdJJ0iaanxYyL42sTrYC6XSVVHJ+BOHc4IoY6qDcPvdwWuyi8v3Cu4TECFT
	zFiTN8w1SWXVDOG4mvK/AHkNxx6EPA8bbd6UERYfWBLCSg9QqHhfr+pm0nPYgNC2Rha7QN
	tuoCMEjPDm9W89ntjkZm81JBbEHFy4FaSNmT6rKkInQEwb/0PpDdgY1RO6+2DbFVCba53H
	Sen62vfu9+k6b1CsCh8STOTVkHkOAhBKJ8+XPS5sUdguqyYkY0pxEhppjw1mT/dPowy5ht
	41bsTpufIfVH/++gJ1McfHuTuWLyAV8gPirJj23R0cdIQtR5PPxl53lOWq8toQ==
Date: Sat, 27 Jul 2024 16:07:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: kevin@holm.dev
Message-ID: <d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev>
TLS-Required: No
Subject: [REGRESSION]  No image on 4k display port displays connected through
 usb-c dock in kernel 6.10
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
X-Migadu-Flow: FLOW_OUT

Connecting two 4k displays with display port through a lenovo usb-c dock =
(type 40AS) to a Lenovo P14s Gen 2 (type 21A0) results in no image on the=
 connected displays.

The CPU in the Lenovo P14s is a 'AMD Ryzen 7 PRO 5850U with Radeon Graphi=
cs' and it has no discrete GPU.

I first noticed the issue with kernel version '6.10.0-arch1-2' provided b=
y arch linux. With the previous kernel version '6.9.10.arch1-1' both conn=
ected displays worked normally. I reported the issue in the arch forums a=
t https://bbs.archlinux.org/viewtopic.php?id=3D297999 and was guided to d=
o a bisection to find the commit that caused the problem. Through testing=
 I identified that the issue is not present in the latest kernel directly=
 compiled from the trovalds/linux git repository.

With git bisect I identified 4df96ba66760345471a85ef7bb29e1cd4e956057 as =
the first bad commit and fa57924c76d995e87ca3533ec60d1d5e55769a27 as the =
first commit that fixed the problem again.

The initial commit only still shows an image on one of the connected 4k s=
creens. I have not investigated further to find out at what point both di=
splays stopped showing an image.

Best Regards,
Kevin

#regzbot introduced: 4df96ba66760345471a85ef7bb29e1cd4e956057

