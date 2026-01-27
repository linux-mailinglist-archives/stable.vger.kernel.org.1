Return-Path: <stable+bounces-211830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELqKGbbLeGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:29:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0695B08
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1A1D306F3C3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D677357A26;
	Tue, 27 Jan 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i42ENrUD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75F33B6FC
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523859; cv=pass; b=AcDsnqiGhbmbgUeQnrSAz5dDq1H5liHm21m0LNY7bYgsx7njknaoUXzafmqGV7kK6T7NrQUsFM2YDlu8hFhzAbCRI1Dr6YldgXkJsA5ONoV7XWYZ7JUkwM3VVB2RRaRDCl3CJ1ye/eliq1t8Z61eQYdpQCNx3712eN47t8FDiEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523859; c=relaxed/simple;
	bh=8wGhZ57QYRdVwdwGXh3v1vTEUMwIfmYPnQ8VICDIueg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl3RA9Q6OXIcDlt1gZN+jcUxY5Es7bc4fiyM59xUjHWYfwjKWxOcU4LUaTspOu3lMl63pnP/xdrMw6+9yx1/OehY6JIgQX/cTr8Z+ebwcUoi1r6ScMRLfiwyxhspLmiiu1o5qHgA661mvXqyi+aIhEjG/3Koa0CAY3uCKCpM/cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=i42ENrUD; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09757004cso54182905ad.3
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 06:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523857; cv=none;
        d=google.com; s=arc-20240605;
        b=keeroFGTrgsgYR5XUeaPi5cqLYBMSwAem966fkN+6MDGuyHm7kj9yj/l77ASp39Y6w
         oif1ZdYzgWuSIL+ac0uvb5frL/g+sd4N1i6TuyqDsxA0nsV8e8VbCymIHdot0tK4IbD2
         Y6X9EIozZeipKSRMkOX7jOkqYzVHDTEqaMGflczjn7N/c4MfNu7ufcMRH8MIF+yTfTFH
         MHfkSwAlquBiTD5FL0AJeSSPm9mzdB8PNt/Z9H6ZG6lX18kHTe9jcMhwmiEPDHkLxCj+
         axz4UEmb/AexOkeagtkGaMJF7u1pkhkHEgLLXN/CsLFdHvsRYkRKOgb2kUefh8cJkpxO
         O7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        fh=vVvsoU54lLzCrRzJc7XpURkfJFfmcrRg+F6ZYk8hDzE=;
        b=FWLZSPmNSnWzG7ugu+pCMSr8gdH+7RA3NRtm6QkKcx0xnRpxfG+uL6Otij/KwtHMmH
         N637OLTmTT0cUtg9WAaNFjvcvvwPJ2mvDwHsbn90JaJh8sSyuSGwXvdk5kkg6t/M5qQ3
         AVVSE2toKjRUpzk3eXtP5s8/rYS7gVDasE0S+1PUAWP3zh3FaDYA03S9AzpyagjvDR0G
         uPuK36ugtc9C1rSNE+mQLD9qka5lomLULzpcJKUKqRFkA8tXWDFxrjEfL4mmw4CVcdBn
         xM+ps+xX00ed0HqKF/LFz/AvOqffrkunYckTxYMYUZjTbg/RULxd5bfrB2H+bjiDl7+T
         mPEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769523857; x=1770128657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        b=i42ENrUDMUDCGjKkz9nFFlAcDg0PNwtBaKNF3qlouMLTpEnprDZZNW0YCfwyCBpoY1
         nhs0ID4Y0piH5123jsmUq6CAgDP7LC3u9xWeOsF+2cNmlEbhEUtQLshFfBZB6I6lNMZ+
         XUVyVWK05w118524yXjGwJ1RTctZckUMr002cp5LGGiqiguZFM1FgniqI4CSYFl0NJiy
         0PtJlTBfnJDKMIINLIiu8tvVi+ifJeuXTiKLfbr4EwmtvHL41ExgoA6eghpPDcoSiZs6
         lkJP0BBGkJSi/aEyCmWcsXwN8WU6sNJU/Ek/Ij6/KVNdjiy2qE7poBuJj9hGwLUH+Rke
         3Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523857; x=1770128657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g8tcvewIRp4nWFWaAt8GaNWTar5d4nYaZWbJiaHU2o0=;
        b=GP19VxvIXEx1CI9Tuphxm1UDgZYFB7UVfiEd8xpzZTtPgY1YoR0hL0mf8+KH2cufEX
         pMu293xEimQPEObwO/ibo7U1o+3WWj0HBHE/x1mJV0Ue6DURDqTQ2dGsaZkSQef5Swjx
         fQwZcjO6jREcsn43fhIbenjhE4MGQpi0fX4LOBg8IwLfoNtxC4xM8H1WMjJC9zXguphK
         4B5qlXOTfDJp5JyuHJ/GuAJX6tuhCkk20QmpEGubVdV0cUkzSsKvCLQ8HXwstfPLxQ4q
         yle4Oef9KSOxyfZ9H2fgeCCNERXSwPwEePxO+w0MbdmQZpz+0352mZWzkzXJq364uHki
         6FNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLbHufG116zDLqwksWaYn2Gn+OQWc6/PEGYitGv3q5xKuAtmOolHMe1NNYnVE57zp+expQn5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOcqFuGteGzGlO0HjWQ13B1OFRG4nxtUw70VfI63KtSG+tzKp
	0w2fvC74DqUB6bY2BgZK85ZY5BCuKYjdgP85bRYr7BsdbNzpTQOSXHRLpTloaq9/a1OGrDrvdhN
	HIYefoIuYZJEzAyXKPBvh/ozwILyjlTv9lOU05M7B
