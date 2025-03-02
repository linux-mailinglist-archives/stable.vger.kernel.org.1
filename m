Return-Path: <stable+bounces-120027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C4AA4B495
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 20:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982C63AF98E
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C01E7C10;
	Sun,  2 Mar 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nkz9Mg2t"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88A1EB5D7
	for <stable@vger.kernel.org>; Sun,  2 Mar 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740945415; cv=none; b=SJ7G6p67yV7d9bJEIofLWaPaeR7wL/Md8rdATS1Fy3Xnr85WyZzNxLS83GYcLt5zt+fk+A0RzImSDRIJp7y/3PIw4s6dabKsHPMBpUbhPonYF7cYzQbVk7Yirv8P+WjMQB+1NokrQHnlA4RCBiu3eIts6vWU30MqWqKY6v3T6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740945415; c=relaxed/simple;
	bh=OKV1efYMrZxsnJ/rWVIilTTMcKzd4WopWuD1/2wnSV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGCmkBqJ2MD8L7yViRCXZ1PmaSupVXzAfeZmYJzvalcF+hbejs4N9BDX7bHpjCmDK1kVyLUHo3jIHzgcefqDP47KBogKJkEi/sayLIx/OfujOu/5SsR0WMUGJGoLMI3Ci3MiC7eMnBu94bN8DZg3FFtBgfZRgPWYb5aUO2cyGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nkz9Mg2t; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e89b6b5342so36325396d6.1
        for <stable@vger.kernel.org>; Sun, 02 Mar 2025 11:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740945412; x=1741550212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGINuK0Lq7qG+F3Hr7JCQc8hjE7AHW/exSMusJ+icT0=;
        b=nkz9Mg2tMpOG/g9D8mkJ5UA3ufxBtCX/fB4Zm8ETuewr2V6eo3MJYj9reKmwcnoSOt
         erFXXydwjsXbLqPkCrK7+GURdVLAdF8SfcfGKxB9tPRl2pfQfTqzQfGEspLmO8cP9EZ0
         A/KH+3SjkUFPhCrxyRSSSKpUcMjx/1hqWJKk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740945412; x=1741550212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGINuK0Lq7qG+F3Hr7JCQc8hjE7AHW/exSMusJ+icT0=;
        b=ZwsRRWtAHE5YVs3s8gGzhDshF7YK38VG0q2PGJvttZ+zF1YLU+fehW7FYw9h7yw2yB
         IcQ6hVCPvsZnn+TeeNEpjnv9FPFTLHJ56CoAIAH0e7eDouAvRdtwnk9AYQOe4Y8uyrlN
         +yMzvdwxfsWHOco6uxouVCduGaZf1iZ7Bx6tfhPLwOHi7auAEVyPYOi0AaMp7lyqT5JW
         yDIvhvBTEIsLAjKbRugzi0yzEeIW+GHy45ac5QFwAFCZxfJPLlknfDgV+NZgJ2FpklRn
         wgOgCAx/PAmQZv7r0x1F2tgWmXUO6GWHO3y4MRRYrBYoUQ05bVXOCQdIlzvmb0FAFj71
         0Guw==
X-Forwarded-Encrypted: i=1; AJvYcCVqN71G8aVIeyjyYGZQtINEXFc8WX9Y5MRlgDzg1ccdFU9k1s2ojE64KQtUd8YGzn/5XTvb0KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSej3qzMsqOS7rh7yt+Lk9ffA9wxyVQpxWuoFNYPR4PNRjimhD
	UZGtfmZPr053LBxthnHl8d1k8Jh5tNUkMI1N4o/swR1B/5+0uFA2qApSxy1fRxVxyMgow1NJ72s
	=
X-Gm-Gg: ASbGncvmop1qJrkPd0XIX6pKiHsfTAFWa9XOq7PggtgjhcjHWZNOXzh7MM/pkpiSnol
	P9OxEczSWiQe56CqUSXIzPB6fmjS4NXLW1a5euk3jtwJxGTJ/JZQ8HXgdAf8fsHdv6NI5j4ImNy
	cyykHen1Y4j7gvleqI+yzqwWbwUb07SIblsf5SHDjplj2DL/BjtZrlrO4216iYVIrGIn/nhTo5T
	1ZEbh4txX7IdTz0Vpvdt3vHlietmt2bT3KtddwziXyvgbwQ8RcA7LqdBA8GzMekL9cunLP3Bifd
	C0lj7K75McsdLLkiyWzY7q/letrov3bv9h4pdGrKljmUVP9dyE+iCdANESXNStBUg/RHsj11R2l
	W6rTNunYV
