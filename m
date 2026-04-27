Return-Path: <stable+bounces-241419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD5bBlGc72kbDQEAu9opvQ
	(envelope-from <stable+bounces-241419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:26:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C928C477802
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2D9A301B063
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849BD3E559B;
	Mon, 27 Apr 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWCVIq5z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7A3E5589
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310470; cv=none; b=K93l5JYBVweUuCxgErHe/PreUHkCmI+e8VFOc+mamIHKIGVfwcXBZdPzMCcui+6vqNfLEu0Rai/6XXjY739kTFtWsKy5I+ui5kWp9f9O7E69GCoI+IyggEsTjIwOEJay7tQKOSWex1rXD30dv2ZFI+sDOuJSUVqU/PUChvlZW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310470; c=relaxed/simple;
	bh=obehfuvDOPCLhTirGVOUvt2wVZmlOsdY9gxSYUckscM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxvGwH8evzSuHJY5q5KU0KxSHOGK8JpgzQ2uAera3q7DcAGagnoHqfw/ZENxHjVTA/aqN5VobXmZyStX1m4eSyfUbjf4T86duozRzCMdddRiDWyjHq0m1RXgxUvfZbBouyb2Jj09tKkjI5aUIidOxWn9uI/XU84qhK5DlPdosUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SWCVIq5z; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso1543641766b.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777310466; x=1777915266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obehfuvDOPCLhTirGVOUvt2wVZmlOsdY9gxSYUckscM=;
        b=SWCVIq5zo7ryhziNTT9WgUye03CFcoX/QUTJLMcn+3USm1mA8EjR7QNit36mGSea3K
         WZO6HPReAtJdyFPM16vg72+FMJ5ZZtS1r4xI3aWmfpUD4xO0orbGw0g4STxRW1Jxh6MJ
         wjN+4e8GWWAZ8ypyFIZQBN8MrJgVyqf03DkFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777310466; x=1777915266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obehfuvDOPCLhTirGVOUvt2wVZmlOsdY9gxSYUckscM=;
        b=CHcmin8pe+N/k6oMNcT8yS7xFdT7LTMXUXLSISesmuQwpOkh2FGuYR1ysdOyRLW4/V
         u9Xmm0HC/m6J/GW1TfuhfVXIz4YkMKWy5sVcTRMxBJNFUn50GeNnLEH9H5ruOHZDHy8V
         tkrnAMFqKD/pNFbowJY436gL6tx96fdartPiotIiOSC+FNFaXZpaV+4yJZTP7JLXA2Yj
         r85h/C7MqwJ0KVeFMPRHA3/MO4EsI4JV+1yKsQIt9lRX7sJTEoii3yHwFp9EsJ7oQUHe
         9K68GRg6DIl6eDvTduOJ70xGOeyHAbAgzaP2byYqCfwJv2v7qHCX1OOfSLMjYIWLQcnm
         YZ+A==
X-Forwarded-Encrypted: i=1; AFNElJ/DoWW1WcqGl3eLKO9IH11ayFxMeWV7AUUoPr6+EFdvuyLd4lpq2l4gB4syyYaF6yyWSDRCvV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAu2no/wG3wZVojK7Td4I8F9SqCejd0BCTDCQu8HgX/2IrkBh6
	tFWpNICztfcOK3TXu61kTwzHhdw3F1Of7GqfLpjKh/zxnAM6Nra1sK4LobTgX1rwto/KUjqkWxG
	D+ZwybQ==
X-Gm-Gg: AeBDievMgS+ihyxFwjLJITk/8nEJAFQJ6Mm4u50bOwd6akadwZEsPJL0CGY6WO0t3B2
	M/PkHky/GVZ4BrJbPi3myLo/8v27+ojbP71LofZDRY5pCr9gE1SAdSuoelosqvMe3zVEbCEOIar
	Id/DL5R0MOywv9eeHQoj2YIkwBVb5PfffZCcsr3gBAw7hAQIhHisWOyJMyfXaJVfEcljNNliwPw
	6jqtTzOePIaDm4C4ONCVkONWoEX+HOssfvOgxULlngwVICDN9d1VbVwsaBdPKNFVgMg9lXhWtDy
	19DlJ+BFDwygbK6d8m+XeiBxXOinifxjXCvTSaX0MZhPK3iyWqRL/VtS973xpl77CgKPfQt0YM8
	IGziUhxZ0HRgEtNtbc/xtCLy6mgTa00qacrlLyTGfoEPPV1wR4cXmkPyXZ0rFMNQhIqmucwBGcl
	vVca7TnwW3QmTUV5ohB5YaAlGxzTiXx0IpN5EibdTBpb/K9bOKmh8U5wT7R1HDzGsHyNPNcucW
X-Received: by 2002:a17:907:970a:b0:ba7:9885:b56e with SMTP id a640c23a62f3a-ba79885ba4amr1665164966b.20.1777310465762;
        Mon, 27 Apr 2026 10:21:05 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-baca4936566sm540804166b.20.2026.04.27.10.21.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 10:21:05 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f9568e074so1735524866b.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 10:21:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/D9Z2W6FSlOj4+BU8ab3eedL0AQcTLHXRFS/L0BcS7EA0s2sFxe9FYEiX3enuVyRUvTQK/hI=@vger.kernel.org
X-Received: by 2002:a17:907:1c98:b0:ba5:7cce:9794 with SMTP id
 a640c23a62f3a-ba57cce9990mr1849540266b.30.1777310464413; Mon, 27 Apr 2026
 10:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026042755-pelican-cage-f353@gregkh>
In-Reply-To: <2026042755-pelican-cage-f353@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 27 Apr 2026 10:20:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBDeq-wrkMdUtPfP1XMN4sUeFK3J5Fu43T5g0LEz=cmA@mail.gmail.com>
X-Gm-Features: AVHnY4IAKXpuEzPrRkQdbar3OZgp38ItirmZmmimUF0MwnErzNFfQym3ZXygvKY
Message-ID: <CAD=FV=XBDeq-wrkMdUtPfP1XMN4sUeFK3J5Fu43T5g0LEz=cmA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] driver core: Don't let a device probe
 until it's ready" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: dakr@kernel.org, m.szyprowski@samsung.com, rafael@kernel.org, 
	stern@rowland.harvard.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C928C477802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241419-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:dkim,linuxfoundation.org:email,gregkh:email]

Hi,

On Mon, Apr 27, 2026 at 9:40=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x a2225b6e834a838ae3c93709760edc0a169eb2f2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042755-=
pelican-cage-f353@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Done with all of 5.10 - 6.6. The 6.6 patch applied cleanly to 6.1, but
I sent it out as per instructions anyway. I didn't try to boot any of
these picks, but conflicts were generally straightforward context
conflicts and I compile-tested them. The 5.10 patch had a slightly
more major conflict since `can_match` didn't exist there, but based on
my previous reasoning about this I believe it should be fine, so I
just removed the comment talking about `can_match`.

-Doug

