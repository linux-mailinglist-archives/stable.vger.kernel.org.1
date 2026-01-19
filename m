Return-Path: <stable+bounces-210258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D93D39E73
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71D55303A03C
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631426B77D;
	Mon, 19 Jan 2026 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra6I2J+x"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493D225F96B
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803991; cv=pass; b=HUrV6Uhyom1vKAS6KgopI0UAsLmTGjPZY1RPQmnbz4T5Ft+s4gFUm+mTG0L6Pg+pC/5RZRCSJW/fQ8cY/cU+o0CuV+pS9pgUZr4EAYRl7yiub4sQUprbP6DrhoVpM2eqHuG2p8JEk8ReMzjx9azYcntjuddsj19LhvSS68xNZfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803991; c=relaxed/simple;
	bh=OIjzeBWD6G/+7P95/hT4dCh+pMCak/NsTNO3fpWO1Yw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GOqpGEFdotv+qVrrIDUhKgwsFYxqjT4LjRQqbSfk8S0QKO0PqkpLlWcMDWPPdq1ivV7y6omdKBm9Oe4zBG141H6dsPYpW0iNImkWu1GlwLrlBRjRUhFLurQt4O21v/fTpRMeAG3j8FNW2TzOvNK3C4oLLrm6NqVfhLEBLqrHwAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra6I2J+x; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so7474955a12.0
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 22:26:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768803989; cv=none;
        d=google.com; s=arc-20240605;
        b=Ie6hzrdetLN++X/6gZfw1ofkHAp136vErDPhI4YKV3m989zv9Jq83N1uanJlTb1vHl
         tvkT4G7HdOL26nAfAJffcPgsaqUe0Tw72KoALyeFoAQpzkHLHT/vIEfZAfxO0z3fhLcT
         s6U0peQcnTT1d14w19K/zDULsQxIIXMQgMhC5wsFo9KM5jB9QNC03Q2cvDcQAN95zhMt
         aaiDA8CsuSl2XezBDQsMZZbcY6jzxtgUAYGV1vd66YHFJEEHfsGF0upNFPeN4ATWBV2C
         v90FmHN78VPtQncAwPfKt+BaQG7lSmrVFiXLmWeHBPDtLlWSIFzg6fxpKouEiRbCzyd2
         wiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OIjzeBWD6G/+7P95/hT4dCh+pMCak/NsTNO3fpWO1Yw=;
        fh=ylbxjRMvm3lu0TkmvhEoDPmP6jbAeC2fyLkYlP2E0a0=;
        b=Nysm6SNEzjJjn65xZ+69TrO1fqgcMzAx8V/XZJ7PZKByfRwbbQaAz1oRvDSsi7cCa+
         h1FynCm4PWkyYPcXiNZEQxAD20VJtiPW11xCNiPZ21B4hoBQ4ASrOLyminE6TTRVrfly
         UD1VihROfzrGqDCW1nLZZGawN+htPbSbLotEziSoNMT2lgHOwpYCFKScNFafy+VQDpkW
         VkdG/N5MJfoafGYhPHJRcwILU/FGAV11kC9fWJQhOMlc/Q/TcxjDERXS1nGmCsJVUEkJ
         WqsyIh69HsuIMfOhUjc0Z+U9XBxRDVpMHDebs1nsajo8QNLOpMrX8VnPHCP1Lv7fLJDa
         XE4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768803989; x=1769408789; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OIjzeBWD6G/+7P95/hT4dCh+pMCak/NsTNO3fpWO1Yw=;
        b=Ra6I2J+xwVEYeaTpDHE85avwKKYJdMOtRN1hqs00Oj5ZWGRJAGM3imIgPaKZbJARIT
         W3l266fBwTiFdVKkF4WtC/bd7iCCKNoOqdEX3lQR3hxPoZhjRIrisKRYMraZqIY69q8N
         H1zMpe+/fRP+2QMtPUUtRdmTJ7CVNYO+75qgXBW6S5BCtsemV+lXLyrVYie8+PKN2aWS
         iCbLnXPnyV4p307HBDMdDaxuVNUhNEZ5F+X6VQpLwlUS1XKmGGOw+w6sU9aG1NCSfIJz
         vEtsiZ/PZYSbBl9IA+eF5OlUkkfyZMIqgMPpRx4ULPSSL509hZtgoI69bgLQiwfuYic7
         1E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768803989; x=1769408789;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIjzeBWD6G/+7P95/hT4dCh+pMCak/NsTNO3fpWO1Yw=;
        b=KtwuqgV+dtousVjNKdQnUjuBTgaV85yfOvIi2z5AaYjJqLol4+rRJiCZoQq1AI+uBS
         XBdCDZAZLpxbyyI9D7O5y1No+QFadcWWGPnXDP6CL0NUb+HFg2yhACivrfO62cksc/lb
         cH5zZ7XfFNui6nmLBjgtA9KejbrQe/nKFprramLlkgsuL/xUwbI+V2gMJAmZDunyYsuM
         IKpTI289t0eurlC1grVOWvPfEeIC5GZP6R4IpgbYPzCMbASoE3uhQiworLhKvPTDaz4a
         bvThAY162tOwkbsVgVeySuQ918+aqd8yb9i8j5aMygPSOt3DGZhRb417tO6In5nPEcdC
         rM9g==
