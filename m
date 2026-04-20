Return-Path: <stable+bounces-239228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN6MFxJJ5mnSuAEAu9opvQ
	(envelope-from <stable+bounces-239228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D042E78A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 126D63224069
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C533D6CA5;
	Mon, 20 Apr 2026 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6gO40bB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3993D6691
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692347; cv=pass; b=k4rJCdlIpL5ECk2jLGRVujF0v3/RwDwZoeueRD0DF4VfSjN3ehEnq21ZcsFwYYYayIVRO1oK4yeD30X9cAOVq4btE7fCO/4NN/vPRpV0oNhykJKB9lYzx8AnGLROSLgSkLtFKyEV5OBFQVGjFYUlb6Q4MzrMLktufWj8FH096xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692347; c=relaxed/simple;
	bh=/K9UOf5uqT2sQnqLd2oKoclnHJwSG4aPabyxOCos+4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT2AJRlX9TMJ0KQOU6HuadmvM4pRPaHPxvYEalAIsyPH0iEcX2NufUPT9+kE+8mbz9szAJ4w8fOdCsIulOQhRevgOhVgESYiC3iqiGNvqXCYdP0MKLGjB/yaqd2bu8zy+/VpoNEC1Lbe+jfNr31gWSD3nlE9GbPIDtrsRCwKrks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6gO40bB; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e7d984096so32529261fa.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776692344; cv=none;
        d=google.com; s=arc-20240605;
        b=cj4B8e/fs+TIsv7sxiViBKDowNuvZM+RgPxTzW3ai+VyIKBTYkO5rX21BL/8TAu+EV
         w/TIb5VPlJJbt63zBDArPnPnYZBBJv8aAWeNo0P5OxgLvG1ZO9UmOHswvuMGTV1Brbpc
         0oD0vINauFC7tPp9Zbi+Nx0I8elVCpzbL7/Bp3wdr4AqWCVPmH4cxN+LwJZF8DyXL0x7
         l/2LdPTJhXYyzRWy8HzlqjkPa+D4a4N6BejnLLA6SKFZ5uGPERj6D5jcho09PM6LXZxA
         sC2JPr4ayTiqha9dLg2DFIEx13U3Q4cFcfNQdQN7TLFumimPNPz5DHiMsZbYY+HBpnPh
         o90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G8DASL1EiWTXednHDBiz8AtRSsNePlCWQ5TEGU5yhf0=;
        fh=Gbu/uwarjVJ+/BdLU9UQG1QDud+SN3eNgkEad94h6YM=;
        b=LsonDN94QnosjXpgGw30dVltFuKWDq3Lepn4PfcJozI6E82qJRiiUmYdk1jjGt6ZNb
         Xq0nFYWwQixeu1KLr2reoVOdztvlXwCh263wQ7LrXGRJP7edLBOII09ndEGA32Pbo7TJ
         +xE2+oJJq25f2jjZ82nS2LK8hjTBKOkGCvmJtfX/+FnBIaGKnMB+XHm4on7Bw7WcH9is
         eu6dHhanCg8VlJZozDglT106vMnVOTnPAZO+6fcVIhJ4mA219GqfjIYKcHsSM0g+tNPE
         6dANDHSGCWteiv5DKmg1BdRx/E0+QvHT/6cAvF7Tmw87WQSL+Tf/J1b7fjUNd+Ce2j5U
         PkGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692344; x=1777297144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8DASL1EiWTXednHDBiz8AtRSsNePlCWQ5TEGU5yhf0=;
        b=M6gO40bB9Yu14z9hBzVzmDeUAxkuDY8H3OhMvcv9NRGIWhphybdIno5XKNstnMMVa8
         EHCGGoSsU0yyU+2PXbYGBKnG3GOq3x0D2As/UVmAgFFgnNqlBOXV3Iwn52XrwNgqhqSI
         SZWuSA9Qts5+TWU68iEjV0UeYBhoawpbiEeBgRKOEt7HUpJrBhIbBXyiP8gShJZb8MQu
         IN1TR0QVZux3Lpu5QgmECV+jun7/eW+V4fxQigKZp2kY8yWRDEjK/l+0rIoomsMrTMCa
         hdSTqI25HTs2MXAHzldpoYwy6kKEbqXyMlhVXsC4G6XhzaPZvEvvXFII3gcelDfzJhA8
         zmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692344; x=1777297144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8DASL1EiWTXednHDBiz8AtRSsNePlCWQ5TEGU5yhf0=;
        b=RGxlMBlH8aKo1rPldfS/6U5uPXQLoqdNc2GgCPsyjO05N1S1YDkXZxvmtVqnpDzmN2
         oPhVDwjh617SbDOIEdiIS2KDg/9SgKfvmRe+HaoeQWHVjN1xQ5SSOPQrczkb8woRqDnR
         MJD5jLu6ld2jVGP4LmNi+V94WBcxIN+fWE470EmWn7IK8JsbwjbgdOi/x/A8UwRkQSpb
         LSDXqsEr2VzdQRMrTfjR5ZFUCsm0v77EcQ6to22B58OMyrSCwfp0icpg2jjw5N8AZEID
         XBQjxHb0zZBcZi+RshHfKTIJA9uWLc06zHNzLadwrbMo0RwE9IptvLiRzxzjzd/UPdQk
         WpHg==
X-Forwarded-Encrypted: i=1; AFNElJ/Q7UThKJB3sydIpy+HEvv77kqAZp+HSs4zgFHl68q9NA2FQXpqKxlmcrFyRABDcUEpndnuR1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/xoE+aVF1xy+dWkf1ESl/WV2VGyoSram6vf0ZtIb+lnJh+RN
	48KXvTf1OT34mfcTtb8G6XrGorxeQT3oM6LRTx77cY6mRUDnS7lTb95oOl4MJw8lnLrBFELNbCo
	da8HNWx9xQ5JDRdis6Eakm1Uzgk6QjlY=
X-Gm-Gg: AeBDiesaXrtEUdcHKUFm2hn5AfqR5d1A/y+UK+iye0XhDKdopaFxXnnqf81O5ZTWxj4
	dhsBCg63Ixhyb8RsumnKM9fth7W7lzHukdIwDgh15h4ETfl6975mRTA4tf1j6g5T7pJ3mn7L1VR
	Of5Ae29O7XbZxSCxYS0pWnO/v9HtzxJBMq3VGnTMPvDL21FDDmWheP3J4BBLIKi7uYKBYz+/BCV
	DPNu1CxYyhz1L2PfLyN/f7PkeCMylHAYxvHsDmBjLaerYw3PshXHZuN7bjayBTThWUQOQM7ED7c
	ty7AtzqB11OX5Dt/
X-Received: by 2002:a05:651c:4208:b0:38e:7ed2:b63 with SMTP id
 38308e7fff4ca-38ec7acfd31mr36038541fa.22.1776692343742; Mon, 20 Apr 2026
 06:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com> <20260412135743.GK469338@kernel.org>
 <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com> <20260414112951.GD469338@kernel.org>
 <CAKvcANPEa91paujTQjpW2hZhpXEhwfOjjy6CsN=OJ32iXYXdTA@mail.gmail.com> <85ec14af-bdd5-45ea-8c06-ebd769499bd1@app.fastmail.com>
In-Reply-To: <85ec14af-bdd5-45ea-8c06-ebd769499bd1@app.fastmail.com>
From: Kangzheng Gu <xiaoguai0992@gmail.com>
Date: Mon, 20 Apr 2026 21:38:50 +0800
X-Gm-Features: AQROBzBrhMAvRHsvT_Uh3_bh_6PBMT7vbMlO9R2BKmmLDZimLRkGEVK80HjiNtE
Message-ID: <CAKvcANNyS=itNKW6LBAHb+iOV7v7fNt=rsbuLug8_cgfS85Eng@mail.gmail.com>
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, sjur.brandeland@stericsson.com, 
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239228-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,arndb.de:email]
X-Rspamd-Queue-Id: E19D042E78A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ok, I would like to wait. I am just researching for security.

Arnd Bergmann <arnd@arndb.de> =E4=BA=8E2026=E5=B9=B44=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=80 16:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 20, 2026, at 10:09, Kangzheng Gu wrote:
> > Thanks for all of your advice, I am preparing a new version of patch no=
w.
>
> If you are actively using CAIF, please chime in at
>
> https://lore.kernel.org/all/20260416182829.1440262-1-kuba@kernel.org/
>
> If you are not actually using CAIF, maybe wait a little bit before
> spending more time on it because the patches may no longer
> apply if it gets removed due to lack of users.
>
>      Arnd

