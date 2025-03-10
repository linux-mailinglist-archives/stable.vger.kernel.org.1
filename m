Return-Path: <stable+bounces-121717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB5A59900
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407A51891D43
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C035A22D4E4;
	Mon, 10 Mar 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="Uzf2lLjQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B922069A
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618605; cv=none; b=exdFx1J43x1PzxKlXi+DZWn9wZFGLX3VQBT1k1jPvxnf4/kY+vSPW9sG8Ioh3q6UJi6Cw491BV5SqnO4B5y1u9P6dg0Yb9mbKU9Y77l/Gfx2lcGZjyH4Vh4bBE6gc53YVeFcebqAZR70godt5Q+xXJZCIqQQGfN9dLE6CMK7rwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618605; c=relaxed/simple;
	bh=UYVzgN9ktwWJ/Omdx9KoLnQn7l+5gJdLXSp7SktPMM4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JlWqUNoJXV0Z40j2c71hbqlqIdrcrAdZEQuIPfQ4RiRQ377cY3xURG0grrixQSqVxKb5YfF4EabR6G7UPren+8buX+Z7ndZEj2+AlyuDytdGXQz2xFPPv6C8xKu310fGE8SoUS49i2Fz13OxPOXurib7PewolMsRXrqY4Hbx5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=Uzf2lLjQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab78e6edb99so660777266b.2
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1741618602; x=1742223402; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oYNPzp+ecMUNtet3D1azs0pBZJ4ja/mD6eVd9mi2oXU=;
        b=Uzf2lLjQOArIRdL7S96USckwaRLhziqr8aPElxt0z7mUJhMtTPbGQNJ+b8ImvKIGln
         Qub3zjfh15y+qfBQHcsTS+OVOcW19UfprqzrMmDbqWDeW6jPdLShJQFr8qYtSfwUL81f
         4G8oyjIPjakks2Y0ubbM93kX/dubMelyW1Cqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618602; x=1742223402;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYNPzp+ecMUNtet3D1azs0pBZJ4ja/mD6eVd9mi2oXU=;
        b=bwBNKTOSAytWSTQbU44IICNaNez3zMWgGXLiP/lg1gIJTs/cKuj7/U+lKJRqFN0yTs
         teUvJ2tWervgBObThMCb1JKWePf4frXXZ70IimN5425pUbDVix+ltD/YVGZZ7VVkDTRB
         mGxG66TLjbKeb/d8ZuZnJ7LwZOfP+kPySP6cSkKmL81nwINWO8h6Z0/1E/bwUhd4BTGS
         Hbi8/PY/UXDjboQAt3wM+wpxu1gKD9tGuzalWs7tS+ORAZb1IL0RXAifi7LBfKz9Ty+m
         AnSjvoxrL2uGaqqerbh9cfzO3qatfNta69xunkaVy0w79dKawmXovj/RTX91PoiZBKBu
         ssdA==
X-Gm-Message-State: AOJu0Yyx1xsI1yKjGx0zjE+ygwsftpaIOdDrWoDPC8m0BVtc6ewo0TW0
	jryp5S6LwVxXjUVHWdGRp7wu9AvGQPzpwgpEYKyD8oc8cdME1wTsRXrV04i/E+dlg1LOMmtq+nh
	UiQ/sy64cYNJjd+vYAr25ddPxOKBp2DVP0dheIhqWV4lkJrsDYAraLw==
X-Gm-Gg: ASbGnct4F6H4y5qo4cITGyVpq26CzAIBiJyk+uNHwQWBjClvpaoyrs7YjmshKImNRCw
	IXLhl7doyC+HCdG21z2sSmS2sCKcGhUl1S8E4lfiMyNYOHv9x6VE5U+Cg9w/tLWeyMnKw+q2s6R
	bQ0sARHAAdXcLnKdA+tMeMFB/1HQw6SgiRU2XPDEl44S7eCfztJSgZ5QoCvi1OBgKWwA==
X-Google-Smtp-Source: AGHT+IFhnIZJFlXw+sjsjhgv9b8EPgS9LT/3EOjQv7WOG1+/Q08ogPfkfeer4om7zsdNiGFWL4p0m6W0STX3gg0+vWc=
X-Received: by 2002:a17:907:3e16:b0:abf:fb78:6743 with SMTP id
 a640c23a62f3a-ac252fa0fedmr1699028866b.35.1741618601250; Mon, 10 Mar 2025
 07:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel J Blueman <daniel@quora.org>
Date: Mon, 10 Mar 2025 22:56:29 +0800
X-Gm-Features: AQ5f1JoyTZLAR1uYFfnbJ4miozOrM_h9cFJ05aZP40squ0JSXTgqkhAOetNxIvQ
Message-ID: <CAMVG2sts_vaXReAYsQ60RQoc_76dT2TkthZHsX=FvRNMA177=g@mail.gmail.com>
Subject: net: cadence: macb: Enable software IRQ coalescing by default
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The macb ethernet driver (Raspberry Pi 5) delivers interrupts only to
the first core, quickly saturating it at higher packet rates.

Introducing software interrupt coalescing dramatically alleviates this
limitation; the oneliner fix is upstream at
d57f7b45945ac0517ff8ea50655f00db6e8d637c.

Please backport this fix to 6.6 -stable to bring this benefit to more
Raspberry Pis; it applies cleanly on this branch.

Many thanks,
  Daniel
-- 
Daniel J Blueman

