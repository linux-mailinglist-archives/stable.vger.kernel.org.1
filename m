Return-Path: <stable+bounces-194474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86200C4DF29
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049013B8B36
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C63246FE;
	Tue, 11 Nov 2025 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7Pb2V6W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33803246F8
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865195; cv=none; b=ZFy3DROacOsbdoaQCl4nLns2o3Q8dFwZC63JvvuD6JHmLLsdM0BGuD2TC/n12GDcfoenSFW9b8ijF+TTVzmeJwYhHJrozYSEP2rX6WxcpS1Zz+vU5NN/9OfiUey6m9Ho9HqBmF5XqZazT2MAXnVkH02zhwtE3AEhSwItLKa9RIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865195; c=relaxed/simple;
	bh=JItpcP0eTnhwV9Noczy8NGuBeT9NEkCy8IiKMQF/MfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS5du6LMoKi5Zvir1BOZZqjjJ2Bofti0zS6ft4oDRyHV7QqSdUvdL1QsrOTx6fkEadF+IawOzLDcO5VqjBezyb/1fppuYgS/tya349U+sA0Xjw8Wtc53ZQdDDeH5inGFgmVbhI5/zbF8Pbw4WwcGc0vSMzJZUEI+5WzlwmelJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7Pb2V6W; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b8b33cdf470so280368a12.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 04:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865193; x=1763469993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JItpcP0eTnhwV9Noczy8NGuBeT9NEkCy8IiKMQF/MfA=;
        b=U7Pb2V6WWzHiK+/xkhnQQDjcx+wWEndDsTXwOdqB3d6cNWnRtN2rlYXSnrXnCmSysi
         ors2STwyFeY4iFSQ78RklBuyPF/wtRPIqALW88nHCmfbtH0x18iSf7GzHpOGI6ZctyMV
         yY6iC7DcqGTmkjtpcZScJmsTATrpoII6B1mNQnoH0ZUpYPX2pnYqAvlEUvSyHcCq8zjm
         bvB2PA9QWU0Tcvc7Gv02X09Bzx52sUed301JJBIzzENpMm6WrEHhUOffKZren0pYJiAR
         YenXdw5WT4X0XJzn1adAODOtTflgwM1E11tOVaLuN8bqygHRrJvi45lfGE+5WqJqpRIe
         NWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865193; x=1763469993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JItpcP0eTnhwV9Noczy8NGuBeT9NEkCy8IiKMQF/MfA=;
        b=aUv2Je8lxqDawtOWe74NkA6lqQ72BeoxFEREP1Ag87ltUfZ/jSTZFDMYTuTb/gV4eg
         ONw+ZSsaE3XklI4QDo521pl2dToJi9NfsYyT5OCO2mm7ZROMUdyvHpRmc21PatDou4I0
         2R4jdCEOoSAR/K5wBR6pWwcHZ7O7AaroiXK3k2iuhqX/2DsD2EhZLAa0VxV5CBlyZ6Sm
         6Ts7lofDR/bMa8W8y74SmJ53sUBg+I0sIm9eA4a4Y6F4q8t75k7AlxDUWKafvNRXAk30
         aZCrnrjeuZSoAH8NS4jfGyZMKB+G8THXZJX46Fkhjnnp2PuEt1Tj8eNRapnm0oidK3Pd
         sbDg==
X-Forwarded-Encrypted: i=1; AJvYcCU0cvJEiDpPBlSENriaKgwEelU+8x52xNsZ6kR0U58o6fExiBmzJ0q7zdzm6KRooST8P+pSyEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzta995aGZdx5+T26x4YiSCNyk1G1R5BJkGGM21L3wfzpSB4jJc
	MH9BI+HVJQXISSMgf0Tzhbg5HhgW2SiMY52pEjOwU608O7Q7jQrDlXJut5CkzDe/xq41a8ZXC5S
	Tt7V7DOQ7r/DUqxL7ReAeOfiKPrQQbos=
X-Gm-Gg: ASbGncvg3wG0/18ilSOwcii5AdfaIj2B8of0a8RwC3OQrK8FoHED3FiQXciGo6VeeSE
	RfUqdBpNNcn4SX2dHke5H0ZgGPoxOW3SC2lsQUYWbZwMLLdIQRQVNgM9w7O9bie3ijYR7pvH97g
	RwMUS4yMvFRDfHKHxoYcHSt7lo5J5Kr6UEnDZsk/wAU+khtAgCbnpnJCi69KQO5uih7KQ2iQucB
	P+fO+o7mZacrynPup+8wHU+1pKKx1W0Hv14TTuN+ClDukk/mvQ0/hvnSgasraKvnNu8STIfBBBD
	kJEy8MfP9LNeh+ztLno+c/YnG1eU10dS3cDyeE8ihQlpLRBktqdMnlrllhwafFXG3f+g6bmS/t2
	4cdIoXH5h/aPeJA==
X-Google-Smtp-Source: AGHT+IG89+nJqt1NQ9yQVlJ7wMMJLKuqKsEWh13ScU5u4eE2MLJnm71QK+LeNOMd2nCi8GjSzg2EFdqVeEg9hU69+/E=
X-Received: by 2002:a17:903:2f8b:b0:297:f304:25ac with SMTP id
 d9443c01a7336-297f3042725mr68312795ad.8.1762865193170; Tue, 11 Nov 2025
 04:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110816-catalog-residency-716f@gregkh> <CANiq72m2Rw2tFVH5e0PKo99k6Bn4fn-6N39DnHGsEDvmNhGYMg@mail.gmail.com>
In-Reply-To: <CANiq72m2Rw2tFVH5e0PKo99k6Bn4fn-6N39DnHGsEDvmNhGYMg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 13:46:20 +0100
X-Gm-Features: AWmQ_blsDWXmpWcoue2F8soDSQoDs9HhAkKRH1l-aeoMFDTI8bR0YrVGK0tZMmM
Message-ID: <CANiq72kEW52FBsanY2eqs+OXS6xLx6+J052RTBzFLdR5dinNuQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: kbuild: treat `build_error` and
 `rustdoc` as kernel" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, aliceryhl@google.com, jforbes@fedoraproject.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 6:05=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Sasha's sibling resolution looks fine, thanks!

Just in case this was missed, I think this one and the related one
weren't picked up for 6.12.58-rc2.

Should I do something?

Thanks!

Cheers,
Miguel

