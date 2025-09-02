Return-Path: <stable+bounces-176954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E918B3F9A1
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A25E4E17BF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91F2E8B7A;
	Tue,  2 Sep 2025 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dBbd/6o9"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818A26C3A2;
	Tue,  2 Sep 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803957; cv=none; b=joZRlsLkLkVa2bnPykC94Hw5RjnICh5oxQXXiKc2SZdQIQxefRt7tqnDI3MiCg5katoMODxTe8iOGhjufL9TJF64U5LPU8Ietl+2lmwojpLWmN0l4Qu+tBiq4eInpmGtmsKKAWDYckrsOsPkbgzrzwq6eMbMKqOwC2+ikqD1Iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803957; c=relaxed/simple;
	bh=+nkngfhtlefzYrgaaBDcONQHLL3AXtmMSucpEWB6mb4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=L3Jtg+K9xU30zaEGSDeegEk7QykGkDAiz/n1/PFbzH0aCnHx56vmiYy8in84o/Z5Me8kau36LCftZZz4K5VsAzv5DRlSSlVTmG7dbU+68VooO5M7xZjO9Ic4WcEzy7kbM+nTNcasvTRnon4OHJ4cqumq6lWs9Dg6GsHcuRsSfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dBbd/6o9; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756803946; x=1757408746; i=markus.elfring@web.de;
	bh=+nkngfhtlefzYrgaaBDcONQHLL3AXtmMSucpEWB6mb4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dBbd/6o9BnYuDuuaDXw/oPB6s8Cd/UHgIT3Y/VcMo4mVrBiCQgZ3o3Io3xX01BOI
	 s3Y1dpboZFjHgAiPT/zJ0M3bvsWiEf/RO1L3QimGu7BPlodC2h9dH+WacC6MxFFFD
	 uVTY/EHkDx3/WpgGjSr8rAry4QfMcrtGlTZ5eQjrs45jMjMwovafD0lUDtiPlj0ZR
	 BaUvIPlsxGv8++83BEqRAWG+m5fhUp0ccVKx618GLJWX94ucdY2efh+Ls1S93rDP4
	 x4nYwRXJe3cbodpt4gr2Axjp1CwAWrwduTvKRDY67dF3ATxR7OwdrdHXqAfjqKDjb
	 PhLiQvyeQ8lUPHEabg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgAJ8-1uGB7s1tqo-00awlz; Tue, 02
 Sep 2025 11:05:46 +0200