X-Forwarded-Encrypted: i=1; AJvYcCVOsd1gfvBjFBavSO2dhqzlSh9wUMWTJt2wpk/3p7PzzlH221Khfz+fsSz+sJN5Et1Dd4+THio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmJ2TxNhnw1R7iN0kXNFBSXFxsbPThxjIGffwWOkIMWWVLQ+M
	BV7TyLEAFUvFXcOhu8jA4EG3pxA972+/5Y/95pPOrslkNCEQQ2euWixdytTOMbs+qaZP/C1SqSy
	DVUUv12d+zFwhQYFQKsHp7PzgKPIB/kE=
X-Gm-Gg: AY/fxX7N4LLkVJnQucCrD5FIrUN14xOERUme+qL0BfFBihOvpKRB9I+YIy5BlDOQwlK
	XeAxZV1/8v5PBbYPYlB8qnbZmmpOd6cCYxdjWNX+ODfmr535rfxdN2g/gpYaUlre2PDIHtpocF3
	dkSv+BlSUmJK6YnyCHuLs9w1r7hAthD6vDluacg4XjiIf5QFG8MtM/lVKhVY+NE4t+j76fvSxfO
	IXVNRVrUGOmLnthFNPvFo/EGOhD3dtOkADaWaR+1aeLrQrxuotFNER4EQN+mR6+fnH1hHLxuVHv
	aPsDQXtA2dKJ29lHgW17S6a+33LlR6lSeFZ7rQ==
X-Received: by 2002:a17:907:26c7:b0:b87:124c:5f65 with SMTP id
 a640c23a62f3a-b87930408e9mr948920766b.51.1768803988646; Sun, 18 Jan 2026
 22:26:28 -0800 (PST)
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 01:26:26 -0500
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Jan 2026 01:26:26 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: zynai.founder@gmail.com
Date: Mon, 19 Jan 2026 01:26:26 -0500
X-Gm-Features: AZwV_Qi6XDSFA_U2na8XtIpwcJHOlx1Ktn1gzOVWFkswqGUefYYzi7MxmnFGNFs
Message-ID: <CAEnpc1YcccwVsPBqCSDuoJppJwVqSs8owWVorgCTKYT9ab=ftw@mail.gmail.com>
Subject: Can AI Help Your Dental Team Save Time?
To: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	patches@lists.linux.dev, info@morenofamilydentistry.com
Content-Type: text/plain; charset="UTF-8"

Hi Moreno Family Dentistry team,

As a dentist, I'm sure you're no stranger to tedious admin tasks and
manual patient follow-ups. With so many patients to care for, it's
easy to get bogged down in paperwork and scheduling.

At ZynAI, we've seen dental practices like yours struggle with
repetitive tasks that take up 5-10 hours per week. That's time taken
away from what matters most - providing top-notch patient care.

Our AI-powered automations can help streamline these processes,
freeing you to focus on what you do best. Let me know if it's worth a
quick conversation to explore how we can help?

