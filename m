Return-Path: <stable+bounces-202887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA70CC936A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 19:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA9B30AFF3F
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0060238C36;
	Wed, 17 Dec 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j9xsHBMU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F74223DC1
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994529; cv=none; b=NeEystHNQfbC+AMwfEQpZs9oQjcsGzdo/h+fzHzF+FJ+x6JHNLZ6irNnZ/aNdlySTJbj73TtpdcOXoV/q0avoW9vJ7YpnsyMlKn2dumBRpLrERXPFi6ExegEYAO1r6mq+gVfHWKrEsnBVooJzU7B77bCiNdBfuebwcBan0yBGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994529; c=relaxed/simple;
	bh=2TPL5Q/dPHrwc6hmMCFQBrGZHI/uyj+NlBwzYPnK5Gk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=bkLiM3NPuQUhqcbCgMhysQW3ad9/kgcctezGy7ASFDb8HewL+DIqRjqNevQzZKimoj1qmfploJqfZnsaIwTMA4eeXMFO+pmh7J60dZFaHie0b0We2CRMCOzRzVfJCG1P/NuQVc4jZmEl8Nuncu5A2Vyr2U04MDL+QtzDBEsOMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j9xsHBMU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-647a3bca834so9045610a12.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 10:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765994523; x=1766599323; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TPL5Q/dPHrwc6hmMCFQBrGZHI/uyj+NlBwzYPnK5Gk=;
        b=j9xsHBMU1tF850WwbYQC6CArPCKOscNB76vZGH6G/jkO310pZY5PYhyDbzRjupa5rU
         bjqfY7YlWwCrARGlXZ1R7dqXuu9ISV1xSKTDg/VP8mTywOVWXrwFrDyncXU0gIHgrTB/
         Iys/WfEZLPvwLA97azVHqrjEdq8gecFNcsCKcAyFtXtwFN96zoiYbQ+NQdYh2a6uBx5/
         zZbDgbe2m7z9SVZN8zIlFet4TfV1N+vl0OaJnHfE9k7vn0MIBmlvFlFnO44wuHWwzjcK
         f4FPtLKP5suuuyB1yi6IJ+S/JFdRE5ofxmyThHccMfw7IFsNVHBfXrl918RoOBeQS+tl
         n/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994523; x=1766599323;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TPL5Q/dPHrwc6hmMCFQBrGZHI/uyj+NlBwzYPnK5Gk=;
        b=K1ZTuYwXTNRKuBTfQ/x3aiQmDkcXNqs9G5QxUsT0tBrVX5mD9To+eO401eeP0ciLxE
         d2tYaNA9yY770Nxn31OjwDumvrktDwEzyjVhoKHf/FOirGz633TKyrNpj8wQvpH9gp2j
         nrDq93Tvlhf1va4kgIN7eVNLN8CvymSr9nSeLjK00w8Uw4BSMDDOhWr8Xv8xuIa2c2eN
         KLklbjjSgLLpylhzmabccAuERIdY6tTzMHr38qpoDh4/MyExyLqqKFOgdQai3aBVtTik
         3rhwm9L4hSH5rk9O1SUYE0OBc4Qp6GgWz+qxt3pwypdJkVKKk2GSA9KBNDn+570rfLCK
         D4XQ==
X-Gm-Message-State: AOJu0Yx7M7B+7R0ITVr7ExQqzR2IIDw1Xw/sb8To8rO4b8cZzxBnqlBA
	SLiI0VsdnPB8bC/9fbkNRffhig0EclY89QnhAH76WhxQ/3vw5VmGjA53BPD4K9J+KgZ0uO2RTNX
	ztC+p
X-Gm-Gg: AY/fxX6HyOp7U2caMtMhwyIZiSV/1hajERHOPJ3cvp7YijFt1siW90lO/8xSNo8XM/6
	5cUvRDrydA7aCCo1Sy4yceaUglQlj7AxUrUfP30300eQxj+x36yKzz+iMdiIFiqjIAzojae6CXb
	IL4S4nB4uqwtCUXJB2FUoovXoJsKvmTYCzyjrqUIDvlS0SXK2FVe2nL8mWxUxpaJdOI7ovApAej
	wrsvIdv1bgWRN/Yn0UqHhHfwQywvhUY31OAkOsI0uz7Vc4DR+rDh0rs+v84W6qrS1twoErYDSKw
	zfi+U/im5BSS08lhkVe/0KCY+3UYRTfehTrmL2RgUzfnVBGlVidFMj9SUk8FfviidnTHHi09eOE
	zEU4MLbjxBP/LtVsSigXTgx33tnPYWS88ELqaTG648RKnINk8EofkU2/5Z4AYtTSM6hCeSjRbNI
	wINYeO/W/WrPgPrD6A3g==
X-Google-Smtp-Source: AGHT+IFqUv2onCAWz5WRrEdj13P1On5njhOcHAJ3MoM6BWuSRi8aLm/kX1KqyWxD1+w3DOqXeyUDug==
X-Received: by 2002:aa7:da4e:0:b0:649:aa32:7c0a with SMTP id 4fb4d7f45d1cf-649aa32a55fmr14103094a12.13.1765994523015;
        Wed, 17 Dec 2025 10:02:03 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b585d1d61sm162369a12.9.2025.12.17.10.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 10:02:02 -0800 (PST)
Message-ID: <5966fc5a-6057-4fb7-9a54-aca0765120a9@tuxon.dev>
Date: Wed, 17 Dec 2025 20:02:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
To: linux-stable <stable@vger.kernel.org>
Subject: Blackport commit 44bf66122c12 ("pinctrl: renesas: rzg2l: Fix ISEL
 restore on resume")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, stable team,

Please backport commit 44bf66122c12 ("pinctrl: renesas: rzg2l: Fix ISEL
restore on resume") to 6.18.y stable. This fixes pin controller
configuration after suspend/resume on Renesas SoCs supporting suspend to
RAM (e.g. Renesas RZ/G3S). Patch applies cleanly on top of 6.18.y.

Backport patches were proposed for 6.17.y and 6.12.y:

https://lore.kernel.org/stable/20251217180000.721366-1-claudiu.beznea.uj@bp.renesas.com/T/#u

https://lore.kernel.org/stable/20251217180010.721533-1-claudiu.beznea.uj@bp.renesas.com/T/#u

Thank you,
Claudiu

