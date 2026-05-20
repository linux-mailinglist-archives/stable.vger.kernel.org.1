Return-Path: <stable+bounces-250666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4McZAqoSDmoJ6AUAu9opvQ
	(envelope-from <stable+bounces-250666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F16598FC0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3A3D37BE48E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8523BA246;
	Wed, 20 May 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a88r0ebo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DA371D00
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296003; cv=none; b=d8hOxrPDaFTfP8xQSxhNa/Po3hY7q431OirsXr1hM1uVkTZ8eMuMMJb2KpUzT08XyIx2NhNF3XYgztudGA9s0OUWAmlp+VnqAeQUaGroZUAS7ePyxyYw2kxcizk2kU0WVlpuXI/x8ggmLQ/CUhO/SfL9ECfxOoZq6q+xvPpTfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296003; c=relaxed/simple;
	bh=++VV2z8DF9nYNXw7ZGVhPSn17Ap73p9EQBATvvZQOOI=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoeJ8Mk5BCiI1PEx1BHvG8NtnaeJ/Ucfn1dSJwvzuYxY0CGMo/bdUlss0/niaLsm491iO9BmE0d5R0cXEyTgA3djQSDFom8k+SFBiNsQ74yhR0s9zsXX8C6PAXYW5NxgSNwp6IqeZ0DqwWN2urvM2rWzReZJ3YwVeg8dGnxaINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a88r0ebo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso1024451866b.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295998; x=1779900798; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uW1DWs6dLVxbMJbJA1XC7hMjjnFFtxpIrjpCj7Et85U=;
        b=a88r0ebomWrncpMAU1k1hVlO/8O9b5BTZsgHdTR7xyt6cnrTkR2xbvXR+pTYbUcwSW
         WFN1WCAOPyK40/TM3xPW/3X57uY4dVxOUZRtvCZZ3w00TIY8PSx34NloolnOs04SO/Jl
         +3UokslLUEu3svnFxjxH8ldUmJLhFePs9vjR3MrcF5pq+puw+z34DCUtmePCxDI1AZ+J
         NdyWr0IyUQl0XTFdm/2d6dId1G/eRwEJWOxf/1wb+PdCOkmqJyfIRcwkCJXU8fGHv9iI
         KQ4dQKerFnQT+YkpQ8NqDadATMvk6U2Khz8nfwyB+Oo1cVq6hk51af1v4NEuWln5j9uM
         QMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295998; x=1779900798;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uW1DWs6dLVxbMJbJA1XC7hMjjnFFtxpIrjpCj7Et85U=;
        b=aOEThVHqBDTYm72/hQQIwcQ1Yt3ywD58P8nKAOYOh49zEIlP84gRtyGuHQaciLqxtN
         hD6siDgHX5OGRkhtJhVg9R/89DbyitODLfx5zfl6oweSSklwprGjUWiXiLf73rSOH8AL
         n6aVjcFlhBhMel2OK9TOCQpGIzn40GQYeCd7krac0LavQ9XIvv8Z7r0pbfWA/1S2Xa2B
         iEOi/eCzMNiPNuxa9C8pxDK7jePl7nnwAx3PWOvHjrKCQ4DLD3IorIxQ47PXLThbWAhr
         E8UJ0z3/Do6JPwif/kTGTm3m2eT//+5d0fS+yn94+i0AEGgC8LdDr94AB2S5ifBeOx11
         MaiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WR6WnMD0mnUcI/pAFDJSQ7PdsU+I/4cJkUTWN+8F8bCcoIjr6PWwD5BJmdx1/L859UO3nGrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdriX5ajWQvAr22hKRlEk50vXy1+86DEHsbPvgvldecRoQ9Zc
	dRUseHBODTmfgNd7lV37zPp8BbdokijJF+JoaHcNeFwRocTxSs5NiVkj
X-Gm-Gg: Acq92OH1mSIZO3WULEh3BhKdLViTDhQ7V76xdjHUb2uQScp+oboBOZ+LFQBIgbwTvRx
	CfPU5LwL4k3bmQUHntKsr5R1oVALuaPkH0pRhEW5jkiTSNY8RdVRfyckVeFHlj1b7vvEFmhzO85
	X6mb8t6U6GtuEd1fATBa4zZS2IRhoUVdy/UAli2RC19dDbc2NrDEPIC+d8lQUbO7LCpqD0mly4y
	LYOiJN2vabZ4MpuR8YamMoNcWNCIArCvZAR0nFnhZXSl11QArKY8FrHsW6jhUWwbBrLoo+pqFGD
	D0lZvDlOZABtsCO2IYy9yvzRhlGi+YnZGCeRkyarF33ZmW80RID8jn4HCT3ICpIyBL2TThs0VA8
	fWOxW9q4n1LQ3OeeuEzFnHzxy5JekVHugszU8fUp7W+bKQBpCE5ZdP34tzJzM7HeDhQjKovdFG0
	9wpSEDZdZQRt+M/N5Q7/q7fxMU1luwBUot4VsjYoHXdcwuHyk0tUlDN2lmbkAX+f/VDCwq6a0lg
	xJwcqJdm5WT6hAKtRO06S+ZLY/Ovbv/iA+KyfNYvYaWD/lAdz6gFmWBq6r14RSANXa31x8G7JWN
	LlZwN83WacEJMdZNaCMclNub3KS3
X-Received: by 2002:a17:907:d78b:b0:bd5:2c56:71a2 with SMTP id a640c23a62f3a-bd52c567250mr1328647166b.36.1779295997739;
        Wed, 20 May 2026 09:53:17 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68704a658d3sm1547636a12.17.2026.05.20.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:53:16 -0700 (PDT)
Message-ID: <6a0de6fc.2d57a604.3a8602.5396@mx.google.com>
Date: Wed, 20 May 2026 09:53:16 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: mlombard@arkamax.eu
Cc: martin.petersen@oracle.com, bvanassche@acm.org, ddiss@suse.de,
 target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org, hossu.alexandru@gmail.com
Subject: Re: [PATCH v2] scsi: target: iscsi: validate CHAP_R length before
 base64 decode
In-Reply-To: <DINMKOIB4PRJ.1Y571RHF6NAQJ@arkamax.eu>
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
 <20260518235040.48647-1-hossu.alexandru@gmail.com>
 <DINMKOIB4PRJ.1Y571RHF6NAQJ@arkamax.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,acm.org,suse.de,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250666-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 79F16598FC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, Maurizio Lombardi <mlombard@arkamax.eu> wrote:
> There is something that doesn't totally convince me about this length check.
> Couldn't chap_r contain those Base64 padding '=' characters that
> would make strlen(chap_r) too big to pass this check?

Correct. For SHA-256, a padded encoding of the 32-byte digest is 44
characters (43 data + one '='), but DIV_ROUND_UP(32 * 4, 3) = 43, so a
legitimate padded response would be incorrectly rejected.

v3 strips trailing '=' before the comparison:

	size_t r_len = strlen(chap_r);

	while (r_len > 0 && chap_r[r_len - 1] == '=')
		r_len--;
	if (r_len > DIV_ROUND_UP(chap->digest_size * 4, 3)) {
		pr_err("Malformed CHAP_R: base64 payload too long\n");
		goto out;
	}

chap_base64_decode() already handles '=' by returning early, so
stripping them from the pre-check does not affect decoding.

v3 below.

Alexandru

