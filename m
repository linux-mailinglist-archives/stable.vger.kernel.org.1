Return-Path: <stable+bounces-235948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMKxJ2aj3GkqUwkAu9opvQ
	(envelope-from <stable+bounces-235948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:03:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFD3E8BDB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0A73066BC8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1661437E30D;
	Mon, 13 Apr 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO1RK0xq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CB1DD525
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066919; cv=pass; b=szeo8c4gjMLgG8FkAo6fuUlwNm6z4Ux1Z1ET94HuEtOniuahMV3DjDdAPrlRDQLBFptRk1rgsZjeQNtd+HukaNnmSeDfgDuA9VYHd1ccxcVKiAcO0s4Zf2cFvh8SoIqJlaXbI7qlFJgdBO80nA/32BbLA/3qpbTeux9fQZZYeoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066919; c=relaxed/simple;
	bh=9gc0LnLyL5gZ/okwpuRma5xwO90aLrmno7f04MKpCBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRagZgZbv1xREzPmzY89GqFl7Uk6LbpFEHe+aKDR0cNQ1aC3x2h8hddAeEMuTzSkO6hoyyKqM/XkRawzTZySLrVF8iU+CnWWZDnwHVX6vSACl28FZYv+u18fOQbsHaCXS6WK6/UwIJAI4dMvxrz7O4F544KPAifm4axHfMZPYwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO1RK0xq; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651b0eb2564so1344564d50.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 00:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776066918; cv=none;
        d=google.com; s=arc-20240605;
        b=bwfT6P6OvosAIXZFs7HNDTRe3L09XX4tpCqU8AAgEb3DiXMNhfhlwXO6pXQa6h2GMt
         wg+SDlforrBYi3EFIA9jKKWQ8qhVqMhTBwmo5FFina3OQvgXmGG8IxyByxghGixclqvr
         YVyW61Bu7LG78cDVMZU1xF/2Iq259m4njnpfGPC8qTY/QzHnzL6ncj4/QZC135vWYFmd
         0FVHWJSvZLlP/yiS0LL0Zkr4OaIwItDepwxTxUhPNez3FIaH45+Uh9w7XB6CELAlhdtC
         aNqZIB5LMzdl9C+gstaTaqaa+4mTBVlh5L8iMndips1okY1CMA4oEPeuRVIOhg6jfW0y
         oW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9gc0LnLyL5gZ/okwpuRma5xwO90aLrmno7f04MKpCBE=;
        fh=Kioocv5QXhOqyG7cnxBaBc0ISiVQy1TLofYHtbHBMHg=;
        b=X8zLYlrgmCGeyxGlB0pyXgeF4nbi0RylQyAm0aYxYZqc8BWi00crmrq2n/+Q5/H7Hz
         JLRvcNfCrFniATPaFCgKA6zunRIF3/3sJRAAXrKx16EDivpaRn1Nbm5vZofzINeWRP7z
         jjbbVyuItzdgSN3ugTjO5RwjCmq8M6ovPYIoKb194s5udrrhj3BvfJHMSzEA+YdROJL6
         Fa425iR6hcKeS49JhjwE8GhXTLxLgkt5/sjyGSuo/kWLJBGmiAhjIjUrJ4SvZBPDD/QX
         E82oIUvqAlLpFvxXvgqrDONGrjqp17lMDwRaUlwbKCjn8rXbE4BQPZKxvO3G1feSbiQG
         D7lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066918; x=1776671718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gc0LnLyL5gZ/okwpuRma5xwO90aLrmno7f04MKpCBE=;
        b=JO1RK0xqPfeEk7i5h/v/lDu9og3nXjLVZuzGecAJR30OafNu3G9vwIWtBY0jalQ7ni
         icBL0v+nu0RQ1zaxNSnm5CMlj3PSIF7bEUxpIZmZpPT16yiQmzjOhlEeybJ9BFHBHYi1
         8B7wyFhw7M90XwKYUXMsN/tZVS/GUVD7h7YkE7YMktxrR4ZCiwM0QfOTose5qxUsTDho
         udOKCYKhMZ6mn31DsV3TrEm3/h0ligtENq7buANUeXZtW4bSWOMbKdZxKo9ZNEIWMIxK
         ApIi0GvYtYWWb9QarDGiewCXi4U3xlXOlmfbdnHvMvuFs5fXZpGUNNJkTImOK5ve/Mgo
         urog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066918; x=1776671718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9gc0LnLyL5gZ/okwpuRma5xwO90aLrmno7f04MKpCBE=;
        b=bYSDo5wwjHQcSbgA8oYf9vGshU4CpfMoNTVCL6jDhrqtXKYzz2e524fj/GbFFQOwY6
         b/7twZdZifWzf3yjTWdSyme7r2bGOey8atZJjmg0l71NZ2Fle3tw/DHGoXFjCjI9hPGb
         Fo9Olv/gi/hCI/eD0eqAhe86LWryDx5aIo6HaefFlW09+0T88BhRAiJijZbe8WKICqcr
         i9Su7+0KTsWTsGZD4mBKdigSCBUULOcAGfc3IoLGTxgvZagROE8F36rj5AxvJGVZltiG
         J5/k7/KpiMu7dah5t/l9tVJ0pMb32EG+suIkij/gSlT+nJpj9pFuAoj0cQqcqfxxY404
         PgvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NdrCQ0H6clqWLb9pFTOUyuj6MyVKo8V6Hb/l4y7oa6R1YL1WdoqOdXbSQpxCicRdCiCdEXII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxehGrnBaOjZwRBxQ1mOQTVNiZaxT3QVsSSbZ5B1BtR5X8mgqqZ
	8X5FMhQFul8etuPSCtPWH9b7Cqht0zlYnnEDt9Rtv1+jyKz9FNUUXrMjc1BH40RJktzxmKsi0M5
	yJzbqKFSLrrwkjGjDJpio4mDmh3c+PGE=
X-Gm-Gg: AeBDietG51n9+8BHp2yTUkGJ8mR52Oh8KxE9uLlkAQYM4FSF50VYX1DgV1qCYp0O0BN
	tz2c5aqaW1Z7cuM1s1FTyXv+FGnzmD7XSPYu998X/oj/6EvcYf/k2Cn22ueH5E1ooGXFsnNTQfr
	R0tX5LZVntVEDINPRrHfZ7guP/BDzIIdx+edYSLNMWcweU7JQfshUV2sFg74/caTxwc/+AU+u5y
	BcwYCentVtgTeAG1Bb5I4gZaewrWOVIjLqfw8nWaV2jsagj9EVBd7Vh1RSm4k0GRoMYGtfrXCPB
	csQkBeg=
X-Received: by 2002:a05:690e:134c:b0:651:b7e2:6835 with SMTP id
 956f58d0204a3-651b7e268f5mr6139035d50.35.1776066917886; Mon, 13 Apr 2026
 00:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412165311.2578501-1-lgs201920130244@gmail.com> <adyT6oW0UgvcEQbX@hovoldconsulting.com>
In-Reply-To: <adyT6oW0UgvcEQbX@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 15:55:09 +0800
X-Gm-Features: AQROBzBvM2t448POngzR85HeuLhzGHKLxNZZ_0ViYHX8H0y7B2Cz5TcbmZhUfog
Message-ID: <CANUHTR80npU59MrNq=1nYnb-r1ASKv_nG7=NF_G_Ko9-V-XaVw@mail.gmail.com>
Subject: Re: [PATCH] usb-serial: fix port device refcount leak when
 device_add() fails
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235948-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E7CFD3E8BDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johan,

Thanks, you are right.

I had missed the disconnect path: usb_serial_disconnect() retrieves the
serial object from usb_get_intfdata(interface) and then calls
usb_serial_put(serial), which can eventually release the ports through
destroy_serial().

So this is deferred cleanup rather than a refcount leak.

This report came from a static analysis result produced by a tool I am
developing, and my review of the report here was incomplete.

Please disregard this patch.

Best regards,
Guangshuo

Johan Hovold <johan@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=80 14:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 13, 2026 at 12:53:11AM +0800, Guangshuo Li wrote:
> > usb_serial_probe() initializes each port device with
> > device_initialize() before registering it with device_add().
> >
> > If device_add() fails, the current code only logs an error and
> > continues, but does not drop the reference acquired by
> > device_initialize(). This leaves the failed port device referenced
> > until a later teardown path, if any.
> >
> > Fix it by calling put_device() when device_add() fails. Also clear
> > serial->port[i] after put_device() so destroy_serial() will not try
> > to put the same device again.
>
> Any port that fails to register is released in destroy_serial() which is
> called when the last reference to the device is dropped (e.g. when the
> device is disconnected).
>
> So there is nothing to fix here.
>
> Are you using some kind of tool to find these "issues"?
>
> Johan

