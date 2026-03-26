Return-Path: <stable+bounces-230454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDGNH10kxWkU7QQAu9opvQ
	(envelope-from <stable+bounces-230454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:19:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A71853351A5
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1AF2300ADBC
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD83F786B;
	Thu, 26 Mar 2026 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR6GLlbV"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E733F8D4
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527400; cv=pass; b=k0sjkI3cWDlgNmTpde+lJx7G/uCf6iFKaykdTZOsNp0Ja6UfDfXfeRpv/O/tVP+E6EnpsJ5FrSZ3YFM7Ym6/1KHYO3Dhf5BkEXwdMJMWw8RzZ0InFFU5pn9TxPe/nu4REybs3pSSkgeIBN2mZ7yxM6AOAfR8IkFV4qb9kGJwwDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527400; c=relaxed/simple;
	bh=PYCc/ATpnym011AgK+0P6Tb2mKVBgUCH0DqbilqhAa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daXdwVq05u+a/RDU+SFBbYg8bYNNQ5lBow2nkih9ikjvlG4ZlrrgUKdwd2EEl31oqgbLIRjPEDY6+u1ij7U9wtBWjNrgWjP+prirKKHHP43dR8xbPkffZd80uC0BpNxZIWj/dOffjoKwWwjCsTeL+7pFLY+WbFmQcTE52BKTPXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR6GLlbV; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40ef10ec84cso719355fac.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 05:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774527398; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBT8Yb9tn0LCZic0UZ1CA+nGBYV2dORwFXopU80WiNjbkW5mCLiNltUa8aUX9QgpTg
         zThW16R5YA5y44QvdsXP/FvFKNf1cEj2Diy9Jr/MMy5SxSPLusLfU6AqSnHtdQfu5Jp/
         Cuq0b4gCs3Y2sbXol/kHwQNepiyveTxbSp8bFK7VgS0HjvXXclyb6VdG9vVGaAWiWQBm
         CAYR96eyu2QYQ2f6TZNImbVvUJhcW1/9zcj58KVtrm2WnJ61db6JtlXcQh1bCEa5H/by
         o5WMJmBzyQwHJihU0DG6OIzZAXJx3UUMKio00LVAZLnAQzmtsX2cEMFBk4WMTkMEwj/J
         bhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IzqmWQY9PdTlI25+3zB4WndqeSZSv2VgqzxKhkjqgpE=;
        fh=l8RFLEyEzIzGKmuVu2DpRBo/nYkEnS3358K5TvD85NE=;
        b=W6qj5aGGgAGUHzIzCaofUDpob3qNoOKshkTe5HG+9uaSc588njs35N4S0rft0nFBcV
         qhfnUeKZfWKLZ9rRzwnQcmKO7o+xNQSnhytPVJjwP9r9mYnBcAfrE+DuMoz/mCLr04SD
         jIMvW3RJlufThyTCdIjsrUkC6n7mQau56cuejTfqOqcN+rOydW9szg9MGpNoCkr5whV7
         n8EIjFGtSiF94Cajg9ZV4S3h1oUtT2WkqrG6i9Uf4APTuYDnXXeXPhTpfo88jzUmEfBN
         n/DdlyT7vYLPPS5H/H607PO44Wo/yLTVm7PF+VT6Fh5XxEVpesUPDNJ+dvs6CxvPMUaP
         JZmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774527398; x=1775132198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzqmWQY9PdTlI25+3zB4WndqeSZSv2VgqzxKhkjqgpE=;
        b=KR6GLlbViajL5EuvlpszLjw6tLDn9VLkSDqyHxqLhNRTY71sO4f1elKua5DyYn9utT
         hB3NhI71bKJ1cxIb7yvBlEaZ4N/4QhS4evitpH13MD/Goe5RmTxVF4Bdlnt96GtBYsnr
         J6IutPJaU/J+QDli6YYw1TpNpWNHT7stygevnIzlLwJ0/IjsS9gxhEn0r/LXOeUmhafo
         XTLOsRw04qOWV6rSrGiP/7LoeFZ/hCHhIK2OzJ/gqZ+MIIAUgs59np33etMzSmZRwyjQ
         LjEgVxlQU7ESHErj0z8nehgJLN2HRU17F71UypGnA6pa/p+1tgnnpPRnEAp2WP+X5gb9
         A6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527398; x=1775132198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IzqmWQY9PdTlI25+3zB4WndqeSZSv2VgqzxKhkjqgpE=;
        b=G+8tXMthVTfb39uUE5oTKqEFXl3InZQcW7soL1hAPGUdT2TneqnsVKUobw/6hGKs3o
         gxEbiON/9z43NkcxWw+2XWtECuAwuUFrwKAgdE+jkEhNRDoFQbnh7vyzjsZ+S1qoywFA
         Vyv3ovB2/b4QKyzOztidOwOaVmwt8G6qxOPI4GxpF0AUJi2vSrHTE5NH/JOr+dBa2Jnl
         0u86tRM/ypyjkRvHYsDAf4Z9tbIYj/C/mUgdwqu5XcAqrS7dI6lZwcu28+AtwhUoYU1T
         spYOZGCinoz3WVpGSVGuLy4sdhRRdK20CCAdZZMm4fVjiRAE19v0TUar9WGkDkaA0Txn
         6vBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8BI2DLPb3j2BfmfiRS92evy4poglNz51QOVw832IHpXJ2s5iNXoJm4PqSQgiirir5dAM4zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWj7dWQR7bGgO9QGqWTKG2fRcT5BdLvvp6q/xNDx9DTBKSJjzF
	F8+mfTrnsOch2rCn0tiZH7iyu8uggP8P/PypfimMUwaHCdeRZCWPsUJ4jnHyD3jFy6wfEVHxcOU
	OvUP9hdqaPz5S0gMQ+BMtcg7gsXOE4wU=
X-Gm-Gg: ATEYQzz+xWymM2QB/P/2iljQaD39uREa/aa87o4AF8Y7hBSv7UazVaRnW0AMc9JkaOG
	9gWjedVPaBdZYrJ2AVv4iyOJUqG3yD8FvmOO+DX/j/AGS6ABeLR6QUMV50JNdQ1KVb0pRRxH+Sc
	Kd4cjBSeLIM8JB09+373DElvgXUQnQq5+7YjnELtXGRgfmQWM0u18SQpFbi/COiVeExc+Ha7q33
	S5fTgSrma35xQjMkx1G99ZFX45bLMK/Z26cQd5nsJK472GUGZD7TL6T5H8YEvKO97F2/Qd4n/I6
	+chqzRw=
X-Received: by 2002:a05:6870:458c:b0:417:4c0a:1ff4 with SMTP id
 586e51a60fabf-41ca6d15f6amr4017036fac.10.1774527398240; Thu, 26 Mar 2026
 05:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
 <20260326013719.1662-1-fjhhz1997@gmail.com>
In-Reply-To: <20260326013719.1662-1-fjhhz1997@gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Thu, 26 Mar 2026 13:16:27 +0100
X-Gm-Features: AQROBzC5df8Kx53ffXvlh9wIgTM-6dOUFOdkLJ4dqCoP6Ot6c-qSsWpAuHW8GuQ
Message-ID: <CA+bbHrX3CdXqW6b0GbY_C7rmte3_9Q=89TJN=A2EBCQM1xSzag@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: fix the issue of NULL pointer access
 when deleting the virtual interface
To: =?UTF-8?B?5YKF57un5pmX?= <fjhhz1997@gmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230454-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,aliexpress.com:url]
X-Rspamd-Queue-Id: A71853351A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, in response to the three points:

