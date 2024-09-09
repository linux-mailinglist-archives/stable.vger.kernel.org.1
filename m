Return-Path: <stable+bounces-74032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B374971C22
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EE6281A3C
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B011B3F23;
	Mon,  9 Sep 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="O/qFV2+F"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66898178CDE
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891033; cv=none; b=R2lmuAxupACm3mde2QDnQFF3D+WnnmxYLsHG7WT528BTbelAs19ASwCUJJ41ZCjT05HwZ7BohOUc+85+Gl2E4ec+Dt8gS55iFRjfLGwYsUZe7VTFzMAfZoWRi79agJR9XSf8K+ynuzd8BdaZmJMtgT0145TwmyghISzA0Z5Qvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891033; c=relaxed/simple;
	bh=tcHbu2WxTCzZZxiKMoploj6K3xSZQXbbd1azlo15A70=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GTQ6KW3bOO27g6MLK3TFESMwKiZYm7aSQzt07D8yq8Va4bXYOcA6LXGbUtfBYjauVsMYqInihfNOS5BW6oh9+v+UJUp2P8pHGODfIVgQtuhtlxMxveABVzQCCgECu0OIB4Lws8arH9qryUjuEhqRkKP0P5yNOi/ZaBdVixt1PQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=O/qFV2+F; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725891031; x=1757427031;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=1NX7AA4nZYD/Nt/1RO9GP9oyRNAADm67ob4LhSkjKgA=;
  b=O/qFV2+FrYxlXcknhVdPiGEjXGzmta8b9uWba3zvlOBWOpjeyEaa8/DH
   ZzhBZfxnPs5wfCDfOENl6F5EjfJKGcOkfikLLiRklmqXfEAbBJu+x9ATr
   Ia7gjNoVWJSe0iCGMPpikTkb91kxggbnESysIXWScdKuqIfftxFO5vF4C
   o=;
X-IronPort-AV: E=Sophos;i="6.10,214,1719878400"; 
   d="scan'208";a="432169779"
Subject: Re: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Thread-Topic: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 14:10:27 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:35889]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.1:2525] with esmtp (Farcaster)
 id 6fdd83e8-ebec-4917-94c0-f9cd04f1c581; Mon, 9 Sep 2024 14:10:25 +0000 (UTC)
X-Farcaster-Flow-ID: 6fdd83e8-ebec-4917-94c0-f9cd04f1c581
Received: from EX19D030EUC001.ant.amazon.com (10.252.61.228) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 14:10:24 +0000
Received: from EX19D030EUC004.ant.amazon.com (10.252.61.164) by
 EX19D030EUC001.ant.amazon.com (10.252.61.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Sep 2024 14:10:24 +0000
Received: from EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477]) by
 EX19D030EUC004.ant.amazon.com ([fe80::f98a:db18:b0eb:477%3]) with mapi id
 15.02.1258.034; Mon, 9 Sep 2024 14:10:24 +0000
From: "Krcka, Tomas" <krckatom@amazon.de>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Tomas Krcka <tomas.krcka@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song
	<muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, "Johannes
 Weiner" <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, Andrew Morton
	<akpm@linux-foundation.org>
Thread-Index: AQHbAHN76BCEi9lPCEGAlG87/4qxrrJN3boAgAGdzgCAAAXgAIAAAaqA
Date: Mon, 9 Sep 2024 14:10:24 +0000
Message-ID: <139A9542-CECA-4A05-AD88-1C06ED4CB8D9@amazon.de>
References: <2024081218-demote-shakily-f31c@gregkh>
 <20240906154140.70821-1-krckatom@amazon.de>
 <2024090810-jailer-overeater-9253@gregkh>
 <E31564A0-FC73-4807-879F-DB5B3211C327@amazon.de>
 <2024090904-unframed-immerse-6db8@gregkh>
In-Reply-To: <2024090904-unframed-immerse-6db8@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37ECFE65F4DB1F41A46179ED8AE886AE@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On 9. Sep 2024, at 16:04, Greg KH <gregkh@linuxfoundation.org> wrote:
> =

> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
> =

> =

> =

> On Mon, Sep 09, 2024 at 01:43:25PM +0000, Krcka, Tomas wrote:
>> Hi Greg,
>>  Got it, thanks.
> =

> Please do not top-post.
> =

>> Submitted
>> v6.1 - https://lore.kernel.org/stable/20240909134012.11944-1-krckatom@am=
azon.de/
>> v5.15 - https://lore.kernel.org/stable/20240909134046.12713-1-krckatom@a=
mazon.de/
> =

> No 5.10?
> =


5.10 - is the original one https://lore.kernel.org/stable/20240906154140.70=
821-1-krckatom@amazon.de/ =


Or shall I re-post it ?





Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