X-Gm-Gg: AZuq6aLbs08fs6MpCfyFzbb+p4pr0Ltbg7LedlmkB/qfhNYegnxacoV7ZMECPlHvs7z
	s3iUxDmmvK/Q8zCUqvxLZkcW1DGzqx0wvlKd0mPiP/eP6n8yaMLRbox4aGGkE5XRrtvOMXSrCKB
	S29d8lar12Uz2tSu9jXkiPSbYWsMxKUvYv3pZKyCh2wjCYwe+0xyuRWs7PxRiAFC38pMVaNsMdq
	c+2l1KwO3ZUMCKOSN5fq/a0G+QGjxSMrcUgGVasDg0espTJg6oeABEPTZpW80e6nJuDk+h6iJNR
	kB6oGPq7cFaV6hqbGk7hgysJ3ODzrLHOsQ3QhVcbqU4aTEh/I2yopAFKR8QXNwDV8LNznbuCGFW
	5bMm192HcSw==
X-Received: by 2002:a17:902:ebc3:b0:2a7:683c:afc6 with SMTP id
 d9443c01a7336-2a870dbc9acmr21001815ad.39.1769523857061; Tue, 27 Jan 2026
 06:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
In-Reply-To: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 14:24:05 +0000
X-Gm-Features: AZwV_QgkM7RdmAG2bnPSNf7d7wiBR9A44kYI2A7GzBO9Yj2LAjFQ-cNjrOT6bes
Message-ID: <CAGrbwDStoDBMTB2f-F1jSeak6mqmHvq-ZjpkRNmExeX024=TVA@mail.gmail.com>
Subject: Re: [PATCH v2] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: dima@arista.com
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211830-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,arista.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06E0695B08
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:18=E2=80=AFPM Dmitry Safonov via B4 Relay
<devnull+dima.arista.com@kernel.org> wrote:
>
> From: Dmitry Safonov <dima@arista.com>
>
> ima_init_crypto() skips initializing ima_algo_array[i] if the alogorithm

Managed to forget correcting the spelling here ^
Please, ignore v2, version 3 is here:
https://lore.kernel.org/lkml/20260127-ima-oob-v3-1-1dd09f4c2a6a@arista.com/

Excuses for the noise,
           Dmitry

