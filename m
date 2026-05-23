Return-Path: <stable+bounces-253926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHyVJnKNEWrHnQYAu9opvQ
	(envelope-from <stable+bounces-253926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3555BEB0F
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 881FA301ABA9
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A923388E5E;
	Sat, 23 May 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amtVA1oW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F542F28E3
	for <stable@vger.kernel.org>; Sat, 23 May 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779535012; cv=pass; b=TaAmcXfvHdpYDjQK66IXbi3f+lcbvhM+QSk5G9yi6r8D23b1aWsMg1mldPhvI7CTq6L+VUDDix+cXtFlUQHoA70aksA9z3l5k350RwOSy0ZMKTrUiKTw7NNa8STKLjOFA2q53q8KexBa5d0mhvxd7/PrT1UdjNUOOxyX0MiWOYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779535012; c=relaxed/simple;
	bh=NypGMlp3cyhLiUYrJBvQ/DxQ//zQTlSSSmvew8byhDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNsJxMS/b2QQXh4GSjrTPZIG0y3Om8fZ5z8O439J7qJ6g2+JG/WPz/VapHqZiC0+iTFAnxMO7wl+0ImBAT7loi2OnPPeuNTRGLpu4zIQC8cMsK10a2nyVxf+rFmsPb1yifgiSzVTcMs+A5fxlBmr13Ps8DtzfK15dWGq14NZFoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amtVA1oW; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c21049dafso7385983d50.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 04:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779535010; cv=none;
        d=google.com; s=arc-20240605;
        b=ieuNl8KfhSs3VnD2kBc4faPnsfuuYwKSjeKOGjEGBoK0NVMHUt6Cy/fxT4OEQKyedg
         J9K6Rxd0pMZi1BhzYOyTC5kTZXY39rwvgIHpB47pTaO73Wm9bATa5xxDPG+9d7uNcrL0
         rfv6FrrLoiRLOp94yPJXyYGmK5ngrLKDo/d0KY/PAATlOlmWc3rvcB7LCDdhpw8vqKv8
         4qURbnK57vOPylE8eOboNZPs7PkF+RUugnxLj6ToufFkp2ZaXe/FL44e/iCpKiSlv3nM
         nWe4L4s7NCH1bEntsC93nGNb13lNfy4ZgB4Kyk8dumAtMiqILtcpaE7725rwEtsWJH6c
         bueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SdF6tpQVLDhXweuUd49vYyzxySvvSzPJQt+DpMGXwZI=;
        fh=swKmSvffx16TEoBZQc8Q1kcJTBTbdNUq9gba0X7aWM8=;
        b=XXovjDO49cKtu2GOYzFXK/RiErANgnmR6zXtR9Zio8XwAyfg+HgxXW96YHL5zeZQ62
         OzhoGmYz8G7L7G4KYq1QjSm+iBaZLUWMPvyO8s+iQWI0sbSvWN5HNDfLSLuQvsh1EAmM
         KIbagySGyCh3qs45UP0si08JwuefkZNIt0ApAzfUq0bI9U//3OAtDMcwt3F6A40SL6jS
         C6ZjdtmHeZNVQ+9/+h+Gf9vu3ZMXVb0+orFPlIA8yeujkNZC8f2I8n81W423pm69K64n
         /dcC/vhN/H9oJJhyxoRjM++shGhHL+RV6p+NQdyKOzvlE7BnZqMbXPmdOjX1nzl9SGn6
         b0Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779535010; x=1780139810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdF6tpQVLDhXweuUd49vYyzxySvvSzPJQt+DpMGXwZI=;
        b=amtVA1oWQuwPwEDiftcxPHNm8z9z/6MfaFGXc+GAc2TXErUvbx2LO/WBrmvMQHXIF2
         ivW1lnrY5tJwowYBzl77t52YOdc04AeTJHm9CgZNipPu+jwwR/llL9sP6W/vEihRTlyY
         TGXchZUXOSJuGjMY8lHEyK8Ui5e6zdIIIq1SNjpNing4uMV356++TrbZQESUVUhfeVx0
         sFhimYDQRhHuaxkg5hK1QhJJVr6PO40sYzD/e7d3suz0CmgWtgcY0IZC5ecQ5yGWq0tS
         dPvw+0AiW8yEZzybk3D96U68pclSz6kwH2ZXN/ExeV0SDw0OJGZeotpiwRvOsE2A9iEA
         1dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779535010; x=1780139810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SdF6tpQVLDhXweuUd49vYyzxySvvSzPJQt+DpMGXwZI=;
        b=f/dgDK3mO3HPAK0Brq/lxGJJna9uozgKkz/f6rBVk4vswzEUrKEFUvo9bBKQ24t1mb
         VH/aYt2eHRIKcaPqHVqNSJeHD/XalXCjXFMIQEHl7iiuqi+/ofhmP4Eg4u5LdbkQ0NZj
         rcXpuZd7B9qA+Xa89qLk/jzXO0ndSq/VYdDY53lfW/TSzavo0ze91tPTu5udPgan1SBO
         cyPKUv3Wou29ygXnsYMIgBIETHW+wUrD2+5fsN7t+ilX/mXyWl4Axs3SsPR6ymomxGTE
         YAwzM3tNBpoCpa4/beOZTrJu1bPlyTsxVGXAc76edJ30poSu7EniCUj/yx+negxzjlJI
         2nhw==
X-Forwarded-Encrypted: i=1; AFNElJ8zcew84pkD424XQoUFBCfwKUk1+AhmFPDNt7HLT5hRsg3cn/BUobU3ptPlVNVdDU5kioSiMBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCp/+uA/tVUmHTJ2INzvrLPxUbTAW0i/bkl78+oFMbFEkuUR7
	uq4y9CWjlG/xopNh0uuNsRENOQ5tu0dkPPW6CxbmWrXi5rynTih6n6ziFwqiKXAW5AXYC1OFp4O
	CocJSaDhjeeXuK5GUw3rAU3wCSl1Yyy0=
X-Gm-Gg: Acq92OHZTJNMuPPnf8l+uz8EnjJJgewj6c7AaDjy3A6vvV4SPTARI2xj3SplrH0fzjK
	LtG3sXBmh4A3nWRVjmYDTfn6DD8ceDpJ56aorJr3K2AiN2O10E0QjXbxQgNaU0NQSZwh+t7JXb9
	1oceruyez/heqhWUAqQVpVOb+fw9gM8rfHSGDovxoFsjdj7u5i145CtzGYEo4i6pb3tY239xbO7
	SHqQo2vwC5kYj0ZtCbehVuvuLBAYjz9K6OkbWGO9Rc47uWHXiH3/aL6+o0ha6VMoAXVYAiXvHdd
	CyL+wIo/uPPJCVVL5sLMjUutRe9iYHyXzDA4rMoY7Bf1iO0=
X-Received: by 2002:a05:690e:2502:10b0:651:b40a:d6ce with SMTP id
 956f58d0204a3-65ec96397dcmr5360494d50.14.1779535010085; Sat, 23 May 2026
 04:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523014203.2462827-1-michael.bommarito@gmail.com> <bdf9ef246acd34862588e525c0e9a5fe47f37955.camel@kernel.org>
In-Reply-To: <bdf9ef246acd34862588e525c0e9a5fe47f37955.camel@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 23 May 2026 07:16:38 -0400
X-Gm-Features: AVHnY4KN9_u1yHXF207YL-qGc1v-Djsk1UgFkB57Gpz3aXTtJwExcu0t4k1JkdQ
Message-ID: <CAJJ9bXzjm=-CezSy5x=sHAmsersT6osb9rCk7x39xg=CLU42Nw@mail.gmail.com>
Subject: Re: [PATCH] lockd: pin next file across nlm_inspect_file lock-drop
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253926-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: ED3555BEB0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 7:05=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Sashiko seems to think there is a regression here. See:
> https://sashiko.dev/#/patchset/20260523014203.2462827-1-michael.bommarito=
@gmail.com?part=3D1

Yeah, the predicate check is a real regression.  I'll fix that and send a v=
2.

The other one  is a separate issue (nlmsvc_create_block).  I never saw
that path fire in my harness, but will send a separate patch if I can
get that to light up.

Thanks,
Mike

