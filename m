Return-Path: <stable+bounces-210276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBDFD3A0F4
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2822530056E2
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44733AD9F;
	Mon, 19 Jan 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7UDcAmz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DC33AD9A
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809879; cv=none; b=KEdB9bRTmGaDa+UxuXHkXUlPX/xC+ygeJW50F3etkf/VHp7nDO1RFxiNwcTrsXcNRVr0f+1jFq9ihwQedIuGZv2DBBtsHbWNKL2cuREGOoklU4S9D/o3nN3RHDKr29qw6VkEmBiXep4HKHmHZJVzR416bl8dcQlAy3eulO0VO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809879; c=relaxed/simple;
	bh=fSk12Kv8vzWHPNwrVW04X+ndtNeLwKcienPDea2JogA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tuYHKZ0arJOd4tUxFw9Qn4gw66Z6eeRn5FJAIeOeoa43U+P+rr1s81rJYAK6318VWEuszdNBEYI4ka+X9zy0g44aCR/pvIVGswjhmV8/gLmWSWFIxjmxniQ0xDwQOZK2dJXHBuZt3AwJw9brAYkSj05tELJayOcuaujldw0FusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7UDcAmz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b87dba51442so74091366b.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768809876; x=1769414676; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSk12Kv8vzWHPNwrVW04X+ndtNeLwKcienPDea2JogA=;
        b=U7UDcAmzCl7y/Pwj214rsFCtPgeJh5bvSJ+a4+Co8bGAjj8oM+bJNpih1kzSKO6J78
         NG93sdvCqfMZhA7/N5vDAzNdrk79YUmn586xg+Fixmx1J5HlhiZB4IwYQgOdK4GPUMcZ
         m7UMJec2qzUn7YOwnPSmMNak8cBsJssgswKZm0EdzQRh9HTFwOJBT7YG4tdRyoCFHsCt
         QoLbKil+7FK46jcg6L6I/E7RwtMynwUqewz6OgeL0zXAHgA9QVx7LpGLWWsFkvSnF8bQ
         /iVsrf3mWa0Iky+X+unoAk2YYoXx2WviXy4DmWltDx1FIpClg9andegwyE7uS/xOyBL/
         NTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768809876; x=1769414676;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSk12Kv8vzWHPNwrVW04X+ndtNeLwKcienPDea2JogA=;
        b=jTQGDD37TnOE8wpKY1/U/127QVvYRF+vS9BV3Nrdgn9zaG+blGaPbo2iJ55V/T1ZAd
         3J0NbSmp0jYTyqoPPHls8Ri4wapozFJnbl8mcsSwfxDk12QG8OAgkixNFzvjh1MAte9B
         CiFlG9vInrivNR9vb/qAaEwk1ZAqb8/IL7Xy6VaV7PWZ9M0UrmzrbbUHRrQ6CKCK4buH
         Jt5+EWofLsPexxdWYFfV7Z6DqmDPrgNvHRdJKun3/UwLaOZqhPjdhpmPhj6RGeZ+wJXF
         krLGPipOZf/xDm8GiB3hRW8NK17yHnRIaw9Rlsj4fcRxyipFOBl27VBlpFRZXVYWip7r
         5WAA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Amokxb5gR9NBhx42tGXAbPC3prcJnhdeu5ISwv18mRHZO4XIi2YuaxQ/0WPuDY1c3s5BW0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwgNayfvZ60O1I2W6BnVNcmXGxtSZ8xFJeLA9W2aCb5EZsm7u
	/cjzAkSna18sYXBazHKeMNhdF0XwlC1CU2N767eiSxVSFzSUWU+cRQwmoMq1+WkMrykcTZ7iSQ0
	TKM8Q5HJT02he+rbS3WQbh/i76SP6uBw=
X-Gm-Gg: AY/fxX4auJIQoTJAzF0DU9LUJITEk2vN0bx4BD2G3Mn/sr4jSEP2De/immd+dztxOji
	cJrGGj0lL8f2gF2A36IolqALOVVVb+8ervra3gynWACZwjBlfoc5X6hrlqPCi9vcmKV4lyOI4ct
	gpTenw3DdzZBw9vTBoms+M8u+pvEYvQ18WTw/Z6k34w6bM79APBxw+hKKaP2YDSsJ4iamUDexZ5
	RLeOyPUFnEUTqFPnVciJ7zVpNQXLux6FjRfvQ9uk0XFXgrKp88eb9BtArNfpIqpIxDdCTjjN53o
	QauJZYGIE9iPNhGDIo9FBEV2sWyRrXFAFGBq3A==
X-Received: by 2002:a17:907:6d08:b0:b87:1a92:b621 with SMTP id
 a640c23a62f3a-b879324e841mr878599966b.64.1768809876386; Mon, 19 Jan 2026
 00:04:36 -0800 (PST)
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 03:04:35 -0500
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 03:04:35 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: zynai.founder@gmail.com
Date: Mon, 19 Jan 2026 03:04:35 -0500
X-Gm-Features: AZwV_QjOh7H8oNxE7nJj4oXOSyEyHo-o-wDGfblLl6I25ugW0u8RNniD7otOyKE
Message-ID: <CAEnpc1ZU=HtgrpTYFFE-PXgFy58C3eLQ4m7akAz=QJq6xfj6rw@mail.gmail.com>
Subject: Dentist Time Savers: Is AI Your Secret Weapon?
To: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	patches@lists.linux.dev, info@morenofamilydentistry.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Moreno Family Dentistry Team,

As a dentist's office, you're likely no stranger to juggling
appointment scheduling, patient communication, and administrative
tasks. But let's face it =E2=80=93 with so much on your plate, how can you
free up more time for what matters most: patient care?

ZynAI helps businesses like yours save 5-10 hours per week by
automating repetitive workflows. With our AI-powered solutions, you'll
never have to worry about manual lead handling or tedious reporting
again.

Would it be worth a quick conversation to explore how ZynAI can
streamline your operations and boost productivity? I'm here to help
you discover the possibilities.

-ZynAI

