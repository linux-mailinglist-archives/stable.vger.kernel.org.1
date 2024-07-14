Return-Path: <stable+bounces-59249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98B4930A8F
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7291F21186
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B913A249;
	Sun, 14 Jul 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BedlXOKO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC27346C;
	Sun, 14 Jul 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720971167; cv=none; b=P18D+E2gpJL5uKatoNE8QFGYJdSKtvA8A1WPSAI+58e6SAlAwmgikXTSXrGWU9qw6ZK+GPI99RLgxMp/ekKn2irj5rrs5OOTYZrKS88gO9DdG8XW0KAQvM8ONUbABvvWNgkRwbU7mxzbMtgjcG/7HfagUOIBBzQjF78cYlhvzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720971167; c=relaxed/simple;
	bh=2De6he6VSLh0YG1nLPNHQ9FmCZU/7MYcTOc778Z9eDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=LoXWsxXm7g79+reJIk7YB42rF4hkELTba/oY3IV6DYi02e8K/SefmGou1U5v9UkO6qL6KIJ6V3tEbodPKcoElKdK2ieGfNpa7eQMWbJLTkqWQFon0S+2HyVrQf8EVjVt7Nttra0+jXJKzmOX4WsynAoQHckwGD7RVXzTKFSAa34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BedlXOKO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso4346118a12.2;
        Sun, 14 Jul 2024 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720971165; x=1721575965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2De6he6VSLh0YG1nLPNHQ9FmCZU/7MYcTOc778Z9eDA=;
        b=BedlXOKOcv8q1KkzWNu4rFd/dqyK/oAD8kuNpAz5OqTla2nG+cUC20BD7b8fJqwMX6
         izW3yMUYGMvthxUV0o8TTeXOa4+nFf60BoBrfocuNMGn00+BoBU1qwra0AogloHlDQ5y
         ZhTcNhRfc/Wn4zZmK9VV9C5rO6y5rGoGctAJdzEvq1hmP9euZWzKgkyrAPok79oLlksV
         gaHRVOuLyB37f5oTPXXjHRAbEyvkP1pPk1V3Ee1VGvJnwkwNxl8+mLcLQ/P2w9ZX7DRh
         U4mvj8QYsaMD3oMeRH+wtzOizfDj2amIZ/9brey3VtbDyX/KQDlAi2O50hk5DKKyMWcl
         EsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720971165; x=1721575965;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2De6he6VSLh0YG1nLPNHQ9FmCZU/7MYcTOc778Z9eDA=;
        b=LK2U8C44tWqd2S3/Lz69U4IRPd/OCCmnQzO5jP/6VG46wPl6wAt8cL/9gx8HYpcweG
         mT7sufDQOUuWZERGGugly82SI8GcfsEZEZUYua7wZShKnl85hC7sBKaeNAjZ1AY13buX
         sJporMCjoACKZHg8QX90VpW796iRVxUyo6w88LmowikZjbzefA3ndWEz5Ii9za9aZjcP
         lncl7yUZxFlcgYy2YjuzxvO3ILGMtI7JZ8AdZL34hn4RYFyccyf24gZ0Xgi96IzwdXvM
         9hr4x6sw/xCIVne9jTtTtIjh27in2mZThbKxtCC+A5vWc+FZPX+G2LbhBf14KeYvok6A
         ikeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSVPRTBiJgfsTCKl0U2zvfbYMAtXvGt+WjU2Ushl2UW7p2InpLsVQWo02KVQbJogx8spTEk1kseX86JwTl96kZ3MdhwFd+XhqZAa2hGPx3a0pZSRRB31Hazo55Y3p0Ohm1bo0cBHHdVeCd4Vi/wHBTIEdMOw6LGw341TJ1C3Pq
X-Gm-Message-State: AOJu0YyOGskYq/vbk291PKiA1d+DlmvuvdA5ItFkCk53CAO5dREWYJaC
	adNQwIs6i4NPEhtwb3E7uiYyTVD19iOlqO+0BNUkoz2As1hx+lPJpv2RPmsr
X-Google-Smtp-Source: AGHT+IFTdJSZz2yINg0hLtyz4ho7f5/gPjRmFrJzZi06s3gTu11+Jt1+LLogwIIHdKUjVI+L2YIz6A==
X-Received: by 2002:a05:6402:51c8:b0:59a:c13f:9129 with SMTP id 4fb4d7f45d1cf-59ac13f93d8mr4540008a12.9.1720971164477;
        Sun, 14 Jul 2024 08:32:44 -0700 (PDT)
Received: from foxbook (bip217.neoplus.adsl.tpnet.pl. [83.28.131.217])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26996c70sm2161168a12.68.2024.07.14.08.32.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 Jul 2024 08:32:44 -0700 (PDT)
Date: Sun, 14 Jul 2024 17:32:39 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: elatllat@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
 niklas.neronin@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <20240714173043.668756e4@foxbook>
In-Reply-To: <CA+3zgmsCgQs_LVV6fOwu3v2t_Vd=C3Wrv9QrbNpsmMq4RD=ZoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This looks like bug 219039, please see if my suggested solution works.

The upstream commit is correct, because the call to inc_deq() has been
moved outside handle_tx_event() so there is no longer this critical
difference between doing 'goto cleanup' and 'return 0'. The intended
change of this commit also makes sense to me.

This refactor is already present in v6.9 so I don't think the commit
will have any effect besides fixing the isochronous bug which it is
meant to fix.

But it is not present in v6.6 and v6.1, so they break/crash/hang/etc.
Symptoms may vary, but I believe the root cause is the same because the
code is visibly wrong.


I would like to use this opportunity to point out that the xhci driver
is currenty undergoing (much needed IMO) cleanups and refactors and
this is not the first time when a naive, verbatim backport is attempted
of a patch which works fine on upstream, but causes problems on earlier
kernels. These things need special scrutiny, beyond just "CC:stable".

Regards,
Michal

