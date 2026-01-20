Return-Path: <stable+bounces-210505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFP7HOMhcGlRVwAAu9opvQ
	(envelope-from <stable+bounces-210505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:46:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 026824EAAA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D7945ACDE8
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 12:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCCB4219E0;
	Tue, 20 Jan 2026 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIpDO1pr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD83BF2E6
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913220; cv=pass; b=RGSJAep1qhcXpF7AHufLv+sXKvw5AnRTmGPt9XaotFRP7j0XgunAusVgT2oyqfSQqHa6MH4bScZerRJ0+7++8efw/pXPjVRX916K8GjxQtCD4jy/ZOCdAvM407QNJHhzdP/eGx1v9jFriwrkgSveryZfGbY0d2LaSP5f2qyU6Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913220; c=relaxed/simple;
	bh=rQrD+V1Y+in1alLViW1NLHP+ces+ltnLdTUx9NLPHmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDU6hmmfjVbnaE+ZLWY1mwVfoLIvjrouAuRN0StHFo159NuYkAUENo6/UAtOIDSfhIZGgUf1I6ZOVq0P4xMUUecyc2GHxNU8hMX7ZMZJD3oh2JAOkWOPKW81f8tApoK3N0TBuqO6Q1V9hGq8tBdQSrV2AwDI3a/iCAI0CnTsfgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIpDO1pr; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7cfdf0c8908so2527171a34.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 04:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768913217; cv=none;
        d=google.com; s=arc-20240605;
        b=DIUiEv1U5A2NpfA0KWtHSHvIYpQe3FxBRCnzqxoNpIIG1LGsqaHAqL9t4qlogxjbPL
         qjejDy6R7hBpNmwT1Lr81wFJ4vRCyZix4PTUaIrKHIwb6aMs6T2DrcjdlTCwXDBY76HV
         2jPUCfNbsz343VkRLFa+FdMj2jGekxE0hsrvlWLK3ruJLNLJRoZ6mP4zKrnXC+vmh0VC
         THhLb2FRaUaY5t6fG/2v0t1e8xPQbhIo3S0BSaeTSXZA8TrFgU7t06LMdMDvAkmEtAEs
         d77OZYDnrXOpNKTNo8BkfzrrKgwXb792MsVIwDNWqvfEQDBWkyItAFYs8cLHDCqpNT7s
         Xa1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQrD+V1Y+in1alLViW1NLHP+ces+ltnLdTUx9NLPHmI=;
        fh=xdOCmjjftJKBoUThovK/6MIuVhqmXa0eQKQf6vfSK3w=;
        b=CwxbmAr7k4lvfal7iiYVinCZBV9KShANEBvbLqg0El6Cw4naX+Vpj1TzbL/OiiM/hu
         2PKqJ69A6lllL9sCKu5oYR/zoHhkVGiBSWyv+M2z+pwbTBuliA1NPpWqlQw+4aGMSY0I
         hPm5ItlRawwnK+GyDtelcrIOOa1Ok/RKKcBVmVVV8SX4SKkq7DaS4ky46w8x3MR4QIT3
         a45f8l+kTtm2ZNi0jUeTceC4CBw8cVtxMEbrv9cNSlqIJl0AZSFPcUJlQKNxoEu09t3P
         /4f4Cus12ABoev5Qchxtviw1O63bBx4NUZc+QjfB1Y07iTVJ/5d3pjn7Ra8VNVpwJJL/
         LPtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913217; x=1769518017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQrD+V1Y+in1alLViW1NLHP+ces+ltnLdTUx9NLPHmI=;
        b=RIpDO1pr937+m1F9qiRGKDjEuzei/A17XH9zs8moYTDr+AWQfEqMPVNmjiFA1VRFy0
         tB8YoNLIWXmx78ol2Fn67xoyOBUW1QKBLzxyWgBhknjaZ/Sr1nCsPvIVPA24PXt8Tn8l
         k8fzqoO6h89Jfq8P1vAVjiKw1+v7dfBNnWJhsxr5AcqC5M0joNRtORRTJKrCRQI3qzhY
         ESQl4FumAwZLUlGV/ar/p1K62StE/6C/LLER3ATmU+LFhVNBaDogMd+GrCdkpVvEw7sA
         77jamSaxfiRa2kDd9FwBNfLr2kqcHmMWrEWOMiFs5AwmLPDcxmMrIK+LNYO5gQVdxmQc
         K6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913217; x=1769518017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQrD+V1Y+in1alLViW1NLHP+ces+ltnLdTUx9NLPHmI=;
        b=NbJp1/t3RrgrerQgfaujrVOsZPSvk2cxM338jY4IreJ7Wdbd+hsRq08Ru39nK47Nz9
         SlmOV2LRmyhetK0mMq3bUvdGph0AQvwF0rSyVF5alxgmOQ/KqG1K7rCnbV7mq6sXDES5
         +ziPxSi8yYp9zow3aNH2GvBBiTFmPUfZltpId0JEXtH1fYqjlhS2Qn0IprjsTJ7xMiCX
         /9FV/obDeGhahlEwa9r3FwYjIfyKuRvqn2pWtLUqJFdhSqcgQUCUgLaDekBo7xjDj0dr
         F3UqPS/Y65DVjGb9rDBu6EFwRutbez3n5bYRP1t7mmmXPuF4yGRbji4K71V29PwG2xlt
         Qlkg==
X-Forwarded-Encrypted: i=1; AJvYcCWXg7lj+u+zBBVBSoJSrLA+xrH8QVC4O51AexVknlrhxGR6+wK/p7WIY5zRCmsCJr8NIhrMXnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYaE5i88JueDazf02pDo3KTA1a5poONSo1aCV7PQsWHHzPtmj
	3E0LKYF8e3fOG7kSJreK/HJVNyU6sY6iRiLaLmI6xpB3JbKbGDJcd34vcC3g9YpTlEGQopQaXhm
	fpuO0i0KQ7evKcVjwLChV/TDGaZO/T3w=
X-Gm-Gg: AY/fxX4SWwT1beaVc7NkdjxUKnpBklI1zr5brkkkpiQIA92ebAY3uykFhxgkPASz+f3
	iK6Kf7DftqG5PTMLM9UdTHiQbqPyoNE6Bzvj7lS8B5BFkKMe5O47AD5yHpmrGwXJwlqyR89E3ta
	2jYNK/T67s4PEXhDaLahg6HKpXcfYTRmHR86LpCN9oIn4FVpWUpr9yHNuW5PmEzhnUbNrfAhvIt
	f5D59oFu7jlNu6vOR+mJhjbj8zk7k65Fu1TLAY6fo1O2fmAqFBsmurbTiseeJeZetxXWpvXL96X
	Gw1D9YY0OJlWd/mLCKIAyS/KyfwnEmEsmxYAqIRbIRgSTA6dw9fRdeqHR/tSOg==
X-Received: by 2002:a05:6830:380d:b0:7cf:dc0c:8cf6 with SMTP id
 46e09a7af769-7cfded1e4f5mr9674488a34.8.1768913217232; Tue, 20 Jan 2026
 04:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120121105.8959-1-hanguidong02@gmail.com> <88dbfb85-571a-4f65-8879-16972dd87bbd@web.de>
In-Reply-To: <88dbfb85-571a-4f65-8879-16972dd87bbd@web.de>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 20 Jan 2026 20:46:46 +0800
X-Gm-Features: AZwV_QhRCRUwlJkWsKCItRp2IeRZVqpE0H4RsHQpr9Q6txnacLb4VQKU95lDNoY
Message-ID: <CALbr=LacbaugBceAEf65uT9xhQsxF99zo4jXqNUELqb=2t_9cg@mail.gmail.com>
Subject: Re: [PATCH v2] media: dvb_demux: fix potential TOCTOU race conditions
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-media@vger.kernel.org, stable@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210505-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,bootlin.com:url]
X-Rspamd-Queue-Id: 026824EAAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:38=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > Fix this by extending the lock scope.
> =E2=80=A6
>
> How do you think about to increase the application of scope-based resourc=
e management?
> https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/mutex.h#L=
253

I did not use scope-based resource management because it was
introduced into the kernel relatively recently. Since this patch fixes
a bug that has existed for a long time and needs to be backported to
older stable kernels, using standard mutex locking ensures better
compatibility and easier backporting.

> > This possible bug was found by our experimental static analysis tool,
> > which analyzes lock usage to detect TOCTOU issues.
>
> * Do you refer to any other source code analysis approach than LR-Miner?
>
> * Will any additional background information become more helpful here?

This is a new experimental static analysis tool we are developing.
There is no additional background information to share at this moment.

Thanks.