X-Google-Smtp-Source: AGHT+IEwC4yVWJmDpb66quEe8Qpn51JOxTPTBjbMZzzZdLgDGpTOtMwFzrhIb+GETqbPpW4Wmfe8vQ==
X-Received: by 2002:a05:6214:da1:b0:6d8:e5f4:b969 with SMTP id 6a1803df08f44-6e8a0c9e4a7mr185137566d6.10.1740945412559;
        Sun, 02 Mar 2025 11:56:52 -0800 (PST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com. [209.85.222.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec0f8sm45286576d6.120.2025.03.02.11.56.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 11:56:52 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3b4c4b409so112358185a.3
        for <stable@vger.kernel.org>; Sun, 02 Mar 2025 11:56:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXXkiUDvK2Ywhkt6Z4Hi6ewW5YGnTF5Qx16DFecvTHi4JUi83R20HDLhRt6XegPxWzF/eVzcg=@vger.kernel.org
X-Received: by 2002:a05:620a:1710:b0:7c2:4a63:1a5f with SMTP id
 af79cd13be357-7c39c4a4736mr1373896985a.1.1740945411646; Sun, 02 Mar 2025
 11:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABD8wQ=pU9Yc45WE07FGO40MUBf+BSZFGcoO1ff7NxC1cXzx-A@mail.gmail.com>
 <d4c5d4f6f47d4d926c7a2469cb4b85c0850945ab.camel@mediatek.com>
 <CABD8wQ=K=xa4+KoEWuQNaMRP7A8fVY38ShyfW3DLcwVcU8R2aA@mail.gmail.com>
 <CABD8wQnRAdEUnc=NUeYjTXNOt5oX6secXw5jgC1C0Eb2wp4cTQ@mail.gmail.com> <f935443fe3970d0e16462dc53bdb4101855f165c.camel@mediatek.com>
In-Reply-To: <f935443fe3970d0e16462dc53bdb4101855f165c.camel@mediatek.com>
From: David Ruth <druth@chromium.org>
Date: Sun, 2 Mar 2025 14:56:14 -0500
X-Gmail-Original-Message-ID: <CAKHmtrTWj_z1bVEZDkSTNvjidTdHVoHqKO9D70ZfpsBMf5WP7w@mail.gmail.com>
X-Gm-Features: AQ5f1Jq-3et_HWVOPe7HtPn0rYvMjAlKZKXqHpAM4f51RCv2Y65rFVDuuq4d6Wo
Message-ID: <CAKHmtrTWj_z1bVEZDkSTNvjidTdHVoHqKO9D70ZfpsBMf5WP7w@mail.gmail.com>
Subject: Re: [Stable Regression Bisected] Linux 6.13.2 breaks mt7925e
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= <Mingyen.Hsieh@mediatek.com>
Cc: "cjorden@gmail.com" <cjorden@gmail.com>, =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>, 
	=?UTF-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>, 
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
	"kvalo@kernel.org" <kvalo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

I ran into this same issue this weekend. I tested v4 of the patchset
at https://patchwork.kernel.org/project/linux-wireless/list/?series=937821.
On 6.13.5 with gentoo's patchset, the conflict I encountered was at
https://patchwork.kernel.org/project/linux-wireless/patch/20250226025647.102904-6-sean.wang@kernel.org/,
specifically the hunk:

@@ -134,6 +141,7 @@ struct mt792x_vif {

  struct mt792x_phy *phy;
  u16 valid_links;
  u8 deflink_id;
+ enum mt792x_mlo_pm_state mlo_pm_state;

  struct work_struct csa_work;

The issue is that the mt792x_vif structure has changed significantly
between 6.13 and mt76 HEAD, so I had to manually merge the patch
myself (which wasn't particularly difficult, but it's worth knowing).

