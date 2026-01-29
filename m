Return-Path: <stable+bounces-212738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAoMLjoEe2kyAgIAu9opvQ
	(envelope-from <stable+bounces-212738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:54:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11FAC59C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17B6830058E9
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F33793B2;
	Thu, 29 Jan 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="WOzWyR8Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC23793BE
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669685; cv=pass; b=dZn8HlJpMOiljUijybJPA7X81yhnzQfAdQhS2+OVz6sgdf6qihYIOx5vvS4d/wZgdtBcx2t5lnVqDYV/lceSESApSlS1aAMWQyFY5eSw+sendlD5GT8scWuwmWsYs8HQ9k+JzI4nW3mGNrfuGbk3RRutqzCSH90OSrMWAtQpDMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669685; c=relaxed/simple;
	bh=XDNu5SJ7NlxJ/w3kwjRLCAZTv+l7SQBkMa4RqVUjAEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU7xILdw740B5HWuG1MUMumVhqRm+nFJOT3nrNtvyKFWibzEhLqASrOuPSRgdbRORWYkw2BRVDnk9S9ts8xxK59mUUjphE6z5nl2kCDvP7GZ4ucpC9wcgZAi9po7rz2ByGZC8OUEtOI3IlqnuBjIeJUDegpXQr0q9o1SH/Po5sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=WOzWyR8Z; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so110021766b.2
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769669683; cv=none;
        d=google.com; s=arc-20240605;
        b=OxcHDk19HJEr4cQlCRjxMLSyI6NIgu98NTpAGoTXFuVpfjslzDJNY11YiNDPWKM3gs
         QxWEV1Xwu7TKYGiBw+D3rymlYtzrcs3TmHpURDOzgujBvXaRjUeNRRwOPN0zB9fYnNJ5
         MeJ/W56S5ePRhtydZoyvW0F8bLlbPaBs0CTfCAchV02RWQol18fHMKL62mcMjnhllJ+P
         jfDORsWCeG4fSwJrJkH9ojcntNexvCqKa2jXWiL82YTSdtrMXdktSpiu6u4A8O/LskrS
         myto9soFhUKI04EGAx7y8ELAxBE7sz725ysowaQK6SJCqZvnvXypdy+c6aBgioNAVdHU
         bhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01bbw/wzbRiBXVf7AycG37TcaFvtUpv7cQrw54iOmM0=;
        fh=Y74f01YznQtICCoVpDtu65QsUfM3VPu5xLIo3JzpQ/I=;
        b=bRi1ohayPyXwycM/GG9dYOwL3DIxlwmD/6dHE9J353FlUA7JvworCb01wjD0sAsNSx
         07umRRd5RM96XN1ARP3sW4eukYgbbaKR3z7LM7kdDhLHZtuS1NfKZbwQqlU0Vl+rK37Z
         WKh9FQCveUgvO/iOTFPR8mBcW48zGCt//NeRmD0u3KEB7ZiMneloP+BRKaksDRyd82oL
         Ls88RYrA+A28RB6B/bV/6y6x0+uTQYg3/fi2gBA4ZHsIsTE4iRBmeRgjE+WseU+Jttn9
         jNji8xzmqhxzWNY5iAf4rPb+dEGkGDP/nWUwgIx0EMn7dOat/S38LQWTOY9Oeo7O9e7R
         +qZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1769669683; x=1770274483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01bbw/wzbRiBXVf7AycG37TcaFvtUpv7cQrw54iOmM0=;
        b=WOzWyR8Zpt1qJV5wX7t6Xy/Pkzsz3Od6OPxtVEdxAE6MEIqSe7BDsKpT3sanbGrz2Q
         QnjLR2GS3P2v3EVI8Apo9SVDfY2UgPD0Hj9LnE4BHwAKiUQW1N0hv9YbWuz8Kp4HZgMr
         8Xtj+EmG3ZjakzDkwB3/HVPQbVqEFzNqzEr+yCLXW/Jb/JDCtSByvhBa/aE92PO4rRKm
         UazaBeiE5lJeDkicMR2wrIXVF3MUIUDto2mJagnPmpOlWD59BF+d49fBjyr1TDm6N421
         SQDftdPuhJrlWEWrNcFjc18E6+7tm46BlKJOcgiBZXRwLPaP5n3U1V9i6lUeY0dZQdrE
         2aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769669683; x=1770274483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01bbw/wzbRiBXVf7AycG37TcaFvtUpv7cQrw54iOmM0=;
        b=j9CeXf1RP66eVs4EdmdzWi9keJA3lOLaWKhMR7cM7Rt4nhOVm55TxU0jPGMYcA14oV
         DGOtd6rBWGHC+CpkO1gdjRVJZ23Zugzn1g/gkjmYgszkSikogQ98X6QtqQu5LjtoI6ap
         sVXbPiacFpELItQMcLdSCECiqqJyDP8pdT5xTW8Z3o2gJll/PmQ/toS2/QWVhT17i1V1
         69w+bHJB8Q0Bg0BW1nOvjdh/tfD+cOprP/oTovIIV7PbZaCv5oxiNxIhGxVMed+5VN2T
         KhZ3fH4QBLrOATweI449l2bNjKFe6RvGjH6LLqgvPA4TNknOUZL5/iWv9ygfrErtke9S
         FO9Q==
X-Gm-Message-State: AOJu0Yz4fQaXGG1ntdcWHLzBCLwq3lTl8r034DOg+Rr2lDJYCgFAHm3n
	yxGdwdz7PlefSAeLMC+2UDNva1qToZrChTVlMpoKxItOSwGCcKQaFZSjKvL92E72nYFUeIzvylE
	1bOM/O7YH7Oy8xSzDQqS4mIrIeQSwjCTELWIYaA0+TA7Q1nCxWxyxTa1nU635uGLa0tDFfsmUpf
	n0pdqYh2zD7KI4brumUUkFGtHHtsc=
X-Gm-Gg: AZuq6aIYGkACCZ4fLTZWBmrq7psQNbeWsioN8jxnC+oy4EcmMeevNDflC8OH6WioZQz
	E+aKhLX4zubsXftH7OtXUzzebs9VhMAhkiwZwydGWHE5h8LqJtshA+hak6jw59GEiJtd1eK/PgD
	vbb7CU1c2HNxe6Qp3jbfDYeIqb7M0F5vfLASfKwbHqYR0qBZbMZm5CZsgsj6KWHUTnpHhw0J8zs
	Ti5viM3qjHc69VOoQPXHrZ0Q/RXpJvkcIlHXSWImRWog9nTybyvUY8amLk/jiJjAbfCMsHxD83m
	NrJzimGEK6PqBUDrqkVHzi8q7yw=
X-Received: by 2002:a17:907:c22:b0:b87:6d6b:1366 with SMTP id
 a640c23a62f3a-b8dab33093dmr550624466b.41.1769669682055; Wed, 28 Jan 2026
 22:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128145344.698118637@linuxfoundation.org>
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 29 Jan 2026 01:54:30 -0500
X-Gm-Features: AZwV_QhMwQVgQ5G6i9WzR7U8oXW_gCCL5BwmoR-L73Bq9ZYhkj7dXgbA3qhtoIM
Message-ID: <CAMC4fzJ-3WDwOgi-PjYUdnqECE2up5ihzJrCgVYy_NuLUVsSBg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/254] 6.6.122-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sladewatkins.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sladewatkins.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212738-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sr@sladewatkins.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sladewatkins.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 5C11FAC59C
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:28=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.122 release.
> There are 254 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.

6.6.122-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