1. VMware

2. This is the output of the lsusb command: "Bus 004 Device 002: ID
0e8d:7961 MediaTek Inc. Wireless_Device". The adapter is very cheap,
it=E2=80=99s a Fenvi AX1800 (MT7921U), this one:
https://s.click.aliexpress.com/e/_okxhxNl . But as I said, the bug
also happens when using the Alfa AWUS036AXML (MT7921AUN).

3. I=E2=80=99m not sure about this right now. I=E2=80=99d say everything di=
es. I=E2=80=99ll
test that to see if SSH is still available (I don=E2=80=99t think so, but I=
=E2=80=99m
not 100% sure at the moment).

Give me a few days. I=E2=80=99ll test this again over the weekend. I=E2=80=
=99ll also
run a test on bare metal (not in a VM). That said, like me, many
people use VMs for pentesting. So even if it works on bare metal,
which I=E2=80=99ll test this weekend, I think it would still be worth
investigating whether it can be fixed for VMs, since many people,
myself included, use them for work. If it works with other WiFi
adapters, it would be a big drawback if it didn=E2=80=99t work with MediaTe=
k
adapters.

I=E2=80=99ll also reply with a similar message in the thread.

Thanks and regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El jue, 26 mar 2026 a las 2:37, =E5=82=85=E7=BB=A7=E6=99=97 (<fjhhz1997@gma=
il.com>) escribi=C3=B3:
>
> Hi =C3=93scar,
>
> Lucid-Duck spent some time trying to reproduce your crash and wasn't able
> to trigger it. Here's a summary of what was tested:
>
> - Kali 2025.4 (kernel 6.18.12+kali-amd64) VM on QEMU/KVM, with my v2
>   patch applied
> - MT7921AU USB adapter, passthrough to VM
> - Full airgeddon evil twin flow: monitor VIF + hostapd AP + continuous
>   deauth via aireplay-ng
> - Also tested on bare metal Fedora 6.19.8 with the same adapter
>
> All tests were stable -- no crash, no dmesg errors, load stayed low. The
> deauth frames were confirmed sending for 30+ seconds under the v2 patch
> without issues.
>
> The one variable that couldn't be matched was the VM hypervisor.
> Lucid-Duck used QEMU/KVM, which handles USB passthrough at the kernel
> level (xHCI). If you're using VirtualBox or VMware, the USB passthrough
> path is quite different (userspace proxy), and that could potentially
> explain a total VM freeze that isn't a kernel panic.
>
> Could you please reply to Lucid-Duck directly on GitHub with the
> following information? Here's the link:
> https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4129198757
>
> 1. Which hypervisor are you using? (VirtualBox, VMware, QEMU/KVM, etc.)
> 2. Your exact USB adapter model and ID? (0e8d:7961 covers several
>    MT7921 variants)
> 3. If possible, try SSHing into the VM from the host while the display
>    is frozen -- if SSH still works, the issue is at the hypervisor/displa=
y
>    level, not the kernel.
>
> Thanks,
> =E5=82=85=E7=BB=A7=E6=99=97