Message-ID: <a4130364-dabd-4a95-b793-06ba5581e56f@web.de>
Date: Tue, 2 Sep 2025 11:05:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250902084933.2418264-1-linmq006@gmail.com>
Subject: Re: [PATCH] cdx: Fix device node reference leak in
 cdx_msi_domain_init
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250902084933.2418264-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5VCKIXIz+ES2THDys4Ce9OFqaJrB1WI42qlUTAk4E06YPNzInqj
 QtSXDDcpanh46C8PlZ8vmHutpuFTyl35XovIkLv6cts2/a/Wi0hAOtR9wuVYS05HsZwUlu0
 bB/eCLmJ9DipVm6dr99VA4VvAhYpX8KDtb8ve0UcYOpIshzKnJjfu5lMSYDf8D7iEImUnvS
 vYDR7XXS+t+rv55LmQ6sQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:exoY0KhbITA=;7llFJbyLyftgJjJ+pIs1P1qYOCA
 OKJcbzi2M+pFTYRBOWPza93XuMyL02xiXoUCarcIgdIvaL+jxi4dgTFol5NlgW1vp19m7nZb/
 pNlRD3xWob5rdhlMsGSJChYIukVWFBbNzjtiW2F4esLTA5aIolWlGOBm3BtK3tNzk3VmJfLC3
 a83hfcerTbhGqKJ66QyFJkSnECWaazY95qS4V7aUPzYpVXli8S8fmx8SmRyQURBvy7FrHA6xR
 bsRRgtWYxvTCI+JRVJRX/7z/eUEF2QfDlfjZquHk/i/dc1OCwwHRlCwBzh2u3Qjy5LDI3TsQU
 X8Y99gQB76tu1e+I1Zg2kPsxkCe8vcaPTQIP63AZe50l3Vwo3M+Tog5VK4fYZJkOJbYKsuhcj
 LXVKABPBm5g0R9EPzbfrZQIatbIrNwEhEeZPDIvafmq1vVGDtb0ZLfH6CvClg4Q/DKwk42SyM
 a+XLcO9NoO54xozpz+wSSrD9KDKTLzLuQ1f9V+nKS4hwngBPC3g9Zfm0fp7a+fl1Bp8eSvDxf
 lb7J2KxTTVL+cPh3MHkjMETzWLVXi/xHLRB4geq6s/vtGp/hHrt7aBWT8pvNqnjID1Vj/ftH3
 7ANByEdOkKtW7Am48tzvXKUwT4QczY23/0dZjcyZu1dm01AFkgVSogIBfW+EM0/j+hj1Ng3g2
 28FVFYsLkov38dhANfAVd/D4PnI72mJ7oeLpKFCDNGXltCSFZITEB7uZ4MZwjaUG1q4LQiipg
 La1A9YYCNLGwXmhLLC9dPWUxFb9FcHtUfIf5J+hHPK4IRfdhIkRjhan1QuXbfAKH5jcPzn7fU
 WvK/lsWoXAmvIgv/2RaUvdIjxZLkOpxYjyqVI+0xv1vNPpg8GYCY8zhyxz3ujDlOoOXEPvBlG
 6A1h9yztLK69gyEgT4G8BYCFCIxQupkObhpOZIN9BUv+FC8XpWsuxD+K0KXvJYibzuh6988+q
 T4DufUv145x9WwHjmb4taDcYZzKECwnqpen7Zsy9pOGNia5RSgbNX/0SwiV3e5eIXOT4qa/7L
 uUUELZtxEIWR2lMX5kwsQY/BsPqlNA3Kp8FKxQaHCgnJwPtW9RZL+Xy01V4HUk49xSTqdO9qm
 cOSnV5NZF6a7Q7uUsDH8jr+2S3oXiboAFLmOd8XMCoFcVnkcAHjxisecgHqudkLKk/skf8yQg
 FxoHrHm1+lsBVb+CtncpUAe5NSkAOazNbaC2M9M3DqwCpEA9xfgZaumbROC1d8SfF+MZn8eJ/
 QsJjtMrZMwpcaYb1rOAro0M+5Y0n4FJNj79/PB1HGV4P7GFRM+hEYmjrTZJJwgNWt2Lc96A0A
 HStyPL1rBiOCSGZ59vp75xFKi7nvd5/azzvd6pjq6zAoJcJCUqXoMDO/fB89xrzGT8mBIi5Pc
 avDVG0tFoOebmixYXcFfY5G7H/HprpEtXsESY6wsLTSuP8bcU+aSWtLOi9zqQMNwkRBfu043S
 +wDg1OFIQzigQ2S/GyBFsx4eVWFNgViu1zsF8qbZMKcAayMmmJjKI2D/kKikXmn6J8/ICaj0Z
 1d+1Nr0cwZLkXYVNj5pEhhyvagOpU6rmkxwkFoNWja2fKGoDh85L0CcqYrO58j2qV7HlWRMXm
 iIha6txy31aXmh44m6UQ8zyZuj/pK6VZtXUu00ULNok7CwaBCA60FQc/vK62TQXznjWg6/Kvj
 ykrVB9kBw21sm3yvcC+5+O1CymUKbPSvj92jBEa5T0ZC9Q83/DsL+BXiyw/v3IeOuo3a+WBYI
 fXKM8ikBQhgr8VdNsaxJJTo73/Eofe0PMkze9sEsi6uZ6hqoIPhDQEv6GakHHbEic2VihYgyC
 lauMklHIx5BbI8cGAgkjm+0fBtn/1UOI3H6IeDl+fx7G5LKH/X4zAIPwsIv3ZcD9X3LPW9FnF
 vFpVDWqUaekm/xv9KbxRTNT+LBDdAweotpXAfx/DN41+1JYxNKBirgK42qtRCV11xytrhgu77
 cHg4cvnrMjeS115IkMKYBpiTLnrBqrACWPgcvyLuiLMADwbYJ2UFNaNniwppjVNs9jJHB4N73
 LqQ9dT8BM03zjjjn2o1kJroYOMWXmzUbFhRiYMKJqtQx20EAydKES292DjqjPl/LhKTA7j3Z6
 KG5QjW4rjBRoelLAbCu6+h+U3uLCDBrWWiV464fwb6xIBSGa4fCwfrBaANX2ICLlpOSvOX3EA
 CGRSI48vaOfbp4QxXuxRVKda5bUTKLXu27adYrdCxb4Xg8vOrPvMrwXa6GyXm0tquTQHGYei+
 6uAN/16mbZ8pZuEYefNx9zm+655G58pSogmFohsG+MotwaHNg97hZRG3tEV0S5GK+x7eK1zsY
 Nso89EuVvTy6lRpk4MZoyxU1Wsuzpxqq3DNKIIm2oqicJo8MClZTYLQzlYKB4uXK3UZyojCP0
 P4f8D8BdlSj3GwP9D8AUFB/X1LXjECm3sL0IUVVsneWlTKok+B+Ik0unuCiXGMyllXPQ+9v2l
 kxMUM1jI4WXbDWJEr0BH1rtMTtQ8e1DhHOf3L/FyQUIpbXmKqSICZWmml2kedqfCfWFzS/oal
 71fH0mCv4HL22CVzj5ywpLDoez90kjFUMnMRpWtRnnSuqEvrJumCBbMEbaRb60nzKYL3ZPcXe
 x7VRhbvHiaqi6Pbphwcp33WNd7V2KK9oDA1NSzytWR6roKgsR3UQOYwLg7CD+dTgIjpr9R+Sz
 BlANiZLuAm8XP19RtSmlcC71Z/Gj3S184w+ob+f6SFL4r7an8nVzgRITeK1ptXrhVm9SH7qfU
 62eSu3AuNQK3J9tfnG2fVqpOB6Bhu492O8hKyZrLQbu4VhiQ4cwWnvElIHdjnpxoJ+UlcGgmi
 IZP5MowbHx+AlkpWxoT569gVaJWuxaRwXLhUjpnua1R+/dAo0lvnBPVj2G155YDy3ke18WQNe
 6qXPlDMWrKhH8797N42o5x0tTM63ZI9hYvJIgt/1GtXPvp1NZmHCfw0evVtQFLp/aoIWhKM+1
 a1cekMHF3AS/ucGAE9pF/R3RGC1tRWVVzoDvmqRm4GmRq03ECBXtPuMjQm2PhPP41O1wdv5od
 roRwOAwlwMC0mEtLGYHfQLOinCsGeJM38Bo00P1ETkmi39zOWju3nxpN3DYo8XSn1LLDeGg4T
 9cUmeH6q8XBDkTJDdWo7NnWBtNatqiSbu9YgRl0ee9KIdn6HpM1VU31Yn9SHDyOZfRxfYX880
 tDbHIKNWwIP8w+Enr/Ds4YIOksz4dzsSGsYMKDUXpzV5af67HYlvMPYWUBZnQgbs1WL2wOGRg
 V9zMSWOYEHWIrtI8czupyYzVfF2kyXl2lQ2EIm0HZeVYxpo1SIz/Zb2aieljQSjc5BG3mZSoi
 T2wzMpD3+SasXXrzKoKUF8WSOuajFmHqVxgEulkESKtjifgu5Mu/rbRo3XBQGytS3NfNeUGkz
 RvzlT0h8WCwcObU/ocBQTmACRMj/BBczXl7FLZPTY4jxXXG5sgztBVxuShUChwLO1zN6cQB2+
 867qGK34ICF6p9wIkx44IljRDItZwEN43+kYgRY5pUxrpKybG02ZboyZq67Alv7DkqpjugDXH
 o0A/VKvmErg9E3cfWttyB69CS+IsnKvxJKskKQXlmg8cbpZdE3XZ6jP54bXvjIzZXflLcGXLV
 Q4ZLITqnWGHvkTMlUOVvw1Oda42FxHXt781So2Zpl1WTdb2SQnOnEQbef6omFsPOldgZRg1+1
 sDOLW5xJtqtX1yv4WanIg6TNUijErLdx7gbnTFI7k5xGn8Q5e6X3sxRMuEOhWQZEJQleHx6R5
 0ZmpS3f62KR7t7tzFZFmbknzVw8wSZEs2OsxK0vvDlyOB4UD+IMfc57SsJbDNsZBLYLlpVQka
 +ntTNjsOJCx6QdeZryiA/3HaWqKDGdJQpGpX4wmZNhk90mFMA56sfO6e+T+tQFzJt4yHawgj0
 E+2pKzcEmVuuQ2daRwTRquohwV5hfRIdN+sOnn+85s0LXwg8XFIeUh5cABBosOglhYVbOG7zr
 BKC3zl3S5ds+2c1L/n9y/2afKTXM7mf/4M10xT67NOg03SEbD3f72w74S5AcsdvIt89TsZ25m
 ljAI/Opc0KWk5+yLkwgG4GbFisN93QIzbMGp5LSNMb87bCtN9IaDNGVuAlbWaVIsBctx3XBTS
 ujgIJQeeBxCQjPgFhLXPjyQM5P9Rnp8PHdXB8J+hxO+4AB9+Jt14/47Ozwp6gyf2NnWH8Fjxd
 EKKR0Hg64/Iegujom536tq6vTykxf6W5p3uD0F3bVgoNd/F3NcGe8WA47nHkk5CWEfN9OlQAU
 Onte+Qf1+0F4pbYmWDwn8R6tJoWkILHNmFd4JK86pO37PfgNZHJDr98ODhdkJHGG0bu65IK4F
 HGf++BMULTFyYsgG6gBp3ZX/ANCVQmLrEH25ZWfU5i4QW8gNPoSWbctb0kWB2ybbPlmHDSGYL
 3Mix8gcA3CyCl8potgztqvK0ZbGIVTkBCu8zab+Kb2wgi11a72Np9dJb7mlQ+NSvlcTMVY3DN
 AQh3DqhEU9dq2rq8w700jnOsqqwG9Ksfr7PnEO+1AU1QZKGsU9vbLqlwwIJwfo9VHKb6UIohu
 xDQmKTCc1X7vbUS+4NmFa0sFZiR1asq0R8uus57MqshnruT2yvRfBwmnVJjVid6GCCjZ+gTUL
 tHioqR/SF8K9mNCulprk4/Epp+FGBLXRqJu11EaL+VxToqo9wYtB7NYykhcwR/06RglicZ9Zj
 gJmyLoL/xpLpkXprxSAA3NVDHecdkUcX06xVAhAfM5JjgOjca/G7N9Nr26DenwJDc0o13OjRF
 lY9J+yBYnjwXKdCHbQWaGHcJ26m2INDczsduXLO2g==

> Add missing of_node_put() call to release
> the device node reference obtained via of_parse_phandle().

You may occasionally put more than 58 characters into text lines
of such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc4#n638


How do you think about to append parentheses to the function name
in the summary phrase?

Regards,
Markus

