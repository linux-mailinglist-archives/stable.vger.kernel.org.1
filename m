Return-Path: <stable+bounces-214431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJPED2BghGny2gMAu9opvQ
	(envelope-from <stable+bounces-214431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 10:18:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76B6F07FB
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 10:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5CD03016710
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 09:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F1389445;
	Thu,  5 Feb 2026 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmYYZMit"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D4389E17
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282841; cv=pass; b=h40Wgykao6GyC2LTEzr+kDYeW4d88H0JfPulU8hKbD+vg6anqi/xQjTiHRy0uzO/s1Ubt6nX8RkcXEPTjPof+M2lAM1f2y6TOr0kGfW2u3/qJKNjClVrGP8JmN+sfI8xOPonI7esiJbOLizq6qJKxD1OjqmtVDR2fQmuc+7oqiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282841; c=relaxed/simple;
	bh=kZy9He49zevIscQI8TKi266PdhFwv75woDxw06ZBjks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oU01d53bvlXu6u3n7MUSUKmzRuiOxiKBtsIAE020JssDTzJ9B26bcCe7eHnxKnYs0Wz//mJoRAcsm20aZxPF8C/7YDZy19MNrLdjIrP2LnJArW8IFs/qz827LgzkZ715/TOI+GoAb4jGyxx9txBWxmVYNix4FxdguilQKBvWuII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmYYZMit; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so4993555e9.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 01:14:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770282840; cv=none;
        d=google.com; s=arc-20240605;
        b=exWQrgo3SvZsFfOUTxFPldVCmLIFAwaEnsEzanWHpK9w93mtN0XfCb9sPeKuPXvihV
         3NIljna20zXMZ+fLsFGYoxF9lcd/1VCe/lA2warjoYbCfQtXF4NBh6epOCXOW+TcZ8I/
         druNoG4btFq9HSUWtvEqYbTdz5wzVR+d4LvkaU0lJKirTJdrYO+YC/HGf9eZkr0dcmKY
         1SfhNdKh6lo+LSj9jX2WxPN/al37F0x0fxpW8vHml6hWrjiWR5StX0JxjrfkuTRbHORk
         hEkfLl45Wbql1a2LFPw7eyj84076Zcg6LAR/JISYURK9FK2gIGID/Nmok1LWIJi+kJeE
         2fLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kZy9He49zevIscQI8TKi266PdhFwv75woDxw06ZBjks=;
        fh=9K5ujsQeUFORUAhnaZUdk2S17UPrL7Z+Z2H91is0Y+4=;
        b=RbsT3ZL1qX8skhNg/AQ4PjjW5OWRR9IALSDJRHVHE6yZWB1iUGlfP5SfaNgzgyLh5D
         UqaMRSbBR8i4uFn+FuGKEg8W2D7cu37op+0RmTZ5sUJgYkk/ERKIFjJO98Rx+SX7E7I8
         KyDKGwQARBJ0CGzYpjR2g6OoNx8qWTna7Zh+XllyMGZEu13p6GdWvf0t+mMG5I10p0+j
         6D+WAMy6zOpSKeHqvubEqXaIRy1BL2y8ySvLMbhUvwccX6qOvTou6/6kYSlbco711Z/D
         mPrE5bTv9vNZKQtd5nFFD92TUqoa2xrQrnxsSSCO5/denpodv4E8qU0UKXMTKDKfrKSo
         J1ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770282840; x=1770887640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZy9He49zevIscQI8TKi266PdhFwv75woDxw06ZBjks=;
        b=RmYYZMit+tWQploXo45nSdx5BJu/qw+y8FJT1TxG1W2WxV3lrYLOl+lL/FWCk4bBCx
         vlGJKH4cqyEB9FzN+vk+hGkVqMVshDhXNnFmOS5hrp98/3HlOqDnqAXE1tCQ0rSCxbpA
         C8sbxX4W55MH6ar50yCqMRJ1l7BgUERPlAhK7KzQ4TlaeN1cV8BN/MhJchX7CsAC5QGM
         KBOxgm+iyFhgTFzvKsZ1zpPDdsyY14FWKotFa3DVT0Kn3H027lQFxHGw/L2FVc/Tof5o
         UcK8i1+B1V0LmVmZV0A6R0Lge399bL9WDlDccIAyuqbrDcC3PHHTU7F0Bo+6GbCS1L/N
         V9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770282840; x=1770887640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZy9He49zevIscQI8TKi266PdhFwv75woDxw06ZBjks=;
        b=vnkp/FFhFw8a8iQ3uDqsRTPGQaOemyv5VMzrziRx3CM1L+bag+J/3iOl43Up3bI8rm
         1o8KqozJWjvEZoOAs2hfJe4BWSzBDKYLlqLcRSB6QMARxOKtGfJyd6bABDmkC9n7Pa9r
         gt3nC5LDCSwnAid58aSaPlAj3AfVho5Okp6Y/3+Giy98jMwQ1SeTydDS5IDg8HA7NyVR
         NRoiK9HHaCCHxyq0duciNfmKnmG1AP79+9FThc6PfgVqJGOhk9kxvwBiWus4dJomC1Oi
         nfkXnhyjmTiseVcWegWZSx8Nf9gfdOhNcfuSpHt3QBaI+JXQxQoRdMMisLCkGTwWQ15o
         ecWw==
X-Forwarded-Encrypted: i=1; AJvYcCVmiupxjpQKR/MtAaTtSExKsL5EEpL2Orj2HFGSnJ1kdrcCfRR9gp3efpTIJzsuTILO6oUH3O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0SZIW7huBdhaP7TQ23sWmQARMLMAKlsmHcUzoIxIOJFQxbI6
	MGvjmmMudtXUmIhDX86fVE5lPhGSrFStz+jKoExge01Db0V7AmAHiq204ZdpaZloQVIS4q+ge+M
	RbLmYt4gKme23TRMrqluhFmMuJLDeRJakRh/O9zMB
X-Gm-Gg: AZuq6aKC7X6hxvcfJyXZilaDbA6cIaJoCMR+rO6mVW+x38FydyVDDn47isyTDQT2NY4
	hrxOBPGaOhVjgRyzjy66hk6q5V0hQGoKLLcPF/0TUwrDXGgiKwli6A/BUcuzl081azOpA3qeNxf
	RnBbydMZRUKgNWpIxZ6SmKEqW/QnZ4trMlCOxuKp55GMZlXqV9Sz1IScoAdr9dN4NZoCuPYmhVR
	RZmd8hX//nCAR1ihJ5MzU7BJ4707vlaM1U0iPq/7lwt5gAjmllrmXM2xzszX5VjLlDbbCf2KEAU
	Uc+GkdKFhySdMELkNDl/MJxySg==
X-Received: by 2002:a05:600c:1d04:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-4830e979529mr86636545e9.27.1770282839548; Thu, 05 Feb 2026
 01:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204143858.193781818@linuxfoundation.org> <20260204143905.245830999@linuxfoundation.org>
 <20260204184810.GA2715873@ax162>
In-Reply-To: <20260204184810.GA2715873@ax162>
From: Pimyn Girgis <pimyn@google.com>
Date: Thu, 5 Feb 2026 10:13:48 +0100
X-Gm-Features: AZwV_QjqlCzx2sZYGhkrTvRiOprnY_rvYth7AxrlqHjxRYRPxTSZ_CfZuKQ-TKo
Message-ID: <CAJWNTGz0Yd4W3piDT5RFzmmKPhcUaNu0pSEgMOF3U0FmfsyzVA@mail.gmail.com>
Subject: Re: [PATCH 5.15 195/206] mm/kfence: randomize the freelist on initialization
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-214431-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: B76B6F07FB
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 7:48=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
> This introduces a new instance of -Wsometimes-uninitialized, as pointed
> out by this KernelCI report:
>
> https://lore.kernel.org/177022794292.7001.3716577555750776270@22d5995788c=
3/

Thanks! I'll be sending a V2 shortly.

