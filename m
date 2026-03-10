Return-Path: <stable+bounces-223844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLjWE8Tnr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:43:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB34A248B7D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 493863009564
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6729B43DA55;
	Tue, 10 Mar 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvtN+Tcp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935B43E9CE
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135806; cv=pass; b=uLy4T9KkHqoBL6hC/Zf3YmsG928Hn+v9mkpDwHdXTh+9EfprQt8z4KNECRGiC9kVpAjshetJQgMx3eh70oPSbyAc4LcNde4dvB1EFwH0c4GmLs+KQxxBJu7Oz66zhf4NeBZPUUwlHxgXwn6wTFfKbJawBUkUIl/zy57Y/6Oozy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135806; c=relaxed/simple;
	bh=D6BEttDHIZ8SMAl+BzTFPlqZNeDWk3kXgelyvPsAYsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uzf7/6r4DDhdHBF/l5M2vkW4jTDitx1DBn6ifIG7qomN1u9GuUHFktYauw+JM2rzRmnRFOP9HPgBY7I1aI3h0JO2OZaI+ByQdat1tcM18g2MXMB/r7ce9TpdYFHo/c43THHFm661kJWtyDPlUTkyZO7U+h4MKUc7C+U0zHiakyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvtN+Tcp; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8f9568e074so2084641966b.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773135802; cv=none;
        d=google.com; s=arc-20240605;
        b=Pwp7HA2LnGxv2A15mXrTrYZxYwYsQ5Y36lOEIrCtiIlsnkFDHoekZaWtW7MLhd5Lu0
         EaLED6OcNs9ShWiVMG1ijXeXoquKz3oFEEJmAQwGaT8G7m0dIw/vjL6W1kyHZzEZkqsc
         yNMURb3p8qAEha2DhAtV2X7cOpVQ0rADkzzFe2AH3zzmTvpJFz8Ikdm5N4tELqOLlRq+
         eZJKEX7ZjhKIHTaMzyPOmLOgboWnIVbPHdw7ZXq5SbimRfEZVjjTMu5eVjfq3xLoDy1G
         ANybrvNM5WjMpCgMP4rBlEPHRV7qOTERzkG3JwzIpQkeNPZ85pHosEqjGJNmzC+6xsEF
         XzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D6BEttDHIZ8SMAl+BzTFPlqZNeDWk3kXgelyvPsAYsQ=;
        fh=MzYy/47DPRidEm9b/cRiZY6ixHWcMCeIGCCxNV/G/Is=;
        b=OndcX+k3mzokxtHUBMkuy68fND+kBSz7SaQEVP2PgVmquqrDjtvdw4b7N07EN/gKbC
         lUojPvChwXRuswC6HbEUFx0B9oodIC1uOu6xRjWr3hGJxhMllT/NgYgG0n7XLsqlrR0M
         7jwQoIor3fjXiBAd9PvkayRPUeUMbCU8mzzEaUnBBEs8/NjHitBmdZcRuXMZh1q7r4MY
         THWT/vMZwfFbkBFht8bfTPYBop8Fd4uVkms5Ct/yzYkUKw01yboug1ECjDraRpdT1RcK
         aCRs9b6SWEgNr6OG8WfwmNrkKdaUZX3tQCjb8e0ynYgH4x1ksIvldpELsfaEHaJeP+vf
         RvIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773135802; x=1773740602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6BEttDHIZ8SMAl+BzTFPlqZNeDWk3kXgelyvPsAYsQ=;
        b=LvtN+TcpsaTHiJXKR25JYWuQMDH/Z+lJpcJajEfYQSMqMPSHiRl1XWpHqXm8c3A8t+
         rFxwpgXSFZLKiDqSTm1RCCTfGk6ChUj+Q30eyGXI3ag4s/nQS1mP/cobwAwTp31HTv0d
         8lKBweO0/mQhw/aa0t0a6kRZd+kz0NyjWfCN+ooM6o+0Cc8PwLVJ2tTh2psjRxKWN/oK
         VEcbya7g91FU0dIQYfq8HGj3Jv8jyaV37Hi5GOj5LQaLvxzWajq/nP5OUSb/qSMH6oe3
         LwHh3SrfFo5ECSXITJnHKpvPxnlTfQ3k0BRftvvNZki7DwpRFKRJDt7MN6HiThBMc4OP
         uXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135802; x=1773740602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6BEttDHIZ8SMAl+BzTFPlqZNeDWk3kXgelyvPsAYsQ=;
        b=RW8zhYaL5diNyXZ+L7Oae9FyyQIH4B1swXctQ1te1dH55WAJMqXBig5Xwm6/MsIwz6
         rt3q2njCpU585yLBPL+60M2XF+dTOo17YREQzhhjMH7EGnLpaOhkLPtKB5OCcpU4VgD+
         Qte+YWzoNQ00Ck2v7TNUf9BF+IjyK+A88jV+GI8niG4q5yEK+rl5IBnAfRzjLlKD5KmE
         vzbu2ZRTXef3jg3AiJ++2/KhnmtFmOSS9jio7GwO3CPGtcsPYns8W9uCPE6/7ABITCSi
         vrQrtyGkJ2R2a8gNVG925cmcyP5UXDVrLuFbIO3TNQN48Kxs9mV6tfJ3bos4S+ltD2js
         J8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX26ghG8OhbRfPcfT1Ng6mett7i9ovBcg4eaN2X/lmJTwB2vON8ZUqagkXI/Abw++WBqjIv/CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7N5IhMJ5If9iu71tNsQXQUi8GM5d7Dhs1NjJWwqbyc6IuCHKq
	DuWKdiUHqSpWI4hTmevammvwkLD7VFGA+arhehsYNCMwsyOz1S7DG8g+/S9Tmqh0swv6EjZrwg/
	BX1BxsAB8TVpyxTzdGkBTfa83WMndNno=
