Return-Path: <stable+bounces-238547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGiAAzgl42naCQEAu9opvQ
	(envelope-from <stable+bounces-238547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:31:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21F4202EA
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5249303204A
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEA34D4FA;
	Sat, 18 Apr 2026 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqgIAlo2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E242248F7C
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493705; cv=pass; b=i7nh6UIWhUuVLbwaLCGSsqhiaM4IvghC73XgJGAAFkmOctax2eor/Rt6HpyGTifTAzkx6rf5tyVYt5bqBPYbEEdrQZ1LtGZoe71mFbPoBIqf9zMNAJwuVnqIjaccvpfIdKbmJo/gMJeiuyBtBufGOhPzWBZ+kZh6JWw1wY6gUs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493705; c=relaxed/simple;
	bh=q5sXUmmHRoxu8wAX7Z8moLBnkCLANJH3ZJjuZ5dac78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hsh2VCAYZKNI/ghzcWjqLXkOq6ejdkxsoARN5IXy1s/gTv9m3hnAwjlqWJGY5EhQt41ERqFUl0jVVXg8qEwXKOiv+8u3MBTIpX9pC71UUtdkscYCa3ZW7WOYDoU/CuNTY5r45Y4er+AP0gaDCBDLXy9yt1RApUqJmA+M8YTBfo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqgIAlo2; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65075c2ba66so1012651d50.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 23:28:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776493704; cv=none;
        d=google.com; s=arc-20240605;
        b=MeFXtRobfTl9eb3/ATuI+1AGbjkb8B758M9hKbfeHTMrscXXxKu+/+XaiFKJmzuhll
         tUxET8DJads3batmgHQDE2NBP63hBf/pmkqmqoZq/0OH4gmJRArORMLz0VAceM8jW710
         REOd7uKROGS3IwuOn/R78Z6RUc7Dhp1Szntuk7GzpBBy1vGIw3k5vOBTLDsspQc6SCr1
         bSTxJieVJBxVU7nuYebFuNY7vAMNoSp9NtWmq7TwKsoJWI/nDGFkmhYcL9j/K8gpwvTj
         PYefXGqkjaidmVvonftNkDYzMLw9v8x5L4/b/2VPB+pH2NnVjBT08L4KFVmkRTOvOr3t
         5PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VRGdNT5EVnDN4KpPjGoIdZF53jgO+iSGoqzCoge+7ig=;
        fh=J0NDNMW+6U94pN9zsvB3Q2N7ZclCudpQeS6ARglucls=;
        b=F7TBd0gj6UyX/HjcBCjPyUH4KOl2rdX0yFTN1dzEOXma3iUzwoGqo3zLdrL9ktQgKk
         g0sGa/Qv/kNMeRUPnqcIMyDYr0Y22/BE1zAqDRV2znLjW3hdjEKGapwpOudUT3In+HOy
         cHXbk/hBjaQw4ELU6owptzpNE6uacDajzMQZCpX5BDmF7JCc1sk6IGjwLDq0xL6yJ81P
         0iLRSK8yXstoUK4zD9dBtOrrSsnEEyVL13yxnh6LODNRyC60lP276jWZMOzs/uVlpvep
         mcSIJ+ujhuAzNAsUExAB/91FCcBABoApE1x0BQmgH4iNYAHuJb0aSTz9P5yNTiSe+I5V
         MeJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776493704; x=1777098504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRGdNT5EVnDN4KpPjGoIdZF53jgO+iSGoqzCoge+7ig=;
        b=qqgIAlo2IZE61aX3Dp8DG1I+TTDKMooZPidwfeYUizXzN4Kl/OYOJfv5FrxwySnqof
         WzO66BPQRc5kGcOWu5AMAW82666ZZwgF019DXezIXXI+kuyOLpxkYXdw7NiS3fqaHAAg
         E/w5wRJwByy1pCebCvbiMI/nD2iHF/MfucJ0ZDknSeE7RmxIWmAs7vMrXHj/pp575nAA
         niWxfSbv+763CXGWUwecVjyT6/DOnrEPzvRyWMYfE2UmWYKXcn8EmlYjZrahlDI2Qrr6
         zwBn9eg0LpjIj5pUBX+vkyapmuIyKt6CXEuJpxCgf8TE+BHZA1z1c07rSiJLGX4nMrwW
         zzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776493704; x=1777098504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRGdNT5EVnDN4KpPjGoIdZF53jgO+iSGoqzCoge+7ig=;
        b=FbD05qM55qJMBanWcdL2gi0yp2Imw+x+Tod32sU0xDkd5Mj2Tx2/YxJizw9SpL32LC
         N7HdowhQiXNDS0nK81tnbrx8pWvqaqIH6veXxnau8Ui0Gwqw7dJgcFC6MUIDmYko8Yoz
         9Nxd3C5hefjhDcj79Vn1h9krHy2xbKzN943wGHqK0xXNcX1kEa54YXyj8PXe0vJQ5k9o
         GYyYpvm1glMs+Rgbn6NTZ2prh17JXW/+bbSTUj2CGn70405ocpwQ97yQQadJaqUhvgYX
         hXYfweCvRRCfLXCZgVBkrTxU08/uimgwqDMVvM3gPUNqk2BVgb32biPhIBXGELLbdshG
         VwuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FehVDFVdxf4kFDTC4be3jtUdFuKkXQn/55vIehT58nZ/LS1aRK1W20LFZZmuxFBSTTJjjeHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw131G083mXo76+y0focsdMn/MALp8iNwfvStzGV6XR9ZLqHuHN
	h09rh+/8aiFTLKz4wNudsHNjiA/tVLAoRl8PHYeole7OH6tff8tNnoLsKR8/v5vz0qtqFnqV4By
	y4vD0qnhV+uCyiXE9SHLFzJr3Wr0ooAY=
X-Gm-Gg: AeBDieuMHUjeMEb9kph/onAD7GBHSp6SXhjYXwW0iW2e9Sa0X8ZHoSfNWC2FZS8YJq7
	HSkHHp/baup7ne0yO5qofchAQHKfvB2HAWgVLOScMGLKIMv6UobhFvcIy6U9gLxC1hEFYIlTMMu
	T5VTjulhKseAqcNIdf+rKng8qyMWiEp6+QNgOcTb0RGnXzsHIG8vwSOkScbfGgKXUmLQNL0HoDu
	6jFUUmBOKP/4VBEVnab6MkCJYzA1mLNyh81DTxdBsiJ+A81vhPJPPWFxZZE60oH5vo9f+VbYVDD
	i6w2Gds3XuRuqkeqe/s=
X-Received: by 2002:a05:690e:4812:b0:651:cddf:8c2d with SMTP id
 956f58d0204a3-65310a558dcmr3722853d50.43.1776493703618; Fri, 17 Apr 2026
 23:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415085109.3267323-1-lgs201920130244@gmail.com> <mmcqvvqqq2yj65adm2prscpnxtbp5tljaxtbiqrwlfwpwd3slg@xniqactlghfc>
In-Reply-To: <mmcqvvqqq2yj65adm2prscpnxtbp5tljaxtbiqrwlfwpwd3slg@xniqactlghfc>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 18 Apr 2026 14:28:13 +0800
X-Gm-Features: AQROBzDREeOl9R0EzGYKW9fIL7PkN9hEOk9Qv3oFYdK7SQu9JTEYFKTiqBjhzxs
Message-ID: <CANUHTR8h3nKAXt1fh49h=c4Mj7mH62cA7HCUar9ut3gZCW_Y1A@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: fix device reference leak in firmware_upload_register()
To: Russ Weight <russ.weight@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tianfei zhang <tianfei.zhang@intel.com>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238547-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5C21F4202EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russ,

Thanks for reviewing.

On Sat, 18 Apr 2026 at 07:22, Russ Weight <russ.weight@linux.dev> wrote:
>
> Given that the free_fw_sysfs target is used only once and no longer
> falls through, I suggest we remove the free_fw_sysfs target
> altogether.
>
> Instead of:
>         goto free_fw_sysfs;
>
> Do:
>         put_device(fw_dev);
>         goto exit_module_put;
>
> - Russ
>
> >
> >  free_fw_upload_priv:
> >       kfree(fw_upload_priv);
> > --
> > 2.43.0
> >

Good point =E2=80=94 I agree that since free_fw_sysfs is now only used once
and no longer falls through, it makes sense to remove that label
entirely and switch the error path to put_device(fw_dev); goto
exit_module_put; directly.

I'll send v2 shortly.

Thanks,
Guangshuo

