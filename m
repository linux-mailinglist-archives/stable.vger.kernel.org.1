Return-Path: <stable+bounces-160360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C7AFB172
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 12:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C640D4A10FE
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEBF275AF8;
	Mon,  7 Jul 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b="ukDGK6na"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD01C5F14;
	Mon,  7 Jul 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884918; cv=none; b=o42Jjv7xm2RMU182n0rUH3wU1vwOH8CKki6SahhqoYqsEnQ3B1nhbovWbFd8Ae7GdqC5aJ6sMwy2Zd6lk8fUVc6VNbf2Ur3y8lte2EKTbB7iJh4VJeJAPthjf6yAPnqoSu3aUEhXYLKRlwK0eaVz0J9YxtO+Eyd+l0987Fnmp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884918; c=relaxed/simple;
	bh=bQJ9BKTilV63YT01fASPJVcROrhut3eHE0ruotsWn00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA6R2M2Bq5bK1HkIHzPPyYHgBqMMEt38jHTgeOyewT+zpmZ+RLxuu1rqYXIhB9acrGxqp74JN7OyyaDoAXwuYY2b9rj7KjBP8RK3s8WyLgW+1DPksgwqbCHZgU9S/fohl/RXeEaDONk4Na+YSv4BxPlf/etSjtt2EfHHujFYMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b=ukDGK6na; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751884909; x=1752489709; i=jvpeetz@web.de;
	bh=bQJ9BKTilV63YT01fASPJVcROrhut3eHE0ruotsWn00=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ukDGK6naciFddw9wAQvrPRx0IlXwe/1DcFAfW0GDyX8jutXW/I5tBQrVrZ11x6B0
	 ugo13D5LH1jqJ8JhUqyw+3SVuMRzA8GfDHIdmJeMCy/Rc/P7w9ZYYgF9x8NKQ+WnA
	 /B/b+2XZ9Gzy4sdZm2wRpc7nEmOZ5n3TrBFFJoTiM0CGAJmy2g1x05g0IxwwsEQAv
	 DaR5I9tNP2VdWs0aMvo4jq4IEu1W10E9ls14NImoHE/E934AL3mcVaekXF3KHO3vX
	 FVWlNa1oMVn871AYTWr2+w8ERrtbg7dPnCkexalcXFhzZrIrZ4o+1mpgNTgPYcUDo
	 DxsWF1P3y7hSb00sEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from uruz.dynato.kyma ([84.132.145.192]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1v2YGN3dsR-00cWsk; Mon, 07
 Jul 2025 12:41:48 +0200
Received: from [127.0.0.1]
	by uruz.dynato.kyma with esmtp (Exim 4.98.2)
	(envelope-from <jvpeetz@web.de>)
	id 1uYjIC-000000004aq-0cJv;
	Mon, 07 Jul 2025 12:41:48 +0200
Message-ID: <d7527ee9-fba1-49ad-9a71-6d955eeddc3e@web.de>
Date: Mon, 7 Jul 2025 12:41:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.15.5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org,
 mario.limonciello@amd.com, gautham.shenoy@amd.com,
 dhananjay.ugwekar@amd.com, ray.huang@amd.com, perry.yuan@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: lwn@lwn.net, jslaby@suse.cz
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.stable
References: <2025070646-unopposed-nutrient-8e1c@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
In-Reply-To: <2025070646-unopposed-nutrient-8e1c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zjNvKukOX4V8lLjO2G02+fp+R4qnKtmtxs8YjECJthn+2waOcfY
 vt4LpKZKG/NpmfDKkGXu2nCYpr9pe8Yazyq7KTN7nSuapgqK0QYQQ4LG91fyZm76nYO3CUF
 bbVyB0y4tV4fOHCRRs9U5uwWLNxO0kLJ0riiNn4hcmJb9WGg64Z3IhFrvXfA0a2a/K33350
 rC0FyPobtSW8oefCDnVPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E+9h6GIniuY=;bhQxbqa2UT6ob3aP1WOsV6lD+vf
 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

Hi,

upgrading from linux kernel 6.14.9 to 6.15.2 and also now with 6.15.5 I no=
ticed=20
that on my system with cpufreq scaling driver amd-pstate the frequencies=
=20
cpuinfo_min_freq and cpuinfo_max_freq increased, the min from 400 to 422.3=
34=20
MHz, the max from 4,673 to 4,673.823 MHz. The CPU is an AMD Ryzen 7 5700G.
This in turn increases other values (scaling_min_freq, scaling_max_freq,=
=20
amd_pstate_lowest_nonlinear_freq, etc.).

Bisecting this leads to

commit a9b9b4c2a4cdd00428d14914e3c18be3856aba71
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 23 Jan 2025 16:16:01 -0600
Subject: [PATCH] cpufreq/amd-pstate: Drop min and max cached frequencies

Did you notice the increase at AMD? Is it intended?

Thanks,
J=C3=B6rg.