X-Gm-Gg: ATEYQzws9caGv0KYwv8SJ+qcTswDKmOA0+2+EHRq6B3XuY+ukRC6hMWY5JV4vgbLe+v
	aKQkBsG5ibzLHASCbF5g+J6Oqyav0ZtoAR+b3K8C/vfEtcBxgmJwLIIT6FzhIyeAol56wU2xpvA
	PgA6qbPWXYkJzHd3A1iO+qS5xtoNCY7XJPb7JChryg1gnu7PHE2b8aU3yWa4XXAHMdkT6/zuhPK
	uYAhJQJsVZij425O2AJCe0PKPgSRP1VIVXZH1JrDR1rOaGj+V4RQM0tTvA00TudgJpzL8Y3OUm3
	m8F4HzvQ1Znf1/5bEcl0irK0YU73bk1+MbzjQRDA061OQCZdZpn3XgKKLgnH3IBsI4fYsumV0FD
	yRugfTzRsZOA=
X-Received: by 2002:a17:907:960d:b0:b93:5744:aee1 with SMTP id
 a640c23a62f3a-b942dfb9f56mr860539966b.51.1773135801970; Tue, 10 Mar 2026
 02:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310075447.2088205-1-gality369@gmail.com> <19e81a86-a8ce-42df-8cf7-da74205584ce@suse.com>
 <CAOmEq9Umi=3AA+0DkmHrfFjj2hBnkq4xGSFdfS40x5F7DpEtuw@mail.gmail.com> <4e697f30-1057-451c-9238-5ea748dd3236@suse.com>
In-Reply-To: <4e697f30-1057-451c-9238-5ea748dd3236@suse.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Tue, 10 Mar 2026 17:43:10 +0800
X-Gm-Features: AaiRm536-m2uYjLqi9U5ujWYS_-IxuEn188Eo6qNjtn33hUuJVhYfzIx46MnQs4
Message-ID: <CAOmEq9UNR3ykGP6exskiJLQpUT36xe91aAs_4Jk8mNvEfNkJ8g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reloc: unlink orphan reloc roots before dropping them
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DB34A248B7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223844-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,fb.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 5:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> I just grabbed one from Johannes:
>
> https://lore.kernel.org/linux-btrfs/20260224125113.14831-1-johannes.thums=
hirn@wdc.com/
>
> And from Filipe:
>
> https://lore.kernel.org/linux-btrfs/b99cee6ce652b926463a080ef052a2e8e37bf=
f33.1772105193.git.fdmanana@suse.com/
>
> And myself, which is more aligned to your style:
>
> https://lore.kernel.org/linux-btrfs/4170e39bac4a2559ad0535f9bd74a89bc44a3=
6d4.1771488629.git.wqu@suse.com/

Thanks a lot for the clarification and for the example patches.

This is very helpful. I understand the changelog expectations much
better now, especially for crash/KASAN fixes. I'll study the examples
you linked and use them as references for future submissions.

Thanks again for the guidance.

Thanks,
ZhengYuan Huang

