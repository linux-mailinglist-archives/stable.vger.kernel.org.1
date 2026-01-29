Return-Path: <stable+bounces-212739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAIROXsEe2kyAgIAu9opvQ
	(envelope-from <stable+bounces-212739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:55:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5FAC5B4
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6864A301778D
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7D3793BE;
	Thu, 29 Jan 2026 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="olXwaNfL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCBE318B81
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669751; cv=pass; b=X3eBJASYRrzcXQavya/72g2BibsTM284GeOQJkyc63a/jr0Qs3DLGTjl8t3HvXhyg5wpo9yUAiFHFRAPBb5abgSahtunXeinEKn4somo+l7MzjXlSwF5eQRBrkMJLzqVVVsI7Q1pukv1MvKVgFvhEA2cZZbKkJYsGPAwMvdh77g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669751; c=relaxed/simple;
	bh=YX+VT6G//hQzFKre4H4+dJSNx6e21J8uALflX/1Rda4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ7dWOSLT8OgerHzJ6fqeuPjvjJgfNKoMWdlKN/JNPpQeaziq845mF34XfW025Tkja6UT34VoieTrpA6CaVIHTkxjk3JbSxCbaqsuBTcCp6H9wd/aKk4pYLcLzZPsq/89a+ogUlwoK25k9Mu7TYLtPNNIOrgfjYBW5ZzUUwPem8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=olXwaNfL; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so1003406a12.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:55:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769669749; cv=none;
        d=google.com; s=arc-20240605;
        b=Ps+MJbJ3i78b6Pkx31REfB3j9rkYF16oCGiguNHlmFfqddMbgjSwW/logBrqzurcnl
         BjHdHkoEU1dGDHAAeFY1MyHD3XaKHdEIuZfTMnDadfxgPynyodVueZWDTbPk/SIIV5Zq
         DBRpSyEKTVYquUzkUy45S/viEnH0kkf4UQSEdgQLTJMZFrFIiYCK7qMQcTPv3ZH2O2A+
         mYo266qIKcId0qcW4UAKeC0xkzpIEi5iMylOshJG3ZyN9JVb46yC67D/c5w72jchN16c
         hnHgbgoSHqsE5PedEyqa+HRWM07lkSD4FAxRc9a8Q41+oDF+hQVSfiijUQEJ4DnBAaXn
         1Kcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sQO5rKRKBQvQpktDVX5k3oNgy0DyD9YcvVc55rWtXVQ=;
        fh=Y74f01YznQtICCoVpDtu65QsUfM3VPu5xLIo3JzpQ/I=;
        b=e7ewM6J0j+iLWjxD1wsVh/AmJOeSQPASUpYrKrlJbepFEyDOYKez5N/Jma2f+H9FRO
         6mmPt4vReRnkjdTApwZyI9ciHNywx8ap/8cdWSY/QNw5NxWMctneIvmrmssftkd116nJ
         2zVDXkqDGBl6mVXShX6H7ltt5nZfuuFDPJrt01M2+1CqXK3yUtEShfkUkBmtPXWePo0K
         SW/xyn+CP4NQINp1OternBKf/vZB8+9IROWHqejlRlBn1l1HLl9k721/oGcyHAhKl/JZ
         PzzU/BNDOSreHl0oD7nlgiNEP6Jj+AJM3P0jlMHPRfkmfVzEcmbUr5ptAOfJSt5n5Jyx
         uP3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1769669749; x=1770274549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQO5rKRKBQvQpktDVX5k3oNgy0DyD9YcvVc55rWtXVQ=;
        b=olXwaNfLn/gcS47T1yuAuEQ6vD/2fWZXoohJIl4dXiPsDcoI1Ss+0Hvjnq1a+qWIek
         krm261Pm1s/ftRlTK4v/Cvc15XnuxOy0pqTrth/E3IHyVRP/1j4HrapcLfcHPBGV+GWG
         QhLkI6PPxqj2aZHVnMZF66COJ7AArdSPQ3DTYB3Inm5LHDiolo+3b165xOkxiExLuB1u
         ShddlmkaJ4xg5Tb5RbvsbFKE0b+ud4cn9b/H8o+CwydheRzY66dKBAsLcSCoYTQNoqPL
         V+oJZhwFEqe+7rd3TJFvSHn7DBFhR+HnN8qNUu870UBBobvtZzCtrWC5FOxqRCb5tZTj
         jf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769669749; x=1770274549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQO5rKRKBQvQpktDVX5k3oNgy0DyD9YcvVc55rWtXVQ=;
        b=nctcJLG+eMBq7+gUHGUGA9iWktNNPa0w/lnfyoGotVao7OGCznPjKd+Oz0mMz+KNaN
         6mx6P0gc1hLHtvGUWkJKMg2VvTbYxftLxDRbay1UDmKqxeJKYmz6kpYp+SOG9EU09+ih
         VcRzxMU4KkJ2akfCVoY3ynYYWdtRl/GebLzFuI3eFLjttKptHrk17/m9/OJAwbxMGset
         qp8hoJ31UFu6z3pNuA+lFKz1aebUgFKupXVa3bvd3pschaaQ7NhmVnGg+NHAzkHGdwVi
         l0dAjaVDWonA9kGYw8q+eE6pAye/r2O35+wPmnLbd5ZwEksbYOUNHZ+Od3iImOthf6wt
         U5GA==
X-Gm-Message-State: AOJu0YwgwG/B3Kj5KywJbpH9Gj/DoZvsUXvu+eoh6Io4IhK40RcXaJu3
	SoGgo7dGMy5NofPS2Coi2VxeZcmt27qIyfD2LTAXA90iZwwEPnMsIcebShOkWClg8IrpOQTVLrB
	2mApXdd4I1SC1MLHJ/1ktH7eQNgF8wJjEOd2vsipVz4dShc5zRsIOSuEmJlKl4ZYqnHd7/NSdjG
	5NCmiN4eGYKjhXGT2gywAT2ROdevB2m9LZGm1Kb/eWago=
X-Gm-Gg: AZuq6aIIULtPZNsai48+yHxaeYjncrSt5m2/C2tTcBU0hEPeBt7b9E5Q+w0OtfJZIru
	K+fcmhbWzzh5xMatAGc2AMvFtJr0tgzulMKcpK7WXltqGLv8q6b3tiY6fLxkfSktc5tjOVR5Rng
	hQ1X0k0S0WBC9bYTXVdFHHI8ocxVDRBXh+uZMhIa3NSw9J5JZG7V4CUlRweIvtlO6Hq8KwjI4sR
	RHIeCkoFG4MlkQK+QwaOy91R+r1YePqEqyaLZjs9wv5LEJzXt7gU8zNOLXNE86+XtJAGyLuu0Zq
	2dl7ZtjKl6yr0R+CIqSQXcoINyc=
X-Received: by 2002:a17:907:1c28:b0:b87:d09c:1825 with SMTP id
 a640c23a62f3a-b8dab2bd67cmr548106166b.13.1769669748136; Wed, 28 Jan 2026
 22:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128145334.006287341@linuxfoundation.org>
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 29 Jan 2026 01:55:37 -0500
X-Gm-Features: AZwV_Qh5NgojKdDDaPCetv2klBsLVpmM8TfAh5a_KdjTwFgRdmpUzPubNaPNCfg
Message-ID: <CAMC4fzJTCRO=J7R+w1XqTe_cQPvo9p_Ls93aexd99qqRPwhcmQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/169] 6.12.68-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sladewatkins.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212739-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sladewatkins.com:email,sladewatkins.com:dkim]
X-Rspamd-Queue-Id: 45A5FAC5B4
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.68 release.
> There are 169 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.

6.12.68-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

