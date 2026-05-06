Return-Path: <stable+bounces-244375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI41NNMz+2nfXgMAu9opvQ
	(envelope-from <stable+bounces-244375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 14:28:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61A4DA2F4
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 14:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E2E4301E944
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A444105E;
	Wed,  6 May 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQKidTzN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BD31716F
	for <stable@vger.kernel.org>; Wed,  6 May 2026 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070451; cv=pass; b=FFOf/cHiqiDpm1sZ51ObV8ytzozEieBnPo2Zf0J+XhlFut2NSZtAzOBE4wjtRQr8sqpBvQ4k7iedJ+phDnbKKrbwxPurZOo+2jYWVIQyMOzPl7R3G2EjRWCHHcaX3LZc3gJg8Jbg8/djvLr/hp5e8uQqFK6TgR7mCcq1wqhCwYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070451; c=relaxed/simple;
	bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aU4wMeaOPimeiSr4hUw9fT/OsxkvQb77n/ReZusHU9M+CU9oMtGleuP5AloaTj8WoS6Voy0OGs3/NoQtz1anHjJN9SHoU3mj8+fLqc2BfU1/t8KrEwRRAUfaKxXssXuL/lpcAPTjHl14rhoRbxroZ1VeZQgXD23846FxaSPwFTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQKidTzN; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7982c3b7dfcso64117257b3.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 05:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778070448; cv=none;
        d=google.com; s=arc-20240605;
        b=Vo3Gm/DMymqkxggm5RlhEMwJaAvXh3vv71nMJ3YNfkLcxAEqewaesDM5w62c27GJs6
         kZE31pvemFqWP4iprGMbGXld2Toov8+gMSqdqtC7eWWmWfADxvG25LFZNyfEsrmWHFzH
         +/XCofIZ5VuBjeIRKlJm3tSrhLBTQD1tKWoIVIR8faAozRocXbDcT7Fu6UB2pp1HRlP1
         eFMz7tfc7Mm3szcmapTBQby8dACyA1b4IeBs1imW5RAFzqCPYbsFZyOHp8mCdDSyfzE4
         V9j6gyRpFfiIEZjdbt4FTcjyZVlAvUw8q2u7ioz+tnj1wJTtckQVt3kyV2xHMPoAZGbw
         Dq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
        fh=s1eA2VigJwBVz/J/17lXarPxCw7KJ0/7roIZI/EBgo4=;
        b=KF6gLlgnWsVWvr0f+vKSrqa81ADx2PjTu58QE4QtJRcQAA09wvg3FEyBpxzSZgfU1r
         bPPi9PSdnniQV+v5Z3Jpwf19HHGb8wl/22WBl9YORrECNWH0r/h3ckrKk6Wu4FTd5RuX
         Mci9rKxliJPt5AIdDCDpekJzreHRiqTVUQg0Ibug7TKegqz+MBcXaFCoxKFBGUkjhfXd
         NEYVHf8r5B6SC7jh11yTiaZDj3TTIPB9G9AYXHxEhGz/ZV9+3za/CUK8tL5yQcxAgex2
         0N0iEJ6Pl/eGdzo+hI6V4VyFwCcsGqy35gbUPhrjSo78Os/np/Ee+P6dNWAFdviyW1F2
         E7pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778070448; x=1778675248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
        b=VQKidTzN+nolgvcJtSdyy/MCiYxr/IK0UEYUaWHmQyEQyo/R91SC1FBx4FIOgBPnqa
         eJQP167qhsKEcJWjYEoluI9B2YvbeS+xpuZou0mSu68meejh2uLwBlPMuEBoj2Xd/DQV
         RWVQ3cLMHNJeUm3KBpg4ZvvkxjdcjUiQersOV1aWkAXsLYL1sWbLju+FqHyOfsYU42p1
         L3/8TIWhWbJTDRiCWX59XAMVYo6VCtTbjnql4A2xr90nUYQY+OsiqqmaJKewZQE8p04Z
         Y/B2HWj8lATo1dIG9kk/55yW0dHV2XIgOaTgStEogOkoqhRCCAAcexXhTfbMnBxUxmFg
         9Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778070448; x=1778675248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
        b=JSVtMKdWkFGvpx33gTsb9wpVDSrPERLMzGO0XGTvtzdCN5+wJ9grwyb97bKutVd/ic
         wSTgo2kotVXGRKWyFjBjLQH2KjFV8iK1+1w+fA0YWXKd/LjXDFAPjhe4Bt4F03R5ZnGx
         OYWvsp0L9l8kiVprxTfrDGqyzDVBsk0aoW778DWy2X4eR8/cJdf9mJXy83EcWifW8SvZ
         VoByne5NnUJ7w0SB2PcQA2a6UNteITPKUDwmibdlBscSPKoXS1eKT9WImSEO6Krt4lxT
         AtZpAYg7pDxXDbF0cUJUXKtBM83UFeTNS+W/4EJIi6yZjO6/qCuUPaOX+Vvo+b5ITIRf
         YOxA==
X-Forwarded-Encrypted: i=1; AFNElJ/RJBzfDklGGam3ZFYH9y4GJ6cyBM7t0DgFLPsxmy4gLTxcQPRgaGmBNhfbfEwiqPJdXKlVd3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKcATxVwwFN3IywDfG/IQdcmgW8frofOOK10X/kUlditAYr4sD
	5HVdg2tonPC74jnqQ71vjsPU49g8NSYAj6q0LjNSFAWlZGEtSieCQeic3tgclkElbjlW9psaFQ9
	vpsYdgO4t7ftm4lMFZl2jhoW9azM7H00=
X-Gm-Gg: AeBDies20PIXTdBH2jJ6GZmBr/lV3wWdt7uTqCl0YR8ySjUALIn28483fBwL3M7aSti
	BntCjzo4R6ijKdQe0LhhX9KEarRkt1YjDJRNd+atZvVkidve/NwIT51gtaGVapi+bgodun2+6fG
	OCZseIk0DenGmUcaQcZR3VJLG4vc2FGc0NHrIhW7XjQiR5Cguax/79G9NE2kdfrvdkBCn6U116D
	k8bT4hIgLpbmY42sjP9r28N4XlGnOa4V3AJyq2hlhJfnEvUIW013Sv/wEGJcP28m2JafYW0mXXe
	wasDhkZRIT3uA8kTZkB5kRPYIF7KlyP9K+c7iHPUs/EnWkWp1vOs39know==
X-Received: by 2002:a05:690c:6ac6:b0:79e:9cc1:edf7 with SMTP id
 00721157ae682-7bdf5da8c15mr37150617b3.13.1778070447680; Wed, 06 May 2026
 05:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506120034.2146771-1-cuigaosheng1@huawei.com>
In-Reply-To: <20260506120034.2146771-1-cuigaosheng1@huawei.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 6 May 2026 20:27:17 +0800
X-Gm-Features: AVHnY4LVQ5PLSM6stSei6WuvL93BxQAfl2RRSXYgEbbHlbSGc423uKlaLMvtDZw
Message-ID: <CALW65jYMfBN33qrWAMaNmnKfOd0eK4xA8KvCijkPS5mdBfoWSQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "l2tp: do not use sock_hold() in pppol2tp_session_get_sock()"
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, gnault@redhat.com, 
	gregkh@linuxfoundation.org, lujialin4@huawei.com, gongruiqi1@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D61A4DA2F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-244375-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,huawei.com:email]

Hi, Gaosheng,

On Wed, May 6, 2026 at 8:01=E2=80=AFPM Gaosheng Cui <cuigaosheng1@huawei.co=
m> wrote:
>
> This reverts commit ce63943f9bce64df1be9b6a65b04fa6e1d99ec2c.
>
> Upstream commit 9b8c88f875c0 ("l2tp: do not use sock_hold() in
> pppol2tp_session_get_sock()") was backported to v6.6.130.
>
> The blamed commit c5cbaef992d6 ("l2tp: refactor ppp socket/session
> relationship") was introduced in v6.12 and was never backported to 6.6.y.
>
> Revert it from 6.6.y to avoid incorrect reference counting and
> potential use-after-free.
>
> This is a revert of a backport, so there is no upstream commit.
>
> Fixes: ce63943f9bce ("l2tp: do not use sock_hold() in pppol2tp_session_ge=
t_sock()")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Sorry for the confusion. The backport is meant to fix another issue,
but the commit message was not updated to reflect the actual use.
Link: https://lore.kernel.org/stable/20260318012653.232518-1-dqfext@gmail.c=
om/

The backport is correct and should not be reverted.

Regards,
Qingfang

