Return-Path: <stable+bounces-74028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7A971B59
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72B11F2328E
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3881B9B55;
	Mon,  9 Sep 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="aETgA2WW"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1E1B9B28
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889412; cv=none; b=hy6UGxOhRXhrZGKmSwo/oMvZ+c+F2JH3QIuQcQ1BG0DxgT1vVRCdboSF9zyYrq/iSXJ/HE2fy0THrjsguZTDAqlInxyyB69hPHqHH4tvst3QLLLbVBBJDk9WIXoVUu6NcSemz4YNXHrz9mhlLo1g2d84hn3J6G03MognzBMr/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889412; c=relaxed/simple;
	bh=FXW9Pyi6cgKCWeSiDn/BWV3k+CKZ3puRDjG+lW3JaUg=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOIxSuaAfB1eCF6SrkmioMeKvzQujve7h70ySddKjPZaaoYU/jRntT136Z0lj2zCzGuYObizEhlHE4tE9hsfi0T0BKY6D4yQjXevywDCg51pvfbSJay2MXr6oWLV8SyHqmwGfbyaUw/091Y6Ih/pzByydVD168ZuD80g2FUrP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=aETgA2WW; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725889411; x=1757425411;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=rsS3xVyLaK3y93Yyv0ln0311IsJGxyGmJ2adaiAfq3o=;
  b=aETgA2WWXBATxl07kgZkyr+J8VvgEFini58ZWgAUd4ET15ueg37KUEgm
   KzomeKgbjtQOI3dE4PL+HzjPCJMoMK7mKj+pa2c4pHW8mv57bc48qEMb1
   5PonkfvgB9FZcx4caizlUrivLlijZpc0OLxNT34+2mRYbEJ+q1cpBcmMc
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,214,1719878400"; 
   d="scan'208";a="422581434"
Subject: Re: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Thread-Topic: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:43:28 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:13478]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.26:2525] with esmtp (Farcaster)
 id ffd4bc28-1c08-4259-be30-1505e681b9ce; Mon, 9 Sep 2024 13:43:27 +0000 (UTC)
X-Farcaster-Flow-ID: ffd4bc28-1c08-4259-be30-1505e681b9ce
Received: from EX19D030EUC003.ant.amazon.com (10.252.61.173) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 13:43:25 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC003.ant.amazon.com (10.252.61.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 13:43:25 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1258.034; Mon, 9 Sep 2024 13:43:25 +0000
From: "Krcka, Tomas" <krckatom@amazon.de>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Tomas Krcka <tomas.krcka@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song
	<muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, Andrew Morton
	<akpm@linux-foundation.org>
Thread-Index: AQHbAHN76BCEi9lPCEGAlG87/4qxrrJN3boAgAGdzgA=
Date: Mon, 9 Sep 2024 13:43:25 +0000
Message-ID: <E31564A0-FC73-4807-879F-DB5B3211C327@amazon.de>
References: <2024081218-demote-shakily-f31c@gregkh>
 <20240906154140.70821-1-krckatom@amazon.de>
 <2024090810-jailer-overeater-9253@gregkh>
In-Reply-To: <2024090810-jailer-overeater-9253@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F88F11E0AAA394EA86326F4280020F7@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Greg,
  Got it, thanks.

Submitted =

v6.1 - https://lore.kernel.org/stable/20240909134012.11944-1-krckatom@amazo=
n.de/
v5.15 - https://lore.kernel.org/stable/20240909134046.12713-1-krckatom@amaz=
on.de/

Tomas

> On 8. Sep 2024, at 15:02, Greg KH <gregkh@linuxfoundation.org> wrote:
> =

> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
> =

> =

> =

> On Fri, Sep 06, 2024 at 03:41:40PM +0000, Tomas Krcka wrote:
>> From: Shakeel Butt <shakeel.butt@linux.dev>
>> =

>> commit 9972605a238339b85bd16b084eed5f18414d22db upstream.
> =

> To quote the documentation:
> =

>        When using option 2 or 3 you can ask for your change to be include=
d in specific
>        stable series. When doing so, ensure the fix or an equivalent is a=
pplicable,
>        submitted, or already present in all newer stable trees still supp=
orted. This is
>        meant to prevent regressions that users might later encounter on u=
pdating, if
>        e.g. a fix merged for 5.19-rc1 would be backported to 5.10.y, but =
not to 5.15.y.
> =

> I've dropped this from the review queue and will wait for all of the
> needed versions to be submitted.
> =

> thanks,
> =

> greg k-h




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


