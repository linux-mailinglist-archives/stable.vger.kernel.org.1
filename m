Return-Path: <stable+bounces-89694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B40A9BB3BF
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332651C2245E
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797F31B21B6;
	Mon,  4 Nov 2024 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="DRZFb8d1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52816EC0E
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720771; cv=none; b=dvtSkfSohBKU9ccEVwiYUxKWAsND4HGd7JdneuT7t37K7Siz9LrVzpvK8QBADEFhvlvEzSEMWX4KXMzVFcylxVPJ4m8KBtqNeugZqVUQYl/qcelxGVftXF0SkMQpddInnCWKwnKG/cwOzbkuMWrM2Dpb9PajmA4D521SDjNJC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720771; c=relaxed/simple;
	bh=BJ1XxwX9+ejRCakC8DIkr47BHFwGMfhDiTygxZv5Azg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gi85XQlThr6Sl7uKRL4mk2pzTazL/gb3V9wXhHr/czmYvEh54uYHnPYvn98Z14iAY9lsiXCpwHCvvyFCz0fP1bvsgbnOtezcWcUPuw1LX8pgtA4J3kikUEiHl6/5CMZSVxgfms/fz0ep1pTjjVNBO+bEUsg6bxWAx96OTHEYCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=DRZFb8d1; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e602a73ba1so2194157b6e.2
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 03:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1730720768; x=1731325568; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJ1XxwX9+ejRCakC8DIkr47BHFwGMfhDiTygxZv5Azg=;
        b=DRZFb8d1C0DD3lp0kWXzrd065N1LCA9KaO16ie5tmaG3Yp+3yuWUb3qb0WP0Cskw2w
         3TmUTw6Zi2xrO0+oPnh+tNEfOqLOcPqHPl1mn4zdaRr1Fpz7nQ83FDcXqIRUb0KL1of6
         JyovpQjO48L0qjJYls0yEM41AHFaQoChkIf/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720768; x=1731325568;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ1XxwX9+ejRCakC8DIkr47BHFwGMfhDiTygxZv5Azg=;
        b=PQhHHcPcUwc6ZL83p2Yh8oaZBJ73gsxXGrG49oYMJeW6vORS0SmqNxB2XdDpzso5Je
         N+tv8c9bGXkkQLcT1tRAUZ2RiFIF+hEu5yvpTql/RPJZtJNa5jS7r6lmsmly5EmjhGXj
         1BgMt/fCZnCyZYF3vS1ztp6y0qIvgG16noj40Cufb+bHQ/X7EpdbmghdNlAb0NfnZUai
         W7bbwTTPqh9ghBpLWr7MRgBEC6ufh8Dn3MMYIrFkDqM0D9iHepxHb1gdLGJl3/xQCFEA
         Ju5mvOtzCa4teVIXV071iUioRmI0GRvSSSHjDOKUhws6/DWbjS/7VR0c4qGwUwnTXlHS
         Np9w==
X-Gm-Message-State: AOJu0YxzkprIA/6gCkd+nj2Jf1bKOkOGjg0TAj4h1K1dF3xe3FP7XwOA
	X+hW50KIIq9kTyW+pNR2UvLmsSyaGm2/b4XMD66ue+bYdssH/hjXNTriJyLDNb4Pyz6A1eEijBn
	GKPKS/NHQYDQreTCnHmEz01+R2XPvXlEyWIMnu5bpl+XXL+q9lXg=
X-Google-Smtp-Source: AGHT+IE57DiZ+vwILLCms+OSZvNlNPYNXW+urfabeelFRda5oIiDd1E43fOiBip2okHpFR/tPat5B8ZzYNTtgycEDjA=
X-Received: by 2002:a05:6871:5810:b0:28c:8476:dd76 with SMTP id
 586e51a60fabf-29484638c26mr12056861fac.29.1730720768222; Mon, 04 Nov 2024
 03:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hardik Gohil <hgohil@mvista.com>
Date: Mon, 4 Nov 2024 17:15:57 +0530
Message-ID: <CAH+zgeH2Cjk3pjgrmZYN45VNa_9v8MA52QRjwdaS9hrKnaJUzw@mail.gmail.com>
Subject: net: dpaa: Pad packets to ETH_ZLEN
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Request to add the upstream patch to v5.4 kernel.

Upstream commit cbd7ec083413c6a2e0c326d49e24ec7d12c7a9e0

