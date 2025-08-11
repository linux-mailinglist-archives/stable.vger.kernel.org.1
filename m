Return-Path: <stable+bounces-167049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8BB20D21
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE36C179EFE
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09452DEA7B;
	Mon, 11 Aug 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LiTX9A5d"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F24A42048
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924915; cv=none; b=lP9IYShqL/rgkuDkpsvANKefUxKp0IceernxTNARRduH9F5NcdvvG84W56xmGcR7MGKhAZ2/2uke8+Jno6k4HiZt4PRUpkcGfS70QfvP0rsm9KwlY3AYv0fu0eWLQXZz0/5Bp8MH4c8Y09OCX6POROwuecBxL9Ali/yPt4jWtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924915; c=relaxed/simple;
	bh=9mcIvw8TnqTafyJ+8Oq/Hi3wC4RkWVvI3M4CG1Gk+uA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rKiamEupROdnlBKRpWWi7QLXxhe2m9VTljt57zXPSTR4ztMz4L1qrQhCjqiWGQjjiRfcBs51J71IPRzvsL/68FWOocjUT26NJw4GGAO9YwWmkXYWNM40p+EiHcMPl1/KXMQDQ8cW4v88rs+1E8qMNSQ8yD95k7hNnciwA/22Keg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LiTX9A5d; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754924901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcFl3Ghkjin7WsXXZp+/nVY4juF8ODjjvZjAsODy3wQ=;
	b=LiTX9A5db/1wkUONRwIhSnRFawSE+w4zT4gdYF+5FON9ACzziuBTKR0KgeyUWetAb2npy5
	9FZ2wuJXpdKLYhOiRGa4faaCAO36qbXwPtYXGWz+h6rUj0wg2Re9McG2fhkxPTuHZUXfey
	GV1XrTsYfn+QWjKodRuNHYVjWJBIJzQ=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] kconfig: nconf: NUL-terminate 'line' correctly in
 fill_window()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <98b4d33c-24eb-4034-82ce-e88e85f8e6f2@gmail.com>
Date: Mon, 11 Aug 2025 17:08:07 +0200
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Shankari Anand <shankari.ak0208@gmail.com>,
 "nir.tzachar@gmail.com" <nir.tzachar@gmail.com>,
 Michal Marek <mmarek@suse.cz>,
 stable@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4B3C8558-81F3-4965-A09C-CE07D6A5FF4A@linux.dev>
References: <20250810142239.120294-2-thorsten.blum@linux.dev>
 <98b4d33c-24eb-4034-82ce-e88e85f8e6f2@gmail.com>
To: Franco Martelli <martellif67@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 11. Aug 2025, at 14:51, Franco Martelli wrote:
> Is there a rationale behind the choice to avoid to use snprintf()
> in these circumstance?
> Preferring snprintf() you will not have to take care to
> compute the position of the NULL terminating character of the
> string, it's done automatically by this function.

I looked into it a bit more and I think we need neither strncpy() nor
snprintf() (and no temporary buffer) because this should be sufficient:

	mvwprintw(win, i, 0, "%.*s", len, line);

Unless I'm missing something, I'm happy to send a v2.

Thanks,
Thorsten


