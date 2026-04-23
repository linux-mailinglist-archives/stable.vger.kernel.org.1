Return-Path: <stable+bounces-240401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJz8EouO6WkvdQIAu9opvQ
	(envelope-from <stable+bounces-240401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:14:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E862944C7B3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC143024528
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD172343BE;
	Thu, 23 Apr 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDM+ziEE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6C1F8AC5
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914051; cv=pass; b=TUoPfaCTkoN3yhRa+zeXpfmnJtALywHT4MYotoOc22bk8L/rcvqGmtd6vWdkgJDk+B1xIu8EO36hlg6BcRNuCwswKZBwjVF9zLoWyFWA2MEnL0IrDIDVQi3Kkb84ICdIQtvTbpPI8HLzwi5+WMZgU2NvnVTOSS8ds9yrGcmUaTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914051; c=relaxed/simple;
	bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEH+EXkJ1URbPIXyKsAsq9RsPI9VhyCiw1Cvv8Ue+rzVLdc/KS7nHPO0Fa489nT/WvmERyY536kA7YkjEhUUh0Eo2UzyG4g64sAaPPWJSrpFywVvtoftpIobxgAIcavBrDq6304HZu9GvJ5XfjhgTMgQiIH3rX13ueXUTRkhGaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDM+ziEE; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501c9903edso6318855d50.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 20:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776914049; cv=none;
        d=google.com; s=arc-20240605;
        b=ELWwRWRsbpEdcW1gQ8l6nFgaxJqWQCK2yHhsSoo0ZCqO2fs0n8KqU97kTf0zsN901c
         xjUxf8VVBsKH0Fmj0AOQjqpkmiUlpy3AOu89hrbMbNx8bhioKKSVJxdW69nSda0Ql/dw
         j77UN9Hkqz6XKi963WCnGVbplsZ/uT7KQ1c/NqKfJria//+QD2hXwUr8sPTzooQLcmED
         8r4yPWG/S12OWlkgjvNnngAxaEtRHGznIciDX7h7Ovd2M6T/sSzVmDGxInA15mR2NSoJ
         QRQL7IPXNcc1hqsJCy+DylRuqAlKz2kZtMLThnrahzY8BkEa6nooux2eltUlcdtG19NB
         k7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
        fh=PKmBne7sLULxGXrRD30NFQLguLkN93mXhuW9QJFXIc0=;
        b=ML0o194jo7Ipha+zQZWsK5Caf0ywC59pgUL+O99jg4NAqypQohozaWaq/kXh62RoSr
         BxiYb6Eif/Gx+vX2EbDVMNUHRdgVmeaAlCdufcaK0MfGTuPQWJo0Y6eQMevcdAi9Sxch
         y+qjhZftTB+WRN7AZo6i5gxcMmDxgtsWsDh/vKXh+tWxl27cSNDC3wrc+Zwb/1impwy+
         D260geyBNItXRU+ryVzOzc9uxLkroqTZzi+llHUxlkcGc8Hi34xGMr3S6Pyp9iuzAlZ3
         Rw1RPO/qCGdLt6evmLzt7UVzT00mSNnK7SfyqrH/HCJURBFkzaAPORUpLZ/0WbOxFfdc
         xjFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776914049; x=1777518849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
        b=JDM+ziEEPNxxZRqTtmymOQxKyWfud3CVlWEshx0CilZMfKeO/48XvUVOJCvrDz8lT3
         uund3iHiOe0s7yxhmKYt2m/+C9dxnJxYkuXOwG+04odSgDjFFid2+eXMQ+xg9/tUQ5CQ
         1qsUl9i6pIh0NC7t1VjaNBAN6jmlFvp3jWpJzzwdTYIY8Llm5AXYjiZZE7x0iEAqz44N
         HjjLFdk36FI9rCI8O+16YWUKWLMVageLwz2jRRxZSKjw6AGuUq+22Q6lGCuRY5BoAPWO
         kTqAH8saZKxARiEitI0XHL/Y9KKfzUbTtBoDhmHi1Nj1qyp8rj3zAlAsFtA0cCnWFJYu
         y3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776914049; x=1777518849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=shudGTvVCzWOaBlrtpLXOI7LUGzeV4XSn+NNbmOFUmo=;
        b=VRhB7SoPtY5LfJU3BMm981U8MCl0VU3akalsJ1bFo99SacgbP0v921XPzPPRTuoMiI
         V457IBFoz+3G0IxzUHVP0psFwU8Y6eRzZfpSapxxdjXnVSlxt/vd2+0lDfaOeLItSnE7
         xhYPKFPEZ3Or1qw7oA5mpCaW7TNGNrZ9vKr23wZvV1NQZl+dUqZGd7A+pqE/cgJh7fcw
         qzFPg+S8VeOytX7xDa/37zgSv7iYFctmGqRvl5sLKMMyWo2viXNqoUDQz3Ru6jyGBEyi
         7ms6/pYFBwM2NvPWQg7XyXcv61KBZefIXJrfF96TF0Nup86XiSMrOU60QJG6jkvgB1LL
         Huig==
X-Forwarded-Encrypted: i=1; AFNElJ8r0PUkCoizr7fuHQ83aXF+mM4KuRxOKlOsygbKeVQPv73QZ35L//CYqXvQhn47iBAv93u2jAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNFH9mrkegEYswdgMtkMh2gYzKq63frB7GrJr3KJmBuJ1wAZ0
	YkyPGHp1ObVHlpUxKUgFzM7S0QE+flnG3DYeaUTglV/9yZsooTRpanaWF5cshO1OMGjEiRHZQ7E
	qPpXyt/A1Gz0GsLudh42O6t7kV6IyMXY=
X-Gm-Gg: AeBDievvj9TG2vLdITG0f9Vx2k0sGwq5+2SbJj/G/YHnWrfTPWuiveRXcr2JmJ3dTjJ
	25f4bYiljLYXxl99j/ffCdcqFllm0R6p5DlqO4ScjU/rpcjVefdKi3YsCA7fyHlJncMTV4tRC/A
	wHmoNedtNWATBeRLpsGitYwbvfpGH/Udptz/7+RSlVqPTwQraDl3hdzKJSbpgrLTD6vbJf9RXeA
	8F2UQL6Jpq3sM7E3/cWRz6hYBiPCF2D3KM8SIIgm9KT0XDY51WX4ONY6elynbmhGJGbkPC4SC/b
	GByaEnJsDoFimasgwLSc
X-Received: by 2002:a05:690e:ed3:b0:650:3e1f:907c with SMTP id
 956f58d0204a3-6531059530emr16317023d50.0.1776914048967; Wed, 22 Apr 2026
 20:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413113113.2725940-1-lgs201920130244@gmail.com> <87340m3bi5.fsf@intel.com>
In-Reply-To: <87340m3bi5.fsf@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 23 Apr 2026 11:13:56 +0800
X-Gm-Features: AQROBzBcHjCWMDIKu4eKnHDHBqJWQ-q-pT5XmmSFEBvux7VpXdd8kUaCt7bwZFo
Message-ID: <CANUHTR_UiN8V6wWkb2d=9p2FpxH79Fvv-mXCG9217h-aeak6bQ@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: idxd: fix double free in idxd_alloc() error path
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-240401-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: E862944C7B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vinicius,

Thanks for reviewing.

On Thu, 23 Apr 2026 at 05:56, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> On the review of 'v1', you agreed to the comments I made, but they are
> neither reflected in the code nor in the series organization.
>

You're right =E2=80=94 my v2 did not incorporate the broader issues you poi=
nted out.

At the moment I don't have a good fix for the similar patterns in
idxd_clean_wqs(), idxd_clean_engines(), idxd_clean_groups(), and
idxd_free(). Do you have any suggestion on the preferred way to
restructure those cleanup paths?

Thanks,
Guangshuo

