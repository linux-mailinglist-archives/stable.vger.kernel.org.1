Return-Path: <stable+bounces-64732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D51942A54
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D421F250F1
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF11AAE24;
	Wed, 31 Jul 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BA2isd2h"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A611A8BE5;
	Wed, 31 Jul 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417841; cv=none; b=U/HityyGcXtI3PMu9LwY/iLUxIw21AcvWBrJnxzfPzVwgjCD9h3VvoPCPihgWG4ZYVESjhW5HvAON/o/NF29+RY42hp+fv/IY5rR7qgekGvBlz0ZQmqHMXuEhrvXu28kTqr4UnYGBKbLQDgKEmjbg2pGkdPFOwkVAG6zTNxcm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417841; c=relaxed/simple;
	bh=d+0qhvwccHRNYP7gB2J1RJP6B7fuEbs+FdSBOgXKONc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Yomu93xNe3syLj2SXNQ0xFgbSOQc9MWmr0d31CRE9MSIe5NL3UbAp6pv3JrE2rbc/8UIjI776RDeRPnCuKGMEQEcj1P8I2JB0DH944phCCtqAKHG33OJqIOdM5ZCTajRNj1n+7kPLk6Bjo0x3Ony+j+JOkWdpQwG/46kLPlS4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BA2isd2h; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722417784; x=1723022584; i=markus.elfring@web.de;
	bh=0YmNy+yZCoJdyxtRmqU9DnXpRRd2Yx16nCVHhrQoPMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BA2isd2hoBTUGxqViXo1jxACTMcqCndC1NusIza1e4/+646x6+82yMjc+DYI0iFM
	 t6I0w4OBKEl42YHUvYPFR3IQ9Zvd17WNXj+UNbMeMqpMG2OmlypOhEvU9Jj9cwJj2
	 Oqunx/+pZekAg8rtKLdN4iZ10zxnUt7i8zHnHMoH8MWqP2eShKfX2GR6LTElvS8il
	 CaIiWej3y71IZQTaiYlpNRT2OsSeX3sXiIwdYJczriiomSMoRcXVQ0npqkECuA23b
	 59Ohm1+3uQQQfCD97hlzJ6hgiTu7bWQiBEOFuNRCgKCqnrwIn7mKcCYdRrZKY5pFg
	 dmnHcG2KoLQVeFN4Uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1rTG-1sWtge05Wq-001lGJ; Wed, 31
 Jul 2024 11:23:04 +0200
Message-ID: <6c6d2e8e-1392-4c1b-aa39-46149ff2956c@web.de>
Date: Wed, 31 Jul 2024 11:23:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Herve Codina <herve.codina@bootlin.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240730063104.179553-1-herve.codina@bootlin.com>
Subject: Re: [PATCH net] net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock
 to a mutex
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240730063104.179553-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ptvWP2JpA+KQ0oIRv9Hv1yCYM6e8ZIPJX3xm8Jrs46Z0EYQIqAO
 GTmbcWD4zNO8atDH8Qk5/8G2dLdADEYw64kLSUwUQhW7HcDvzjgdREg5AtiwDq3XbAXIYIU
 PIrsil/Woseyo+psqQdJ3UtIttMstZsiaY3amt2lW0HetwPxLfkmZg7ZYHBgb5RevM6GwZT
 uyR8HNRV2dQUiouIRmyfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wduvmi2tmRY=;ycowwX4dgWkZRr2SN8rxOYtybyH
 BsaNdh8FrLq0bxUnmtcLmTxQM9V26OJv9OswClzpFUO9VmaQ8561jja/JquD0WKSKsQHATLJ4
 Ja243VQjxtTJADdVtP51Q5wCB5PNhpbeEdkz1AQJN22Nou1WBfXYtbfVJAloQAURq7sJcZS+3
 AeOeIyhZeLlMc4vSXF5Mfi0Pn8bwDh3+GERNPnN0esQANY0vwqw9XXs+owhTuzzBraAU3AfrK
 2O2vmkt5roG3iugmdoNtzDk1jzfOJh7Lj7Bqh3vOxEKqg76aMj5DDG31tXBaGxv0W2z3htfLr
 5qcIExaulObRJKhjzX74bTLzfTyXR7cYz4GcWM0K1sMJnCt+Hu4e1P7yfd5uRmhLD3Tt+5gNG
 tlLzMBE83gI7gbiY79guOPG8BEsTWjzKoe+NkCNtBVAxGqHzlaL51lFLyI2zQ6kCwIymGIDfJ
 cXtOI7OROfs33qe5VetOItaake1ysbnnt0WAU5xPlDpJB39XjHh4IRwcpP1y1ukMhNzAi6EkU
 jXLjsI45MoY0ZYrInQ4iukNtMnONXMA9FxK3PEg5s20GpKbt1wCYZx3jk3MtpFW1HpxstyrLu
 uT3ZJUUHcqzl2m/e9gJMHZU1Rwh5Mqb0W+jxvVQ61hctcvF44z91uZsrfzFTUP2uUFx1Y/zwG
 mWbQx1cGIvvqFA/fNn4ZbNOV9ID84MpUcxvrKs26ar/Zfn0J17CV+fjokSc5mma/lFKPLU4md
 vXHCU9oXFyjemUTCPnvV1gtUE/Zn2IUQWLbVafJxd4XnlrzTJ5HC/+vdROjvsxhT6F0HA35hw
 vHmGqNXj/CeEFX6d5XVbua0g==

=E2=80=A6
> hold, framer_get_status() is called witch in turn takes a mutex.
=E2=80=A6

                                      which?

Regards,
Markus

