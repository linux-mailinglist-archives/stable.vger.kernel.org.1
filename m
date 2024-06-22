Return-Path: <stable+bounces-54862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653489132FB
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CEF28413B
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D814D716;
	Sat, 22 Jun 2024 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRKchq1I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5AD14B947
	for <stable@vger.kernel.org>; Sat, 22 Jun 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719051276; cv=none; b=H8wS/jw5j6UEgszQPxdBIQPXMo2SSuZ/n1uF3e4onZSy/H6NfclBOksYli7zI3sxLtQCAqlPF3TSGkYcjAttb92SK3K04oh4m2b7+dUcrNr/asiHl0UR6nDKlVea00MgA/wunh+QCRgV3NXfWkLyNrkjV2Q5oNQaI4kIe4ZndLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719051276; c=relaxed/simple;
	bh=TrpnPDWlENMgK+QM3Bpkpvqow1x66qbusPsLwsIgpdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BfajnUiYjpdBb9GxeVHutTssaMiio8pVxqEplmnbrUXT1ZjiUg57FZsn5yxSmT2yurrBusslapv63Mer3uxgHxiaJg1u+F1Foqm/6MRZtIUnbAdBg/FBvw3nLFwNYXfOfHP3ddf0eDHca1aDBlYeFa3ADLboQ/Mwta8Lyd7ss58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TRKchq1I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4217d451f69so24568515e9.0
        for <stable@vger.kernel.org>; Sat, 22 Jun 2024 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719051272; x=1719656072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LOGZewqxDMGMbF7UZoIa28jx2OtGU7FNX/jJsQDTBA=;
        b=TRKchq1IyH5aS7n3QRGuQkadRN0sqjKmPIuh5pEkMjb5wBaF4rbVkXySAIbXe92+Ge
         Kiuvi4ALwaUOlm8IwFsfiCqC8UxeWQFscykqT2VVxTey5IpaDG5bqJM2Zktv6CqO5E65
         ZNinLRlt+23dZ5uvBWyPYbUE5iY+ch5U4tax6KJ31suKjJJ654KVCGFbsLUOslD3Q+aV
         SkQh1sLxN/1lX7KQyaezliNbOObdD9NxO6Rl+c9JMgZewg2WRypueRepRw0oD/piTMRz
         GjIm4JAL7EDJxE9nZt2kS6+yF0Hxfgv2tt5C1xMs/hF2nmf4KjRspzEx5JyE09Y2frYY
         cUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719051272; x=1719656072;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LOGZewqxDMGMbF7UZoIa28jx2OtGU7FNX/jJsQDTBA=;
        b=l7OQY2RSzGpr208opEtjc0sZsHgIhB+WRXGTeDErxw5eQeuwonnl2gwbbZR3THduW9
         PjUpI1rNNurxSAVNxhTcyShHTo1ASauPDaVU11fZmyPxcQQJOWla5pLa14zT5Z1J8nQw
         /KCg16t1YjJyiK4f9BEVCwYhjnRTp8FdBrIL3vydoe5vGFm0tRXAyu/42Ac90orkS88f
         CaB6loE+uuj0hKM4cjpiXtFrJd9mRWGZ92J0VoqFC473C9yIzWXv8nblgz60LkLmJJ06
         tmzhr9aPaoBcaqpB7HCrJJ0rY2es3X/81XDoTsfjA5uNh2DltyZbtAXTsv+arwo+czlu
         E0SA==
X-Forwarded-Encrypted: i=1; AJvYcCWrl+6y+GXIBy3oMdu+H7b5ZeGRMX7lVjPtsQwjKCIdJMQtY0TyKIx7SJcwOKnE+SrXr3FZOt6Zbb6ufVwW0PKUwgUCbefZ
X-Gm-Message-State: AOJu0Yw8gVhsofYbXJQIiWFVEkXXwXIFe0FmNsWsnidKcJmTn1HYL6PE
	LdVP74TQGSnNZDM6Zn8PBJvaQX1jSGwKeMVsSsDyxESfc8WdUFc/5PeTeQk39upHNJATc0vJh/e
	JMFw=
X-Google-Smtp-Source: AGHT+IG0BPBJiTNWPcmSLfddECphdGj8leb6Xt9X9nc4MOdu/1ICSnVyniIgidXPWDCxYo7oIfCQyA==
X-Received: by 2002:a05:600c:2252:b0:424:798a:f7f6 with SMTP id 5b1f17b1804b1-424798afe74mr82525105e9.8.1719051271977;
        Sat, 22 Jun 2024 03:14:31 -0700 (PDT)
Received: from [172.20.10.4] (82-132-215-235.dab.02.net. [82.132.215.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248482f1c4sm44662305e9.10.2024.06.22.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:14:30 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
Subject: Re: (subset) [PATCH 0/5] nvmem: core: one fix and several cleanups
 for sysfs code
Message-Id: <171905126866.193679.14095365395671907555.b4-ty@linaro.org>
Date: Sat, 22 Jun 2024 11:14:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Thu, 20 Jun 2024 18:00:32 +0200, Thomas Weißschuh wrote:
> Patch 1 is a bugfix.
> All other patches are small cleanups.
> 
> Hint about another nvmem bugfix at [0].
> 
> [0] https://lore.kernel.org/lkml/20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net/
> 
> [...]

Applied, thanks!

[1/5] nvmem: core: only change name to fram for current attribute
      commit: 92e57866c8eeefd00ee0c05232b5134e11a66298

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


